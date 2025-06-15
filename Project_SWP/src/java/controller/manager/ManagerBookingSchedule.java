package controller.manager;

import DAO.BookingDAO;
import Model.BookingScheduleDTO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/manager-booking-schedule")
public class ManagerBookingSchedule extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        BookingDAO dao = new BookingDAO();
        List<BookingScheduleDTO> bookings = dao.getManagerBookings(user.getUser_Id(), null, null, null, null);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("manager_booking_schedule.jsp").forward(request, response);
    }
}
