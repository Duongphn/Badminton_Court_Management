package controller.manager;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.ReviewDAO;
import Model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet(name = "StaffDashboardServlet", urlPatterns = {"/staff-dashboard"})
public class StaffDashboardServlet extends HttpServlet {
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

        BookingDAO bookingDAO = new BookingDAO();
        CourtDAO courtDAO = new CourtDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        int todayBookings = bookingDAO.countBookingsTodayByManager(managerId);
        BigDecimal weeklyRevenue = bookingDAO.getRevenueLast7DaysByManager(managerId);
        Map<Integer,Integer> hourly = bookingDAO.getHourlyBookingDistribution(managerId);
        Map<String,Integer> topCourts = bookingDAO.getTopBookedCourts(managerId, 5);
        Map<String,Integer> statusCounts = courtDAO.getCourtStatusCounts(managerId);
        int reviewCount = reviewDAO.countReviewsByManager(managerId);

        ObjectMapper mapper = new ObjectMapper();
        request.setAttribute("hourlyJson", mapper.writeValueAsString(hourly));
        request.setAttribute("topCourtsJson", mapper.writeValueAsString(topCourts));
        request.setAttribute("todayBookings", todayBookings);
        request.setAttribute("weeklyRevenue", weeklyRevenue);
        request.setAttribute("statusCounts", statusCounts);
        request.setAttribute("reviewCount", reviewCount);

        request.getRequestDispatcher("staff_dashboard.jsp").forward(request, response);
    }
}
