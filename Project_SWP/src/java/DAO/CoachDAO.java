/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Coach;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author sang
 */
public class CoachDAO {
    public void insertCoach(Coach coach) throws Exception {
        String sql = "INSERT INTO Coaches (area_id, fullname, email, phone, specialty, description, image_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, coach.getAreaId());
        ps.setString(2, coach.getFullname());
        ps.setString(3, coach.getEmail());
        ps.setString(4, coach.getPhone());
        ps.setString(5, coach.getSpecialty());
        ps.setString(6, coach.getDescription());
        ps.setString(7, coach.getImageUrl());
        ps.setString(8, coach.getStatus());
        ps.executeUpdate();
        conn.close();
    }

    public void updateCoach(Coach coach) throws Exception {
        String sql = "UPDATE Coaches SET area_id=?, fullname=?, email=?, phone=?, specialty=?, description=?, image_url=?, status=? WHERE coach_id=?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, coach.getAreaId());
        ps.setString(2, coach.getFullname());
        ps.setString(3, coach.getEmail());
        ps.setString(4, coach.getPhone());
        ps.setString(5, coach.getSpecialty());
        ps.setString(6, coach.getDescription());
        ps.setString(7, coach.getImageUrl());
        ps.setString(8, coach.getStatus());
        ps.setInt(9, coach.getCoachId());
        ps.executeUpdate();
        conn.close();
    }

    public void deleteCoach(int coachId) throws Exception {
        String sql = "DELETE FROM Coaches WHERE coach_id = ?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, coachId);
        ps.executeUpdate();
        conn.close();
    }

    public Coach getCoachById(int coachId) throws Exception {
        String sql = "SELECT * FROM Coaches WHERE coach_id = ?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, coachId);
        ResultSet rs = ps.executeQuery();
        Coach coach = null;
        if (rs.next()) {
            coach = new Coach();
            coach.setCoachId(rs.getInt("coach_id"));
            coach.setAreaId(rs.getInt("area_id"));
            coach.setFullname(rs.getString("fullname"));
            coach.setEmail(rs.getString("email"));
            coach.setPhone(rs.getString("phone"));
            coach.setSpecialty(rs.getString("specialty"));
            coach.setDescription(rs.getString("description"));
            coach.setImageUrl(rs.getString("image_url"));
            coach.setStatus(rs.getString("status"));
        }
        conn.close();
        return coach;
    }

    public List<Coach> getAllCoaches() throws Exception {
        List<Coach> list = new ArrayList<>();
        String sql = "SELECT * FROM Coaches";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Coach coach = new Coach();
            coach.setCoachId(rs.getInt("coach_id"));
            coach.setAreaId(rs.getInt("area_id"));
            coach.setFullname(rs.getString("fullname"));
            coach.setEmail(rs.getString("email"));
            coach.setPhone(rs.getString("phone"));
            coach.setSpecialty(rs.getString("specialty"));
            coach.setDescription(rs.getString("description"));
            coach.setImageUrl(rs.getString("image_url"));
            coach.setStatus(rs.getString("status"));
            list.add(coach);
        }
        conn.close();
        return list;
    }

    public List<Coach> getCoachesByArea(int areaId) throws Exception {
        List<Coach> list = new ArrayList<>();
        String sql = "SELECT * FROM Coaches WHERE area_id = ? AND status = 'active'";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, areaId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Coach coach = new Coach();
            coach.setCoachId(rs.getInt("coach_id"));
            coach.setAreaId(rs.getInt("area_id"));
            coach.setFullname(rs.getString("fullname"));
            coach.setEmail(rs.getString("email"));
            coach.setPhone(rs.getString("phone"));
            coach.setSpecialty(rs.getString("specialty"));
            coach.setDescription(rs.getString("description"));
            coach.setImageUrl(rs.getString("image_url"));
            coach.setStatus(rs.getString("status"));
            list.add(coach);
        }
        conn.close();
        return list;
    }
}
