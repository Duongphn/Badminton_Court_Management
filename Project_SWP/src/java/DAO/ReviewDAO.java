/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
BookingDAO dao = new BookingDAO();
public int countByArea(int areaId) {
    return dao.countBookingsByArea(areaId);
}

}
