package controller.manager;

import DAO.UserDAO;
import Model.User;
import Model.Staff;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManagerStaff", urlPatterns = {"/manager-staff"})
public class ManagerStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();
        UserDAO staffDAO = new UserDAO();

        // Lấy danh sách tất cả các user có role = staff
        List<User> staffUserList = userDAO.getUsersByRole("staff");

        // Lấy danh sách Staff (có user_id)
        List<Staff> staffList = staffDAO.getAllStaff();

        // Đẩy ra JSP
        request.setAttribute("staffUserList", staffUserList);
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("manager_staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Xử lý cập nhật trạng thái user
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String newStatus = request.getParameter("status");

        UserDAO userDAO = new UserDAO();
        userDAO.updateUserStatus(userId, newStatus);

        // Redirect lại sau khi update
        response.sendRedirect("manager-staff");
    }

    @Override
    public String getServletInfo() {
        return "ManagerStaff - Quản lý nhân viên (Users + Staff)";
    }
}
