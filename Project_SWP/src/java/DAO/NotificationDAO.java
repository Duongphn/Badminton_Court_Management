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
        List<Notification> list = ndao.getAllNotifications();
        for (Notification notification : list) {
            System.out.println(notification.toString());
        }
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

                    return noti;
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy thông báo theo ID: " + e.getMessage());
        }
        return null;
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

}
