package controller.manager;

import DAO.AreaDAO;
import DAO.BookingDAO;
import Model.Branch;
import Model.BookingScheduleDTO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ManagerBookingScheduleServlet", urlPatterns = {"/manager-booking-schedule"})
public class ManagerBookingScheduleServlet extends HttpServlet {

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

        String areaParam = request.getParameter("areaId");
        if (areaParam == null) {
            areaParam = request.getParameter("area_id");
        }
        Integer areaId = null;
        try {
            if (areaParam != null && !areaParam.isEmpty()) {
                areaId = Integer.parseInt(areaParam);
            }
        } catch (NumberFormatException e) {
        }

        String startParam = request.getParameter("start");
        if (startParam == null) {
            startParam = request.getParameter("startDate");
        }
        String endParam = request.getParameter("end");
        if (endParam == null) {
            endParam = request.getParameter("endDate");
        }
        LocalDate startDate = null;
        LocalDate endDate = null;
        if (startParam != null && !startParam.isEmpty()) {
            startDate = LocalDate.parse(startParam);
        }
        if (endParam != null && !endParam.isEmpty()) {
            endDate = LocalDate.parse(endParam);
        }
        if (startDate != null && endDate == null) {
            endDate = startDate.plusDays(6);
        }
        if (startDate == null || endDate == null) {
            LocalDate today = LocalDate.now();
            startDate = today.with(DayOfWeek.MONDAY);
            endDate = startDate.plusDays(6);
        }

        String status = request.getParameter("status");
        if (status == null) {
            status = request.getParameter("bookingStatus");
        }

        BookingDAO dao = new BookingDAO();
        List<BookingScheduleDTO> bookings = dao.getManagerBookings(managerId, areaId, startDate, endDate, status);

        java.util.Map<LocalDate, java.util.Map<Integer, List<BookingScheduleDTO>>> schedule = new java.util.HashMap<>();
        for (BookingScheduleDTO b : bookings) {
            LocalDate d = b.getDate();
            int hour = b.getStart_time().toLocalTime().getHour();
            schedule.computeIfAbsent(d, k -> new java.util.HashMap<>())
                    .computeIfAbsent(hour, k -> new ArrayList<>())
                    .add(b);
        }

        List<LocalDate> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            days.add(startDate.plusDays(i));
        }

        AreaDAO areaDAO = new AreaDAO();
        List<Branch> areas = areaDAO.getAreasByManager(managerId);

        int openHour = 6;
        int closeHour = 22;
        if (areaId != null) {
            Branch a = areaDAO.getAreaByIdWithManager(areaId);
            if (a != null) {
                openHour = a.getOpenTime().toLocalTime().getHour();
                closeHour = a.getCloseTime().toLocalTime().getHour();
            }
        } else if (!areas.isEmpty()) {
            openHour = 24;
            closeHour = 0;
            for (Branch a : areas) {
                int oh = a.getOpenTime().toLocalTime().getHour();
                int ch = a.getCloseTime().toLocalTime().getHour();
                if (oh < openHour) openHour = oh;
                if (ch > closeHour) closeHour = ch;
            }
        }

        request.setAttribute("areas", areas);
        request.setAttribute("bookings", bookings);
        request.setAttribute("schedule", schedule);
        request.setAttribute("weekDays", days);
        request.setAttribute("start", startDate);
        request.setAttribute("end", endDate);
        request.setAttribute("openHour", openHour);
        request.setAttribute("closeHour", closeHour);
        request.getRequestDispatcher("manager_booking_schedule.jsp").forward(request, response);
    }
}
