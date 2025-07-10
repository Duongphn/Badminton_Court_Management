/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Dal.DBContext;
import Model.Reviews;

/**
 *
 * @author admin
 */
public class ReviewDAO  extends DBContext{
     Connection conn;

    public ReviewDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
public int countReviewsByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Reviews r " +
                     "JOIN Areas a ON r.area_id = a.area_id " +
                     "WHERE a.manager_id = ?";
    
    try (
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, managerId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }catch(SQLException e){
        System.out.println(e.getMessage());
    }
        return 0;
    }

    // Count all reviews in system
    public int countAllReviews() {
        String sql = "SELECT COUNT(*) FROM Reviews";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public boolean addReview(int userId, int areaId, int rating, String comment) {
        String sql = "INSERT INTO Reviews (user_id, area_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, areaId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public String getLatestComment(int userId, int areaId, int rating) {
        String sql = "SELECT TOP 1 comment FROM Reviews WHERE user_id = ? AND area_id = ? AND rating = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, areaId);
            ps.setInt(3, rating);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("comment");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public java.util.List<Reviews> getReviewsByArea(int areaId) {
        java.util.List<Reviews> list = new java.util.ArrayList<>();
        String sql = "SELECT r.review_id, r.user_id, r.area_id, r.rating, r.comment, r.created_at, u.username " +
                     "FROM Reviews r JOIN Users u ON r.user_id = u.user_id WHERE r.area_id = ? ORDER BY r.created_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reviews r = new Reviews();
                r.setReview_id(String.valueOf(rs.getInt("review_id")));
                r.setUser_id(String.valueOf(rs.getInt("user_id")));
                r.setArea_id(String.valueOf(rs.getInt("area_id")));
                r.setRating(String.valueOf(rs.getInt("rating")));
                r.setComment(rs.getString("comment"));
                r.setCreated_at(rs.getString("created_at"));
                r.setUsername(rs.getString("username"));
                list.add(r);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
BookingDAO dao = new BookingDAO();
public int countByArea(int areaId) {
    return dao.countBookingsByArea(areaId);
}

}
