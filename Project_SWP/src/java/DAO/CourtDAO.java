/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import Dal.DBContext;
import Model.AdminDashBoard;
import Model.Courts;

/**
 *
 * @author admin
 */
public class CourtDAO extends DBContext {

    Connection connection;

    public CourtDAO() {
        try {
            connection = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    AreaDAO dao = new AreaDAO();

    public List<Courts> getCourtsByAreaId(int areaId) {

        List<Courts> listCourt = new ArrayList<>();
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id, price FROM Courts WHERE area_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, areaId); // Set tham số ở đây

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int courtID = rs.getInt("court_id");
                    String courtNumber = rs.getString("court_number");
                    String type = rs.getString("type");
                    String floorMaterial = rs.getString("floor_material");
                    String lighting = rs.getString("lighting");
                    String description = rs.getString("description");
                    String imageUrl = rs.getString("image_url");
                    String status = rs.getString("status");
                    int areaID = rs.getInt("area_id");
                    double price = rs.getDouble("price");

                    Courts court = new Courts(courtID, courtNumber, type, floorMaterial, lighting, description, imageUrl, status, areaID, price);
                    listCourt.add(court);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listCourt;
    }

    public void addCourt(Courts court) {
        String sql = "INSERT INTO Courts (court_number, type, floor_material, lighting, description, image_url, status, area_id, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, court.getCourt_number());
            ps.setString(2, court.getType());
            ps.setString(3, court.getFloor_material());
            ps.setString(4, court.getLighting());
            ps.setString(5, court.getDescription());
            ps.setString(6, court.getImage_url());
            ps.setString(7, court.getStatus());
            ps.setInt(8, court.getArea_id());
            ps.setDouble(9, court.getPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void increaseCourtOfArea(int area_id) {
        String sql = "UPDATE Areas SET court = court+1 WHERE area_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, area_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void decreaseCourtOfArea(int area_id) {
        String sql = "UPDATE Areas SET court = court - 1 WHERE area_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, area_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Courts> getAllCourts() {
        List<Courts> courts = new ArrayList<>();
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id, price FROM Courts";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Courts court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setType(rs.getString("type"));
                court.setFloor_material(rs.getString("floor_material"));
                court.setLighting(rs.getString("lighting"));
                court.setDescription(rs.getString("description"));
                court.setImage_url(rs.getString("image_url"));
                court.setStatus(rs.getString("status"));
                court.setArea_id(rs.getInt("area_id"));
                court.setPrice(rs.getDouble("price"));
                courts.add(court);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courts;
    }

    public Courts getCourtById(int courtId) {
        Courts court = null;
        String sql = "SELECT court_id, court_number, type, floor_material, lighting, description, image_url, status, area_id, price FROM Courts WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, courtId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setType(rs.getString("type"));
                court.setFloor_material(rs.getString("floor_material"));
                court.setLighting(rs.getString("lighting"));
                court.setDescription(rs.getString("description"));
                court.setImage_url(rs.getString("image_url"));
                court.setStatus(rs.getString("status"));
                court.setArea_id(rs.getInt("area_id"));
                court.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return court;
    }

    public void updateCourt(Courts court) {
        String sql = "UPDATE Courts SET court_number = ?, type = ?, floor_material = ?, lighting = ?, description = ?, image_url = ?, status = ?, area_id = ?, price = ? WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, court.getCourt_number());
            stmt.setString(2, court.getType());
            stmt.setString(3, court.getFloor_material());
            stmt.setString(4, court.getLighting());
            stmt.setString(5, court.getDescription());
            stmt.setString(6, court.getImage_url());
            stmt.setString(7, court.getStatus());
            stmt.setInt(8, court.getArea_id());
            stmt.setDouble(9, court.getPrice());
            stmt.setInt(10, court.getCourt_id());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteCourt(String courtId) {
        String sql = "DELETE FROM Courts WHERE court_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courtId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourtDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Courts> getCourtsByManager(int managerId) {
        List<Courts> courts = new ArrayList<>();
        String sql = "SELECT c.* FROM Courts c JOIN Areas a ON c.area_id = a.area_id WHERE a.manager_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Courts court = new Courts();
                court.setCourt_id(rs.getInt("court_id"));
                court.setCourt_number(rs.getString("court_number"));
                court.setType(rs.getString("type"));
                court.setFloor_material(rs.getString("floor_material"));
                court.setLighting(rs.getString("lighting"));
                court.setDescription(rs.getString("description"));
                court.setImage_url(rs.getString("image_url"));
                court.setStatus(rs.getString("status"));
                court.setArea_id(rs.getInt("area_id"));
                court.setPrice(rs.getDouble("price"));
                courts.add(court);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courts;
    }

    public int countCourtsByArea(int areaId) {
        String sql = "SELECT COUNT(*) FROM Courts WHERE area_id = ?";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, areaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public int countCourtsByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Courts c JOIN Areas a ON c.area_id = a.area_id WHERE a.manager_id = ?";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<String> getDistinctCourtTypes() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT type FROM Courts WHERE type IS NOT NULL AND type <> ''";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("type"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<String> getDistinctFloorMaterials() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT floor_material FROM Courts WHERE floor_material IS NOT NULL AND floor_material <> ''";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("floor_material"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<String> getDistinctLightingSystems() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT lighting FROM Courts WHERE lighting IS NOT NULL AND lighting <> ''";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("lighting"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
// Get counts of courts by status for a manager

    public Map<String, Integer> getCourtStatusCounts(int managerId) {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT c.status, COUNT(*) AS cnt FROM Courts c JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ? GROUP BY c.status";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getString("status"), rs.getInt("cnt"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public BigDecimal getCourtPrice(int courtId) {
        String sql = "SELECT price FROM Courts WHERE court_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courtId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal calculateSlotPrice(Time startTime, Time endTime, BigDecimal pricePerHour) {
        // Sử dụng getTime() để lấy milliseconds
        long millisStart = startTime.getTime();
        long millisEnd = endTime.getTime();
        long durationMillis = millisEnd - millisStart;

        long minutes = durationMillis / (1000 * 60);

        if (minutes == 60) {
            return pricePerHour;
        } else {
            // Nếu không phải 60 phút, tính giá theo giờ (hoặc throw exception nếu muốn)
            BigDecimal hours = new BigDecimal(minutes).divide(new BigDecimal(60), 2, BigDecimal.ROUND_HALF_UP);
            return hours.multiply(pricePerHour);
        }
    }

    public static void main(String[] args) {
        CourtDAO dao = new CourtDAO();
        int a = dao.countCourtsByArea(5);
        System.out.println(a);
    }

    public List<AdminDashBoard> getAllCourtReports(String filter) {
        List<AdminDashBoard> list = new ArrayList<>();
        String dateCondition = getDateConditionForJoin(filter); // phần ON b.date...
        String dateConditionWhere = getDateConditionForWhere(filter); // phần WHERE

        String sql = "SELECT c.court_id, c.court_number, u.fullname, "
                + "ISNULL(SUM(CASE WHEN b.booking_id IS NOT NULL THEN b.total_price END), 0) AS revenue, "
                + "COUNT(b.booking_id) AS bookings, "
                + "(SELECT COUNT(DISTINCT b2.user_id) FROM Bookings b2 "
                + "WHERE b2.court_id = c.court_id " + dateConditionWhere
                + " AND b2.user_id IN (SELECT user_id FROM Bookings WHERE court_id = c.court_id " + dateConditionWhere
                + " GROUP BY user_id HAVING COUNT(*) > 1)) AS returningUsers, "
                + "AVG(CAST(b.rating AS float)) AS avgRating "
                + "FROM Courts c "
                + "LEFT JOIN Bookings b ON b.court_id = c.court_id " + dateCondition
                + "LEFT JOIN Areas a ON c.area_id = a.area_id "
                + "LEFT JOIN Users u ON a.manager_id = u.user_id "
                + "GROUP BY c.court_id, c.court_number, u.fullname";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AdminDashBoard a = new AdminDashBoard(
                        rs.getString(2), // c.court_number
                        rs.getString(3), // u.fullname
                        rs.getDouble(4), // revenue
                        rs.getInt(5), // bookings
                        rs.getInt(6), // returningUsers
                        rs.getDouble(7) // avgRating
                );
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Dùng cho JOIN Bookings b ON b.court_id = c.court_id ... (lọc từng booking theo filter)
    private String getDateConditionForJoin(String filter) {
        switch (filter) {
            case "today":
                return "AND CAST(b.date AS DATE) = CAST(GETDATE() AS DATE) ";
            case "week":
                return "AND DATEPART(week, b.date) = DATEPART(week, GETDATE()) AND YEAR(b.date) = YEAR(GETDATE()) ";
            case "month":
                return "AND MONTH(b.date) = MONTH(GETDATE()) AND YEAR(b.date) = YEAR(GETDATE()) ";
            default:
                return "";
        }
    }

    // Dùng cho WHERE điều kiện trong subquery returning user (b2), phải bắt đầu bằng AND/hoặc chuỗi rỗng
    private String getDateConditionForWhere(String filter) {
        switch (filter) {
            case "today":
                return "AND CAST(b2.date AS DATE) = CAST(GETDATE() AS DATE) ";
            case "week":
                return "AND DATEPART(week, b2.date) = DATEPART(week, GETDATE()) AND YEAR(b2.date) = YEAR(GETDATE()) ";
            case "month":
                return "AND MONTH(b2.date) = MONTH(GETDATE()) AND YEAR(b2.date) = YEAR(GETDATE()) ";
            default:
                return "";
        }
    }

}
