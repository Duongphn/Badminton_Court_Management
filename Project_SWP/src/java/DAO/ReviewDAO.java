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
BookingDAO dao = new BookingDAO();
public int countByArea(int areaId) {
    return dao.countBookingsByArea(areaId);
}

}
