/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;


import DAO.Branch_ImageDAO;
import DAO.Service_BranchDAO;
import Model.User;

import DAO.ServiceDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;


/**
 *
 * @author admin
 */

@WebServlet(name="DeleteImageBranch", urlPatterns={"/delete-image"})
public class DeleteImageBranch extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
========
@WebServlet(name = "DeleteService", urlPatterns = {"/DeleteService"})
public class DeleteService extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
>>>>>>>> 02881c1ca9f788f36b5f3e62cd7d0ab19d67c073:Project_SWP/src/java/controller/manager/DeleteService.java
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

            out.println("<title>Servlet DeleteService</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteService at " + request.getContextPath() + "</h1>");

            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)

    throws ServletException, IOException {
         HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("staff")) {
                int image_id = Integer.parseInt(request.getParameter("image_id"));
                String area_id = request.getParameter("area_id");
                Branch_ImageDAO areasImageDAO = new Branch_ImageDAO();
               areasImageDAO.removeImageFromArea(image_id);

                response.sendRedirect("detailBranch?area_id=" + area_id);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    } 

    /** 
========
            throws ServletException, IOException {
        int service_id = Integer.parseInt(request.getParameter("id"));
        try {
            boolean result = ServiceDAO.deleteService(service_id);
            // Có thể set thuộc tính để thông báo xóa thành công/thất bại nếu muốn
            response.sendRedirect("ServiceView.jsp"); // Chuyển về trang danh sách dịch vụ
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xóa dịch vụ.");
        }
    }

    /**
>>>>>>>> 02881c1ca9f788f36b5f3e62cd7d0ab19d67c073:Project_SWP/src/java/controller/manager/DeleteService.java
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
