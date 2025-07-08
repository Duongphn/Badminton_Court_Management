package controller.user;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SettingNotificationServlet", urlPatterns = {"/setting-notification"})
public class SettingNotificationServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            boolean sendMail = userDAO.getSendMail(user.getUser_Id());
            request.setAttribute("sendMail", sendMail);
        }
        request.getRequestDispatcher("setting-notification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            boolean sendMail = request.getParameter("sendMail") != null;
            userDAO.updateSendMail(user.getUser_Id(), sendMail);
            user.setSendMail(sendMail);
            request.getSession().setAttribute("user", user);
            request.setAttribute("sendMail", sendMail);
            request.setAttribute("message", "Cập nhật thành công!");
        }
        request.getRequestDispatcher("setting-notification.jsp").forward(request, response);
    }
}
