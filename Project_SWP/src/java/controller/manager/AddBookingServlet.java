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

        int userId = Integer.parseInt(request.getParameter("userId"));
        int courtId = Integer.parseInt(request.getParameter("courtId"));
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
        Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");

        if (!startTime.before(endTime)) {
            request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
            doGet(request, response);
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        boolean available = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);
        if (!available) {
            request.setAttribute("error", "Khoảng thời gian đã được đặt.");
            doGet(request, response);
            return;
        }
        bookingDAO.insertBooking(userId, courtId, date, startTime, endTime, "confirmed");
        response.sendRedirect("manager-booking-schedule");
    }
}
