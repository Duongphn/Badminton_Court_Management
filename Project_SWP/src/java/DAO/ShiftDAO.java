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
import java.util.ArrayList;
import java.util.List;

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
   public Shift findShiftContainSlot(int courtId, Time slotStart, Time slotEnd) throws Exception {
    
    List<Shift> shifts = getShiftsByCourt(courtId); 

    for (Shift shift : shifts) {
        Time shiftStart = shift.getStartTime();
        Time shiftEnd = shift.getEndTime();
       
        if (!slotStart.before(shiftStart) && !slotEnd.after(shiftEnd)) {
            return shift;
        }
    }
    return null; 
}

  public List<Shift> getShiftsByCourt(int courtId) {
    List<Shift> list = new ArrayList<>();
    String sql = "SELECT s.shift_id, s.area_id, s.shift_name, s.start_time, s.end_time, s.price " +
                 "FROM Courts c " +
                 "JOIN Areas a ON c.area_id = a.area_id " +
                 "JOIN Shift s ON s.area_id = a.area_id " +
                 "WHERE c.court_id = ?";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, courtId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Shift s = new Shift(
                rs.getInt("shift_id"),
                rs.getInt("area_id"),
                rs.getString("shift_name"),
                rs.getTime("start_time"),
                rs.getTime("end_time"),
                rs.getBigDecimal("price")
            );
            list.add(s);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



   public List<Shift> getShiftsByArea(int areaId) {
    List<Shift> shifts = new ArrayList<>();
    String sql = "SELECT shift_id, area_id, shift_name, start_time, end_time, price FROM Shift WHERE area_id = ?";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, areaId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Shift shift = new Shift(
                rs.getInt("shift_id"),
                rs.getInt("area_id"),
                rs.getString("shift_name"),
                rs.getTime("start_time"),
                rs.getTime("end_time"),
                rs.getBigDecimal("price")
            );
            shifts.add(shift);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return shifts;
}

    public Shift getShiftById(int shiftId) {
    String sql = "SELECT shift_id, area_id, shift_name, start_time, end_time, price FROM Shift WHERE shift_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, shiftId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Shift(
                    rs.getInt("shift_id"),
                    rs.getInt("area_id"),
                    rs.getString("shift_name"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getBigDecimal("price")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}


     public boolean addShift(Shift shift) {
    String sql = "INSERT INTO Shift (area_id, shift_name, start_time, end_time, price) VALUES (?, ?, ?, ?, ?)";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, shift.getAreaId());
        ps.setString(2, shift.getShiftName());
        ps.setTime(3, shift.getStartTime());
        ps.setTime(4, shift.getEndTime());
        ps.setBigDecimal(5, shift.getPrice());
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
public boolean updateShift(Shift shift) {
    String sql = "UPDATE Shift SET area_id = ?, shift_name = ?, start_time = ?, end_time = ?, price = ? WHERE shift_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, shift.getAreaId());
        ps.setString(2, shift.getShiftName());
        ps.setTime(3, shift.getStartTime());
        ps.setTime(4, shift.getEndTime());
        ps.setBigDecimal(5, shift.getPrice());
        ps.setInt(6, shift.getShiftId()); // Lưu ý vị trí thứ tự tham số
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
      public static void main(String[] args) {
        ShiftDAO dao = new ShiftDAO();
        List<Shift> list = dao.getShiftsByCourt(1);
        for(Shift a : list){
            System.out.println(a);
        }
    }
}
