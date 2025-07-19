package controller.user;

import DAO.BookingDAO;
import Model.Bookings;
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

        String fromStr = request.getParameter("fromDate");
        String toStr = request.getParameter("toDate");
        String status = request.getParameter("status");
        LocalDate from = null;
        LocalDate to = null;
        if (fromStr != null && !fromStr.isEmpty()) {
            from = LocalDate.parse(fromStr);
        }
        if (toStr != null && !toStr.isEmpty()) {
            to = LocalDate.parse(toStr);
        }

        BookingDAO dao = new BookingDAO();
        List<Bookings> bookings = dao.getBookingsForUser(user.getUser_Id(), from, to, status);

        if ("json".equalsIgnoreCase(request.getParameter("format"))) {
            response.setContentType("application/json;charset=UTF-8");
            Gson gson = new Gson();
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(bookings));
            }
            return;
        }

        request.setAttribute("bookings", bookings);
        request.setAttribute("fromDate", fromStr);
        request.setAttribute("toDate", toStr);
        request.setAttribute("status", status);
        request.getRequestDispatcher("booking_calendar.jsp").forward(request, response);
    }
}
