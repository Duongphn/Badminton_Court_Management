/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Branch_pictures;
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
public class Branch_ImageDAO extends DBContext{
    Connection conn;
    public Branch_ImageDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
     public void addImage(int areaId, String imageUrl){
        String sql = "INSERT INTO Area_Image (area_id, imageURL) VALUES (?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, areaId);
            ps.setString(2, imageUrl);
            ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }
      public List<Branch_pictures> getRoomImagesByDormID(int area_id) {
        List<Branch_pictures> imageUrls = new ArrayList<>();
        String query = "SELECT * FROM Area_Image WHERE area_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, area_id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("imageID");
                int area = rs.getInt("area_id");
                String imageUrl = rs.getString("imageURL");
                imageUrls.add(new Branch_pictures(id, area, imageUrl));
            }
        } catch (SQLException ex) {
            System.out.println("getRoomImagesByRoomID: " + ex.getMessage());
        }

        return imageUrls;
    }
       public static void main(String[] args) {
        try {
            // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
            Branch_ImageDAO imageDAO = new Branch_ImageDAO();

            // Thông tin cần thêm (sửa lại giá trị thực tế tùy ứng dụng)
            int areaId = 4;  // ID của khu vực muốn thêm ảnh
            String imageUrl = "https://example.com/images/area1.jpg";  // URL của ảnh

            // Gọi phương thức thêm ảnh vào cơ sở dữ liệu
            imageDAO.addImage(areaId, imageUrl);
            List<Branch_pictures> list = imageDAO.getRoomImagesByDormID(areaId);
            for(Branch_pictures a : list){
                System.out.println(a);
            }
//            System.out.println("Image added successfully to area with ID = " + areaId);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
