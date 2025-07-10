/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "PostView", urlPatterns = {"/PostView"})
public class PostView extends HttpServlet {

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
            out.println("<title>Servlet PostView</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostView at " + request.getContextPath() + "</h1>");
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
        String type = request.getParameter("type");
        String keyword = request.getParameter("search");

        int page = 1;
        int recordsPerPage = 5;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * recordsPerPage;
        int limit = recordsPerPage;
        
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PostDAO dao = new PostDAO(conn);
            HttpSession session = request.getSession(false);
            int userId = -1;
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                userId = user.getUser_Id();
            }
            List<Post> posts = dao.getPostsForUser(type, keyword, userId, offset, limit);

            int totalRecords = dao.getTotalApprovedPostCount(type, keyword);
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            if (type == null || type.isEmpty()) {
                
                List<Post> latestNews = dao.getLatestNews(1); 
                Post newsFeatured = latestNews.isEmpty() ? null : latestNews.get(0);
                
                List<Post> allPosts = dao.getPostsForUser(null, keyword, userId, offset, limit);

                List<Post> otherPosts = new ArrayList<>();
                for (Post p : allPosts) {
                    if (newsFeatured == null || p.getPostId() != newsFeatured.getPostId()) {
                        otherPosts.add(p);
                    }
                }

                request.setAttribute("newsFeatured", newsFeatured);
                request.setAttribute("otherPosts", otherPosts);

            } else {
                request.setAttribute("posts", posts);
            }
            request.getRequestDispatcher("PostView.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi lấy danh sách bài viết");
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
