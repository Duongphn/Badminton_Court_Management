package controller.user;

import DAO.UserDAO;
import Model.User;
import utils.PasswordUtil;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");
        String gender = request.getParameter("gender");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String dobStr = request.getParameter("date_of_birth");

        // Kiểm tra mật khẩu
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{6,}$";
        if (password == null || !password.matches(passwordPattern)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất 1 chữ cái viết hoa, 1 số và 1 ký tự đặc biệt.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên đăng nhập
        if (username == null || username.trim().isEmpty() || !username.matches("^[a-zA-Z0-9_\\.]{3,20}$")) {
            request.setAttribute("error", "Tên đăng nhập không hợp lệ! Chỉ cho phép chữ cái, số, dấu gạch dưới (_) và dấu chấm (.). Độ dài từ 3-20 ký tự.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra số điện thoại
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            request.setAttribute("error", "Số điện thoại là bắt buộc!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.matches("^(0)\\d{9}$")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ! Phải bắt đầu bằng 0và có chính xác 10 chữ số.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra số điện thoại đã tồn tại
        UserDAO userDAO = new UserDAO();
        if (userDAO.isPhoneExists(phoneNumber)) {
            request.setAttribute("error", "Số điện thoại đã tồn tại");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu
        if (confirmPassword == null || !confirmPassword.equals(password)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi ngày sinh
        Date dateOfBirth = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                LocalDate localDate = LocalDate.parse(dobStr);
                dateOfBirth = Date.valueOf(localDate);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Định dạng ngày sinh không hợp lệ!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(PasswordUtil.hashPassword(password));
        newUser.setEmail(email != null ? email : "");
        newUser.setPhone_number(phoneNumber);
        newUser.setRole("user");
        newUser.setCreatedAt(LocalDateTime.now());
        newUser.setGender(gender);
        newUser.setFirstname(firstname);
        newUser.setLastname(lastname);
        newUser.setFullname(lastname + " " + firstname);
        newUser.setDateOfBirth(dateOfBirth);

        // Đăng ký tài khoản
        boolean success = userDAO.register(newUser);

        if (success) {
            request.getSession().setAttribute("message", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại, vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "RegisterController - xử lý đăng ký người dùng bao gồm đầy đủ thông tin người chơi";
    }
}
