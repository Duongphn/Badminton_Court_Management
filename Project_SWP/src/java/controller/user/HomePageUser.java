/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.AreaDAO;
import DAO.BannerDAO;
import DAO.Branch_ImageDAO;
import DAO.EventDAO;
import Model.Banner;
import Model.Branch;
import Model.Branch_pictures;
import Model.User;
import Model.Event;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sangn
 */
@WebServlet(name = "HomePageUser", urlPatterns = {"/HomePageUser"})
public class HomePageUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomePageUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            AreaDAO areaDAO = new AreaDAO();
            Branch_ImageDAO imageDAO = new Branch_ImageDAO();
            EventDAO eventDAO = new EventDAO();
            BannerDAO bannerDAO = new BannerDAO();

            List<Branch> listTop3 = areaDAO.getTop3();
            Map<Integer, List<Branch_pictures>> areaImagesMap = new HashMap<>();
            List<Banner> bannerList = bannerDAO.getActiveBanners();

            for (Branch area : listTop3) {
                List<Branch_pictures> images = imageDAO.getRoomImagesByDormID(area.getArea_id());
                areaImagesMap.put(area.getArea_id(), images);
            }

            // Lấy event mới nhất để hiển thị popup
            Event latestEvent = eventDAO.getLatestActiveEvent();

            // Kiểm tra thông báo join event từ session
            String joinEventSuccess = (String) session.getAttribute("joinEventSuccess");
            if (joinEventSuccess != null) {
                request.setAttribute("joinEventSuccess", joinEventSuccess);
                session.removeAttribute("joinEventSuccess");
            }

            String joinEventInfo = (String) session.getAttribute("joinEventInfo");
            if (joinEventInfo != null) {
                request.setAttribute("infoMessage", joinEventInfo);
                session.removeAttribute("joinEventInfo");
            }

            // Kiểm tra error messages từ URL parameters
            String error = request.getParameter("error");
            if (error != null) {
                switch (error) {
                    case "invalid_event":
                        request.setAttribute("errorMessage", "Sự kiện không hợp lệ!");
                        break;
                    case "invalid_event_id":
                        request.setAttribute("errorMessage", "ID sự kiện không hợp lệ!");
                        break;
                    case "event_not_found":
                        request.setAttribute("errorMessage", "Không tìm thấy sự kiện!");
                        break;
                    case "login_required":
                        request.setAttribute("errorMessage", "Vui lòng đăng nhập để tham gia sự kiện!");
                        break;
                    case "join_failed":
                        request.setAttribute("errorMessage", "Tham gia sự kiện thất bại!");
                        break;
                    case "system_error":
                        request.setAttribute("errorMessage", "Lỗi hệ thống!");
                        break;
                }
            }

            request.setAttribute("listTop3", listTop3);
            request.setAttribute("areaImagesMap", areaImagesMap);
            request.setAttribute("latestEvent", latestEvent);
            request.setAttribute("bannerList", bannerList);

            request.getRequestDispatcher("homepageUser.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(HomePageUser.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
