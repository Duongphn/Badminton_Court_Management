package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.AreaDAO;
import Model.BookingScheduleDTO;
import Model.Branch;
import Model.Service;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
<<<<<<< HEAD
         if (user == null || (!"staff".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
=======
        if (user == null || (!"staff".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
>>>>>>> 85f7a47d8af951baf57d621348aed8e1abed1458
            response.sendRedirect("login");
            return;
        }
        int managerId = user.getUser_Id();

        String msgParam = request.getParameter("msg");
        if (msgParam != null && !msgParam.isEmpty()) {
            request.setAttribute("message", msgParam);
        }

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
        BookingServiceDAO bsDao = new BookingServiceDAO();
        Map<Integer, String> serviceNames = new HashMap<>();
        for (BookingScheduleDTO b : bookings) {
            List<Service> svs = bsDao.getServicesByBookingId(b.getBooking_id());
            String names = svs.stream().map(Service::getName).collect(Collectors.joining(", "));
            serviceNames.put(b.getBooking_id(), names);
        }

        AreaDAO areaDAO = new AreaDAO();
        List<Branch> areas = areaDAO.getAreasByManager(managerId);

        request.setAttribute("bookings", bookings);
        request.setAttribute("serviceNames", serviceNames);
        request.setAttribute("areas", areas);
        request.setAttribute("areaId", areaId);
        request.setAttribute("startDate", startParam);
        request.setAttribute("endDate", endParam);
        request.setAttribute("status", status);

        request.getRequestDispatcher("manager_booking_schedule.jsp").forward(request, response);
    }
}
