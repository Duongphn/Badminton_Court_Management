/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.User;
import utils.PasswordUtil;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("login.jsp").forward(request, response);
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");

        UserDAO userDAO = new UserDAO();

        String hashedPassword = PasswordUtil.hashPassword(password);

        User user = userDAO.login(username, hashedPassword);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("on".equals(remember)) {
                Cookie cUser = new Cookie("username", username);
                Cookie cPass = new Cookie("password", password);
                Cookie cRemember = new Cookie("remember", "on");

                cUser.setMaxAge(7 * 24 * 60 * 60);    // 7 ngày
                cPass.setMaxAge(7 * 24 * 60 * 60);
                cRemember.setMaxAge(7 * 24 * 60 * 60);

                response.addCookie(cUser);
                response.addCookie(cPass);
                response.addCookie(cRemember);
            } else {

                Cookie cUser = new Cookie("username", null);
                Cookie cPass = new Cookie("password", null);
                Cookie cRemember = new Cookie("remember", null);
                cUser.setMaxAge(0);
                cPass.setMaxAge(0);
                cRemember.setMaxAge(0);
                response.addCookie(cUser);
                response.addCookie(cPass);
                response.addCookie(cRemember);
            }

            if ("staff".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("view-region");
            } else if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("user_manager.jsp");
            } else {
                response.sendRedirect("homepageUser.jsp");
            }

        } else {

            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
