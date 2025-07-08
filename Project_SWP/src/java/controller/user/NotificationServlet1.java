package controller.user;

import DAO.NotificationDAO;
import Model.NotificationReceiver;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserNotificationServlet", urlPatterns = {"/notifications"})
public class NotificationServlet1 extends HttpServlet {

    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        List<NotificationReceiver> allNotifications = notificationDAO.getNotificationsForUser(currentUser.getUser_Id(), false);
        List<NotificationReceiver> unreadNotifications = notificationDAO.getNotificationsForUser(currentUser.getUser_Id(), true);

        request.setAttribute("allNotifications", allNotifications);
        request.setAttribute("unreadNotifications", unreadNotifications);

        String forUser = request.getParameter("for");
        if ("user".equalsIgnoreCase(forUser)) {
            request.getRequestDispatcher("notification-user.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("notification1.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
