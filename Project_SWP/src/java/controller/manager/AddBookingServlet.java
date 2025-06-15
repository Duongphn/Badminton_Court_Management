package controller.manager;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import Model.Courts;
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
import java.util.List;

@WebServlet(name = "AddBookingServlet", urlPatterns = {"/add-booking"})
public class AddBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        int managerId = user.getUser_Id();
        CourtDAO courtDAO = new CourtDAO();
        UserDAO userDAO = new UserDAO();
        List<Courts> courts = courtDAO.getCourtsByManager(managerId);
        List<User> customers = userDAO.getUsersByRole("user");
        request.setAttribute("courts", courts);
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("add_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        // Lấy các tham số từ form
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String courtIdStr = request.getParameter("courtId");
        String userIdStr = request.getParameter("userId"); // nếu có

        // 1. Kiểm tra dữ liệu đầu vào
        if (dateStr == null || dateStr.isEmpty()
                || startStr == null || startStr.isEmpty()
                || endStr == null || endStr.isEmpty()
                || courtIdStr == null || courtIdStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        int courtId, userId = 0;
        LocalDate date;
        Time startTime, endTime;
        try {
            date = LocalDate.parse(dateStr);  // yyyy-MM-dd
            startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr); // HH:mm
            endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);         // HH:mm
            courtId = Integer.parseInt(courtIdStr);
            if (userIdStr != null && !userIdStr.isEmpty()) {
                userId = Integer.parseInt(userIdStr);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Định dạng ngày hoặc giờ không hợp lệ!");
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra logic thời gian
        if (!startTime.before(endTime)) {
            request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra trùng slot booking
        BookingDAO dao = new BookingDAO();
        boolean available = dao.checkSlotAvailable(courtId, date, startTime, endTime);
        if (!available) {
            request.setAttribute("error", "Sân này đã được đặt trong thời gian này. Vui lòng chọn thời gian khác.");
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 4. Thêm booking mới (status: pending hoặc booked tuỳ logic của bạn)
        dao.insertBooking(userId, courtId, date, startTime, endTime, "pending");
        response.sendRedirect("manager_booking_schedule.jsp?msg=Đặt sân thành công!");
    }
}
