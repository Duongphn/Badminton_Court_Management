package controller.user;

import DAO.BookingDAO;
import Model.Bookings;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="SubmitRatingServlet", urlPatterns={"/submit-rating"})
public class SubmitRatingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            if (rating < 1 || rating > 5) {
                response.sendRedirect("booking-list?error=invalid-rating");
                return;
            }
            BookingDAO dao = new BookingDAO();
            Bookings booking = dao.getBookingById(bookingId);
            if (booking == null || booking.getUser_id() != user.getUser_Id()) {
                response.sendRedirect("booking-list?error=unauthorized");
                return;
            }
            if (!"confirmed".equals(booking.getStatus())) {
                response.sendRedirect("booking-list?error=invalid-status");
                return;
            }
            dao.updateRating(bookingId, rating);
        } catch (NumberFormatException e) {
            // ignore invalid number
        }
        response.sendRedirect("booking-list");
    }
}
