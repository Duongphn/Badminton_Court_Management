package utils;

import java.util.Base64;
import java.nio.charset.StandardCharsets;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class TokenUtils {
    
    // Secret key để mã hóa - trong thực tế nên đặt trong config file
    private static final String SECRET_KEY = "BadmintonCourt2025SecretKey";
    
    /**
     * Tạo token an toàn cho join event link
     * @param eventId ID của sự kiện
     * @param userId ID của user
     * @return token đã được mã hóa
     */
    public static String createJoinEventToken(int eventId, int userId) {
        try {
            // Tạo timestamp để tránh replay attack (token hết hạn sau 7 ngày)
            long timestamp = System.currentTimeMillis() + (7 * 24 * 60 * 60 * 1000L);
            
            // Tạo data string: eventId:userId:timestamp
            String data = eventId + ":" + userId + ":" + timestamp;
            
            // Tạo HMAC signature để đảm bảo tính toàn vẹn
            String signature = createHMACSignature(data, SECRET_KEY);
            
            // Kết hợp data và signature
            String tokenData = data + ":" + signature;
            
            // Encode base64 để URL safe
            return Base64.getUrlEncoder().encodeToString(tokenData.getBytes(StandardCharsets.UTF_8));
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Giải mã token và trích xuất thông tin
     * @param token token đã được mã hóa
     * @return mảng [eventId, userId] hoặc null nếu token không hợp lệ
     */
    public static int[] parseJoinEventToken(String token) {
        try {
            // Decode base64
            byte[] decodedBytes = Base64.getUrlDecoder().decode(token);
            String tokenData = new String(decodedBytes, StandardCharsets.UTF_8);
            
            // Tách các phần: eventId:userId:timestamp:signature
            String[] parts = tokenData.split(":");
            if (parts.length != 4) {
                return null;
            }
            
            int eventId = Integer.parseInt(parts[0]);
            int userId = Integer.parseInt(parts[1]);
            long timestamp = Long.parseLong(parts[2]);
            String signature = parts[3];
            
            // Kiểm tra timestamp (token đã hết hạn chưa)
            if (System.currentTimeMillis() > timestamp) {
                System.err.println("Token đã hết hạn");
                return null;
            }
            
            // Kiểm tra signature
            String data = eventId + ":" + userId + ":" + timestamp;
            String expectedSignature = createHMACSignature(data, SECRET_KEY);
            
            if (!signature.equals(expectedSignature)) {
                System.err.println("Token signature không hợp lệ");
                return null;
            }
            
            return new int[]{eventId, userId};
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Tạo HMAC SHA-256 signature
     */
    private static String createHMACSignature(String data, String key) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKeySpec);
            
            byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
            
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
    
    /**
     * Test method
     */
    public static void main(String[] args) {
        // Test tạo và parse token
        int eventId = 123;
        int userId = 456;
        
        String token = createJoinEventToken(eventId, userId);
        System.out.println("Generated token: " + token);
        
        int[] parsed = parseJoinEventToken(token);
        if (parsed != null) {
            System.out.println("Parsed - EventID: " + parsed[0] + ", UserID: " + parsed[1]);
        } else {
            System.out.println("Token parsing failed");
        }
    }
} 