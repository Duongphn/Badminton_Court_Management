/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Promotion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public class PromotionDAO extends DBContext {

    Connection conn;

    public PromotionDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public void updateExpiredPromotions() {
        String sql = "UPDATE Promotions SET status = 'inactive' WHERE status = 'active' AND end_date < GETDATE()";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Promotion getCurrentPromotionForArea(int areaId, LocalDate bookingDate) {
        Promotion promotion = null;
        try {
            String sql = "SELECT TOP 1 p.*\n"
                    + "FROM Promotions p\n"
                    + "JOIN Promotion_Area pa ON p.promotion_id = pa.promotion_id\n"
                    + "WHERE pa.area_id = ?\n"
                    + "  AND p.status = 'active'\n"
                    + "  AND p.start_date <= ?\n"
                    + "  AND p.end_date >= ?\n"
                    + "ORDER BY p.discount_percent DESC, p.discount_amount DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, areaId);
            ps.setDate(2, java.sql.Date.valueOf(bookingDate));
            ps.setDate(3, java.sql.Date.valueOf(bookingDate));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                promotion = new Promotion();
                promotion.setPromotionId(rs.getInt("promotion_id"));
                promotion.setTitle(rs.getString("title"));
                promotion.setDescription(rs.getString("description"));
                promotion.setDiscountPercent(rs.getDouble("discount_percent"));
                promotion.setDiscountAmount(rs.getDouble("discount_amount"));
                promotion.setStartDate(rs.getDate("start_date").toLocalDate());
                promotion.setEndDate(rs.getDate("end_date").toLocalDate());
                promotion.setStatus(rs.getString("status"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return promotion;
    }

    public List<Promotion> filterPromotion(String status, String areaId) {
        List<Promotion> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.promotion_id, p.title, p.description, p.discount_percent, p.discount_amount, "
                + "p.start_date, p.end_date, p.status "
                + "FROM Promotions p "
                + "LEFT JOIN Promotion_Area pa ON p.promotion_id = pa.promotion_id "
                + "WHERE 1=1"
        );

        // Tạo danh sách điều kiện động
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND p.status = ?");
        }
        if (areaId != null && !areaId.trim().isEmpty()) {
            sql.append(" AND pa.area_id = ?");
        }

        try (
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (status != null && !status.trim().isEmpty()) {
                sql.append(" AND LOWER(p.status) = ?");
                ps.setString(paramIndex++, status.toLowerCase());
            }
            if (areaId != null && !areaId.trim().isEmpty()) {
                ps.setInt(paramIndex, Integer.parseInt(areaId));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Promotion p = new Promotion();
                p.setPromotionId(rs.getInt("promotion_id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setDiscountPercent(rs.getDouble("discount_percent"));
                p.setDiscountAmount(rs.getDouble("discount_amount"));
                p.setStartDate(rs.getDate("start_date").toLocalDate());
                p.setEndDate(rs.getDate("end_date").toLocalDate());
                p.setStatus(rs.getString("status"));
                // bạn có thể gọi thêm p.setAreaNames(...) nếu cần
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Promotion> getValidPromotionsForArea(int areaId, LocalDateTime bookingTime) throws SQLException {
        List<Promotion> result = new ArrayList<>();
        String sql = "SELECT p.* FROM Promotions p "
                + "JOIN Promotion_Area pa ON p.promotion_id = pa.promotion_id "
                + "WHERE pa.area_id = ? AND p.status = 'active' "
                + "AND ? BETWEEN p.start_date AND p.end_date";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, areaId);
            stmt.setTimestamp(2, Timestamp.valueOf(bookingTime));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Promotion promo = new Promotion();
                promo.setPromotionId(rs.getInt("promotion_id"));
                promo.setTitle(rs.getString("title"));
                promo.setDescription(rs.getString("description"));
                promo.setDiscountPercent(rs.getDouble("discount_percent"));
                promo.setDiscountAmount(rs.getDouble("discount_amount"));
                promo.setStartDate(rs.getDate("start_date").toLocalDate());
                promo.setEndDate(rs.getDate("end_date").toLocalDate());
                promo.setStatus(rs.getString("status"));
                promo.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                Timestamp updated = rs.getTimestamp("updated_at");
                if (updated != null) {
                    promo.setUpdatedAt(updated.toLocalDateTime());
                }
                result.add(promo);
            }
        }
        return result;
    }

    public double applyBestPromotion(double price, int areaId, LocalDateTime bookingTime) throws SQLException {
        PromotionDAO promoDAO = new PromotionDAO();
        List<Promotion> promos = promoDAO.getValidPromotionsForArea(areaId, bookingTime);

        double minPrice = price;
        for (Promotion promo : promos) {
            double priceAfter = price;
            if (promo.getDiscountPercent() > 0) {
                priceAfter -= price * promo.getDiscountPercent() / 100.0;
            }
            if (promo.getDiscountAmount() > 0) {
                priceAfter -= promo.getDiscountAmount();
            }
            if (priceAfter < 0) {
                priceAfter = 0;
            }
            if (priceAfter < minPrice) {
                minPrice = priceAfter;
            }
        }
        return minPrice;
    }

    public List<Promotion> getAllPromotions() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Promotion p = extract(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int insertPromotion(Promotion p) throws SQLException {
        String sql = "INSERT INTO Promotions (title, description, discount_percent, discount_amount, start_date, end_date, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, p.getTitle());
            stmt.setString(2, p.getDescription());
            stmt.setDouble(3, p.getDiscountPercent());
            stmt.setDouble(4, p.getDiscountAmount());
            stmt.setDate(5, java.sql.Date.valueOf(p.getStartDate()));
            stmt.setDate(6, java.sql.Date.valueOf(p.getEndDate()));
            stmt.setString(7, p.getStatus());
            stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void deleteAllPromotionAreas(int promotionId) {
        String sql = "DELETE FROM Promotion_Area WHERE promotion_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void deletePromotion(int promotionId) {
        String sql2 = "DELETE FROM Promotions WHERE promotion_id = ?";
        String sql1 = "DELETE FROM Promotion_Area WHERE promotion_id = ?";

        try (PreparedStatement ps1 = conn.prepareStatement(sql1); PreparedStatement ps2 = conn.prepareStatement(sql2);) {
            ps1.setInt(1, promotionId);
            ps1.executeUpdate();
            ps2.setInt(1, promotionId);
            ps2.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    public boolean updatePromotion(Promotion p) throws SQLException {
        String sql = "UPDATE Promotions SET title=?, description=?, discount_percent=?, discount_amount=?, start_date=?, end_date=?, status=?, updated_at=? WHERE promotion_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, p.getTitle());
            stmt.setString(2, p.getDescription());
            stmt.setDouble(3, p.getDiscountPercent());
            stmt.setDouble(4, p.getDiscountAmount());
            stmt.setDate(5, java.sql.Date.valueOf(p.getStartDate())); // startDate là LocalDate
            stmt.setDate(6, java.sql.Date.valueOf(p.getEndDate()));
            stmt.setString(7, p.getStatus());
            stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(9, p.getPromotionId());
            return stmt.executeUpdate() > 0;
        }
    }

    public void insertPromotionArea(int promotionId, int areaId) throws SQLException {
        String sql = "INSERT INTO Promotion_Area(promotion_id, area_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            stmt.setInt(2, areaId);
            stmt.executeUpdate();
        }
    }

    public void insertPromotionService(int promotionId, int serviceId) throws SQLException {
        String sql = "INSERT INTO Promotion_Service(promotion_id, serviceId) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            stmt.setInt(2, serviceId);
            stmt.executeUpdate();
        }
    }

    private Promotion extract(ResultSet rs) throws SQLException {
        Promotion p = new Promotion();
        p.setPromotionId(rs.getInt("promotion_id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setDiscountPercent(rs.getDouble("discount_percent"));
        p.setDiscountAmount(rs.getDouble("discount_amount"));
        p.setStartDate(rs.getDate("start_date").toLocalDate());
        p.setEndDate(rs.getDate("end_date").toLocalDate());
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        Timestamp updated = rs.getTimestamp("updated_at");
        if (updated != null) {
            p.setUpdatedAt(updated.toLocalDateTime());
        }
        return p;
    }

    public List<Promotion> getPromotionsByPage(int offset, int limit) {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions ORDER BY promotion_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, offset);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Promotion p = extract(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTotalPromotionCount() {
        String sql = "SELECT COUNT(*) FROM Promotions";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Promotion> searchPromotionByTitle(String keyword) {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM Promotions WHERE title LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionId(rs.getInt("promotion_id"));
                promotion.setTitle(rs.getString("title"));
                promotion.setDescription(rs.getString("description"));
                promotion.setDiscountPercent(rs.getDouble("discount_percent"));
                promotion.setDiscountAmount(rs.getDouble("discount_amount"));
                promotion.setStartDate(rs.getDate("start_date").toLocalDate());
                promotion.setEndDate(rs.getDate("end_date").toLocalDate());
                promotion.setStatus(rs.getString("status"));
                promotion.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                Timestamp updated = rs.getTimestamp("updated_at");
                promotions.add(promotion);
            }
        } catch (Exception e) {
            System.out.println("search error: " + e.getMessage());
        }
        return promotions;
    }

    public List<String> getAreaNamesByPromotionId(int promotionId) {
        List<String> areaNames = new ArrayList<>();
        String sql = "SELECT a.name FROM Promotion_Area pa JOIN Areas a ON pa.area_id = a.area_id WHERE pa.promotion_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                areaNames.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return areaNames;
    }
public boolean isDuplicatePromotionForArea(String title, LocalDate startDate, LocalDate endDate, int areaId) {
    String sql = "SELECT COUNT(*) FROM Promotions p " +
                 "JOIN Promotion_Area pa ON p.promotion_id = pa.promotion_id " +
                 "WHERE p.title = ? AND pa.area_id = ? " +
                 "AND NOT (? > p.end_date OR ? < p.start_date)";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, title);
        ps.setInt(2, areaId);
        ps.setDate(3, java.sql.Date.valueOf(endDate));
        ps.setDate(4, java.sql.Date.valueOf(startDate));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}


    public static void main(String[] args) {
        PromotionDAO dao = new PromotionDAO();
        dao.deletePromotion(1);
        System.out.println("Xoa thanh cong");
    }
}