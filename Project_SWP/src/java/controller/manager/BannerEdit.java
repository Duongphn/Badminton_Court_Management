/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.BannerDAO;
import Model.Banner;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

/**
 *
 * @author sang
 */
@WebServlet(name = "BannerEdit", urlPatterns = {"/banner-edit"})
@MultipartConfig
public class BannerEdit extends HttpServlet {

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
            out.println("<title>Servlet BannerEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BannerEdit at " + request.getContextPath() + "</h1>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            Banner banner = new BannerDAO().getBannerById(id);
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("banner_list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("banner-list?msg=notfound");
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
        try {
            request.setCharacterEncoding("UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));
            BannerDAO dao = new BannerDAO();
            Banner banner = dao.getBannerById(id);

            String title = request.getParameter("title");
            String caption = request.getParameter("caption");
            boolean status = request.getParameter("status") != null;
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Nếu người dùng upload file mới thì ghi đè, không thì giữ file cũ
            if (fileName != null && !fileName.isEmpty()) {
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdir();
                }
                String filePath = uploadDir + File.separator + fileName;
                filePart.write(filePath);
                banner.setImageUrl("uploads/" + fileName);
            } else {
                System.out.println("Không upload file mới, giữ ảnh cũ: " + banner.getImageUrl());
            }

            banner.setTitle(title);
            banner.setCaption(caption);
            banner.setStatus(status);

            dao.updateBanner(banner);
            response.sendRedirect("banner-list?msg=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("banner-list?msg=error");
        }
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
