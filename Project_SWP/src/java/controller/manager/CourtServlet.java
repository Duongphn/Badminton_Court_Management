package controller.manager;

import DAO.AreaDAO;
import DAO.CourtDAO;
import Model.Courts;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/courts")
public class CourtServlet extends HttpServlet {

    private CourtDAO courtDAO;

    @Override
    public void init() {
        courtDAO = new CourtDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            List<Courts> courts = courtDAO.getAllCourts();
            request.setAttribute("courts", courts);
            request.getRequestDispatcher("/court_manager.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            String courtId = request.getParameter("courtId");
            int courtid = Integer.parseInt(courtId);
            Courts court = courtDAO.getCourtById(courtid);
            request.setAttribute("court", court);
            request.getRequestDispatcher("/court_manager.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (action.equals("add")) {
            Courts court = new Courts();
            court.setCourt_number(Integer.parseInt(request.getParameter("courtNumber")));
            court.setStatus(request.getParameter("status"));
            court.setArea_id(Integer.parseInt(request.getParameter("areaId")));
            courtDAO.addCourt(court);

            session.setAttribute("successMessage", "Thêm sân thành công!");
            session.setAttribute("messageType", "success");
        } else if (action.equals("update")) {
            Courts court = new Courts();
            court.setCourt_id(Integer.parseInt(request.getParameter("courtId")));
            court.setCourt_number(Integer.parseInt(request.getParameter("courtNumber")));
            court.setStatus(request.getParameter("status"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            court.setArea_id(Integer.parseInt(request.getParameter("areaId")));
            courtDAO.updateCourt(court);
            AreaDAO areaDAO = new AreaDAO();
            areaDAO.updateEmptyCourtByAreaId(areaId, 1);
            session.setAttribute("successMessage", "Cập nhật sân thành công!");
            session.setAttribute("messageType", "success");
        } else if (action.equals("delete")) {
            String courtId = request.getParameter("courtId");
            courtDAO.deleteCourt(courtId);
            session.setAttribute("successMessage", "Xóa sân thành công!");
            session.setAttribute("messageType", "success");
        }
        response.sendRedirect("courts");
    }
}
