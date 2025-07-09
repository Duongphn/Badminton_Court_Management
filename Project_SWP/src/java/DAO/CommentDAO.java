package DAO;

import Dal.DBContext;
import Model.Comment;
import Model.User;
import java.sql.*;
import java.util.*;

public class CommentDAO {

    // Thêm bình luận mới
    public void addComment(int postId, int userId, String content, Integer parentId) {
        String sql = "INSERT INTO Comments (post_id, user_id, content, created_at, parent_comment_id) "
                + "VALUES (?, ?, ?, GETDATE(), ?)";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.setString(3, content);
            if (parentId != null) {
                ps.setInt(4, parentId);
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }
    }

    // Lấy toàn bộ bình luận theo post_id (bao gồm reply, xây dựng cây)
    public List<Comment> getCommentsByPostId(int postId) {
        List<Comment> comments = new ArrayList<>();
        Map<Integer, Comment> commentMap = new LinkedHashMap<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = new DBContext().getConnection();
            String sql = "SELECT * FROM Comments WHERE post_id = ? ORDER BY created_at ASC";
            ps = con.prepareStatement(sql);
            ps.setInt(1, postId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Comment c = new Comment();
                c.setCommentId(rs.getInt("comment_id"));
                c.setPostId(rs.getInt("post_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setContent(rs.getString("content"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setParentCommentId((Integer) rs.getObject("parent_comment_id"));

                // Optional: load user (nếu cần hiển thị người bình luận)
                User user = new UserDAO().getUserById(c.getUserId());
                c.setUser(user);

                commentMap.put(c.getCommentId(), c);
            }

            // Xây dựng reply cho từng comment gốc
            for (Comment c : commentMap.values()) {
                if (c.getParentCommentId() != null) {
                    Comment parent = commentMap.get(c.getParentCommentId());
                    if (parent != null) {
                        if (parent.getReplies() == null) {
                            parent.setReplies(new ArrayList<>());
                        }
                        parent.getReplies().add(c);
                    }
                } else {
                    comments.add(c);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }

        return comments;
    }
}
