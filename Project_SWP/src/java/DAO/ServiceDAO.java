package DAO;

import Dal.DBContext;
import Model.Service;
import java.sql.*;
import java.util.*;
import Model.Branch_Service;

public class ServiceDAO extends DBContext {
    // Lấy tất cả dịch vụ
    public static List<Service> getAllService() {
        List<Service> list = new ArrayList<>();
        try {
            Connection con = new DBContext().getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM BadmintonService");

            while (rs.next()) {
                list.add(new Service(
                        rs.getInt("service_id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getString("status")
                ));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Branch_Service> getAllAreaServices(int areaID) {
        List<Branch_Service> areaServices = new ArrayList<>();
        String query = "SELECT AreaServices_id, service_id, area_id FROM Areas_Services  where area_id = ?";

        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery()) {
            
            preparedStatement.setInt(1, areaID);
            

            while (resultSet.next()) {
                Branch_Service areaService = new Branch_Service();
                areaService.setAreaService_id(resultSet.getInt("AreaServices_id"));
                areaService.setService_id(resultSet.getInt("service_id"));
                areaService.setArea_id(resultSet.getInt("area_id"));
                areaServices.add(areaService);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("getAllRoomServices: " + e.getMessage());
        }
        return areaServices;
    }

    // Thêm dịch vụ mới
    public static void addService(Service s) throws SQLException {
        try {
            if (isDuplicateService(s.getName())) {
                throw new SQLException("Duplicate service name");
            }

            Connection con = new DBContext().getConnection();
            String sql = "INSERT INTO BadmintonService (name, price, description, image_url, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.setString(3, s.getDescription());
            ps.setString(4, s.getImage_url());
            ps.setString(5, s.getStatus() != null ? s.getStatus() : "Active");

            ps.executeUpdate();

            // Nếu cần lấy service_id vừa insert
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int newId = rs.getInt(1);
                System.out.println("Inserted Service ID: " + newId);
            }

            con.close();
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Unknown error", e);
        }
    }

    // Kiểm tra trùng tên dịch vụ
    public static boolean isDuplicateService(String name) {
        boolean isDuplicate = false;
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM BadmintonService WHERE LTRIM(RTRIM(name)) = ?")
        ) {
            ps.setString(1, name.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDuplicate;
    }
     public static int getNextEquipmentId() {
        int nextId = 1;
        try (
            Connection conn = new DBContext().getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT ISNULL(MAX(equipment_id), 0) + 1 FROM Equipments")
        ) {
            if (rs.next()) {
                nextId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }
}
