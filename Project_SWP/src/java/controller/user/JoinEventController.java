package controller.user;

import DAO.AreaDAO;
import DAO.EventDAO;
import DAO.UserDAO;
import Model.Event;
import Model.User;
import utils.TokenUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "JoinEventController", urlPatterns = {"/join-event"})
public class JoinEventController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "showConfirm";
        }

        switch (action) {
            case "confirm":
                confirmJoinEvent(request, response);
                break;
            case "joinFromPopup":
                joinEventFromPopup(request, response);
                break;
            default: // showConfirm
                showConfirmPage(request, response);
                break;
        }
    }

    private void showConfirmPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String token = request.getParameter("token");
            
            if (token == null || token.trim().isEmpty()) {
                response.sendRedirect("HomePageUser?error=invalid_link");
                return;
            }
            
            // Parse token để lấy eventId và userId
            int[] tokenData = TokenUtils.parseJoinEventToken(token);
            
            if (tokenData == null) {
                response.sendRedirect("HomePageUser?error=invalid_token");
                return;
            }
            
            int eventId = tokenData[0];
            int userId = tokenData[1];
            
            EventDAO eventDAO = new EventDAO();
            UserDAO userDAO = new UserDAO();
            
            Event event = eventDAO.getEventById(eventId);
            User user = userDAO.getUserById(userId);

            AreaDAO areaDAO = new AreaDAO();
            String areaName = areaDAO.getAreaNameById(event.getAreaId());


            if (event == null || user == null) {
                response.sendRedirect("HomePageUser?error=invalid_data");
                return;
            }
            
            // Kiểm tra user đã tham gia chưa
            if (eventDAO.isUserRegistered(eventId, userId)) {
                response.sendRedirect("HomePageUser?info=already_joined");
                return;
            }
            request.setAttribute("areaName", areaName);
            request.setAttribute("event", event);
request.setAttribute("user", user);
            request.setAttribute("token", token); // Truyền token để sử dụng ở form confirm
            request.getRequestDispatcher("join-event-confirm.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomePageUser?error=system_error");
        }
    }

    private void confirmJoinEvent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String token = request.getParameter("token");
            
            if (token == null || token.trim().isEmpty()) {
                response.sendRedirect("HomePageUser?error=invalid_token");
                return;
            }
            
            // Parse token để lấy eventId và userId
            int[] tokenData = TokenUtils.parseJoinEventToken(token);
            
            if (tokenData == null) {
                response.sendRedirect("HomePageUser?error=invalid_token");
                return;
            }
            
            int eventId = tokenData[0];
            int userId = tokenData[1];
            
            EventDAO eventDAO = new EventDAO();
            
            // Thử tham gia event
            boolean success = eventDAO.joinEvent(eventId, userId);
            
            if (success) {
                // Lưu thông tin vào session để hiển thị thông báo
                HttpSession session = request.getSession();
                Event event = eventDAO.getEventById(eventId);
                session.setAttribute("joinEventSuccess", "Bạn đã tham gia sự kiện '" + event.getName() + "' thành công!");
                response.sendRedirect("HomePageUser");
            } else {
                response.sendRedirect("HomePageUser?error=join_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomePageUser?error=system_error");
        }
    }

    // Xử lý join event từ popup homepageUser (không cần token)
    private void joinEventFromPopup(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            // Kiểm tra user đã đăng nhập chưa
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            if (currentUser == null) {
                response.sendRedirect("login.jsp?error=login_required");
                return;
            }
            
            String eventIdStr = request.getParameter("eventId");
            if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
                response.sendRedirect("HomePageUser?error=invalid_event");
                return;
            }
            
            int eventId = Integer.parseInt(eventIdStr);
            int userId = currentUser.getUser_Id();
EventDAO eventDAO = new EventDAO();
            
            // Kiểm tra event có tồn tại không
            Event event = eventDAO.getEventById(eventId);
            if (event == null) {
                response.sendRedirect("HomePageUser?error=event_not_found");
                return;
            }
            
            // Kiểm tra user đã tham gia chưa
            if (eventDAO.isUserRegistered(eventId, userId)) {
                session.setAttribute("joinEventInfo", "Bạn đã tham gia sự kiện '" + event.getName() + "' rồi!");
                response.sendRedirect("HomePageUser");
                return;
            }
            
            // Thử tham gia event
            boolean success = eventDAO.joinEvent(eventId, userId);
            
            if (success) {
                session.setAttribute("joinEventSuccess", "Bạn đã tham gia sự kiện '" + event.getName() + "' thành công!");
                response.sendRedirect("HomePageUser");
            } else {
                response.sendRedirect("HomePageUser?error=join_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("HomePageUser?error=invalid_event_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomePageUser?error=system_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Join Event Controller";
    }
}