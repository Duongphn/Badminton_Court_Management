/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.Branch;
import Model.Branch;
import Model.Branch_pictures;
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
public class AreaDAO extends DBContext {

    Connection conn;

    public AreaDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
  
public int countAreasWithFilter(Integer staffId, String search) {
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Areas WHERE 1=1");
    if (staffId != null) sql.append(" AND manager_id = ?");
    if (search != null && !search.trim().isEmpty()) sql.append(" AND name LIKE ?");
    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        int idx = 1;
        if (staffId != null) ps.setInt(idx++, staffId);
        if (search != null && !search.trim().isEmpty()) ps.setString(idx++, "%" + search.trim() + "%");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}


public List<Branch> getAreasWithFilter(Integer staffId, String search, int offset, int limit) {
    List<Branch> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Areas WHERE 1=1");
    if (staffId != null) sql.append(" AND manager_id = ?");
    if (search != null && !search.trim().isEmpty()) sql.append(" AND name LIKE ?");
    sql.append(" ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        int idx = 1;
        if (staffId != null) ps.setInt(idx++, staffId);
        if (search != null && !search.trim().isEmpty()) ps.setString(idx++, "%" + search.trim() + "%");
        ps.setInt(idx++, offset);
        ps.setInt(idx, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            
            Branch ar = new Branch();
          ar.setArea_id(rs.getInt("area_id"));
            ar.setName(rs.getString("name"));
            ar.setLocation(rs.getString("location"));
            ar.setManager_id(rs.getInt("manager_id"));
            ar.setEmptyCourt(rs.getInt("court"));
            ar.setOpenTime(rs.getTime("open_time"));
            ar.setCloseTime(rs.getTime("close_time"));
            ar.setDescription(rs.getString("descriptions"));
            ar.setPhone_branch(rs.getString("phone_area"));
            ar.setNameStaff(rs.getString("nameStaff"));
            list.add(ar);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public List<Branch> getAllAreas(int offset, int limit) {
    List<Branch> list = new ArrayList<>();
    String sql = "SELECT * FROM Areas ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, offset);
        stmt.setInt(2, limit);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Branch ar = new Branch();
            // set các trường ...
            ar.setArea_id(rs.getInt("area_id"));
            ar.setName(rs.getString("name"));
            ar.setLocation(rs.getString("location"));
            ar.setManager_id(rs.getInt("manager_id"));
            ar.setEmptyCourt(rs.getInt("court"));
            ar.setOpenTime(rs.getTime("open_time"));
            ar.setCloseTime(rs.getTime("close_time"));
            ar.setDescription(rs.getString("descriptions"));
            ar.setPhone_branch(rs.getString("phone_area"));
            ar.setNameStaff(rs.getString("nameStaff"));
            list.add(ar);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    public Time[] getAreaOpenAndCloseTime(int areaId) {
        String sql = "SELECT open_time, close_time FROM Areas WHERE area_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Time openTime = rs.getTime("open_time");
                Time closeTime = rs.getTime("close_time");
                return new Time[]{openTime, closeTime};
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Branch> searchAreaByName(String keyword) {
        List<Branch> areas = new ArrayList<>();
        String sql = "SELECT * FROM Areas WHERE name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Branch area = new Branch();
                area.setArea_id(rs.getInt("area_id"));
                area.setName(rs.getString("name"));
                area.setLocation(rs.getString("location"));
                area.setEmptyCourt(rs.getInt("court"));
                area.setOpenTime(rs.getTime("open_time"));
                area.setCloseTime(rs.getTime("close_time"));
                area.setDescription(rs.getString("descriptions"));
                area.setPhone_branch(rs.getString("phone_area"));
                area.setNameStaff(rs.getString("nameStaff"));
                areas.add(area);
            }
        } catch (Exception e) {
            System.out.println("searchAreaByName error: " + e.getMessage());
        }
        return areas;
    }
    
    public List<Branch> searchAreaByFilters(String areaName, String location, String timePeriod) {
        List<Branch> areas = new ArrayList<>();
        String sql = "SELECT * FROM Areas WHERE name LIKE ? AND location LIKE ?";

        if (timePeriod != null && !"Tất cả".equals(timePeriod)) {
            switch (timePeriod) {
                case "Sáng (6h-12h)":
                    sql += " AND open_time <= '12:00:00' AND close_time >= '06:00:00'";
                    break;
                case "Chiều (12h-18h)":
                    sql += " AND open_time <= '18:00:00' AND close_time >= '12:00:00'";
                    break;
                case "Tối (18h-22h)":
                    sql += " AND open_time <= '22:00:00' AND close_time >= '18:00:00'";
                    break;
            }
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (areaName == null ? "" : areaName) + "%");
            ps.setString(2, "%" + (location == null || "Tất cả".equals(location) ? "" : location) + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Branch area = new Branch();
                area.setArea_id(rs.getInt("area_id"));
                area.setName(rs.getString("name"));
                area.setLocation(rs.getString("location"));
                area.setEmptyCourt(rs.getInt("court"));
                area.setOpenTime(rs.getTime("open_time"));
                area.setCloseTime(rs.getTime("close_time"));
                area.setDescription(rs.getString("descriptions"));
                area.setPhone_branch(rs.getString("phone_area"));
                area.setNameStaff(rs.getString("nameStaff"));
                areas.add(area);
            }
        } catch (Exception e) {
            System.out.println("searchAreaByFilters error: " + e.getMessage());
        }
        return areas;
    }

    public List<String> getDistinctLocations() {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT DISTINCT location FROM Areas";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(rs.getString("location"));
            }
        } catch (Exception e) {
            System.out.println("getDistinctLocations error: " + e.getMessage());
        }
        return locations;
    }

