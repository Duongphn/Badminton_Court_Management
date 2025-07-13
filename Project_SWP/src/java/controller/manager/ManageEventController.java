package controller.manager;

import DAO.EventDAO;
import DAO.UserDAO;
import Model.Event;
import Model.EventParticipant;
import Model.Branch;
import Model.User;
import utils.EmailUtils;
import utils.TokenUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "ManageEventController", urlPatterns = {"/manage-event"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ManageEventController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        EventDAO eventDAO = new EventDAO();

        switch (action) {
            case "add":
                showAddEventForm(request, response);
                break;
            case "create":
                createEvent(request, response);
                break;
            case "edit":
                showEditEventForm(request, response);
                break;
            case "update":
                updateEvent(request, response);
                break;
            case "delete":
                deleteEvent(request, response);
                break;
            case "sendEmail":
                sendEventEmail(request, response);
                break;
            case "participants":
                viewParticipants(request, response);
                break;
            default: // list
                listEvents(request, response);
                break;
        }
    }

    private void listEvents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO eventDAO = new EventDAO();
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr == null) ? 1 : Integer.parseInt(pageStr);
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        List<Event> eventList = eventDAO.getEvents(keyword, currentPage, PAGE_SIZE);
        int totalEvents = eventDAO.getTotalEvents(keyword);
        int totalPages = (int) Math.ceil((double) totalEvents / PAGE_SIZE);

        request.setAttribute("eventList", eventList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("event/event-list.jsp").forward(request, response);
    }

    private void showAddEventForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO eventDAO = new EventDAO();
        List<Branch> areaList = eventDAO.getAllAreas();
        request.setAttribute("areaList", areaList);
        request.getRequestDispatcher("event/event-add.jsp").forward(request, response);
    }

    private void createEvent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String name = request.getParameter("name");
            String title = request.getParameter("title");
            int createdBy = 1; // Assuming admin user with ID 1, you might want to get this from session
            Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate").replace("T", " ") + ":00");
            Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate").replace("T", " ") + ":00");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));

            Part part = request.getPart("imageUrl");
            String imagePath = uploadFile(part);

            Event event = new Event(0, name, imagePath, title, createdBy, startDate, endDate, null, status, areaId);
            EventDAO eventDAO = new EventDAO();
            eventDAO.addEvent(event);
            response.sendRedirect("manage-event");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-event?action=add&error=true");
        }
    }

    private void showEditEventForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("id"));
        EventDAO eventDAO = new EventDAO();
        Event event = eventDAO.getEventById(eventId);
        List<Branch> areaList = eventDAO.getAllAreas();
        
        request.setAttribute("event", event);
        request.setAttribute("areaList", areaList);
        request.getRequestDispatcher("event/event-edit.jsp").forward(request, response);
    }

    private void updateEvent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String name = request.getParameter("name");
            String title = request.getParameter("title");
            Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate").replace("T", " ") + ":00");
            Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate").replace("T", " ") + ":00");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));

            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(eventId);

            Part part = request.getPart("imageUrl");
            if (part != null && part.getSize() > 0) {
                String imagePath = uploadFile(part);
                event.setImageUrl(imagePath);
            }

            event.setName(name);
            event.setTitle(title);
            event.setStartDate(startDate);
            event.setEndDate(endDate);
            event.setStatus(status);
            event.setAreaId(areaId);

            eventDAO.updateEvent(event);
            response.sendRedirect("manage-event");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-event?action=edit&id=" + request.getParameter("eventId") + "&error=true");
        }
    }

    private String uploadFile(Part part) throws IOException {
        String fileName = extractFileName(part);
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            part.write(uploadPath + File.separator + fileName);
            return "uploads/" + fileName;
        }
        return null;
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int eventId = Integer.parseInt(request.getParameter("id"));
        EventDAO eventDAO = new EventDAO();
        eventDAO.deleteEvent(eventId);
        response.sendRedirect("manage-event");
    }

    private void viewParticipants(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("id"));
        EventDAO eventDAO = new EventDAO();
        List<EventParticipant> participants = eventDAO.getParticipantsByEvent(eventId);
        Event event = eventDAO.getEventById(eventId);

        request.setAttribute("participants", participants);
        request.setAttribute("event", event);
        request.getRequestDispatcher("event/event-participants.jsp").forward(request, response);
    }

    private void sendEventEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("id"));
            EventDAO eventDAO = new EventDAO();
            UserDAO userDAO = new UserDAO();
            
            // Lấy thông tin sự kiện
            Event event = eventDAO.getEventById(eventId);
            if (event == null) {
                response.sendRedirect("manage-event?error=event_not_found");
                return;
            }
            
            // Lấy danh sách tất cả user có role "user"
            List<User> users = userDAO.getUsersByRole("user");
            
            if (users.isEmpty()) {
                response.sendRedirect("manage-event?error=no_users_found");
                return;
            }
            
            // Tạo nội dung email
            String subject = "Mời tham gia sự kiện: " + event.getName();
            String emailContent = createEventEmailContent(event);
            
            // Gửi email cho từng user
            int successCount = 0;
            for (User user : users) {
                if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
                    // Tạo token an toàn cho join event link
                    String token = TokenUtils.createJoinEventToken(eventId, user.getUser_Id());
                    
                    if (token != null) {
                        // Thay thế placeholder với token
                        String personalizedContent = emailContent.replace("{JOIN_TOKEN}", token);
                        
                        if (EmailUtils.sendEmail(user.getEmail(), subject, personalizedContent)) {
                            successCount++;
                        }
                    }
                }
            }
            
            // Redirect với thông báo
            response.sendRedirect("manage-event?success=email_sent&count=" + successCount + "&total=" + users.size());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-event?error=send_email_failed");
        }
    }

    private String createEventEmailContent(Event event) {
        // Sử dụng template chính xác từ email.jsp bao gồm cả ảnh
        StringBuilder content = new StringBuilder();
        
        content.append("<!DOCTYPE html>");
        content.append("<html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\">");
        content.append("<head>");
        content.append("<title>Mời tham gia sự kiện - BadmintonCourt</title>");
        content.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        content.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
        
        // CSS từ email.jsp
        content.append("<style>");
        content.append("* { box-sizing: border-box; }");
        content.append("body { margin: 0; padding: 0; }");
        content.append("a[x-apple-data-detectors] { color: inherit !important; text-decoration: inherit !important; }");
        content.append("#MessageViewBody a { color: inherit; text-decoration: none; }");
        content.append("p { line-height: inherit; }");
        content.append(".desktop_hide, .desktop_hide table { mso-hide: all; display: none; max-height: 0px; overflow: hidden; }");
        content.append(".image_block img+div { display: none; }");
        content.append("sup, sub { font-size: 75%; line-height: 0; }");
        content.append("@media (max-width:720px) {");
        content.append(".desktop_hide table.icons-inner { display: inline-block !important; }");
        content.append(".icons-inner { text-align: center; }");
        content.append(".icons-inner td { margin: 0 auto; }");
        content.append(".mobile_hide { display: none; }");
        content.append(".row-content { width: 100% !important; }");
        content.append(".stack .column { width: 100%; display: block; }");
        content.append(".mobile_hide { min-height: 0; max-height: 0; max-width: 0; overflow: hidden; font-size: 0px; }");
        content.append(".desktop_hide, .desktop_hide table { display: table !important; max-height: none !important; }");
        content.append("}");
        content.append("</style>");
        content.append("</head>");
        
        content.append("<body class=\"body\" style=\"background-color: #f5f4f4; margin: 0; padding: 0; -webkit-text-size-adjust: none; text-size-adjust: none;\">");
        
        // Main container
        content.append("<table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #f5f4f4; background-image: none; background-position: top left; background-size: auto; background-repeat: no-repeat;\">");
        content.append("<tbody><tr><td>");
        
        // Row 1 - Hero Image
        content.append("<table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tbody><tr><td>");
        content.append("<table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 700px; margin: 0 auto;\" width=\"700\">");
        content.append("<tbody><tr>");
        content.append("<td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-top: 5px; vertical-align: top;\">");
        content.append("<table class=\"image_block block-1\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tr>");
        content.append("<td class=\"pad\" style=\"width:100%;\">");
        content.append("<div class=\"alignment\" align=\"center\">");
        content.append("<div style=\"max-width: 700px;\">");
        content.append("<img src=\"https://tse2.mm.bing.net/th/id/OIP.zVK1K_k2OBmi3EuxweLu3AHaFj?rs=1&pid=ImgDetMain&o=7&rm=3/\" ");
        content.append("style=\"display: block; height: auto; border: 0; width: 100%;\" width=\"700\" alt=\"Badminton Event\" height=\"auto\">");
        content.append("</div></div></td></tr></table>");
        content.append("</td></tr></tbody></table>");
        content.append("</td></tr></tbody></table>");
        
        // Row 2 - Main Content
        content.append("<table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tbody><tr><td>");
        content.append("<table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 700px; margin: 0 auto;\" width=\"700\">");
        content.append("<tbody><tr>");
        content.append("<td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-top: 5px; vertical-align: top;\">");
        
        // Title
        content.append("<table class=\"paragraph_block block-1\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;\"><tr>");
        content.append("<td class=\"pad\" style=\"padding-bottom:10px;padding-left:10px;padding-right:10px;\">");
        content.append("<div style=\"color:#db5c4d;font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size:46px;line-height:1.2;text-align:center;mso-line-height-alt:55px;\">");
        content.append("<p style=\"margin: 0; word-break: break-word;\">");
        content.append("<strong><span style=\"word-break: break-word;\"><em>MỜI THAM GIA SỰ KIỆN</em></span></strong>");
        content.append("</p>");
        content.append("<p style=\"margin: 0; word-break: break-word;\">");
        content.append("<strong style=\"background-color: transparent;\"><span style=\"word-break: break-word;\"><em>BADMINTON</em></span></strong>");
        content.append("</p>");
        content.append("</div></td></tr></table>");
        
        // Second Image
        content.append("<table class=\"image_block block-2\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tr>");
        content.append("<td class=\"pad\" style=\"width:100%;\">");
        content.append("<div class=\"alignment\" align=\"center\">");
        content.append("<div style=\"max-width: 700px;\">");
        content.append("<img src=\"https://cdn.pixabay.com/photo/2016/05/31/23/21/badminton-1428046_1280.jpg\" ");
        content.append("style=\"display: block; height: auto; border: 0; width: 100%;\" width=\"700\" alt=\"Badminton Court\" height=\"auto\">");
        content.append("</div></div></td></tr></table>");
        
        // Event Name
        content.append("<table class=\"paragraph_block block-3\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;\"><tr>");
        content.append("<td class=\"pad\" style=\"padding-bottom:10px;padding-left:10px;padding-right:10px;\">");
        content.append("<div style=\"color:#db5c4d;font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size:34px;line-height:1.2;text-align:center;mso-line-height-alt:41px;\">");
        content.append("<p style=\"margin: 0; word-break: break-word;\">");
        content.append("<span style=\"word-break: break-word; color: #e96565; background-color: #e6e5e5;\">");
        content.append("<strong><em>" + event.getName() + "</em></strong>");
        content.append("</span></p>");
        content.append("</div></td></tr></table>");
        
        // Divider
        content.append("<table class=\"divider_block block-4\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tr><td class=\"pad\">");
        content.append("<div class=\"alignment\" align=\"center\">");
        content.append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" width=\"20%\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tr>");
        content.append("<td class=\"divider_inner\" style=\"font-size: 1px; line-height: 1px; border-top: 2px solid #078B66;\">");
        content.append("<span style=\"word-break: break-word;\">&#8202;</span>");
        content.append("</td></tr></table>");
        content.append("</div></td></tr></table>");
        
        // Event Details
        content.append("<table class=\"paragraph_block block-5\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;\"><tr>");
        content.append("<td class=\"pad\" style=\"padding-bottom:20px;padding-left:60px;padding-right:60px;padding-top:10px;\">");
        content.append("<div style=\"color:#e33030;font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size:17px;line-height:1.5;text-align:center;mso-line-height-alt:26px;\">");
        content.append("<p style=\"margin: 0; word-break: break-word;\">");
        content.append("<span style=\"word-break: break-word; color: #000000;\">");
        content.append("<strong>Tiêu đề:</strong> " + event.getTitle() + "<br>");
        content.append("<strong>Thời gian bắt đầu:</strong> " + event.getStartDate() + "<br>");
        content.append("<strong>Thời gian kết thúc:</strong> " + event.getEndDate() + "<br>");
        if (event.getAreaName() != null && !event.getAreaName().isEmpty()) {
            content.append("<strong>Địa điểm:</strong> " + event.getAreaName() + "<br>");
        }
        content.append("Chúng tôi rất vui mừng được mời bạn tham gia sự kiện cầu lông đặc biệt này. ");
        content.append("<strong>Hãy tham gia</strong> cùng chúng tôi để có những trải nghiệm tuyệt vời!");
        content.append("</span></p>");
        content.append("</div></td></tr></table>");
        
        // CTA Button
        content.append("<table class=\"button_block block-6\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt;\"><tr>");
        content.append("<td class=\"pad\" style=\"padding-bottom:50px;padding-left:25px;padding-right:25px;padding-top:10px;text-align:center;\">");
        content.append("<div class=\"alignment\" align=\"center\">");
        content.append("<span class=\"button\" style=\"background-color: #FFCC39; border-bottom: 0px solid transparent; border-left: 0px solid transparent; ");
        content.append("border-radius: 50px; border-right: 0px solid transparent; border-top: 0px solid transparent; color: #ffffff; ");
        content.append("display: inline-block; font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 32px; ");
        content.append("font-weight: undefined; mso-border-alt: none; padding-bottom: 5px; padding-top: 5px; ");
        content.append("padding-left: 55px; padding-right: 55px; text-align: center; width: auto; word-break: keep-all; letter-spacing: normal;\">");
                 content.append("<a href=\"http://localhost:8080/Project_SWP_2/join-event?token={JOIN_TOKEN}\" ");
         content.append("style=\"color: #ffffff; text-decoration: none; word-break: break-word; line-height: 64px;\">");
        content.append("Tham gia ngay!");
        content.append("</a></span>");
        content.append("</div></td></tr></table>");
        
        content.append("</td></tr></tbody></table>");
        content.append("</td></tr></tbody></table>");
        
        // Row 3 - Footer
        content.append("<table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #e56848;\"><tbody><tr><td>");
        content.append("<table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 700px; margin: 0 auto;\" width=\"700\">");
        content.append("<tbody><tr>");
        content.append("<td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 25px; padding-top: 25px; vertical-align: top;\">");
        content.append("<table class=\"paragraph_block block-1\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;\"><tr><td class=\"pad\">");
        content.append("<div style=\"color:#000000;font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size:14px;line-height:1.5;text-align:center;mso-line-height-alt:21px;\">");
        content.append("<p style=\"margin: 0;\"><strong><u>BadmintonCourt</u></strong></p>");
        content.append("</div></td></tr></table>");
        content.append("</td></tr></tbody></table>");
        content.append("</td></tr></tbody></table>");
        
        // Row 4 - Bottom with logo
        content.append("<table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff;\"><tbody><tr><td>");
        content.append("<table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; background-color: #ffffff; width: 700px; margin: 0 auto;\" width=\"700\">");
        content.append("<tbody><tr>");
        content.append("<td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-top: 5px; vertical-align: top;\">");
        content.append("<table class=\"icons_block block-1\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" ");
        content.append("style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; text-align: center; line-height: 0;\"><tr>");
        content.append("<td class=\"pad\" style=\"vertical-align: middle; color: #1e0e4b; font-family: 'Inter', sans-serif; font-size: 15px; padding-bottom: 5px; padding-top: 5px; text-align: center;\">");
        content.append("<table class=\"icons-inner\" style=\"mso-table-lspace: 0pt; mso-table-rspace: 0pt; display: inline-block; padding-left: 0px; padding-right: 0px;\" ");
        content.append("cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\"><tr>");
        content.append("<td style=\"vertical-align: middle; text-align: center; padding-top: 5px; padding-bottom: 5px; padding-left: 5px; padding-right: 6px;\">");
        content.append("</td>");
        content.append("<td style=\"font-family: 'Inter', sans-serif; font-size: 15px; font-weight: undefined; color: #1e0e4b; vertical-align: middle; letter-spacing: undefined; text-align: center; line-height: normal;\">");
        content.append("BadmintonCourt - Hệ thống đặt sân cầu lông");
        content.append("</td></tr></table>");
        content.append("</td></tr></table>");
        content.append("</td></tr></tbody></table>");
        content.append("</td></tr></tbody></table>");
        
        content.append("</td></tr></tbody></table>");
        content.append("</body></html>");
        
        return content.toString();
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
        return "Short description";
    }
}