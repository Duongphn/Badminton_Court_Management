package DAO;

import Dal.DBContext;
import Model.Service;
import java.sql.*;
import java.util.*;
import Model.Branch_Service;
import java.math.BigDecimal;


public class ServiceDAO extends DBContext {

    
    
    Connection conn;

    public ServiceDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
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
    String query = "SELECT a.AreaServices_id, a.service_id, a.area_id, " +
                   "s.name, s.price, s.description, s.image_url, s.status " +
                   "FROM Areas_Services a " +
                   "JOIN BadmintonService s ON a.service_id = s.service_id " +
                   "WHERE a.area_id = ?";

    try (
        Connection conn = new DBContext().getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(query)) {

        preparedStatement.setInt(1, areaID);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            Branch_Service areaService = new Branch_Service();
            areaService.setAreaService_id(resultSet.getInt("AreaServices_id"));
            areaService.setService_id(resultSet.getInt("service_id"));
            areaService.setArea_id(resultSet.getInt("area_id"));

            Service service = new Service();
            service.setService_id(resultSet.getInt("service_id"));
            service.setName(resultSet.getString("name"));
            service.setPrice(resultSet.getDouble("price"));
            service.setDescription(resultSet.getString("description"));
            service.setImage_url(resultSet.getString("image_url"));
            service.setStatus(resultSet.getString("status"));

            areaService.setService(service);
            areaServices.add(areaService);
        }
    } catch (SQLException | ClassNotFoundException e) {
        System.out.println("getAllAreaServices: " + e.getMessage());
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
            ps.close();
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
                Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM BadmintonService WHERE LTRIM(RTRIM(name)) = ?")) {
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
                Connection conn = new DBContext().getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery("SELECT ISNULL(MAX(equipment_id), 0) + 1 FROM Equipments")) {
            if (rs.next()) {
                nextId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }


    // Cập nhật thông tin dịch vụ theo service_id
    public static boolean updateService(Service s) throws SQLException {
        String sql = "UPDATE BadmintonService SET name = ?, price = ?, description = ?, image_url = ?, status = ? WHERE service_id = ?";
        try (
                Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.setString(3, s.getDescription());
            ps.setString(4, s.getImage_url());
            ps.setString(5, s.getStatus());
            ps.setInt(6, s.getService_id());

                int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Unknown error", e);
        }
    }

    public static boolean deleteService(int service_id) throws SQLException {
        String sql = "DELETE FROM BadmintonService WHERE service_id = ?";
        try (
                Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, service_id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Unknown error", e);
        }
    }

    // Tìm kiếm dịch vụ theo tên
    public static List<Service> searchServiceByName(String keyword) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM BadmintonService WHERE name LIKE ?";
        try (
                Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
public BigDecimal getPriceById(int serviceId) {
    BigDecimal price = null;
    String sql = "SELECT price FROM BadmintonService WHERE service_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, serviceId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            price = rs.getBigDecimal("price");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return price;
}
    // Lấy thông tin dịch vụ theo id
    public static Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM BadmintonService WHERE service_id = ?";
        try (
                Connection con = new DBContext().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Service(
                        rs.getInt("service_id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}
