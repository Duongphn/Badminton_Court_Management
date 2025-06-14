package controller.manager;

import DAO.NotificationDAO;
import DAO.UserDAO;
import Model.Notification;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/edit-notification")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class EditNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Notification notification = new NotificationDAO().getById(id);

        if (notification == null) {
            request.setAttribute("error", "Không tìm thấy thông báo.");
            response.sendRedirect("notification_list");
            return;
        }

        request.setAttribute("notification", notification);
        request.getRequestDispatcher("edit_notification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String scheduledTimeStr = request.getParameter("scheduledTime");

        LocalDateTime scheduledTime = LocalDateTime.parse(scheduledTimeStr);

        Part filePart = request.getPart("file");
        String fileUrl = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadDir = getServletContext().getRealPath("/uploads");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(uploadDir + File.separator + fileName);

            String fullServerPath = request.getScheme() + "://" +
                                    request.getServerName() + ":" +
                                    request.getServerPort() +
                                    request.getContextPath();
            fileUrl = fullServerPath + "/uploads/" + fileName;
        }

        NotificationDAO dao = new NotificationDAO();
        Notification existing = dao.getById(id);
        if (existing == null) {
            request.setAttribute("error", "Không tìm thấy thông báo.");
            response.sendRedirect("notification_list");
            return;
        }

        existing.setTitle(title);
        existing.setContent(content);
        existing.setScheduledTime(scheduledTime);
        if (fileUrl != null) existing.setImageUrl(fileUrl);  // Giữ ảnh cũ nếu không upload ảnh mới

        boolean updated = dao.updateNotification(existing);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/notification_list");
        } else {
            request.setAttribute("error", "Cập nhật thất bại.");
            request.setAttribute("notification", existing);
            request.getRequestDispatcher("/edit_notification.jsp").forward(request, response);
        }
    }
}
