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
        int managerId = ((User) session.getAttribute("user")).getUser_Id();
        populateFormData(request, managerId);
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
        int managerId = ((User) session.getAttribute("user")).getUser_Id();
        request.setCharacterEncoding("UTF-8");

        String courtIdStr = request.getParameter("courtId");
        String userIdStr = request.getParameter("userId");
        String dateStr = request.getParameter("date");
        String shiftIdStr = request.getParameter("shiftId");
        String[] selectedServices = request.getParameterValues("selectedServices");

        // Validate required parameters
        if (courtIdStr == null || courtIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || shiftIdStr == null || shiftIdStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        try {
            int courtId = Integer.parseInt(courtIdStr);
            int userId = (userIdStr != null && !userIdStr.isEmpty()) ? Integer.parseInt(userIdStr) : 0;
            LocalDate date = LocalDate.parse(dateStr);
            int shiftId = Integer.parseInt(shiftIdStr);
            Shift shift = new ShiftDAO().getShiftById(shiftId);
            if (shift == null) {
                request.setAttribute("error", "Ca chơi không tồn tại.");
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }
            Time startTime = shift.getStartTime();
            Time endTime = shift.getEndTime();

            if (!startTime.before(endTime)) {
                request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            if (court == null) {
                request.setAttribute("error", "Sân không tồn tại.");
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            Branch branch = new AreaDAO().getAreaByIdWithManager(court.getArea_id());
            if (branch != null) {
                Time open = branch.getOpenTime();
                Time close = branch.getCloseTime();
                if (startTime.before(open) || endTime.after(close)) {
                    request.setAttribute("error", "Thời gian đặt sân phải trong khoảng mở cửa: " + open + " - " + close);
                    populateFormData(request, managerId);
                    request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                    return;
                }
            }

            LocalDateTime startDateTime = LocalDateTime.of(date, startTime.toLocalTime());
            if (startDateTime.isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "Không thể đặt sân trong thời gian đã qua.");
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            BookingDAO bookingDAO = new BookingDAO();
            int bookingId = bookingDAO.insertBooking(userId, courtId, date, startTime, endTime, "pending");
            if (bookingId == -1) {
                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }

            if (selectedServices != null) {
                BookingServiceDAO bsDao = new BookingServiceDAO();
                for (String id : selectedServices) {
                    try {
                        bsDao.addServiceToBooking(bookingId, Integer.parseInt(id));
                    } catch (NumberFormatException ignored) { }
                }
            }

            String msg = URLEncoder.encode("Đặt sân thành công!", StandardCharsets.UTF_8);
            response.sendRedirect("manager-booking-schedule?msg=" + msg);
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc lỗi hệ thống!");
            populateFormData(request, managerId);
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

    private void populateFormData(HttpServletRequest request, int managerId) {
        CourtDAO courtDAO = new CourtDAO();
        UserDAO userDAO = new UserDAO();
        ShiftDAO shiftDAO = new ShiftDAO();

        List<Courts> courts = courtDAO.getCourtsByManager(managerId);
        if (courts == null || courts.isEmpty()) {
            request.setAttribute("courtMessage", "Không tìm thấy sân nào thuộc khu vực bạn quản lý.");
            courts = courts == null ? new java.util.ArrayList<>() : courts;
        }

        java.util.Map<Integer, java.util.List<Shift>> courtShifts = new java.util.HashMap<>();
        for (Courts c : courts) {
            courtShifts.put(c.getCourt_id(), shiftDAO.getShiftsByCourt(c.getCourt_id()));
        }

        List<User> customers = userDAO.getUsersByRole("user");
        List<Service> services = ServiceDAO.getAllService();

        request.setAttribute("courts", courts);
        request.setAttribute("courtShifts", courtShifts);
        request.setAttribute("customers", customers);
        request.setAttribute("services", services);
    }
}
