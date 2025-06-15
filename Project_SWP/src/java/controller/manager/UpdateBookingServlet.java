package controller.manager;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import Model.Bookings;
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

@WebServlet("/update-booking")
public class UpdateBookingServlet extends HttpServlet {
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
        String idRaw = request.getParameter("bookingId");
        if (idRaw == null) {
            response.sendRedirect("manager-booking-schedule");
            return;
        }
        try {
            int bookingId = Integer.parseInt(idRaw);
            BookingDAO dao = new BookingDAO();
            Bookings booking = dao.getBookingById(bookingId);
            if (booking == null) {
                response.sendRedirect("manager-booking-schedule");
                return;
            }
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(booking.getCourt_id());
            UserDAO userDAO = new UserDAO();
            User customer = userDAO.getUserById(booking.getUser_id());
            request.setAttribute("booking", booking);
            request.setAttribute("court", court);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("manager-booking-schedule");
        }
    }

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
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
            Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");
            String status = request.getParameter("status");

            BookingDAO dao = new BookingDAO();
            Bookings old = dao.getBookingById(bookingId);
            boolean available = dao.checkSlotAvailableForUpdate(bookingId, old.getCourt_id(), date, startTime, endTime);
            if (!available) {
                request.setAttribute("error", "Khoảng thời gian đã được đặt.");
                CourtDAO courtDAO = new CourtDAO();
                Courts court = courtDAO.getCourtById(old.getCourt_id());
                UserDAO userDAO = new UserDAO();
                User customer = userDAO.getUserById(old.getUser_id());
                request.setAttribute("booking", old);
                request.setAttribute("court", court);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }
            dao.updateBooking(bookingId, date, startTime, endTime, status);
            response.sendRedirect("manager-booking-schedule");
        } catch (Exception e) {
            response.sendRedirect("manager-booking-schedule");
        }
    }
}
