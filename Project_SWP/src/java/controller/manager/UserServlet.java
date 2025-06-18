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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone_number");
        String role = request.getParameter("role");

        Object[] checkResult = userDAO.checkUserByUsernameOrEmail(username, email);
        User userByUsername = (User) checkResult[0];
        User userByEmail = (User) checkResult[1];
        boolean phoneExists = userDAO.isPhoneExists(phone);

        if (userByUsername != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại.");
        } else if (userByEmail != null) {
            request.setAttribute("error", "Email đã tồn tại.");
        } else if (phoneExists) {
            request.setAttribute("error", "Số điện thoại đã tồn tại.");
        }

        if (request.getAttribute("error") != null) {
            List<User> users = userDAO.getUsersByPage(1, 5);
            request.setAttribute("users", users);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", (int) Math.ceil(userDAO.countUsers() / 5.0));
            request.getRequestDispatcher("/user_manager.jsp").forward(request, response);
            return;
        }

        String hashedPassword = utils.PasswordUtil.hashPassword(password);

        User newUser = new User();
        
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword);
        newUser.setEmail(email);
        newUser.setPhone_number(phone);
        newUser.setRole(role);
        newUser.setStatus("active");
        newUser.setCreatedAt(java.time.LocalDateTime.now());

        userDAO.insertUser(newUser);
        

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
            userDAO.updateUser(oldUser);
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

}
