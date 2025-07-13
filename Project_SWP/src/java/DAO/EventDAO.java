package DAO;

import Dal.DBContext;
import Model.Event;
import Model.EventParticipant;
import Model.User;
import Model.Branch;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class EventDAO extends DBContext {

    // Lấy danh sách sự kiện có phân trang và tìm kiếm
    public List<Event> getEvents(String keyword, int page, int pageSize) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.*, a.name as area_name FROM Events e LEFT JOIN Areas a ON e.area_id = a.area_id WHERE e.name LIKE ? ORDER BY e.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setName(rs.getString("name"));
                event.setImageUrl(rs.getString("image_url"));
                event.setTitle(rs.getString("title"));
                event.setCreatedBy(rs.getInt("created_by"));
                event.setStartDate(rs.getTimestamp("start_date"));
                event.setEndDate(rs.getTimestamp("end_date"));
                event.setCreatedAt(rs.getTimestamp("created_at"));
                event.setStatus(rs.getBoolean("status"));
                event.setAreaId(rs.getInt("area_id"));
                event.setAreaName(rs.getString("area_name"));
                
                list.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy tổng số sự kiện
    public int getTotalEvents(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE name LIKE ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
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

    // Lấy sự kiện theo ID
    public Event getEventById(int eventId) {
        String sql = "SELECT * FROM Events WHERE event_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setName(rs.getString("name"));
                event.setImageUrl(rs.getString("image_url"));
                event.setTitle(rs.getString("title"));
                event.setCreatedBy(rs.getInt("created_by"));
                event.setStartDate(rs.getTimestamp("start_date"));
                event.setEndDate(rs.getTimestamp("end_date"));
                event.setCreatedAt(rs.getTimestamp("created_at"));
                event.setStatus(rs.getBoolean("status"));
                event.setAreaId(rs.getInt("area_id"));
                return event;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm sự kiện mới
    public void addEvent(Event event) {
        String sql = "INSERT INTO Events (name, image_url, title, created_by, start_date, end_date, status, area_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, event.getName());
            ps.setString(2, event.getImageUrl());
            ps.setString(3, event.getTitle());
            ps.setInt(4, event.getCreatedBy());
            ps.setTimestamp(5, event.getStartDate());
            ps.setTimestamp(6, event.getEndDate());
            ps.setBoolean(7, event.isStatus());
            ps.setInt(8, event.getAreaId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật sự kiện
    public void updateEvent(Event event) {
        String sql = "UPDATE Events SET name = ?, image_url = ?, title = ?, start_date = ?, end_date = ?, status = ?, area_id = ? WHERE event_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, event.getName());
            ps.setString(2, event.getImageUrl());
            ps.setString(3, event.getTitle());
            ps.setTimestamp(4, event.getStartDate());
            ps.setTimestamp(5, event.getEndDate());
            ps.setBoolean(6, event.isStatus());
            ps.setInt(7, event.getAreaId());
            ps.setInt(8, event.getEventId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sự kiện
    public void deleteEvent(int eventId) {
        String sql = "DELETE FROM Events WHERE event_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách người tham gia sự kiện
    public List<EventParticipant> getParticipantsByEvent(int eventId) {
        List<EventParticipant> list = new ArrayList<>();
        String sql = "SELECT ep.*, u.fullname FROM EventParticipants ep JOIN Users u ON ep.user_id = u.user_id WHERE ep.event_id = ? ORDER BY ep.registered_at DESC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EventParticipant p = new EventParticipant();
                p.setId(rs.getInt("id"));
                p.setEventId(rs.getInt("event_id"));
                p.setUserId(rs.getInt("user_id"));
                p.setRegisteredAt(rs.getTimestamp("registered_at"));

                User user = new User();
                user.setUser_Id(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                p.setUser(user);

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin người tạo sự kiện
    public User getEventCreator(int createdByUserId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, createdByUserId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_Id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setFullname(rs.getString("fullname"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách tất cả areas cho dropdown
    public List<Branch> getAllAreas() {
        List<Branch> areas = new ArrayList<>();
        String sql = "SELECT * FROM Areas ORDER BY name";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Branch area = new Branch();
                area.setArea_id(rs.getInt("area_id"));
                area.setName(rs.getString("name"));
                area.setLocation(rs.getString("location"));
                areas.add(area);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return areas;
    }

    // Lấy event mới nhất đang active để hiển thị popup quảng cáo
    public Event getLatestActiveEvent() {
        String sql = "SELECT TOP 1 e.*, a.name as area_name FROM Events e " +
                     "LEFT JOIN Areas a ON e.area_id = a.area_id " +
                     "WHERE e.status = 1 AND e.end_date > GETDATE() " +
                     "ORDER BY e.created_at DESC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setName(rs.getString("name"));
                event.setImageUrl(rs.getString("image_url"));
                event.setTitle(rs.getString("title"));
                event.setCreatedBy(rs.getInt("created_by"));
                event.setStartDate(rs.getTimestamp("start_date"));
                event.setEndDate(rs.getTimestamp("end_date"));
                event.setCreatedAt(rs.getTimestamp("created_at"));
                event.setStatus(rs.getBoolean("status"));
                event.setAreaId(rs.getInt("area_id"));
                event.setAreaName(rs.getString("area_name"));
                return event;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy thông tin area theo ID
    public Branch getAreaById(int areaId) {
        String sql = "SELECT * FROM Areas WHERE area_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Branch area = new Branch();
                area.setArea_id(rs.getInt("area_id"));
                area.setName(rs.getString("name"));
                area.setLocation(rs.getString("location"));
                return area;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra user đã tham gia event chưa
    public boolean isUserRegistered(int eventId, int userId) {
        String sql = "SELECT COUNT(*) FROM EventParticipants WHERE event_id = ? AND user_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tham gia event
    public boolean joinEvent(int eventId, int userId) {
        // Kiểm tra đã tham gia chưa
        if (isUserRegistered(eventId, userId)) {
            return false; // Đã tham gia rồi
        }

        String sql = "INSERT INTO EventParticipants (event_id, user_id) VALUES (?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}