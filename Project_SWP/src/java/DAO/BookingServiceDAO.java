/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class BookingServiceDAO extends DBContext{
     Connection conn;

    public BookingServiceDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public void addServiceToBooking(int bookingId, int serviceId) {
    String sql = "INSERT INTO Booking_Services (booking_id, service_id) VALUES (?, ?)";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, bookingId);
        ps.setInt(2, serviceId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    public void removeServicesByBookingId(int bookingId) {
        String sql = "DELETE FROM Booking_Services WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Service> getServicesByBookingId(int bookingId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.service_id, s.name, s.price, s.description, s.image_url, s.status "
                + "FROM Booking_Services bs JOIN BadmintonService s ON bs.service_id = s.service_id "
                + "WHERE bs.booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service s = new Service(rs.getInt("service_id"), rs.getString("name"),
                        rs.getDouble("price"), rs.getString("description"),
                        rs.getString("image_url"), rs.getString("status"),rs.getString("category"));
                services.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

}
