/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Bookings;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class BookingDAO extends DBContext{
     Connection conn;

    public BookingDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public int countBookingsByManager(int managerId) {
    String sql = "SELECT COUNT(*) FROM Bookings b " +
                 "JOIN Courts c ON b.court_id = c.court_id " +
                 "JOIN Areas a ON c.area_id = a.area_id " +
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
public int countBookingsByArea(int areaId)  {
    String sql = "SELECT COUNT(*) " +
                 "FROM Bookings b " +
                 "JOIN Courts c ON b.court_id = c.court_id " +
                 "WHERE c.area_id = ?";

    try (
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, areaId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return rs.getInt(1); // return the count
        }
    }catch(SQLException e){
        System.out.println(e.getMessage());
    }

    return 0; 
}
public boolean checkSlotAvailable(int courtId, String date, Time startTime, Time endTime) {
    String sql = "SELECT COUNT(*) FROM Bookings WHERE court_id = ? AND date = ? " +
                 "AND ((start_time < ? AND end_time > ?) OR (start_time >= ? AND start_time < ?))";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, courtId);
        ps.setString(2, date);
        ps.setTime(3, endTime);
        ps.setTime(4, startTime);
        ps.setTime(5, startTime);
        ps.setTime(6, endTime);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) == 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
public Bookings getBookingById(int bookingId) {
    String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, bookingId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Bookings b = new Bookings();
            b.setBooking_id(rs.getInt("booking_id"));
            b.setUser_id(rs.getInt("user_id"));
            b.setCourt_id(rs.getInt("court_id"));
            b.setDate(rs.getDate("date").toLocalDate());  
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setStatus(rs.getString("status"));
            return b;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
public List<Bookings> getBookingsByUserId(int userId) {
    List<Bookings> list = new ArrayList<>();
    String sql = "SELECT * FROM Bookings b JOIN Courts c ON b.court_id = c.court_id WHERE b.user_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Bookings b = new Bookings();
            b.setBooking_id(rs.getInt("booking_id"));
             b.setCourt_id(rs.getInt("court_id"));
            b.setDate(rs.getDate("date").toLocalDate());
            b.setStart_time(rs.getTime("start_time"));
            b.setEnd_time(rs.getTime("end_time"));
            b.setStatus(rs.getString("status"));
            list.add(b);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


public boolean cancelBookingById(int bookingId) {
    String sql = "UPDATE Bookings SET status = 'cancelled' WHERE booking_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, bookingId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

}
