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

    public List<Post> getPosts(String type, String keyword, String status, int offset, int limit) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT p.*, u.username AS createdByName "
                + "FROM Posts p "
                + "LEFT JOIN Users u ON p.created_by = u.user_id "
                + "WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + keyword + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        sql.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        PreparedStatement stmt = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stmt.executeQuery();
        List<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post p = new Post();
            p.setPostId(rs.getInt("post_id"));
            p.setTitle(rs.getString("title"));
            p.setContent(rs.getString("content"));
            p.setType(rs.getString("type"));
            p.setCreatedBy(rs.getInt("created_by"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            p.setStatus(rs.getString("status"));
            p.setCreatedByName(rs.getString("createdByName"));
            list.add(p);
        }
        return list;
    }

    public List<Post> getPostsForUser(String type, String keyword, int userId, int offset, int limit) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM Posts WHERE (status = 'approved'");
        List<Object> params = new ArrayList<>();

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + keyword + "%");
        }

        sql.append(" OR (created_by = ? AND (status = 'rejected'))");
        params.add(userId);

        sql.append(") ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        PreparedStatement stmt = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stmt.executeQuery();
        List<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post p = new Post();
            p.setPostId(rs.getInt("post_id"));
            p.setTitle(rs.getString("title"));
            p.setContent(rs.getString("content"));
            p.setType(rs.getString("type"));
            p.setCreatedBy(rs.getInt("created_by"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            p.setStatus(rs.getString("status"));
            list.add(p);
        }
        return list;
    }

    public Post getPostById(int postId) throws SQLException {
        String sql = "SELECT * FROM Posts WHERE post_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, postId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Post p = new Post();
            p.setPostId(rs.getInt("post_id"));
            p.setTitle(rs.getString("title"));
            p.setContent(rs.getString("content"));
            p.setType(rs.getString("type"));
            p.setCreatedBy(rs.getInt("created_by"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            return p;
        }
        return null;
    }

    public int getTotalPostManager(String type, String keyword, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Posts WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + keyword + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        PreparedStatement stmt = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public int getTotalApprovedPostCount(String type, String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Posts WHERE status = 'approved'";
        if (type != null && !type.isEmpty()) {
            sql += " AND type = ?";
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND title LIKE ?";
        }

        PreparedStatement stmt = conn.prepareStatement(sql);
        int index = 1;

        if (type != null && !type.isEmpty()) {
            stmt.setString(index++, type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            stmt.setString(index++, "%" + keyword + "%");
        }

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public void insertPost(Post post) throws SQLException {
        String sql = "INSERT INTO Posts (title, content, created_by, type, status) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, post.getTitle());
        stmt.setString(2, post.getContent());
        stmt.setInt(3, post.getCreatedBy());
        stmt.setString(4, post.getType());
        stmt.setString(5, post.getStatus());
//        stmt.setString(6, post.getImage());

        stmt.executeUpdate();
    }

    public boolean isOwner(int userId, int postId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Posts WHERE post_id = ? AND created_by = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, postId);
        stmt.setInt(2, userId);
        ResultSet rs = stmt.executeQuery();
        return rs.next() && rs.getInt(1) > 0;
    }

    public void updatePost(Post post) throws SQLException {
        String sql = "UPDATE Posts SET title = ?, content = ?, type = ? WHERE post_id = ? AND created_by = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, post.getTitle());
        stmt.setString(2, post.getContent());
        stmt.setString(3, post.getType());
        stmt.setInt(4, post.getPostId());
        stmt.setInt(5, post.getCreatedBy());
        stmt.executeUpdate();
    }

    public void updatePostStatus(int postId, String status) throws SQLException {
        String sql = "UPDATE Posts SET status = ? WHERE post_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, status);
        stmt.setInt(2, postId);
        stmt.executeUpdate();
    }

    public void deletePost(int postId, int userId) throws SQLException {
        String sql = "DELETE FROM Posts WHERE post_id = ? AND created_by = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, postId);
        stmt.setInt(2, userId);
        stmt.executeUpdate();
    }

}
