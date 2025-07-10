/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.AreaDAO;
import DAO.BannerDAO;
import DAO.Branch_ImageDAO;
import Model.Banner;
import Model.Branch;
import Model.Branch_pictures;
import Model.User;
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

/**
 *
 * @author sangn
 */
@WebServlet(name = "HomePage", urlPatterns = {"/HomePage"})
public class HomePage extends HttpServlet {

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
            out.println("<title>Servlet HomePage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath() + "</h1>");
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
            AreaDAO areaDAO = new AreaDAO();
            Branch_ImageDAO imageDAO = new Branch_ImageDAO();
            BannerDAO bannerDAO = new BannerDAO();

            // Lấy danh sách top 3 khu vực (nếu dùng)
            List<Branch> listTop3 = areaDAO.getTop3();
            Map<Integer, List<Branch_pictures>> areaImagesMap = new HashMap<>();
            for (Branch area : listTop3) {
                List<Branch_pictures> images = imageDAO.getRoomImagesByDormID(area.getArea_id());
                areaImagesMap.put(area.getArea_id(), images);
            }

          
            List<Banner> bannerList = bannerDAO.getActiveBanners(); // hoặc getAllBanners() để test

            // === DEBUG BANNER ===
            System.out.println("=== [DEBUG] BannerList for homepage ===");
            if (bannerList == null) {
                System.out.println("bannerList = NULL");
            } else {
                System.out.println("bannerList size = " + bannerList.size());
                for (Banner b : bannerList) {
                    System.out.println("id=" + b.getId()
                            + " | title=" + b.getTitle()
                            + " | imageUrl=" + b.getImageUrl()
                            + " | status=" + b.isStatus());
                }
            }
            // === END DEBUG ===

            // Set attributes cho JSP
            request.setAttribute("listTop3", listTop3);
            request.setAttribute("areaImagesMap", areaImagesMap);
            request.setAttribute("bannerList", bannerList);

            // Forward tới homepage.jsp
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server trang chủ");
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
