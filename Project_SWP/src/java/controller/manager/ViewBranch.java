/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.AreaDAO;
import DAO.UserDAO;
import Model.Branch;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "view-region", urlPatterns = {"/view-region"})
public class ViewBranch extends HttpServlet {

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
            out.println("<title>Servlet ViewRegion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRegion at " + request.getContextPath() + "</h1>");
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
        Cookie cookies[] = request.getCookies();
        String authToken = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("auth_token".equals(cookie.getName())) {
                    authToken = cookie.getValue();
                }
            }
        }
        if (authToken != null && validateToken(authToken)) {
            String username = getUsernameFromToken(authToken);
            UserDAO dao = new UserDAO();
            User u = dao.getUserByUsername(username);
            HttpSession session = request.getSession();
            if (u.getRole().equals("staff")) {
                session.setAttribute("user", u);
            }
        }
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("staff")) {
                int page = 1;
                int recordsPerpage = 5;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));

                }
                String regionName = request.getParameter("regionName");
                if (regionName == null) {
                    regionName = "";
                }
                AreaDAO dao = new AreaDAO();
                int numberofRegion = dao.countAreasByManagerId(user.getUser_Id());
                int numberofPage = (int) Math.ceil((double) numberofRegion / recordsPerpage);
                
                List<Branch> area = new AreaDAO().getAllByManagerID(user.getUser_Id(), (page - 1) * recordsPerpage, recordsPerpage);
                System.out.println("areas page "+page+": "+area);
                
                System.out.println("rcpp: "+recordsPerpage);
                request.setAttribute("area", area);
                request.setAttribute("numberOfPages", numberofPage);
                request.setAttribute("currentPage", page);
                 String error = (String) session.getAttribute("error");
                if (error != null) {
                    request.setAttribute("error", error);
                    session.removeAttribute("error");
                }
               
               
                request.getRequestDispatcher("manager-region.jsp").forward(request, response);
                
                
            } else {
                response.sendError(403);
            }

        } else {
            response.sendRedirect("login");
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

    private boolean validateToken(String token) {
        // Xác thực token, ví dụ kiểm tra token trong cơ sở dữ liệu
        return token.endsWith("_0810_token"); // Ví dụ đơn giản, bạn nên sử dụng cơ chế an toàn hơn
    }

    private String getUsernameFromToken(String token) {
        // Lấy username từ token
        return token.replace("_0810_token", "");
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
