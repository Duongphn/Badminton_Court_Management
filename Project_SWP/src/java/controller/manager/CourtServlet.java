package controller.manager;

import DAO.AreaDAO;
import DAO.CourtDAO;
import Model.Courts;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/courts")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20)
public class CourtServlet extends HttpServlet {

    private CourtDAO courtDAO;

    @Override
    public void init() {
        courtDAO = new CourtDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String areaParam = request.getParameter("area_id");
        if (action == null) {
            List<Courts> courts;
            if (areaParam != null && !areaParam.isEmpty()) {
                int areaId = Integer.parseInt(areaParam);
                courts = courtDAO.getCourtsByAreaId(areaId);
                request.setAttribute("areaId", areaId);
            } else {
                courts = courtDAO.getAllCourts();
            }
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
            court.setCourt_number(request.getParameter("courtNumber"));
            court.setType(request.getParameter("type"));
            court.setFloor_material(request.getParameter("floorMaterial"));
            court.setLighting(request.getParameter("lighting"));
            court.setDescription(request.getParameter("description"));

            Part filePart = request.getPart("image");
            String imagePath = null;
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                filePart.write(uploadDir + File.separator + fileName);
                imagePath = "uploads/" + fileName;
            }
            court.setImage_url(imagePath);
            court.setStatus(request.getParameter("status"));
            court.setArea_id(Integer.parseInt(request.getParameter("areaId")));
            courtDAO.addCourt(court);

            session.setAttribute("successMessage", "Thêm sân thành công!");
            session.setAttribute("messageType", "success");
        } else if (action.equals("update")) {
            Courts court = new Courts();
            court.setCourt_id(Integer.parseInt(request.getParameter("courtId")));
            court.setCourt_number(request.getParameter("courtNumber"));
            court.setType(request.getParameter("type"));
            court.setFloor_material(request.getParameter("floorMaterial"));
            court.setLighting(request.getParameter("lighting"));
            court.setDescription(request.getParameter("description"));

            Part filePart = request.getPart("image");
            String imagePath = request.getParameter("currentImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                filePart.write(uploadDir + File.separator + fileName);
                imagePath = "uploads/" + fileName;
            }
            court.setImage_url(imagePath);
            court.setStatus(request.getParameter("status"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            court.setArea_id(areaId);
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
        String redirectArea = request.getParameter("redirectAreaId");
        String redirectUrl = "courts";
        if (redirectArea != null && !redirectArea.isEmpty()) {
            redirectUrl += "?area_id=" + redirectArea;
        }
        response.sendRedirect(redirectUrl);
    }
}
