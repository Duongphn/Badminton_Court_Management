package controller.manager;

import DAO.NotificationDAO;
import DAO.UserDAO;
import Model.Notification;
import Model.NotificationReceiver;
import Model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/send-notification")
public class SendNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idRaw = request.getParameter("nId");
        if (idRaw == null) {
            response.sendRedirect("notification_list?error=missingId");
            return;
        }

        try {
            int nId = Integer.parseInt(idRaw);
            NotificationDAO ndao = new NotificationDAO();
            UserDAO udao = new UserDAO();

            Notification noti = ndao.getById(nId);
            if (noti == null) {
                response.sendRedirect("notification_list?error=notFound");
                return;
            }

            // Lấy role nếu có
            String roleFilter = request.getParameter("role");
            if (roleFilter == null) {
                roleFilter = "";
            }

            // Lấy trang hiện tại (mặc định là 1)
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException ignored) {
            }

            int pageSize = 10;
            int offset = (page - 1) * pageSize;

            // Lấy danh sách user theo phân trang và lọc role
            List<User> userList = udao.getUsersByRoleAndPage(roleFilter, offset, pageSize);
            int totalUsers = udao.countUsersByRole(roleFilter);
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

            // Truyền dữ liệu
            request.setAttribute("notification", noti);
            request.setAttribute("userList", userList);
            request.setAttribute("role", roleFilter);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("send_notification.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("notification_list?error=invalidId");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] selectedUsers = request.getParameterValues("userIds");
        String notificationIdRaw = request.getParameter("notificationId");

        if (selectedUsers == null || notificationIdRaw == null) {
            response.sendRedirect("notification_list?error=missingData");
            return;
        }

        try {
            int notificationId = Integer.parseInt(notificationIdRaw);
            NotificationDAO ndao = new NotificationDAO();

            Notification notification = ndao.getById(notificationId);
            if (notification == null) {
                response.sendRedirect("notification_list?error=notificationNotFound");
                return;
            }

            LocalDateTime sentTime = notification.getScheduledTime();

            for (String uid : selectedUsers) {
                int userId = Integer.parseInt(uid);
                UserDAO udao = new UserDAO();
                User user = udao.getUserById(userId);

                NotificationReceiver receiver = new NotificationReceiver();
                receiver.setNotificationId(notification);
                receiver.setUserId(user);
                receiver.setReadAt(null);
                receiver.setOpenedAt(sentTime);

                ndao.insertReceiver(receiver);
            }

            response.sendRedirect("notification_list?msg=sent");
        } catch (NumberFormatException e) {
            response.sendRedirect("notification_list?error=invalidUserId");
        }
    }

}