    public void addRegion(Branch re) {
        String sql = "INSERT INTO [dbo].[Areas] "
                + "([name], [location], [manager_id], [court], [open_time], [close_time], [descriptions], [phone_area], [nameStaff]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, re.getName());
            pre.setString(2, re.getLocation());
            pre.setInt(3, re.getManager_id());
            pre.setInt(4, re.getEmptyCourt());
            pre.setTime(5, re.getOpenTime());
            pre.setTime(6, re.getCloseTime());
            pre.setString(7, re.getDescription());
            pre.setString(8, re.getPhone_branch());
            pre.setString(9, re.getNameStaff());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding region: " + e.getMessage());
        }
    }

    public Branch getAreaByIdWithManager(int area_id) {
        String sql = "SELECT a.*, u.username AS managerName FROM Areas a "
                + "JOIN Users u ON a.manager_id = u.user_id WHERE a.area_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, area_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Branch area = new Branch();
                area.setArea_id(rs.getInt("area_id"));
                area.setName(rs.getString("name"));
                area.setLocation(rs.getString("location"));
                area.setOpenTime(rs.getTime("open_time"));
                area.setCloseTime(rs.getTime("close_time"));
                area.setDescription(rs.getString("descriptions"));
                area.setPhone_branch(rs.getString("phone_area"));
                area.setNameStaff(rs.getString("nameStaff"));

                return area;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void UpdateArea(int id, String name, String address, Time openTime, Time closeTime, String description, String phone_branch, int manager_id, String nameStaff) {
    String sql = "UPDATE Areas SET name = ?, location = ?, open_time = ?, close_time = ?, descriptions = ?, phone_area = ?, manager_id = ?, nameStaff = ? WHERE area_id = ?";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setTime(3, openTime);
        ps.setTime(4, closeTime);
        ps.setString(5, description);
        ps.setString(6, phone_branch);
        ps.setInt(7, manager_id);
        ps.setString(8, nameStaff);
        ps.setInt(9, id);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public List<Branch> getAreasByNameStaff(String nameStaff, int offset, int limit) {
    List<Branch> list = new ArrayList<>();
    String sql = "SELECT * FROM Areas WHERE nameStaff = ? ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nameStaff);
        ps.setInt(2, offset);
        ps.setInt(3, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            // map dữ liệu vào Branch, add vào list
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public int countAreasByNameStaff(String nameStaff) {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Areas WHERE nameStaff = ?";
    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nameStaff);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

public List<String> getAllNameStaff() {
    List<String> list = new ArrayList<>();
    String sql = "SELECT DISTINCT nameStaff FROM Areas";
    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(rs.getString(1));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    public void deleteById(int areaId) {
        String sql = "delete from Areas where area_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, areaId);
            pre.executeLargeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Branch> getAreasByManager(int managerId) {
        List<Branch> areas = new ArrayList<>();
        String sql = "SELECT * FROM Areas WHERE manager_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Branch area = new Branch(
                        rs.getInt("area_id"),
                        rs.getString("name"),
                        rs.getString("location"),
                        rs.getInt("manager_id"),
                        rs.getInt("court"),
                        rs.getTime("open_time"),
                        rs.getTime("close_time"),
                        rs.getString("descriptions"),
                        rs.getString("phone_area"),
                        rs.getString("nameStaff")
                );
                areas.add(area);
            }
        } catch (SQLException e) {
            System.out.println("getAreasByManager error: " + e.getMessage());
        }

        return areas;
    }

    public int countAreasByManagerId(int id) {
        String sql = "SELECT count(*) as Total FROM Areas where manager_id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (Exception e) {
            System.out.println("getAllAreas: " + e.getMessage());
        }
        return 0;
    }

    public List<Branch> getAllByManagerID(int id, int pageNum, int pageSize) {
        List<Branch> list = new ArrayList<>();
        String sql = "SELECT * FROM Areas WHERE manager_id = ? ORDER BY area_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.setInt(2, pageNum);    // OFFSET = (pageNum - 1) * pageSize
            stmt.setInt(3, pageSize);  // Số dòng cần lấy
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int areasID = rs.getInt("area_id");
                String areaName = rs.getString("name");
                String location = rs.getString("location");
                int managerID = rs.getInt("manager_id");
                int emptyCourt = rs.getInt("court");
                Time openTime = rs.getTime("open_time");
                Time closeTime = rs.getTime("close_time");
                String description = rs.getString("descriptions");
                String phone_branch = rs.getString("phone_area");
                String nameStaff = rs.getString("nameStaff");
                Branch ar = new Branch(areasID, areaName, location, managerID, emptyCourt, openTime, closeTime, description, phone_branch, nameStaff);
                list.add(ar);
            }

        } catch (SQLException e) {
            System.out.println("getAllByManagerID: " + e.getMessage());
        }

        return list;
    }

    public List<Branch> getAllAreas() {
        List<Branch> listCourt = new ArrayList<>();
        String sql = "SELECT * FROM Areas";
        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int areasID = rs.getInt("area_id");
                String areaName = rs.getString("name");
                String location = rs.getString("location");
                int managerID = rs.getInt("manager_id");
                int emptyCourt = rs.getInt("court");
                Time openTime = rs.getTime("open_time");
                Time closeTime = rs.getTime("close_time");
                String description = rs.getString("descriptions");
                String phone_branch = rs.getString("phone_area");
                String nameStaff = rs.getString("nameStaff");
                Branch ar = new Branch(areasID, areaName, location, managerID, emptyCourt, openTime, closeTime, description, phone_branch, nameStaff);
                listCourt.add(ar);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourt;
    }

    public List<Branch> getTop3() {
        List<Branch> listTop3 = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM Areas ORDER BY area_id DESC;";
        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int areasID = rs.getInt("area_id");
                String areaName = rs.getString("name");
                String location = rs.getString("location");
                int managerID = rs.getInt("manager_id");
                int emptyCourt = rs.getInt("court");
                Time openTime = rs.getTime("open_time");
                Time closeTime = rs.getTime("close_time");
                String description = rs.getString("descriptions");
                String phone_branch = rs.getString("phone_area");
                String nameStaff = rs.getString("nameStaff");
                Branch branch = new Branch(areasID, areaName, location, managerID, emptyCourt, openTime, closeTime, description, phone_branch, nameStaff);
                listTop3.add(branch);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listTop3;
    }

    public void updateEmptyCourtByAreaId(int areaId, int change) {
        try {

            String sql = "UPDATE Areas SET court = ISNULL(court, 0) + ? WHERE area_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, change);
            ps.setInt(2, areaId);
            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isRegionNameExist(String name) {
    String sql = "SELECT COUNT(*) FROM Areas WHERE LOWER(name) = ? ";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name.trim().toLowerCase());
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

public int countAllAreas() {
    String sql = "SELECT COUNT(*) AS Total FROM Areas";
    try {
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("Total");
        }
    } catch (Exception e) {
        System.out.println("countAllAreas: " + e.getMessage());
    }
    return 0;
}
    public String getAreaNameById(int areaId) {
        String sql = "SELECT name FROM Areas WHERE area_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, areaId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static void main(String[] args) {
         Branch branch = new Branch();
        AreaDAO dao = new AreaDAO();
        dao.deleteById(14);
    }
}
