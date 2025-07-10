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

@WebServlet("/create-notification")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 10,   // 10 MB
        maxRequestSize = 1024 * 1024 * 20 // 20 MB
)
public class CreateNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("create_notification.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String scheduledTimeStr = request.getParameter("scheduledTime");

        LocalDateTime scheduledTime = LocalDateTime.parse(scheduledTimeStr);
        LocalDateTime now = LocalDateTime.now();
        
        if (scheduledTime.isBefore(now)) {
    request.setAttribute("error", "❗ Không thể tạo thông báo với thời gian trong quá khứ.");
    request.getRequestDispatcher("/create_notification.jsp").forward(request, response);
    return;
}


        // Xử lý file upload
        Part filePart = request.getPart("file");
        String fileUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadDir = getServletContext().getRealPath("/uploads");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(uploadDir + File.separator + fileName);

            // Tạo URL đầy đủ bao gồm host, port và context path
            String fullServerPath = request.getScheme() + "://" +
                                    request.getServerName() + ":" +
                                    request.getServerPort() +
                                    request.getContextPath();
            fileUrl = fullServerPath + "/uploads/" + fileName;
        }

       User currentUser = (User) request.getSession().getAttribute("user");
if (currentUser == null) {
    response.sendRedirect("login");
    return;
}


        // Tạo notification
        Notification n = new Notification();
        n.setTitle(title);
        n.setContent(content);
        n.setImageUrl(fileUrl);
        n.setScheduledTime(scheduledTime);
        n.setCreatedAt(now);
        n.setStatus("scheduled");
        n.setCreatedBy(currentUser);

        boolean ok = new NotificationDAO().createNotification(n);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/notification_list");
        } else {
            request.setAttribute("error", "Tạo thông báo thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/create_notification.jsp").forward(request, response);
        }
    }
}
