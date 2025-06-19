package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import DAO.AreaDAO;
import DAO.ServiceDAO;
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
 * Servlet used by staff to create a new booking for customers.
 */
@WebServlet(name = "AddBookingServlet", urlPatterns = {"/add-booking"})
public class AddBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isStaff(session)) {
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
        if (!isStaff(session)) {
            response.sendRedirect("login");
            return;
        }
        int managerId = ((User) session.getAttribute("user")).getUser_Id();
        request.setCharacterEncoding("UTF-8");

        String courtIdStr = request.getParameter("courtId");
        String userIdStr = request.getParameter("userId");
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String[] selectedServices = request.getParameterValues("selectedServices");

        // Validate required parameters
        if (courtIdStr == null || courtIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || startStr == null || startStr.isEmpty()
                || endStr == null || endStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        try {
            int courtId = Integer.parseInt(courtIdStr);
            int userId = (userIdStr != null && !userIdStr.isEmpty()) ? Integer.parseInt(userIdStr) : 0;
            LocalDate date = LocalDate.parse(dateStr);
            Time startTime = parseTime(startStr);
            Time endTime = parseTime(endStr);

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
//            if (!bookingDAO.checkSlotAvailableAdmin(courtId, date, startTime, endTime)) {
//                request.setAttribute("error", "Sân này đã được đặt trong thời gian này. Vui lòng chọn thời gian khác.");
//                populateFormData(request, managerId);
//                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
//                return;
//            }

            bookingDAO.insertBooking(userId, courtId, date, startTime, endTime, "Pending");
//            if (bookingId == -1) {
//                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
//                populateFormData(request, managerId);
//                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
//                return;
//            }

//            if (selectedServices != null) {
//                BookingServiceDAO bsDao = new BookingServiceDAO();
//                for (String id : selectedServices) {
//                    try {
//                        bsDao.addServiceToBooking(bookingId, Integer.parseInt(id));
//                    } catch (NumberFormatException ignored) { }
//                }
//            }

            String msg = URLEncoder.encode("Đặt sân thành công!", StandardCharsets.UTF_8);
            response.sendRedirect("manager-booking-schedule?msg=" + msg);
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc lỗi hệ thống!");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
        }
    }

    private boolean isStaff(HttpSession session) {
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        return user != null && "staff".equals(user.getRole());
    }

    private Time parseTime(String str) {
        return Time.valueOf(str.length() == 5 ? str + ":00" : str);
    }

    private void populateFormData(HttpServletRequest request, int managerId) {
        CourtDAO courtDAO = new CourtDAO();
        UserDAO userDAO = new UserDAO();
        List<Courts> courts = courtDAO.getCourtsByManager(managerId);
        List<User> customers = userDAO.getUsersByRole("user");
        List<Service> services = ServiceDAO.getAllService();
        request.setAttribute("courts", courts);
        request.setAttribute("customers", customers);
        request.setAttribute("services", services);
    }
}
