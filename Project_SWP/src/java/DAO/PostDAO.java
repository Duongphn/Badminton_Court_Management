/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Model.Post;
import java.sql.*;
import java.util.*;

/**
 *
 * @author admin
 */
public class PostDAO {
    private Connection conn;

    public PostDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Post> getPosts(String type, String keyword) throws SQLException {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE 1=1";

        if (type != null && !type.isEmpty()) {
            sql += " AND post_type = ?";
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND title LIKE ?";
        }

        sql += " ORDER BY created_at DESC";

        PreparedStatement stmt = conn.prepareStatement(sql);
        int paramIndex = 1;
        if (type != null && !type.isEmpty()) {
            stmt.setString(paramIndex++, type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            stmt.setString(paramIndex++, "%" + keyword + "%");
        }

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Post p = new Post();
            p.setPostId(rs.getInt("post_id"));
            p.setTitle(rs.getString("title"));
            p.setContent(rs.getString("content"));
            p.setPostType(rs.getString("post_type"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            list.add(p);
        }
        return list;
    }
}
