/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import java.util.*;
import Model.Banner;
import Dal.DBContext;

public class BannerDAO {
    // Lấy tất cả banner
    public List<Banner> getAllBanners() throws Exception {
        List<Banner> list = new ArrayList<>();
        String sql = "SELECT * FROM Banners ORDER BY banner_id DESC";
        Connection conn = new DBContext().getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Banner b = new Banner();
            b.setId(rs.getInt("banner_id"));
            b.setImageUrl(rs.getString("image_url"));
            b.setTitle(rs.getString("title"));
            b.setCaption(rs.getString("caption"));
            b.setStatus(rs.getBoolean("status"));
            list.add(b);
        }
        rs.close();
        st.close();
        conn.close();
        return list;
    }

    // Lấy banner đang hiển thị
    public List<Banner> getActiveBanners() throws Exception {
        List<Banner> list = new ArrayList<>();
        String sql = "SELECT * FROM Banners WHERE status=1 ORDER BY banner_id DESC";
        Connection conn = new DBContext().getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Banner b = new Banner();
            b.setId(rs.getInt("banner_id"));
            b.setImageUrl(rs.getString("image_url"));
            b.setTitle(rs.getString("title"));
            b.setCaption(rs.getString("caption"));
            b.setStatus(rs.getBoolean("status"));
            list.add(b);
        }
        rs.close();
        st.close();
        conn.close();
        return list;
    }

    // Thêm banner
    public void addBanner(Banner banner) throws Exception {
    String sql = "INSERT INTO Banners(image_url, title, caption, status) VALUES (?, ?, ?, ?)";
    System.out.println("===== [DEBUG] addBanner start =====");
    System.out.println("Image URL: " + banner.getImageUrl());
    System.out.println("Title: " + banner.getTitle());
    System.out.println("Caption: " + banner.getCaption());
    System.out.println("Status: " + banner.isStatus());
    try (Connection conn = new DBContext().getConnection()) {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, banner.getImageUrl());
        ps.setString(2, banner.getTitle());
        ps.setString(3, banner.getCaption());
        ps.setBoolean(4, banner.isStatus());
        int rows = ps.executeUpdate();
        System.out.println("[DEBUG] Rows affected: " + rows);
        ps.close();
    } catch (Exception e) {
        System.out.println("[ERROR] Khi insert Banner:");
        e.printStackTrace();
        throw e;
    }
    System.out.println("===== [DEBUG] addBanner end =====");
}

    // Xoá banner
    public void deleteBanner(int id) throws Exception {
        String sql = "DELETE FROM Banners WHERE banner_id=?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close();
        conn.close();
    }

    // Sửa banner
    public void updateBanner(Banner banner) throws Exception {
        String sql = "UPDATE Banners SET image_url=?, title=?, caption=?, status=? WHERE banner_id=?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, banner.getImageUrl());
        ps.setString(2, banner.getTitle());
        ps.setString(3, banner.getCaption());
        ps.setBoolean(4, banner.isStatus());
        ps.setInt(5, banner.getId());
        ps.executeUpdate();
        ps.close();
        conn.close();
    }

    // Lấy banner theo id
    public Banner getBannerById(int id) throws Exception {
        String sql = "SELECT * FROM Banners WHERE banner_id=?";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Banner b = null;
        if (rs.next()) {
            b = new Banner();
            b.setId(rs.getInt("banner_id"));
            b.setImageUrl(rs.getString("image_url"));
            b.setTitle(rs.getString("title"));
            b.setCaption(rs.getString("caption"));
            b.setStatus(rs.getBoolean("status"));
        }
        rs.close();
        ps.close();
        conn.close();
        return b;
    }
}
