package controller.user;

import DAO.UserDAO;
import Model.Staff;
import Model.User;
import utils.PasswordUtil;

import java.io.IOException;
import java.time.LocalDateTime;
import java.sql.Date;

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
        String role = request.getParameter("role");

        // Lấy thêm các field Staff (nếu có)
        String fullName = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String dateOfBirthStr = request.getParameter("date_of_birth");
        String address = request.getParameter("address");
        String idCardNumber = request.getParameter("id_card_number");
        String educationLevel = request.getParameter("education_level");
        String personalNotes = request.getParameter("personal_notes");

        // Validate password
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{6,}$";
        if (password == null || !password.matches(passwordPattern)) {
            request.setAttribute("error", "Password must be at least 6 characters, with at least 1 uppercase letter, 1 number and 1 special character.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate username
        if (username == null || username.trim().isEmpty() || !username.matches("^[a-zA-Z0-9_\\.]{3,20}$")) {
            request.setAttribute("error", "Invalid username! Only letters, numbers, underscores (_) and dots (.) are allowed. Length 3-20 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate phone number
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            request.setAttribute("error", "Phone number is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.matches("^(09|03)\\d{8}$")) {
            request.setAttribute("error", "Invalid phone number! Only numbers starting with 09 or 03 and exactly 10 digits are allowed.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if phone number already exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.isPhoneExists(phoneNumber)) {
            request.setAttribute("error", "Phone number already exists! Please use another phone number.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate role
        if (role == null || (!role.equalsIgnoreCase("user") && !role.equalsIgnoreCase("staff"))) {
            role = "user";  // Default role
        }

        // Validate password confirm
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(PasswordUtil.hashPassword(password));
        newUser.setEmail(email != null ? email : "");
        newUser.setPhone_number(phoneNumber);
        newUser.setRole(role.toLowerCase());
        newUser.setCreatedAt(LocalDateTime.now());

        // Đăng ký User
        boolean checkRegister = userDAO.register(newUser);

        if (checkRegister) {
            // Nếu là staff → lưu thêm bảng Staff
            if (role.equalsIgnoreCase("staff")) {
                Staff newStaff = new Staff();
                newStaff.setUserId(userDAO.getUserByUsername(username)); // Lấy User object

                newStaff.setFullName(fullName != null ? fullName : "");
                newStaff.setGender(gender != null ? gender : "");
                if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                    newStaff.setDateOfBirth(Date.valueOf(dateOfBirthStr));
                }
                newStaff.setAddress(address != null ? address : "");
                newStaff.setPhoneNumber(phoneNumber);
                newStaff.setIdCardNumber(idCardNumber != null ? idCardNumber : "");
                newStaff.setEducationLevel(educationLevel != null ? educationLevel : "");
                newStaff.setPersonalNotes(personalNotes != null ? personalNotes : "");

                boolean check = userDAO.registerStaff(newStaff);
            }

            // Đăng ký thành công → chuyển hướng
            request.getSession().setAttribute("message", "Registration successful! You can now login.");
            response.sendRedirect("login");
        } else {
            // Đăng ký thất bại → hiển thị lỗi
            request.setAttribute("error", "Username or email already exists, please enter another!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "RegisterController - handles user registration and staff registration";
    }
}
