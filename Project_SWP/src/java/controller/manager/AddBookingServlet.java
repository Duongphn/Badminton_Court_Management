package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import DAO.AreaDAO;
import DAO.ServiceDAO;
import DAO.ShiftDAO;
import Model.Shift;
import Model.Branch;
import Model.Courts;
import Model.Service;
import Model.User;
import utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Servlet used by staff or admin to create a new booking for customers.
 */
@WebServlet(name = "AddBookingServlet", urlPatterns = {"/add-booking"})
public class AddBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasAccess(session)) {
            response.sendRedirect("login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");
        populateFormData(request, currentUser);
        request.getRequestDispatcher("add_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasAccess(session)) {
            response.sendRedirect("login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");
        request.setCharacterEncoding("UTF-8");

        String courtIdStr = request.getParameter("courtId");
        String username = request.getParameter("username");
        String dateStr = request.getParameter("date");
        String[] shiftIdArr = request.getParameterValues("shiftIds");
        String[] selectedServices = request.getParameterValues("selectedServices");

        // Validate required parameters
        if (courtIdStr == null || courtIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || shiftIdArr == null || shiftIdArr.length == 0
                || username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            populateFormData(request, currentUser);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        try {
            int courtId = Integer.parseInt(courtIdStr);
            UserDAO userDao = new UserDAO();
            User u = userDao.getUserByUsername(username.trim());
            if (u == null) {
                User newUser = new User();
                newUser.setUsername(username.trim());
                newUser.setPassword(PasswordUtil.hashPassword("123456"));
                newUser.setRole("user");
                newUser.setStatus("active");
                if (!userDao.insertUser(newUser)) {
                    request.setAttribute("error", "Không thể tạo người dùng mới.");
                    populateFormData(request, currentUser);
                    request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                    return;
                }
                u = userDao.getUserByUsername(username.trim());
            }
            int userId = u.getUser_Id();
            LocalDate date = LocalDate.parse(dateStr);

            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            if (court == null) {
                request.setAttribute("error", "Sân không tồn tại.");
                populateFormData(request, currentUser);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            ShiftDAO shiftDAO = new ShiftDAO();
            BookingDAO bookingDAO = new BookingDAO();
            Branch branch = new AreaDAO().getAreaByIdWithManager(court.getArea_id());

            // Calculate total price of selected services once
            double serviceTotal = 0;
            if (selectedServices != null) {
                for (String id : selectedServices) {
                    try {
                        Service s = ServiceDAO.getServiceById(Integer.parseInt(id));
                        if (s != null) {
                            serviceTotal += s.getPrice();
                        }
                    } catch (NumberFormatException ignored) {
                    }
                }
            }

            java.util.List<String> conflicts = new java.util.ArrayList<>();

            for (String sidStr : shiftIdArr) {
                int sid;
                try { sid = Integer.parseInt(sidStr); } catch (NumberFormatException ex) { continue; }
                Shift sh = shiftDAO.getShiftById(sid);
                if (sh == null) {
                    conflicts.add("Ca " + sidStr + " không tồn tại");
                    continue;
                }
                Time startTime = sh.getStartTime();
                Time endTime = sh.getEndTime();

                if (!startTime.before(endTime)) {
                    conflicts.add(sh.getShiftName() + " giờ bắt đầu phải trước giờ kết thúc");
                    continue;
                }

                if (branch != null) {
                    Time open = branch.getOpenTime();
                    Time close = branch.getCloseTime();
                    if (startTime.before(open) || endTime.after(close)) {
                        conflicts.add(sh.getShiftName() + " ngoài giờ mở cửa");
                        continue;
                    }
                }

                LocalDateTime startDateTime = LocalDateTime.of(date, startTime.toLocalTime());
                if (startDateTime.isBefore(LocalDateTime.now())) {
                    conflicts.add(sh.getShiftName() + " đã qua");
                    continue;
                }

                boolean slotAvailable = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);
                if (!slotAvailable) {
                    conflicts.add(sh.getShiftName() + "(" + startTime + "-" + endTime + ")");
                    continue;
                }

                java.math.BigDecimal slotPrice = courtDAO.calculateSlotPrice(
                        startTime, endTime,
                        java.math.BigDecimal.valueOf(court.getPrice()));
                double total = slotPrice.doubleValue() + serviceTotal;

                int bookingId = bookingDAO.insertBookingWithTotalPrice(userId, courtId, date,
                        startTime, endTime, "pending", java.math.BigDecimal.valueOf(total));
                if (bookingId == -1) {
                    conflicts.add("Lỗi tạo booking " + sh.getShiftName());
                    continue;
                }

                if (selectedServices != null) {
                    BookingServiceDAO bsDao = new BookingServiceDAO();
                    for (String id : selectedServices) {
                        try {
                            bsDao.addServiceToBooking(bookingId, Integer.parseInt(id));
                        } catch (NumberFormatException ignored) { }
                    }
                }
            }

            if (!conflicts.isEmpty()) {
                request.setAttribute("error", "Không thể đặt một số ca: " + String.join(", ", conflicts));
                populateFormData(request, currentUser);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            String msg = URLEncoder.encode("Đặt sân thành công!", StandardCharsets.UTF_8);
            response.sendRedirect("manager-booking-schedule?msg=" + msg);
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc lỗi hệ thống!");
            populateFormData(request, currentUser);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
        }
    }

    private boolean hasAccess(HttpSession session) {
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        if (user == null) return false;
        String role = user.getRole();
        return "staff".equals(role) || "admin".equals(role);
    }

    private void populateFormData(HttpServletRequest request, User user) {
        CourtDAO courtDAO = new CourtDAO();
        ShiftDAO shiftDAO = new ShiftDAO();

        List<Courts> courts;
        if ("admin".equals(user.getRole())) {
            courts = courtDAO.getAllCourts();
        } else {
            courts = courtDAO.getCourtsByManager(user.getUser_Id());
            if (courts == null || courts.isEmpty()) {
                request.setAttribute("courtMessage", "Không tìm thấy sân nào thuộc khu vực bạn quản lý.");
                courts = courts == null ? new java.util.ArrayList<>() : courts;
            }
        }

        java.util.Map<Integer, java.util.List<Shift>> courtShifts = new java.util.HashMap<>();
        for (Courts c : courts) {
            courtShifts.put(c.getCourt_id(), shiftDAO.getShiftsByCourt(c.getCourt_id()));
        }

        List<Service> services = ServiceDAO.getAllService();

        request.setAttribute("courts", courts);
        request.setAttribute("courtShifts", courtShifts);
        request.setAttribute("services", services);
    }
}
