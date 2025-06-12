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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.PasswordUtil;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/resetPassword"})
public class ResetPasswordController extends HttpServlet {

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
            out.println("<title>Servlet ResetPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordController at " + request.getContextPath() + "</h1>");
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
        String token = request.getParameter("token");

        UserDAO dao = new UserDAO();
        if (dao.isValidToken(token)) {
            request.setAttribute("token", token);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
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

        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Kiểm tra confirm password
        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.setAttribute("token", token); // giữ lại token để hiển thị lại form
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }
        

String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{6,}$";

if (newPassword == null || !newPassword.matches(passwordPattern)) {
    request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, gồm ít nhất 1 chữ hoa, 1 số và 1 ký tự đặc biệt.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    return; 
}



        // Mã hóa mật khẩu mới (nếu bạn có PasswordUtil)
        String hashedPassword = PasswordUtil.hashPassword(newPassword);

        UserDAO dao = new UserDAO();
        boolean updated = dao.updatePasswordByToken(token, hashedPassword);

        if (updated) {
            request.getSession().setAttribute("message", "Cập nhật mật khẩu thành công. Vui lòng đăng nhập.");
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
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
