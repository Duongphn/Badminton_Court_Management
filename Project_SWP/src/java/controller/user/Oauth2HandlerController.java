package controller.user;

import DAO.UserDAO;
import Model.User;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import utils.PasswordUtil;

@WebServlet(name = "Oauth2HandlerController", urlPatterns = {"/oauth2handler"})
public class Oauth2HandlerController extends HttpServlet {

    private static final String CLIENT_ID = "857502113791-0i40c794o3g4h9hped4lhjb77t7h7mn3.apps.googleusercontent.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idTokenString = request.getParameter("credential");

        if (idTokenString == null || idTokenString.isEmpty()) {
            request.getSession().setAttribute("error", "Không nhận được token từ Google.");
            response.sendRedirect("login");
            return;
        }

        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JacksonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken == null) {
                request.getSession().setAttribute("error", "Xác thực Google thất bại.");
                response.sendRedirect("login");
                return;
            }

            // Lấy thông tin người dùng từ token
            GoogleIdToken.Payload payload = idToken.getPayload();
            String email = payload.getEmail();
            String fullName = (String) payload.get("name");

            UserDAO dao = new UserDAO();

            // Nếu chưa có tài khoản, thì tự tạo
            if (dao.getUserByEmail(email) == null) {
                String username = generateUsername(fullName);
                while (dao.getUserByUsername(username) != null) {
                    username += (int) (Math.random() * 1000);
                }

                User newUser = new User();
                newUser.setUsername(username);
                
                String hashedPassword = PasswordUtil.hashPassword("Badminton_App");
        
                newUser.setPassword(hashedPassword); 
                newUser.setEmail(email);
                newUser.setPhone_number(""); // chưa có
                newUser.setRole("user");

                dao.insertUser(newUser);
                // ... (sau khi tạo newUser)
                dao.insertUser(newUser);

// Gửi email chứa thông tin tài khoản
                String emailContent = "<h3>Chào mừng bạn đến với hệ thống!</h3>"
                        + "<p>Tài khoản của bạn đã được tạo từ đăng nhập Google:</p>"
                        + "<ul>"
                        + "<li><b>Username:</b> " + newUser.getUsername() + "</li>"
                        + "<li><b>Password:</b> GOOGLE_AUTH (đăng nhập qua Google)</li>"
                        + "</ul>"
                        + "<p>Bạn có thể thay đổi mật khẩu sau khi đăng nhập nếu muốn.</p>";

                utils.EmailUtils.sendEmail(
                        newUser.getEmail(),
                        "Tài khoản của bạn đã được tạo thành công",
                        emailContent
                );

            }

            // Đăng nhập và lưu session
            User user = dao.getUserByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            

            response.sendRedirect("homepageUser.jsp");

        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xử lý đăng nhập Google.");
            response.sendRedirect("login");
        }
    }

    // Nếu người dùng mở bằng GET thì chuyển về trang login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login");
    }

    // Tạo username từ họ tên, bỏ dấu và khoảng trắng
    private String generateUsername(String fullName) {
        return fullName.toLowerCase()
                .replaceAll("[^a-zA-Z0-9]", "")
                .replaceAll("\\s+", "");
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng nhập bằng Google OAuth2";
    }
}
