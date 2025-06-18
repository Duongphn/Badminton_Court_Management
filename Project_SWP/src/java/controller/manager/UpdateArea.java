/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.AreaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateArea", urlPatterns = {"/UpdateArea"})
public class UpdateArea extends HttpServlet {

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
            out.println("<title>Servlet UpdateArea</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateArea at " + request.getContextPath() + "</h1>");
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
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    try {
        int id = Integer.parseInt(request.getParameter("regionID"));
        String name = request.getParameter("RegionName");
        String address = request.getParameter("address");
             
        // Lấy chuỗi giờ từ input
        String openTimeStr = request.getParameter("openTime");
        String closeTimeStr = request.getParameter("closeTime");
       String description = request.getParameter("description");
        // Chuyển từ chuỗi sang java.sql.Time
        java.sql.Time openTime = java.sql.Time.valueOf(openTimeStr );
        java.sql.Time closeTime = java.sql.Time.valueOf(closeTimeStr );
        String phone_branch = request.getParameter("phone_branch");
        String nameStaff = request.getParameter("nameStaff");
        AreaDAO dao = new AreaDAO();
        System.out.println(id+","+name+","+address);
        dao.UpdateArea(id, name, address, openTime, closeTime,description,phone_branch,nameStaff);
        
        response.sendRedirect("view-region");
    } catch ( NumberFormatException  e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi dữ liệu nhập vào!");
        response.sendRedirect("view-region");
    } catch (Exception ex) {
        ex.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra trong quá trình cập nhật.");
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
