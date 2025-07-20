package controller.user;

import DAO.BookingDAO;
import DAO.CourtDAO;
import Model.Bookings;
import Model.Courts;
import Model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "UserBookingCalendar", urlPatterns = {"/booking-calendar"})
public class UserBookingCalendar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        BookingDAO dao = new BookingDAO();
        List<Bookings> bookings = dao.getBookingsForUser(user.getUser_Id(), null, null, null);
        CourtDAO courtDAO = new CourtDAO();
        List<Courts> courts = courtDAO.getAllCourts();

        if ("json".equalsIgnoreCase(request.getParameter("format"))) {
            response.setContentType("application/json;charset=UTF-8");
            Gson gson = new Gson();
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(bookings));
            }
            return;
        }

        request.setAttribute("bookings", bookings);
        request.setAttribute("courts", courts);
        request.getRequestDispatcher("booking_calendar.jsp").forward(request, response);
    }
}
