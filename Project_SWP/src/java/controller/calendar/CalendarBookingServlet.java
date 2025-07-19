package controller.calendar;

import DAO.BookingDAO;
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
import java.util.Collections;

@WebServlet("/calendar-booking")
public class CalendarBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        String bookingIdStr = request.getParameter("bookingId");
        String courtIdStr = request.getParameter("courtId");
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String status = request.getParameter("status");
        int bookingId = -1;
        try { bookingId = Integer.parseInt(bookingIdStr); } catch (Exception ignored) {}
        int courtId = -1;
        try { courtId = Integer.parseInt(courtIdStr); } catch (Exception ignored) {}
        LocalDate date = null;
        try { date = LocalDate.parse(dateStr); } catch (Exception ignored) {}
        Time start = null;
        Time end = null;
        try { if (startStr != null) start = Time.valueOf(startStr); } catch (Exception ignored) {}
        try { if (endStr != null) end = Time.valueOf(endStr); } catch (Exception ignored) {}
        if (courtId == -1 || date == null || start == null || end == null || status == null || status.isEmpty()) {
            response.sendRedirect("booking-calendar");
            return;
        }
        BookingDAO dao = new BookingDAO();
        if (bookingId > 0) {
            dao.updateBooking(bookingId, date, start, end, status, Collections.emptyList());
        } else {
            dao.insertBooking(user.getUser_Id(), courtId, date, start, end, status);
        }
        response.sendRedirect("booking-calendar");
    }
}
