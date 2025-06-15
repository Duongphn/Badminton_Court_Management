package controller.manager;

import DAO.BookingDAO;
import DAO.AreaDAO;
import Model.BookingScheduleDTO;
import Model.Branch;
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
        int managerId = user.getUser_Id();

        Integer areaId = null;
        String areaParam = request.getParameter("areaId");
        if (areaParam != null && !areaParam.isEmpty()) {
            try {
                areaId = Integer.parseInt(areaParam);
            } catch (NumberFormatException ignored) {}
        }

        java.time.LocalDate startDate = null;
        String startParam = request.getParameter("startDate");
        if (startParam != null && !startParam.isEmpty()) {
            startDate = java.time.LocalDate.parse(startParam);
        }

        java.time.LocalDate endDate = null;
        String endParam = request.getParameter("endDate");
        if (endParam != null && !endParam.isEmpty()) {
            endDate = java.time.LocalDate.parse(endParam);
        }

        String status = request.getParameter("status");
        if (status != null && status.isEmpty()) {
            status = null;
        }

        BookingDAO dao = new BookingDAO();
        List<BookingScheduleDTO> bookings = dao.getManagerBookings(managerId, areaId, startDate, endDate, status);

        AreaDAO areaDAO = new AreaDAO();
        List<Branch> areas = areaDAO.getAreasByManager(managerId);

        request.setAttribute("bookings", bookings);
        request.setAttribute("areas", areas);
        request.setAttribute("areaId", areaId);
        request.setAttribute("startDate", startParam);
        request.setAttribute("endDate", endParam);
        request.setAttribute("status", status);

        request.getRequestDispatcher("manager_booking_schedule.jsp").forward(request, response);
    }
}
