package DAO;

import Dal.DBContext;
import Model.Staff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.User;

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

    // Thêm user mới
    public void insertUser(User u) {
        String sql = "INSERT INTO Users (username, password, email, phone_number, role, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setTimestamp(6, Timestamp.valueOf(u.getCreatedAt()));
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi thêm user: " + e);
        }
    }

    // Cập nhật user
    public void updateUser(User u) {
        String sql = "UPDATE Users SET username = ?, password = ?, email = ?, phone_number = ?, role = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone_number());
            ps.setString(5, u.getRole());
            ps.setInt(6, u.getUser_Id());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật user: " + e);
        }
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

    // Đăng ký tài khoản
    public boolean register(User user) {
        if (getUserByUsernameOrEmail(user.getUsername(), user.getEmail()) != null) {
            return false;
        }
        String sql = "INSERT INTO Users (username, password, email, phone_number, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone_number());
            ps.setString(5, user.getRole());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Lỗi đăng ký user: " + e);
        }
        return false;
    }

    public Object[] checkUserByUsernameOrEmail(String username, String email) {
        boolean usernameExists = false;
        boolean emailExists = false;
        User foundUser = null;

        try {
            // 1. Check username
            String sqlUsername = "SELECT * FROM Users WHERE username = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlUsername)) {
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    usernameExists = true;
                    foundUser = extractUserFromResultSet(rs);
                }
            }

            // 2. Check email
            String sqlEmail = "SELECT * FROM Users WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlEmail)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    emailExists = true;
                    // Nếu trước đó chưa có User (username chưa trùng), thì lấy User từ email
                    if (foundUser == null) {
                        foundUser = extractUserFromResultSet(rs);
                    }
                }
            }

            // 3. Trả mã kết quả
            if (usernameExists && emailExists) {
                return new Object[]{4, foundUser};
            } else if (usernameExists) {
                return new Object[]{1, foundUser};
            } else if (emailExists) {
                return new Object[]{2, foundUser};
            } else {
                return new Object[]{3, null};
            }

        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra username/email: " + e);
            return new Object[]{0, null}; // 0 → lỗi DB
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
        user.setUser_Id((rs.getInt("user_id")));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setPhone_number(rs.getString("phone_number"));
        user.setRole(rs.getString("role"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }
        return user;
    }

    public boolean registerStaff(Staff newStaff) {
        String sql = "INSERT INTO Staff (user_id, full_name, gender, date_of_birth, address, phone_number, id_card_number, education_level, personal_notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStaff.getUserId().getUser_Id());
            ps.setString(2, newStaff.getFullName());
            ps.setString(3, newStaff.getGender());
            if (newStaff.getDateOfBirth() != null) {
                ps.setDate(4, newStaff.getDateOfBirth());
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }
            ps.setString(5, newStaff.getAddress());
            ps.setString(6, newStaff.getPhoneNumber());
            ps.setString(7, newStaff.getIdCardNumber());
            ps.setString(8, newStaff.getEducationLevel());
            ps.setString(9, newStaff.getPersonalNotes());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi thêm Staff: " + e.getMessage());
        }
        return false;
    }

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

    public List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM Staff";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff s = new Staff();

                // Tạo User object cho staff (chỉ set user_id)
                User u = new User();
                u.setUser_Id(rs.getInt("user_id"));
                s.setUserId(u);

                s.setStaffId(rs.getInt("staff_id"));
                s.setFullName(rs.getString("full_name"));
                s.setGender(rs.getString("gender"));
                s.setDateOfBirth(rs.getDate("date_of_birth"));
                s.setAddress(rs.getString("address"));
                s.setPhoneNumber(rs.getString("phone_number"));
                s.setIdCardNumber(rs.getString("id_card_number"));
                s.setEducationLevel(rs.getString("education_level"));
                s.setPersonalNotes(rs.getString("personal_notes"));

                list.add(s);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getAllStaff: " + e.getMessage());
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

}
