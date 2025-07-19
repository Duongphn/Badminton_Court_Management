package DAO;

import Dal.DBContext;
import Model.Notification;
import Model.NotificationReceiver;
import Model.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NotificationDAO extends DBContext {

    
 

    public List<Notification> getAllNotifications() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notification ORDER BY scheduled_time DESC";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Notification noti = new Notification();
                noti.setNotificationId(rs.getInt("notification_id"));
                noti.setTitle(rs.getString("title"));
                noti.setContent(rs.getString("content"));
                noti.setImageUrl(rs.getString("image_url"));

                UserDAO udao = new UserDAO();
                User user = udao.getUserById(rs.getInt("created_by"));

                noti.setCreatedBy(user);

                Timestamp scheduled = rs.getTimestamp("scheduled_time");
                if (scheduled != null) {
                    noti.setScheduledTime(scheduled.toLocalDateTime());
                }

                Timestamp sent = rs.getTimestamp("sent_time");
                if (sent != null) {
                    noti.setSentTime(sent.toLocalDateTime());
                }

                noti.setStatus(rs.getString("status"));

                Timestamp created = rs.getTimestamp("created_at");
                if (created != null) {
                    noti.setCreatedAt(created.toLocalDateTime());
                }

                list.add(noti);
            }

        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách thông báo: " + e.getMessage());
        }

        return list;
    }

    public Notification getNotificationById(int id) {
        Notification notification = null;
        String sql = "SELECT n.*, u.user_id, u.username, u.email "
                + "FROM Notification n "
                + "JOIN Users u ON n.created_by = u.user_id "
                + "WHERE n.notification_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                notification = new Notification();
                notification.setNotificationId(rs.getInt("notification_id"));
                notification.setTitle(rs.getString("title"));
                notification.setContent(rs.getString("content"));
                notification.setImageUrl(rs.getString("image_url"));

                Timestamp scheduled = rs.getTimestamp("scheduled_time");
                if (scheduled != null) {
                    notification.setScheduledTime(scheduled.toLocalDateTime());
                }

                Timestamp sent = rs.getTimestamp("sent_time");
                if (sent != null) {
                    notification.setSentTime(sent.toLocalDateTime());
                }

                Timestamp created = rs.getTimestamp("created_at");
                if (created != null) {
                    notification.setCreatedAt(created.toLocalDateTime());
                }

                notification.setStatus(rs.getString("status"));

                // Gán người tạo (created_by)
                User createdBy = new User();
                createdBy.setUser_Id(rs.getInt("user_id"));
                createdBy.setUsername(rs.getString("username"));
                createdBy.setEmail(rs.getString("email"));

                notification.setCreatedBy(createdBy);
            }

        } catch (Exception e) {
            System.err.println("Lỗi khi lấy thông báo theo ID: " + e.getMessage());
        }
        return notification;
    }

    public boolean createNotification(Notification n) {
        String sql = "INSERT INTO Notification (title, content, image_url, created_by, scheduled_time, sent_time, status, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());
            ps.setString(3, n.getImageUrl());
            ps.setInt(4, n.getCreatedBy().getUser_Id());
            ps.setTimestamp(5, Timestamp.valueOf(n.getScheduledTime()));
            if (n.getSentTime() != null) {
                ps.setTimestamp(6, Timestamp.valueOf(n.getSentTime()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }
            ps.setString(7, n.getStatus());
            ps.setTimestamp(8, Timestamp.valueOf(n.getCreatedAt()));

            int affected = ps.executeUpdate();
            if (affected == 0) {
                return false;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    n.setNotificationId(rs.getInt(1));
                }
            }

            return true;

        } catch (Exception e) {
            System.err.println("Lỗi khi tạo thông báo: " + e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        NotificationDAO ndao = new NotificationDAO();
        ndao.getNotificationsForUser(1, false);
    }

    public Notification getById(int id) {
        String sql = "SELECT * FROM Notification WHERE notification_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Notification noti = new Notification();
                    noti.setNotificationId(rs.getInt("notification_id"));
                    noti.setTitle(rs.getString("title"));
                    noti.setContent(rs.getString("content"));
                    noti.setImageUrl(rs.getString("image_url"));

                    // Lấy thông tin người tạo thông báo
                    UserDAO udao = new UserDAO();
                    User user = udao.getUserById(rs.getInt("created_by"));
                    noti.setCreatedBy(user);

                    // Xử lý thời gian đã lên lịch
                    Timestamp scheduled = rs.getTimestamp("scheduled_time");
                    if (scheduled != null) {
                        noti.setScheduledTime(scheduled.toLocalDateTime());
                    }

                    // Xử lý thời gian đã gửi
                    Timestamp sent = rs.getTimestamp("sent_time");
                    if (sent != null) {
                        noti.setSentTime(sent.toLocalDateTime());
                    }

                    noti.setStatus(rs.getString("status"));

                    // Xử lý thời gian tạo
                    Timestamp created = rs.getTimestamp("created_at");
                    if (created != null) {
                        noti.setCreatedAt(created.toLocalDateTime());
                    }

                    return noti; // Trả về thông báo nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL lỗi khi lấy thông báo theo ID: " + e.getMessage());
            e.printStackTrace(); // In chi tiết lỗi ra console
        } catch (Exception e) {
            System.err.println("Lỗi không xác định: " + e.getMessage());
            e.printStackTrace(); // In chi tiết lỗi ra console
        }

        return null; // Trả về null nếu không tìm thấy thông báo
    }

    public boolean updateNotification(Notification n) {
        String sql = "UPDATE Notification SET title = ?, content = ?, image_url = ?, scheduled_time = ? WHERE notification_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());

            if (n.getImageUrl() != null) {
                ps.setString(3, n.getImageUrl());
            } else {
                ps.setNull(3, Types.VARCHAR);
            }

            ps.setTimestamp(4, Timestamp.valueOf(n.getScheduledTime()));
            ps.setInt(5, n.getNotificationId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Lỗi khi cập nhật thông báo: " + e.getMessage());
            return false;
        }
    }

    public List<Notification> searchNotifications(String keyword, int offset, int limit) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notification "
                + "WHERE title LIKE ? "
                + "ORDER BY scheduled_time DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification noti = new Notification();
                noti.setNotificationId(rs.getInt("notification_id"));
                noti.setTitle(rs.getString("title"));
                noti.setContent(rs.getString("content"));
                noti.setImageUrl(rs.getString("image_url"));

                UserDAO udao = new UserDAO();
                noti.setCreatedBy(udao.getUserById(rs.getInt("created_by")));

                Timestamp scheduled = rs.getTimestamp("scheduled_time");
                if (scheduled != null) {
                    noti.setScheduledTime(scheduled.toLocalDateTime());
                }

                Timestamp sent = rs.getTimestamp("sent_time");
                if (sent != null) {
                    noti.setSentTime(sent.toLocalDateTime());
                }

                noti.setStatus(rs.getString("status"));

                Timestamp created = rs.getTimestamp("created_at");
                if (created != null) {
                    noti.setCreatedAt(created.toLocalDateTime());
                }

                list.add(noti);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countNotifications(String keyword) {
        String sql = "SELECT COUNT(*) FROM Notification WHERE title LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean update(Notification n) {
        String sql = "UPDATE Notification SET sent_time = ?, status = ? WHERE notification_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            if (n.getSentTime() != null) {
                ps.setTimestamp(1, Timestamp.valueOf(n.getSentTime()));
            } else {
                ps.setNull(1, Types.TIMESTAMP);
            }
            ps.setString(2, n.getStatus());
            ps.setInt(3, n.getNotificationId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Lỗi cập nhật thời gian gửi: " + e.getMessage());
            return false;
        }
    }

    public void insertReceiver(NotificationReceiver receiver) {
        String sql = "INSERT INTO Notification_Receiver (notification_id, user_id, is_read, read_at, opened_at) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, receiver.getNotificationId().getNotificationId());
            ps.setInt(2, receiver.getUserId().getUser_Id());
            ps.setBoolean(3, receiver.isIsRead());

            if (receiver.getReadAt() != null) {
                ps.setTimestamp(4, Timestamp.valueOf(receiver.getReadAt()));
            } else {
                ps.setNull(4, Types.TIMESTAMP);
            }

            if (receiver.getOpenedAt() != null) {
                ps.setTimestamp(5, Timestamp.valueOf(receiver.getOpenedAt()));
            } else {
                ps.setNull(5, Types.TIMESTAMP);
            }

            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Lỗi insertReceiver: " + e.getMessage());
        }
    }

    public List<Notification> searchNotificationsByStatus(String keyword, String status, int offset, int limit) throws ClassNotFoundException {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notification "
                + "WHERE title LIKE ? "
                + "AND (status = ? OR ? = '') " // Lọc theo trạng thái, nếu không có trạng thái thì không lọc theo trạng thái
                + "ORDER BY scheduled_time DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";  // Phân trang

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");  // Tìm kiếm theo từ khóa trong tiêu đề
            ps.setString(2, status);  // Trạng thái (có thể là 'sent', 'scheduled', 'draft', ...)
            ps.setString(3, status);  // Nếu không có trạng thái, lấy tất cả
            ps.setInt(4, offset);  // Vị trí bắt đầu phân trang
            ps.setInt(5, limit);  // Số lượng bản ghi trả về

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notification noti = new Notification();
                    noti.setNotificationId(rs.getInt("notification_id"));
                    noti.setTitle(rs.getString("title"));
                    noti.setContent(rs.getString("content"));
                    noti.setImageUrl(rs.getString("image_url"));

                    UserDAO udao = new UserDAO();
                    noti.setCreatedBy(udao.getUserById(rs.getInt("created_by")));

                    Timestamp scheduled = rs.getTimestamp("scheduled_time");
                    if (scheduled != null) {
                        noti.setScheduledTime(scheduled.toLocalDateTime());
                    }

                    Timestamp sent = rs.getTimestamp("sent_time");
                    if (sent != null) {
                        noti.setSentTime(sent.toLocalDateTime());
                    }

                    noti.setStatus(rs.getString("status"));

                    Timestamp created = rs.getTimestamp("created_at");
                    if (created != null) {
                        noti.setCreatedAt(created.toLocalDateTime());
                    }

                    list.add(noti);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log error if any
        }
        return list;  // If no notifications, this will return an empty list, not null
    }

    public List<NotificationReceiver> getNotificationsForUser(int user_Id, boolean isUnreadOnly) {
        List<NotificationReceiver> list = new ArrayList<>();

        String sql = "WITH RankedNotifications AS ("
                + "    SELECT nr.*, ROW_NUMBER() OVER (PARTITION BY nr.notification_id ORDER BY nr.read_at DESC) AS rn "
                + "    FROM Notification_Receiver nr "
                + "    WHERE nr.user_id = ?";

        if (isUnreadOnly) {
            sql += " AND nr.is_read = 0";
        }

        sql += ") "
                + "SELECT nr.*, n.* "
                + "FROM RankedNotifications nr "
                + "JOIN Notification n ON nr.notification_id = n.notification_id "
                + "WHERE rn = 1 "
                + "ORDER BY n.scheduled_time DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_Id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Gộp thông tin notification
                Notification notification = new Notification();
                notification.setNotificationId(rs.getInt("notification_id"));
                notification.setTitle(rs.getString("title"));
                notification.setContent(rs.getString("content"));
                notification.setImageUrl(rs.getString("image_url"));

                Timestamp scheduled = rs.getTimestamp("scheduled_time");
                if (scheduled != null) {
                    notification.setScheduledTime(scheduled.toLocalDateTime());
                }

                Timestamp sent = rs.getTimestamp("sent_time");
                if (sent != null) {
                    notification.setSentTime(sent.toLocalDateTime());
                }

                Timestamp created = rs.getTimestamp("created_at");
                if (created != null) {
                    notification.setCreatedAt(created.toLocalDateTime());
                }

                notification.setStatus(rs.getString("status"));

                UserDAO userDAO = new UserDAO();
                User createdBy = userDAO.getUserById(rs.getInt("created_by"));
                notification.setCreatedBy(createdBy);

                // Gộp thông tin người nhận
                NotificationReceiver receiver = new NotificationReceiver();
                receiver.setNotificationId(notification);

                User user = userDAO.getUserById(rs.getInt("user_id"));
                receiver.setUserId(user);

                receiver.setIsRead(rs.getBoolean("is_read"));

                Timestamp readAt = rs.getTimestamp("read_at");
                if (readAt != null) {
                    receiver.setReadAt(readAt.toLocalDateTime());
                }

                Timestamp openedAt = rs.getTimestamp("opened_at");
                if (openedAt != null) {
                    receiver.setOpenedAt(openedAt.toLocalDateTime());
                }

                list.add(receiver);

            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách thông báo cho user: " + e.getMessage());
        }
        System.out.println(list);
        return list;
    }

