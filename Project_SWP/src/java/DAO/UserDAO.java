package DAO;

import Dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.User;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.PasswordUtil;

public class UserDAO extends DBContext {

    private Connection conn;

    // Constructor để khởi tạo kết nối
    public UserDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.err.println("Lỗi kết nối DB trong UserDAO: " + e.getMessage());
        }
    }

    // Đảm bảo đóng kết nối khi đối tượng bị hủy
    public void finalize() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đăng nhập
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e);
        }
        return null;
    }

    // Lấy danh sách tất cả user
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách user: " + e);
        }
        return list;
    }

    public boolean insertUser(User u) {
        String sql = "INSERT INTO Users (username, password, email, phone_number, role, status, note, gender, firstname, lastname, date_of_birth, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole() != null ? u.getRole() : "user");
            ps.setString(6, u.getStatus() != null ? u.getStatus() : "active");
            ps.setString(7, u.getNote());
            ps.setString(8, u.getGender());
            ps.setString(9, u.getFirstname());
            ps.setString(10, u.getLastname());
            ps.setDate(11, u.getDateOfBirth());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi insertUser: " + e.getMessage());
        }

        return false;
    }

    // Cập nhật user
    public boolean updateUser(User u) {
    String sql = "UPDATE Users SET username = ?, email = ?, phone_number = ?, gender = ?, firstname = ?, lastname = ?, date_of_birth = ? WHERE user_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, u.getUsername());
        ps.setString(2, u.getEmail());
        ps.setString(3, u.getPhone_number()); // hoặc getPhoneNumber()
        ps.setString(4, u.getGender());
        ps.setString(5, u.getFirstname());
        ps.setString(6, u.getLastname());
        if (u.getDateOfBirth() != null) {
            ps.setDate(7, u.getDateOfBirth());
        } else {
            ps.setNull(7, java.sql.Types.DATE);
        }
        ps.setInt(8, u.getUser_Id()); // hoặc getUserId()
        int row = ps.executeUpdate();
        System.out.println("Update user, rows affected: " + row);
        return row > 0;
    } catch (SQLException e) {
        System.err.println("Lỗi cập nhật user: " + e.getMessage());
        e.printStackTrace();
    }
    return false;
}


    // Xóa user
    public void deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi xóa user: " + e);
        }
    }

    // Tìm user theo ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo ID: " + e);
        }
        return null;
    }

    // Tìm user theo username hoặc email
    public User getUserByUsernameOrEmail(String username, String email) {
        String sql = "SELECT * FROM Users WHERE username = ? OR email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo username hoặc email: " + e);
        }
        return null;
    }

    public Object[] checkUserByUsernameOrEmail(String username, String email) {
        User userByUsername = null;
        User userByEmail = null;

        try (Connection conn = getConnection()) {
            // Check username
            String sqlUsername = "SELECT * FROM Users WHERE username = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlUsername)) {
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    userByUsername = extractUserFromResultSet(rs);
                }
            }

            // Check email
            String sqlEmail = "SELECT * FROM Users WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlEmail)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    userByEmail = extractUserFromResultSet(rs);
                }
            }
            int te = userByUsername.getUser_Id();
            int ss = userByEmail.getUser_Id();

            // Logic xác định kết quả
            if (userByUsername != null && userByEmail != null) {
                if (userByUsername.getUser_Id()== userByEmail.getUser_Id()) {
                    return new Object[]{0, userByUsername}; // cả hai đều đúng và là cùng user
                } else {
                    return new Object[]{4, null}; // đúng cả 2 nhưng là 2 người khác nhau (trường hợp bất thường)
                }
            } else if (userByUsername != null) {
                return new Object[]{1, null}; // chỉ username đúng
            } else if (userByEmail != null) {
                return new Object[]{2, null}; // chỉ email đúng
            } else {
                return new Object[]{3, null}; // không đúng gì cả
            }

        } catch (Exception e) {
            System.err.println("Lỗi kiểm tra username/email: " + e.getMessage());
            return new Object[]{-1, null}; // lỗi DB
        }
    }

    // Lưu token quên mật khẩu
    public void saveResetToken(int userId, String token) {
        String sql = "INSERT INTO password_reset_tokens (user_id, token) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi lưu token: " + e.getMessage());
        }
    }

    // Kiểm tra token hợp lệ hay không
    public boolean isValidToken(String token) {
        String sql = "SELECT * FROM password_reset_tokens WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra token: " + e.getMessage());
        }
        return false;
    }

    // Đổi mật khẩu bằng token
    public boolean updatePasswordByToken(String token, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE user_id = (SELECT user_id FROM password_reset_tokens WHERE token = ? AND is_used = 0 AND DATEDIFF(MINUTE, created_at, GETDATE()) <= 5)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, token);
            int result = ps.executeUpdate();
            if (result > 0) {
                markTokenUsed(token);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật mật khẩu theo token: " + e.getMessage());
        }
        return false;
    }

    private void markTokenUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET is_used = 1 WHERE token = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi đánh dấu token đã dùng: " + e.getMessage());
        }
    }

    public void updatePassword(User us) {
        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";
        System.out.println(us.getPassword());
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, us.getPassword());
            ps.setInt(2, us.getUser_Id());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật mật khẩu: " + e.getMessage());
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo email: " + e.getMessage());
        }
        return null;
    }

    public boolean isPhoneExists(String phoneNumber) {
        String sql = "SELECT COUNT(*) FROM Users WHERE phone_number = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra trùng số điện thoại: " + e.getMessage());
        }
        return false;
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi tìm user theo username: " + e.getMessage());
        }
        return null;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUser_Id(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setPhone_number(rs.getString("phone_number"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setNote(rs.getString("note"));
        user.setGender(rs.getString("gender"));
        user.setFirstname(rs.getString("firstname"));
        user.setLastname(rs.getString("lastname"));

        user.setDateOfBirth(rs.getDate("date_of_birth"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }

        return user;
    }

//    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
//        User user = new User();
//        user.setUser_Id(rs.getInt("user_id"));
//        user.setUsername(rs.getString("username"));
//        user.setPassword(rs.getString("password"));
//        user.setEmail(rs.getString("email"));
//        user.setPhone_number(rs.getString("phone_number"));
//        user.setRole(rs.getString("role"));
//        user.setStatus(rs.getString("status"));
//        user.setNote(rs.getString("note"));
//        Timestamp ts = rs.getTimestamp("created_at");
//        if (ts != null) {
//            user.setCreatedAt(ts.toLocalDateTime());
//        }
//        return user;
//    }
//    public boolean registerStaff(Staff newStaff) {
//        String sql = "INSERT INTO Staff (user_id, full_name, gender, date_of_birth, address, phone_number, id_card_number, education_level, personal_notes) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, newStaff.getUserId().getUser_Id());
//            ps.setString(2, newStaff.getFullName());
//            ps.setString(3, newStaff.getGender());
//            if (newStaff.getDateOfBirth() != null) {
//                ps.setDate(4, newStaff.getDateOfBirth());
//            } else {
//                ps.setNull(4, java.sql.Types.DATE);
//            }
//            ps.setString(5, newStaff.getAddress());
//            ps.setString(6, newStaff.getPhoneNumber());
//            ps.setString(7, newStaff.getIdCardNumber());
//            ps.setString(8, newStaff.getEducationLevel());
//            ps.setString(9, newStaff.getPersonalNotes());
//
//            int rowsInserted = ps.executeUpdate();
//            return rowsInserted > 0;
//        } catch (SQLException e) {
//            System.err.println("Lỗi thêm Staff: " + e.getMessage());
//        }
//        return false;
//    }
    public List<User> getUsersByRole(String role) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE role = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = extractUserFromResultSet(rs);
                user.setStatus(rs.getString("status")); // Thêm dòng này vì có cột status
                list.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getUsersByRole: " + e.getMessage());
        }
        return list;
    }

    public void updateUserStatus(int userId, String newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật trạng thái user: " + e.getMessage());
        }
    }

    // Đếm tổng số user
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đếm tổng user: " + e.getMessage());
        }
        return 0;
    }

