package controller.manager;

import DAO.BookingDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/confirm-booking-manager")
public class ConfirmBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
        String bookingIdRaw = request.getParameter("bookingId");
        String action = request.getParameter("action");
        if (bookingIdRaw != null && action != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdRaw);
                BookingDAO dao = new BookingDAO();
                String status = "confirm".equals(action) ? "confirmed" : "cancelled";
                dao.updateBookingStatus(bookingId, status);
            } catch (NumberFormatException e) {
                // ignore invalid id
            }
        }
        response.sendRedirect("manager-booking-schedule");
    }
}