//public static void main(String[] args) {
//    NotificationDAO dao = new NotificationDAO();
//
//    // ID của user cần test (đảm bảo tồn tại trong DB)
//    int testUserId = 8;
//
//    // Lấy tất cả thông báo (bao gồm đã đọc và chưa đọc)
//    List<NotificationReceiver> allNotifications = dao.getNotificationsForUser(testUserId, false);
//    System.out.println("=== TẤT CẢ THÔNG BÁO ===");
//    for (NotificationReceiver r : allNotifications) {
//        System.out.println("ID: " + r.getNotificationId().getNotificationId());
//        System.out.println("Tiêu đề: " + r.getNotificationId().getTitle());
//        System.out.println("Nội dung: " + r.getNotificationId().getContent());
//        System.out.println("Đã đọc: " + r.isIsRead());
//        System.out.println("Gửi lúc: " + r.getNotificationId().getScheduledTime());
//        System.out.println("Tạo bởi: " + r.getNotificationId().getCreatedBy().getUsername());
//        System.out.println("--------");
//    }
//
//    // Lấy thông báo chưa đọc
//    List<NotificationReceiver> unread = dao.getNotificationsForUser(testUserId, true);
//    System.out.println("\n=== THÔNG BÁO CHƯA ĐỌC ===");
//    for (NotificationReceiver r : unread) {
//        System.out.println("ID: " + r.getNotificationId().getNotificationId());
//        System.out.println("Tiêu đề: " + r.getNotificationId().getTitle());
//        System.out.println("Đã đọc: " + r.isIsRead());
//        System.out.println("--------");
//    }
//}
}
