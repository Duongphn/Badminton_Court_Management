/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.PasswordUtil;

/**
 *
 * @author admin
 */
@WebServlet(name = "Change_pass", urlPatterns = {"/change-pass"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
       request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private boolean isValidPassword(String password) {
    if (password.length() < 8) {
        return false;
    }
    if (!Character.isUpperCase(password.charAt(0))) {
        return false;
    }
    
    String specialChars = ".*[!@#$%^&*(),.?\":{}|<>0-9].*";
    if (!password.matches(specialChars)) {
        return false;
    }
    return true;
}
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String username = request.getParameter("username");
    String oldPass = request.getParameter("old-password");
    String newPass = request.getParameter("new-password");
    String confirmPass = request.getParameter("confirm-password");

    UserDAO dao = new UserDAO();
    User user = dao.getUserByUsername(username);

    
    if (user == null) {
        request.setAttribute("error", "Không tìm thấy tài khoản với tên đăng nhập này!"); 
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        return;
    }

    
    String hashedOldPass = PasswordUtil.hashPassword(oldPass);
    if (!user.getPassword().equals(hashedOldPass)) {
        request.setAttribute("error", "Mật khẩu cũ không chính xác!"); 
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        return;
    }

   
    if (!newPass.equals(confirmPass)) {
        request.setAttribute("error", "Mật khẩu mới và mật khẩu xác nhận không khớp!"); 
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        return;
    }

    
    String hashedNewPass = PasswordUtil.hashPassword(newPass);
    if (hashedNewPass.equals(user.getPassword())) {
        request.setAttribute("error", "Mật khẩu mới phải khác mật khẩu cũ!"); 
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        return;
    }

    if (!isValidPassword(newPass)) {
    request.setAttribute("error", "Mật khẩu mới phải có ít nhất 8 ký tự, chữ cái đầu viết hoa và ít nhất 1 ký tự đặc biệt hoặc số!");
    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    return;
}
   

    user.setPassword(hashedNewPass);
    dao.updatePassword(user);

    
  
   
    request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
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
