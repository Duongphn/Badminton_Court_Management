/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.PostDAO;
import Dal.DBContext;
import Model.Post;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddPostManager", urlPatterns = {"/AddPostManager"})
public class AddPostManager extends HttpServlet {

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
            out.println("<title>Servlet AddPostManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPostManager at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if ("add".equals(action)) {

            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String type = request.getParameter("type");

            if ("news".equals(type)) {
                type = "admin";
            }
            if ("common".equals(type)) {
                type = "common";
            }
            if ("partner".equals(type)) {
                type = "partner";
            }

            HttpSession session = request.getSession();
            Model.User user = (Model.User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int createdBy = user.getUser_Id();
            String role = user.getRole();

            Post post = new Post();
            post.setTitle(title);
            post.setContent(content);
            post.setType(type);
            post.setCreatedBy(createdBy);
            post.setStatus("pending");
            post.setCreatedAt(new java.util.Date());

            try {
                DBContext db = new DBContext();
                Connection conn = db.getConnection();
                PostDAO postDAO = new PostDAO(conn);
                postDAO.insertPost(post);

                response.sendRedirect("ViewPostManager");
            } catch (SQLException e) {
                e.printStackTrace();
                response.setContentType("text/plain");
                response.getWriter().println("SQL lỗi: " + e.getMessage());
            } catch (Exception e) {
            }
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
