package controller.manager;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.EmailUtils;
import utils.PasswordUtil;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;
    private static final int PAGE_SIZE = 5;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pageStr = request.getParameter("page");
        int page = 1;
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (Exception e) {
            }
        }
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        int totalUsers = userDAO.countUsersByFilter(keyword, status);
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
        List<User> users = userDAO.getUsersByPageAndFilter(page, PAGE_SIZE, keyword, status);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("ban".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String note = request.getParameter("note");
            userDAO.updateUserStatusAndNote(userId, "banned", note);

        } else if ("unban".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.updateUserStatusAndNote(userId, "Active", "");

        } else if ("add".equals(action)) {
            // Lấy dữ liệu từ form
            String username = request.getParameter("username");
            String password = generateRandomPassword();
            String email = request.getParameter("email");
            String phone = request.getParameter("phone_number");
            String role = request.getParameter("role");
            String gender = request.getParameter("gender");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String status = request.getParameter("status");
            String note = request.getParameter("note");
            String dobStr = request.getParameter("date_of_birth");

          // Kiểm tra trùng username / email / phone
Object[] checkResult = userDAO.checkUserByUsernameOrEmail(username, email);

// Kiểm tra kiểu dữ liệu trước khi ép kiểu
User userByUsername = null;
User userByEmail = null;

// Kiểm tra nếu checkResult[0] là kiểu User
if (checkResult[0] instanceof User) {
    userByUsername = (User) checkResult[0];
}

// Kiểm tra nếu checkResult[1] là kiểu User
if (checkResult[1] instanceof User) {
    userByEmail = (User) checkResult[1];
}

boolean phoneExists = userDAO.isPhoneExists(phone);

if (userByUsername != null) {
    request.setAttribute("error", "Tên đăng nhập đã tồn tại.");
} else if (userByEmail != null) {
    request.setAttribute("error", "Email đã tồn tại.");
} else if (phoneExists) {
    request.setAttribute("error", "Số điện thoại đã tồn tại.");
}// Validate username chỉ tối đa 10 ký tự, chỉ nhận chữ cái và số
if (username == null || !username.matches("^[a-zA-Z0-9]{1,10}$")) {
    request.setAttribute("error", "Tên đăng nhập chỉ tối đa 10 ký tự và chỉ gồm chữ cái, số.");
}


if (request.getAttribute("error") != null) {
    List<User> users = userDAO.getUsersByPage(1, 5);
    request.setAttribute("users", users);
    request.setAttribute("currentPage", 1);
    request.setAttribute("totalPages", (int) Math.ceil(userDAO.countUsers() / 5.0));
    request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
    return;
}


            // Hash mật khẩu
            String hashedPassword = PasswordUtil.hashPassword(password);

            // Parse ngày sinh
            Date dateOfBirth = null;
            try {
                if (dobStr != null && !dobStr.isEmpty()) {
                    dateOfBirth = Date.valueOf(dobStr);
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ.");
                List<User> users = userDAO.getUsersByPage(1, 5);
                request.setAttribute("users", users);
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", (int) Math.ceil(userDAO.countUsers() / 5.0));
                request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng User
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(hashedPassword);
            newUser.setEmail(email);
            newUser.setPhone_number(phone);
            newUser.setRole(role != null ? role : "user");
            newUser.setStatus(status != null ? status : "active");
            newUser.setGender(gender);
            newUser.setFirstname(firstname);
            newUser.setLastname(lastname);
            newUser.setNote(note);
            newUser.setDateOfBirth(dateOfBirth);
            newUser.setCreatedAt(LocalDateTime.now());

            // Lưu vào DB
            boolean inserted = userDAO.insertUser(newUser);
            if (!inserted) {
                request.setAttribute("error", "Lỗi khi thêm người dùng vào hệ thống.");
                List<User> users = userDAO.getUsersByPage(1, 5);
                request.setAttribute("users", users);
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", (int) Math.ceil(userDAO.countUsers() / 5.0));
                request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
                return;
            }

            String subject = "Tài khoản Badminton của bạn đã được tạo";
            String content = "<h3>Xin chào " + firstname + " " + lastname + ",</h3>"
                    + "<p>Tài khoản của bạn trên hệ thống đã được tạo thành công.</p>"
                    + "<p><b>Tên đăng nhập:</b> " + username + "</p>"
                    + "<p><b>Mật khẩu:</b> " + password + "</p>"
                    + "<p>Vui lòng đăng nhập và đổi mật khẩu ngay sau lần đăng nhập đầu tiên.</p>"
                    + "<br><p>Trân trọng,<br>Badminton Management Team</p>";

            EmailUtils.sendEmail(email, subject, content);

            // Chuyển hướng sau khi thêm thành công
            response.sendRedirect("users");
            return;
        } else if ("update".equals(action)) {
            String userIdStr = request.getParameter("userId");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone_number");
            String role = request.getParameter("role");

            int userId = 0;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch (Exception ex) {
            }

            User oldUser = userDAO.getUserById(userId);
            if (oldUser != null) {

                boolean phoneExists = userDAO.isPhoneExists(phone);
                Object[] checkResult = userDAO.checkUserByUsernameOrEmail(username, email);
                User userByUsername = (User) checkResult[0];
                User userByEmail = (User) checkResult[1];

                if (userByUsername != null && userByUsername.getUser_Id() != userId) {
                    request.setAttribute("error", "Tên đăng nhập đã tồn tại.");
                } else if (userByEmail != null && userByEmail.getUser_Id() != userId) {
                    request.setAttribute("error", "Email đã tồn tại.");
                } else if (phoneExists && !phone.equals(oldUser.getPhone_number())) {
                    request.setAttribute("error", "Số điện thoại đã tồn tại.");
                }

                if (request.getAttribute("error") != null) {
                    oldUser.setUsername(username);
                    oldUser.setEmail(email);
                    oldUser.setPhone_number(phone);
                    oldUser.setRole(role);

                    request.setAttribute("openEditModal", true);
                    request.setAttribute("editUser", oldUser);

                    List<User> users = userDAO.getUsersByPage(1, 20);
                    request.setAttribute("users", users);
                    request.setAttribute("currentPage", 1);
                    request.setAttribute("totalPages", (int) Math.ceil(userDAO.countUsers() / 20.0));
                    request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
                    return;
                }

                oldUser.setUsername(username);
                oldUser.setEmail(email);
                oldUser.setPhone_number(phone);
                oldUser.setRole(role);
                try {
                    userDAO.updateUser(oldUser);
                } catch (Exception ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        } else if ("delete".equals(action)) {
            String userIdStr = request.getParameter("userId");
            int userId = 0;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch (Exception ex) {
            }
            userDAO.deleteUser(userId);
        }

        response.sendRedirect("users");
    }

    public static String generateRandomPassword() {
        int length = 6;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            password.append(characters.charAt(index));
        }

        return password.toString();
    }

}
