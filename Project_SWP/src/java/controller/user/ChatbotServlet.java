package controller.user;

import DAO.ChatDAO;
import Model.ChatMessage;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "ChatboxServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyCypH4mifQ5Th7SQVjc7Kyu2ubZvHowCNY";
    private static final String GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + GEMINI_API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        String userMessage = request.getParameter("message");

        try {
            ChatDAO chatDAO = new ChatDAO();

            ChatMessage userChat = new ChatMessage(userId, userMessage, "user");
            chatDAO.saveMessage(userChat);

            String botResponse = callGeminiAPI(userMessage);

            if (botResponse == null || botResponse.trim().isEmpty()) {
                botResponse = "Xin lỗi, tôi không thể phản hồi lúc này.";
            }

            ChatMessage botChat = new ChatMessage(null, botResponse, "bot");
            chatDAO.saveMessage(botChat);
            response.getWriter().write(botResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Lỗi: " + e.getMessage());
        }
    }

    private String callGeminiAPI(String userMessage) throws IOException {
        URL url = new URL(GEMINI_ENDPOINT);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);
        JsonObject partObj = new JsonObject();
        partObj.addProperty("text", userMessage);  // đúng định dạng Gemini

        JsonArray parts = new JsonArray();
        parts.add(partObj);

        JsonObject contentObj = new JsonObject();
        contentObj.addProperty("role", "user");
        contentObj.add("parts", parts);

        JsonArray contents = new JsonArray();
        contents.add(contentObj);

        JsonObject requestBody = new JsonObject();
        requestBody.add("contents", contents);
        JsonObject config = new JsonObject();
        config.addProperty("temperature", 0.7);
        config.addProperty("maxOutputTokens", 256);
        requestBody.add("generationConfig", config);
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }
        int status = conn.getResponseCode();
        InputStream stream = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line.trim());
            }
        }

//    if (status != 200) {
//        System.err.println("Gemini API error: " + response.toString());
//        throw new IOException("Gemini API returned status: " + status);
//    }
        // ==== Parse response ====
        JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
        JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
        if (candidates != null && candidates.size() > 0) {
            JsonObject content = candidates.get(0).getAsJsonObject().getAsJsonObject("content");
            JsonArray partsArray = content.getAsJsonArray("parts");
            if (partsArray != null && partsArray.size() > 0) {
                return partsArray.get(0).getAsJsonObject().get("text").getAsString();
            }
        }

        return "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này.";
    }

    @Override
    public String getServletInfo() {
        return "Chatbot servlet using Gemini API";
    }
}
