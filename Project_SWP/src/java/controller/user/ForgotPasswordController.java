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
import java.util.UUID;
import Model.User;
import utils.EmailUtils;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordController extends HttpServlet {

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
            out.println("<title>Servlet ForgotPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
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
        String email = request.getParameter("email");

        UserDAO userDAO = new UserDAO();

        // Sử dụng hàm mới: checkUserByUsernameOrEmail
        Object[] result = userDAO.checkUserByUsernameOrEmail(username, email);
        int code = (int) result[0];
        User user = (User) result[1];

        if (code == 4) {
            // ĐÚNG user → Gửi email reset password

            // Tạo token ngẫu nhiên và lưu vào DB
            String token = UUID.randomUUID().toString();
            UserDAO tokenDAO = new UserDAO();
            tokenDAO.saveResetToken(user.getUser_Id(), token);

            // Tạo link đặt lại mật khẩu
            String resetLink = request.getRequestURL().toString().replace("forgotPassword", "resetPassword")
                    + "?token=" + token;

            // Gửi email chứa link đặt lại
            String content = "<h3>Xin chào " + user.getUsername() + ",</h3>"
                    + "<p>Click vào liên kết dưới đây để đặt lại mật khẩu. Link có hiệu lực trong 5 phút:</p>"
                    + "<p><a href='" + resetLink + "'>Đặt lại mật khẩu</a></p>";

            boolean sent = EmailUtils.sendEmail(user.getEmail(), "Đặt lại mật khẩu", content);

            if (sent) {
                request.setAttribute("message", "Đã gửi email đặt lại mật khẩu. Vui lòng kiểm tra hộp thư.");
            } else {
                request.setAttribute("error", "Gửi email thất bại. Vui lòng thử lại sau.");
            }

        } else if (code == 1) {
            // Chỉ trùng username
            request.setAttribute("error", "Username đã tồn tại, nhưng email không đúng.");

        } else if (code == 2) {
            // Chỉ trùng email
            request.setAttribute("error", "Email đã tồn tại, nhưng username không đúng.");

        } else if (code == 3) {
            // Không trùng gì
            request.setAttribute("error", "Không tìm thấy tài khoản với tên đăng nhập hoặc email đã cung cấp.");

        } else {
            // Lỗi DB
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình xử lý. Vui lòng thử lại sau.");
        }

        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
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
