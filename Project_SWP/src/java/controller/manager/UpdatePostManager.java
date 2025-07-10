/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.PostDAO;
import Dal.DBContext;
import Model.Post;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdatePostManager", urlPatterns = {"/UpdatePostManager"})
public class UpdatePostManager extends HttpServlet {

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
            out.println("<title>Servlet UpdatePostManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePostManager at " + request.getContextPath() + "</h1>");
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
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) {
            response.sendRedirect("ViewPostManager");
            return;
        }
        int postId = Integer.parseInt(postIdStr);

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PostDAO postDAO = new PostDAO(conn);

            Post post = postDAO.getPostById(postId);
            if (post == null) {
                response.sendRedirect("ViewPostManager");
                return;
            }

            request.setAttribute("post", post);
            request.getRequestDispatcher("UpdatePost.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi lấy dữ liệu bài viết");
        } catch (Exception e) {
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
        String postIdStr = request.getParameter("postId");
        String action = request.getParameter("action"); // lấy param action

        if (postIdStr == null) {
            response.sendRedirect("ViewPostManager");
            return;
        }

        int postId = Integer.parseInt(postIdStr);

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PostDAO postDAO = new PostDAO(conn);

            if ("approve".equals(action) || "reject".equals(action)) {
                // Xử lý duyệt hoặc từ chối
                String newStatus = "approve".equals(action) ? "approved" : "rejected";
                postDAO.updatePostStatus(postId, newStatus);
            } else {
                // Xử lý update thông tin bài viết
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String type = request.getParameter("type");

                if (title == null || content == null || type == null) {
                    response.sendRedirect("ViewPostManager");
                    return;
                }

                Post post = postDAO.getPostById(postId);
                if (post == null) {
                    response.sendRedirect("ViewPostManager");
                    return;
                }

                post.setTitle(title);
                post.setContent(content);
                post.setType(type);

                postDAO.updatePost(post);
            }

            response.sendRedirect("ViewPostManager");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi cập nhật bài viết");
        }catch (Exception e){
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
