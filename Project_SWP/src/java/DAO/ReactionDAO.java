package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class ReactionDAO {

    private Connection conn;

    public ReactionDAO(Connection conn) {
        this.conn = conn;
    }

    public void reactToPost(int userId, int postId, String reactionType) throws SQLException {
        String checkSql = "SELECT * FROM PostReactions WHERE user_id = ? AND post_id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, userId);
        checkStmt.setInt(2, postId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            String updateSql = "UPDATE PostReactions SET reaction_type = ?, reacted_at = GETDATE() WHERE user_id = ? AND post_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, reactionType);
            updateStmt.setInt(2, userId);
            updateStmt.setInt(3, postId);
            updateStmt.executeUpdate();
        } else {
            String insertSql = "INSERT INTO PostReactions (user_id, post_id, reaction_type) VALUES (?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, postId);
            insertStmt.setString(3, reactionType);
            insertStmt.executeUpdate();
        }
    }

    public String getUserReaction(int userId, int postId) throws SQLException {
        String sql = "SELECT reaction_type FROM PostReactions WHERE user_id = ? AND post_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        stmt.setInt(2, postId);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getString("reaction_type");
        }
        return null; 
    }
}
