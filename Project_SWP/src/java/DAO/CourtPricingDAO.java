/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;

/**
 *
 * @author admin
 */
public class CourtPricingDAO extends DBContext{
     Connection conn;

    public CourtPricingDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public double calculatePrice(int areaId, Time start, Time end) {
    double total = 0;
    try {
        String sql = "SELECT * FROM Court_Pricing WHERE area_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, areaId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Time pricingStart = rs.getTime("start_time");
            Time pricingEnd = rs.getTime("end_time");
            double price = rs.getDouble("price");

            // Nếu khoảng thời gian nằm trong khung giá
            if (!(end.before(pricingStart) || start.after(pricingEnd))) {
                long minutes = (Math.min(end.getTime(), pricingEnd.getTime()) - 
                                Math.max(start.getTime(), pricingStart.getTime())) / 60000;
                total += (minutes * price) / 60;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return total;
}

}
