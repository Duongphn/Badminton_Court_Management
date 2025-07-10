/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.AreaCoach;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author sang
 */
public class AreaCoachDAO {
    public List<AreaCoach> getAllAreas() throws Exception {
        List<AreaCoach> list = new ArrayList<>();
        String sql = "SELECT * FROM Areas";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            AreaCoach area = new AreaCoach();
            area.setAreaId(rs.getInt("area_id"));
            area.setName(rs.getString("name"));
            area.setLocation(rs.getString("location"));
            list.add(area);
        }
        conn.close();
        return list;
    }
    
public AreaCoach getAreaById(int areaId) throws Exception {
    String sql = "SELECT * FROM Areas WHERE area_id = ?";
    Connection conn = new DBContext().getConnection();
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, areaId);
    ResultSet rs = ps.executeQuery();
    AreaCoach area = null;
    if (rs.next()) {
        area = new AreaCoach();
        area.setAreaId(rs.getInt("area_id"));
        area.setName(rs.getString("name"));
        area.setLocation(rs.getString("location"));
    }
    conn.close();
    return area;
}
}
