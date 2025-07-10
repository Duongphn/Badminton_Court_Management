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
import java.time.LocalTime;
import java.util.*;
import java.util.regex.*;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyDNuTvU_1Q3bS-LXSqFymuEcVpESv6thl8";
    private static final String GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + GEMINI_API_KEY;
    private ChatDAO chatDAO = new ChatDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        Integer userId = null;

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                userId = user.getUser_Id();
            }
        }

        String userMessage = request.getParameter("message");
        chatDAO.saveMessage(new ChatMessage(userId, userMessage, "user"));

        String botResponse;

        if (userMessage.toLowerCase().matches(".*(đặt|book).*sân.*\\d+.*từ.*đến.*")) {
            botResponse = handleBookingSubmission(userId, userMessage);
        } else if (userMessage.toLowerCase().matches(".*(đặt|book).*sân.*\\d{4}-\\d{2}-\\d{2}.*")) {
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

        Pattern pattern = Pattern.compile("đặt sân (\\d{4}-\\d{2}-\\d{2})");
        Matcher matcher = pattern.matcher(message.toLowerCase());

        if (!matcher.find()) {
            return "Vui lòng nhập đúng mẫu: 'đặt sân yyyy-mm-dd'.";
        }

        try {
            LocalDate date = LocalDate.parse(matcher.group(1));
            CourtDAO courtDAO = new CourtDAO();
            BookingDAO bookingDAO = new BookingDAO();
            Service_BranchDAO serviceDAO = new Service_BranchDAO();

            List<Courts> courts = courtDAO.getAllCourts();
            StringBuilder responseBuilder = new StringBuilder("Các slot trống vào ngày " + date + ":\n");

            for (Courts court : courts) {
                List<Slot> availableSlots = bookingDAO.getAvailableSlots(court.getCourt_id(), date);
                List<Branch_Service> services = serviceDAO.getAllAreaServices(court.getArea_id());

                responseBuilder.append("\nSân ").append(court.getCourt_id()).append(":");
                for (Slot slot : availableSlots) {
                    responseBuilder.append("\n- Từ ").append(slot.getStart()).append(" đến ").append(slot.getEnd());
                }
                 responseBuilder.append("\n");
                responseBuilder.append("\nDịch vụ: ");
                for (Branch_Service service : services) {
                    responseBuilder.append(service.getService().getName()).append(", ");
                }
                responseBuilder.setLength(responseBuilder.length() - 2); 
                responseBuilder.append("\n");
            }

            return responseBuilder.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return "Có lỗi xảy ra khi lấy thông tin các slot trống. Vui lòng thử lại.";
        }
    }

    private String handleBookingSubmission(Integer userId, String message) {
        if (userId == null) return "Bạn cần đăng nhập trước khi đặt sân.";

        Pattern pattern = Pattern.compile("đặt sân (\\d+) từ (\\d{2}:\\d{2}) đến (\\d{2}:\\d{2})(?: với dịch vụ (.*))?");
        Matcher matcher = pattern.matcher(message.toLowerCase());

        if (!matcher.find()) return "Câu lệnh chưa đúng định dạng. Hãy nhập: đặt sân [id] từ hh:mm đến hh:mm với dịch vụ [tên dịch vụ, cách nhau bởi dấu phẩy nếu nhiều]";

        try {
            int courtId = Integer.parseInt(matcher.group(1));
            LocalTime localStart = LocalTime.parse(matcher.group(2));
            LocalTime localEnd = LocalTime.parse(matcher.group(3));
            Time startTime = Time.valueOf(localStart);
            Time endTime = Time.valueOf(localEnd);

            LocalDate today = LocalDate.now();
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            if (court == null) return "Không tìm thấy sân có ID: " + courtId;

            BookingDAO bookingDAO = new BookingDAO();
            if (!bookingDAO.checkSlotAvailable(courtId, today, startTime, endTime)) {
                return "Slot đã được đặt. Vui lòng chọn slot khác.";
            }

            PromotionDAO proDAO = new PromotionDAO();
            Promotion promotion = proDAO.getCurrentPromotionForArea(court.getArea_id(), today);
            BigDecimal pricePerHour = courtDAO.getCourtPrice(courtId);
            BigDecimal totalPrice = bookingDAO.calculateSlotPriceWithPromotion(startTime, endTime, pricePerHour, promotion);

            Bookings booking = new Bookings();
            booking.setUser_id(userId);
            booking.setCourt_id(courtId);
            booking.setDate(today);
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
                return "✅ Đã đặt sân thành công!\nSân: " + courtId + "\nNgày: " + today + "\nTừ " + startTime + " đến " + endTime +
                        "\nTổng tiền: " + totalPrice + " VNĐ." +
                        (booking.getServices() != null ? "\nDịch vụ đi kèm: " + String.join(", ", booking.getServices()) : "");
            } else {
                return "❌ Có lỗi xảy ra khi đặt sân. Vui lòng thử lại sau.";
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