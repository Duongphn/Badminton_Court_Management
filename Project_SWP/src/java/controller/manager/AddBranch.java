/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.AreaDAO;
import Model.Branch;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Time;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddRegionController", urlPatterns = {"/add-region"})
public class AddBranch extends HttpServlet {

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
            out.println("<title>Servlet AddRegion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRegion at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("staff")) {
            response.sendRedirect("login");
            return;
        }

        String name = request.getParameter("regionName");
        String address = request.getParameter("address");

        Time openTime = Time.valueOf(request.getParameter("openTime") + ":00");
        Time closeTime = Time.valueOf(request.getParameter("closeTime") + ":00");
        String description = request.getParameter("description");
        int empty = 0;

        try {
            empty = Integer.parseInt(request.getParameter("emptyCourt"));
        } catch (NumberFormatException e) {
            System.out.println("Lỗi chuyển đổi số lượng sân: " + e.getMessage());
        }
        Branch area = new Branch();
        area.setName(name);
        area.setLocation(address);
        area.setEmptyCourt(empty);
        area.setOpenTime(openTime);
        area.setCloseTime(closeTime);
        area.setDescription(description);
        area.setManager_id(user.getUser_Id()); // 

        AreaDAO dao = new AreaDAO();
        boolean exists = dao.isRegionNameExist(name, user.getUser_Id());
        if (exists) {
            session.setAttribute("error", "Tồn tại địa điểm rồi!");
        } else {
            dao.addRegion(area);
        }

        response.sendRedirect("view-region");
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
