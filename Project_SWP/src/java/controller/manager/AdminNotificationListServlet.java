package controller.manager;

import DAO.NotificationDAO;
import Model.Notification;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/notification_list")
public class AdminNotificationListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        int page = 1;
        int size = 5;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * size;

        NotificationDAO dao = new NotificationDAO();
        List<Notification> list = dao.searchNotifications(keyword, offset, size);
        int total = dao.countNotifications(keyword);
        int totalPages = (int) Math.ceil((double) total / size);

        request.setAttribute("notifications", list);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("notification_list.jsp").forward(request, response);
    }
}
