/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Shift;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

/**
 *
 * @author admin
 */
public class ShiftDAO extends DBContext{
     Connection conn;

    public ShiftDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    
     public Shift getShiftByCourt(int courtId) {
    Shift shift = null;
    String sql = "SELECT s.shift_id, s.area_id, s.shift_name, s.start_time, s.end_time " +
                 "FROM Courts c " +
                 "JOIN Areas a ON c.area_id = a.area_id " +
                 "JOIN Shift s ON a.area_id = s.area_id " +
                 "WHERE c.court_id = ?";

    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, courtId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            shift = new Shift(
                rs.getInt("shift_id"),
                rs.getInt("area_id"),
                rs.getString("shift_name"),
                rs.getTime("start_time"),
                rs.getTime("end_time")
            );
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return shift;
}
      public boolean addShift(Shift shift) {
        String sql = "INSERT INTO Shift (area_id, shift_name, start_time, end_time) VALUES (?, ?, ?, ?)";

        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, shift.getAreaId());
            ps.setString(2, shift.getShiftName());
            ps.setTime(3, shift.getStartTime());
            ps.setTime(4, shift.getEndTime());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
      public void removeShift(int shift_id) {
        String query = "DELETE FROM Shift WHERE shift_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, shift_id);

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println(rowsAffected);
        } catch (SQLException e) {
            System.out.println("remove: " + e.getMessage());
        }
    }
}
