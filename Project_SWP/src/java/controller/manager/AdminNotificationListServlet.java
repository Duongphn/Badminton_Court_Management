package controller.manager;

import DAO.NotificationDAO;
import Model.Notification;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet("/notification_list")
public class AdminNotificationListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        String status = request.getParameter("status");
        if (status == null) status = "";  // Nếu không có trạng thái thì không lọc theo trạng thái

        int page = 1;
        int size = 5;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * size;

        NotificationDAO dao = new NotificationDAO();
        
        List<Notification> list = null;
        try {
            list = dao.searchNotificationsByStatus(keyword, status, offset, size);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminNotificationListServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Lỗi không tìm thấy lớp cơ sở dữ liệu!");
        }

        // Đưa kết quả vào request
        if (list != null && !list.isEmpty()) {
            request.setAttribute("notifications", list);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("currentPage", page);
        } else {
            request.setAttribute("error", "Không tìm thấy thông báo nào.");
        }

        // Chuyển tiếp tới JSP
        request.getRequestDispatcher("notification_list.jsp").forward(request, response);
    }
}

