package controller.user;

import DAO.NotificationDAO;
import Model.Notification;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/view-notification")
public class ViewNotification extends HttpServlet {

    // Logger để ghi lại thông tin lỗi và thông báo
    private static final Logger logger = Logger.getLogger(ViewNotification.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id của thông báo từ tham số URL
        String notificationIdStr = request.getParameter("id");

        // Kiểm tra nếu ID thông báo có hợp lệ hay không
        if (notificationIdStr != null && !notificationIdStr.isEmpty()) {
            try {
                int notificationId = Integer.parseInt(notificationIdStr);

                // Truy vấn thông báo từ cơ sở dữ liệu
                NotificationDAO notificationDAO = new NotificationDAO();
                Notification notification = notificationDAO.getById(notificationId);

                // Kiểm tra xem thông báo có tồn tại không
                if (notification != null) {
                    // Nếu tồn tại, gửi thông báo vào request và forward tới JSP
                    request.setAttribute("notification", notification);
                    request.getRequestDispatcher("/view_notification.jsp").forward(request, response);
                } else {
                    // Nếu không tìm thấy thông báo, trả về lỗi 404 (Không tìm thấy)
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Thông báo không tồn tại");
                }
            } catch (NumberFormatException e) {
                // Nếu ID không hợp lệ (không thể chuyển đổi thành số), trả về lỗi 400 (Bad Request)
                logger.log(Level.WARNING, "ID thông báo không hợp lệ: {0}", notificationIdStr);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID thông báo không hợp lệ");
            } catch (Exception e) {
                // Xử lý lỗi bất kỳ (ví dụ: lỗi khi truy vấn cơ sở dữ liệu)
                logger.log(Level.SEVERE, "Lỗi khi truy vấn thông báo: {0}", e.getMessage());
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống, vui lòng thử lại sau.");
            }
        } else {
            // Nếu thiếu tham số ID thông báo trong URL, trả về lỗi 400 (Bad Request)
            logger.log(Level.WARNING, "Thiếu tham số ID thông báo trong yêu cầu");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID thông báo");
        }
    }
}
