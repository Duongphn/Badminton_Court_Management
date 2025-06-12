package DAO;

import Dal.DBContext;
import Model.Branch_Equipments;
import Model.Equipments;
import java.sql.*;
import java.util.*;

public class EquipmentsDAO extends DBContext{

    Connection conn;

    public EquipmentsDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public static  List<Equipments> getAllEquipments() {
        List<Equipments> list = new ArrayList<>();
        try {
            Connection con = new DBContext().getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Service");

            while (rs.next()) {
                list.add(new Equipments(
                        rs.getInt("equipment_id"),
                        rs.getString("name"),
                        rs.getDouble("price")
                        //rs.getInt("quantity") // quantity là String
                ));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 public List<Branch_Equipments> getAllAreaServices(int areaID) {
        List<Branch_Equipments> areaServices = new ArrayList<>();
        String query = "SELECT AreaEquipment_id, equipment_id, area_id FROM DormService where area_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, areaID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Branch_Equipments areaService = new Branch_Equipments();
                areaService.setAreaEquipment_id(resultSet.getInt("AreaEquipment_id"));
                areaService.setEquipment_id(resultSet.getInt("equipment_id"));
                areaService.setArea_id(resultSet.getInt("area_id"));
                areaServices.add(areaService);
            }
        } catch (SQLException e) {
            System.out.println("getAllRoomServices: " + e.getMessage());
        }
        return areaServices;
    }
    public static void addService(Equipments s) throws SQLException {
        try {
            if (isDuplicateService(s.getName())) {
                throw new SQLException("Duplicate service name");
            }

            int nextId = getNextEquipmentId();

            Connection con = new DBContext().getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO Equipments(equipment_id, name, price) VALUES (?, ?, ?)");
            ps.setInt(1, nextId);
            ps.setString(2, s.getName());
            ps.setDouble(3, s.getPrice());
            //ps.setInt(4, s.getQuantity()); 
            ps.executeUpdate();
            con.close();
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Unknown error", e);
        }
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

    public static boolean isDuplicateService(String name) {
        boolean isDuplicate = false;
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Equipments WHERE LTRIM(RTRIM(name)) = ?")
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
}
