/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;

import Model.Branch_Service;
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
public class Service_BranchDAO extends DBContext {

    Connection conn;

    public Service_BranchDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public void addServiceToArea(int areaId, int serviceId) {
        String sql = "INSERT INTO Areas_Services (area_id, service_id) VALUES (?, ?)";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ps.setInt(2, serviceId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Branch_Service> getAllAreaServices(int areaID) {
        List<Branch_Service> areaServices = new ArrayList<>();
        String query = "SELECT a.AreaServices_id, a.service_id, a.area_id, s.name, s.price\n"
                + "    FROM Areas_Services a\n"
                + "    JOIN BadmintonService s ON a.service_id = s.service_id\n"
                + "    WHERE a.area_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
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

                areaService.setService(service);

                areaServices.add(areaService);
            }
        } catch (SQLException e) {
            System.out.println("getAllRoomServices: " + e.getMessage());
        }
        return areaServices;
    }

    public void removeServiceFromArea(int areaServiceID) {
        String query = "DELETE FROM Areas_Services WHERE AreaServices_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, areaServiceID);

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println(rowsAffected);
        } catch (SQLException e) {
            System.out.println("removeServiceFromRoom: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        Service_BranchDAO dao = new Service_BranchDAO();
//         int areaId = 1;
//            int serviceId = 1;
//            dao.addServiceToArea(areaId, serviceId);
//
//            System.out.println("✅ Dịch vụ đã được thêm vào khu vực thành công.");

//        dao.removeServiceFromArea(1);
//        System.out.println("Da xoa");
        List<Branch_Service> list = dao.getAllAreaServices(1);
        for (Branch_Service a : list) {
            System.out.println(a);
        }
    }
}