// Lấy user theo trang (page bắt đầu từ 1)
    public List<User> getUsersByPage(int page, int PAGE_SIZE) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users ORDER BY user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int offset = (page - 1) * PAGE_SIZE;
            ps.setInt(1, offset);
            ps.setInt(2, PAGE_SIZE);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy user theo trang: " + e.getMessage());
        }
        return list;
    }

    public void updateUserStatusAndNote(int userId, String newStatus, String note) {
        String sql = "UPDATE Users SET status = ?, note = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, note);
            ps.setInt(3, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật trạng thái và note user: " + e.getMessage());
        }
    }

// Đếm tổng số user theo keyword và status
    public int countUsersByFilter(String keyword, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (username LIKE ? OR email LIKE ? OR phone_number LIKE ?)");
            String likeKeyword = "%" + keyword.trim() + "%";
            params.add(likeKeyword);
            params.add(likeKeyword);
            params.add(likeKeyword);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status.trim());
        }

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi countUsersByFilter: " + e.getMessage());
        }
        return 0;
    }

// Lấy danh sách user có phân trang và lọc search, status
    public List<User> getUsersByPageAndFilter(int page, int PAGE_SIZE, String keyword, String status) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (username LIKE ? OR email LIKE ? OR phone_number LIKE ?)");
            String likeKeyword = "%" + keyword.trim() + "%";
            params.add(likeKeyword);
            params.add(likeKeyword);
            params.add(likeKeyword);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status.trim());
        }

        sql.append(" ORDER BY user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        int offset = (page - 1) * PAGE_SIZE;
        params.add(offset);
        params.add(PAGE_SIZE);

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getUsersByPageAndFilter: " + e.getMessage());
        }

        return list;
    }

    public List<User> getUsersByRoleAndPage(String role, int offset, int pageSize) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE (? = '' OR role = ?) ORDER BY user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, role);
            ps.setInt(3, offset);
            ps.setInt(4, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getUsersByRoleAndPage: " + e.getMessage());
        }
        return list;
    }

    public int countUsersByRole(String role) {
        String sql = "SELECT COUNT(*) FROM Users WHERE (? = '' OR role = ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, role);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi countUsersByRole: " + e.getMessage());
        }
        return 0;
    }

    public boolean register(User user) {
        // Kiểm tra username hoặc email đã tồn tại
        if (getUserByUsernameOrEmail(user.getUsername(), user.getEmail()) != null) {
            return false;
        }

        String sql = "INSERT INTO Users (username, password, email, phone_number, role, status, note, gender, firstname, lastname, date_of_birth, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone_number());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getStatus() != null ? user.getStatus() : "Active");
            ps.setString(7, user.getNote());
            ps.setString(8, user.getGender());
            ps.setString(9, user.getFirstname());
            ps.setString(10, user.getLastname());
            ps.setDate(11, user.getDateOfBirth());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Lỗi đăng ký user: " + e.getMessage());
        }

        return false;
    }

  public List<User> getAllStaff() {
    List<User> staffList = new ArrayList<>();
    String sql = "SELECT * FROM Users WHERE role = 'staff'";
    try (
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            User user = new User();
            user.setUser_Id(rs.getInt("user_id"));
            user.setFirstname(rs.getString("firstname"));
            user.setLastname(rs.getString("lastname"));
            // Thêm các trường cần thiết khác nếu cần
            staffList.add(user);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return staffList;
}

       public boolean getSendMail(int user_Id) {
        String sql = "SELECT send_mail FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_Id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("send_mail");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getSendMail: " + e.getMessage());
        }
        return false;
    }
           public void updateSendMail(int user_Id, boolean sendMail) {
        String sql = "UPDATE Users SET send_mail = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, sendMail);
            ps.setInt(2, user_Id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi updateSendMail: " + e.getMessage());
        }
    }


}
