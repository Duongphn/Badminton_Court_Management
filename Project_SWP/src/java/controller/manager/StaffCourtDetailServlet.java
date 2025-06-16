package controller.manager;

import DAO.CourtDAO;
import Model.Courts;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "StaffCourtDetailServlet", urlPatterns = {"/staff-court-detail"})
public class StaffCourtDetailServlet extends HttpServlet {

    private CourtDAO courtDAO;

    @Override
    public void init() {
        courtDAO = new CourtDAO();
    }

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

        String idParam = request.getParameter("courtId");
        if (idParam == null) {
            response.sendRedirect("dashboard");
            return;
        }
        int courtId;
        try {
            courtId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard");
            return;
        }

        Courts court = courtDAO.getCourtById(courtId);
        if (court == null) {
            response.sendRedirect("dashboard");
            return;
        }

        request.setAttribute("court", court);
        request.getRequestDispatcher("staff_court_detail.jsp").forward(request, response);
    }
}

