package controller.user;

import DAO.*;
import Model.*;
import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.time.LocalDate;
import static java.time.LocalDate.now;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.*;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyDNuTvU_1Q3bS-LXSqFymuEcVpESv6thl8";
    private static final String GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + GEMINI_API_KEY;
    private ChatDAO chatDAO = new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Integer userId = (user != null) ? user.getUser_Id() : null;
        List<ChatMessage> chatHistory = new ArrayList<>();
        if (userId != null) {
            chatHistory = chatDAO.getMessagesByUser(userId);
        }
        request.setAttribute("chatHistory", chatHistory);
        System.out.println("lich su:" + chatHistory);
        request.getRequestDispatcher("homepageUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        Integer userId = (currentUser != null) ? currentUser.getUser_Id() : null;

        String userMessage = request.getParameter("message").trim();

        boolean isBookingCmd = userMessage.toLowerCase().matches(".*(đặt|book).*sân.*");

        if (isBookingCmd && userId == null) {

            response.getWriter().write("️ Bạn cần đăng nhập trước khi đặt sân.");
            return;
        }

        chatDAO.saveMessage(new ChatMessage(userId, userMessage, "user"));

        String botResponse;

        if (userMessage.toLowerCase().matches(".*(đặt|book).*sân.*\\d+.*từ.*đến.*")) {
            botResponse = handleBookingSubmission(userId, userMessage);
        } else if (userMessage.toLowerCase().matches(".*(đặt|book).*sân.*\\d{2}/\\d{2}/\\d{4}.*")) {
            botResponse = handleBookingRequest(userId, userMessage);
        } else {
            botResponse = generateGeminiResponse(userMessage);
        }

        chatDAO.saveMessage(new ChatMessage(null, botResponse, "bot"));
        response.getWriter().write(botResponse);
    }

    private String handleBookingRequest(Integer userId, String message) {
        if (userId == null) {
            return "Bạn cần đăng nhập trước khi đặt sân.";
        }

        Pattern pattern = Pattern.compile("đặt sân (\\d{2}/\\d{2}/\\d{4})");
        Matcher matcher = pattern.matcher(message.toLowerCase());
        if (!matcher.find()) {
            return "Vui lòng nhập đúng mẫu: 'đặt sân dd/MM/yyyy'.";
        }

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate date = LocalDate.parse(matcher.group(1), formatter);

            AreaDAO areaDAO = new AreaDAO();
            CourtDAO courtDAO = new CourtDAO();
            BookingDAO bookingDAO = new BookingDAO();
            Service_BranchDAO serviceDAO = new Service_BranchDAO();

            StringBuilder responseBuilder = new StringBuilder();
            responseBuilder.append("\n");
            responseBuilder.append(" DANH SÁCH SLOT TRỐNG NGÀY ").append(matcher.group(1)).append("**\n");
            responseBuilder.append("----------\n\n");

            List<Branch> areas = areaDAO.getAllAreas();
            for (Branch area : areas) {
                responseBuilder.append(" **Khu vực: ").append(area.getName())
                        .append("** (ID: ").append(area.getArea_id()).append(")\n");
                responseBuilder.append("---------------\n");

                List<Courts> courts = courtDAO.getCourtsByAreaId(area.getArea_id());
                if (courts == null || courts.isEmpty()) {
                    responseBuilder.append("   Không có sân nào trong khu vực này.\n\n");
                    continue;
                }

                for (Courts court : courts) {
                    responseBuilder.append("  Sân: ").append(court.getCourt_number())
                            .append(" (ID: ").append(court.getCourt_id()).append(")\n");

                    List<Slot> availableSlots = bookingDAO.getAvailableSlots(court.getCourt_id(), date);
                    if (availableSlots == null || availableSlots.isEmpty()) {
                        responseBuilder.append("      - Không còn slot trống.\n");
                    } else {
                        for (Slot slot : availableSlots) {
                            responseBuilder.append("      - [").append(slot.getStart())
                                    .append(" - ").append(slot.getEnd()).append("]\n");
                        }
                    }
                    responseBuilder.append("\n---");
                }

                List<Branch_Service> services = serviceDAO.getAllAreaServices(area.getArea_id());
                responseBuilder.append("  ️ Dịch vụ: ");
                if (services == null || services.isEmpty()) {
                    responseBuilder.append("Không có\n");
                } else {
                    for (Branch_Service service : services) {
                        responseBuilder.append(service.getService().getName()).append(", ");
                    }
                    responseBuilder.setLength(responseBuilder.length() - 2); 
                    responseBuilder.append("\n");
                }
                responseBuilder.append("=================\n\n");
            }
            return responseBuilder.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return "Có lỗi xảy ra khi lấy thông tin các slot trống. Vui lòng thử lại.";
        }
    }

    private String handleBookingSubmission(Integer userId, String message) {
        if (userId == null) {
            return "Bạn cần đăng nhập trước khi đặt sân.";
        }

        Pattern pattern = Pattern.compile(
                "đặt sân (\\d+)(?: khu vực ([^\\d]+?))? từ (\\d{2}:\\d{2}) đến (\\d{2}:\\d{2})(?: ngày (\\d{2}/\\d{2}/\\d{4}))?(?: với dịch vụ (.*))?",
                Pattern.CASE_INSENSITIVE
        );
        Matcher matcher = pattern.matcher(message.toLowerCase());

        if (!matcher.find()) {
            return "Câu lệnh chưa đúng định dạng. Hãy nhập: đặt sân [id] từ hh:mm đến hh:mm với dịch vụ [tên dịch vụ, cách nhau bởi dấu phẩy nếu nhiều]";
        }

        try {
            int courtId = Integer.parseInt(matcher.group(1));
            String areaName = matcher.group(2) != null ? matcher.group(2).trim() : null;
            LocalTime localStart = LocalTime.parse(matcher.group(3));
            LocalTime localEnd = LocalTime.parse(matcher.group(4));

            LocalDate bookingDate;
            if (matcher.group(5) != null && !matcher.group(5).isEmpty()) {
                bookingDate = LocalDate.parse(matcher.group(5), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            } else {
                bookingDate = LocalDate.now();
            }
            
             if (bookingDate.equals(LocalDate.now()) && localStart.isBefore(LocalTime.now())) {
            return " Không thể đặt sân cho khung giờ đã qua. "
                 + "Vui lòng chọn thời gian bắt đầu > " + LocalTime.now().truncatedTo(java.time.temporal.ChronoUnit.MINUTES);
        }
            String serviceStr = matcher.group(6); 

            LocalTime now = LocalTime.now();
            Time startTime = Time.valueOf(localStart);
            Time endTime = Time.valueOf(localEnd);

            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            if (court == null) {
                return "Không tìm thấy sân có ID: " + courtId;
            }

            BookingDAO bookingDAO = new BookingDAO();
            if (!bookingDAO.checkSlotAvailable(courtId, bookingDate, startTime, endTime)) {
                return "Slot đã được đặt. Vui lòng chọn slot khác.";
            }

            PromotionDAO proDAO = new PromotionDAO();
            Promotion promotion = proDAO.getCurrentPromotionForArea(court.getArea_id(), bookingDate);
            BigDecimal pricePerHour = courtDAO.getCourtPrice(courtId);
            BigDecimal totalPrice = bookingDAO.calculateSlotPriceWithPromotion(startTime, endTime, pricePerHour, promotion);

            Bookings booking = new Bookings();
            booking.setUser_id(userId);
            booking.setCourt_id(courtId);
            booking.setDate(bookingDate);
            booking.setStart_time(startTime);
            booking.setEnd_time(endTime);
            booking.setTotal_price(totalPrice.doubleValue());
            booking.setStatus("pending");

            if (matcher.group(4) != null) {
                String[] services = matcher.group(4).split(",");
                List<String> serviceList = new ArrayList<>();
                for (String s : services) {
                    serviceList.add(s.trim());
                }
                booking.setServices(serviceList);
            }

            if (bookingDAO.createBooking(booking)) {
                return " Đã đặt sân thành công!\nSân: " + courtId + "\nNgày: " + bookingDate + "\nTừ " + startTime + " đến " + endTime
                        + "\nTổng tiền: " + totalPrice + " VNĐ."
                        + (booking.getServices() != null ? "\nDịch vụ đi kèm: " + String.join(", ", booking.getServices()) : "");
            } else {
                return " Có lỗi xảy ra khi đặt sân. Vui lòng thử lại sau.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "Có lỗi trong quá trình xử lý. Vui lòng thử lại.";
        }
    }

    private String generateGeminiResponse(String message) {
        try {
            URL url = new URL(GEMINI_ENDPOINT);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", JsonParser.parseString("[{\"role\":\"user\",\"parts\":[{\"text\":\"" + message + "\"}]}]"));

            try (OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.toString().getBytes(StandardCharsets.UTF_8));
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            JsonObject jsonResponse = JsonParser.parseString(br.lines().collect(java.util.stream.Collectors.joining())).getAsJsonObject();

            return jsonResponse.getAsJsonArray("candidates").get(0).getAsJsonObject()
                    .get("content").getAsJsonObject()
                    .get("parts").getAsJsonArray().get(0).getAsJsonObject()
                    .get("text").getAsString();

        } catch (Exception e) {
            e.printStackTrace();
            return "Hiện tôi không thể trả lời câu hỏi này.";
        }
    }
}
