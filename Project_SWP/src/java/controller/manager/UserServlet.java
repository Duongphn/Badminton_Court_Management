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
import java.util.List;
import utils.PasswordUtil;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;
    private static final int PAGE_SIZE = 10;

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

    // Đếm tổng số user sau lọc
    int totalUsers = userDAO.countUsersByFilter(keyword, status);
    int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);

    // Lấy danh sách user phân trang, có filter
    List<User> users = userDAO.getUsersByPageAndFilter(page, PAGE_SIZE, keyword, status);

    request.setAttribute("users", users);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);

    // Để giữ lại filter trên giao diện
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

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(PasswordUtil.hashPassword(password));
            newUser.setEmail(email);
            newUser.setPhone_number(phone);
            newUser.setRole(role);
            newUser.setStatus("active");
            newUser.setCreatedAt(java.time.LocalDateTime.now());

            userDAO.insertUser(newUser);

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
