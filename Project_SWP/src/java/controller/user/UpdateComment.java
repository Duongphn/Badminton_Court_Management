/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.CommentDAO;
import Dal.DBContext;
import Model.Comment;
import Model.User;
import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateComment", urlPatterns = {"/UpdateComment"})
public class UpdateComment extends HttpServlet {

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
            out.println("<title>Servlet UpdateComment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateComment at " + request.getContextPath() + "</h1>");
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
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String commentIdStr = request.getParameter("commentId");
        String content = request.getParameter("content");

        try {
            if (user == null || commentIdStr == null || content == null || content.trim().isEmpty()) {
                response.sendRedirect("login.jsp");
                return;
            }
            int commentId = Integer.parseInt(commentIdStr);

            // Lấy thông tin comment từ DB
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            CommentDAO commentDAO = new CommentDAO();
            Comment comment = commentDAO.getCommentById(commentId);

            // Kiểm tra quyền sở hữu
            if (comment == null || comment.getUserId() != user.getUser_Id()) {
                response.sendError(403, "Bạn không có quyền sửa bình luận này!");
                return;
            }

            // Thực hiện cập nhật
            commentDAO.updateCommentContent(commentId, content);

            // Redirect lại bài viết chi tiết (tìm postId từ comment)
            response.sendRedirect("PostDetail?id=" + comment.getPostId());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Có lỗi xảy ra khi cập nhật bình luận.");
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
