/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.CommentReport;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CommentReportDAO {

    public List<CommentReport> getAllCommentReports() {
        List<CommentReport> list = new ArrayList<>();
        String sql = "SELECT "
                + "cr.report_id, cr.comment_id, c.content AS comment_content, c.post_id, "
                + "u_comment.username AS commented_username, "
                + "u_report.username AS reporter_username, "
                + "cr.reason, cr.created_at "
                + "FROM CommentReports cr "
                + "LEFT JOIN Comments c ON cr.comment_id = c.comment_id "
                + "LEFT JOIN Users u_comment ON c.user_id = u_comment.user_id "
                + "LEFT JOIN Users u_report ON cr.reported_by = u_report.user_id "
                + "ORDER BY cr.created_at DESC";
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CommentReport r = new CommentReport();
                r.setReportId(rs.getInt("report_id"));
                r.setCommentId(rs.getInt("comment_id"));
                r.setCommentContent(rs.getString("comment_content"));
                r.setPostId(rs.getInt("post_id"));
                r.setCommentedUsername(rs.getString("commented_username"));
                r.setReporterUsername(rs.getString("reporter_username"));
                r.setReason(rs.getString("reason"));
                r.setCreatedAt(rs.getString("created_at"));
                list.add(r);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<CommentReport> searchReports(String search, String reason, int page, int size) {
        List<CommentReport> list = new ArrayList<>();
        String sql = "SELECT cr.report_id, cr.comment_id, c.content AS comment_content, c.post_id, "
                + "u_comment.username AS commented_username, "
                + "u_report.username AS reporter_username, "
                + "cr.reason, cr.created_at "
                + "FROM CommentReports cr "
                + "LEFT JOIN Comments c ON cr.comment_id = c.comment_id "
                + "LEFT JOIN Users u_comment ON c.user_id = u_comment.user_id "
                + "LEFT JOIN Users u_report ON cr.reported_by = u_report.user_id "
                + "WHERE (1=1) ";

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (c.content LIKE ? OR u_comment.username LIKE ? OR u_report.username LIKE ?) ";
            String kw = "%" + search.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        if (reason != null && !reason.trim().isEmpty()) {
            if ("Khác".equals(reason.trim())) {
                sql += "AND cr.reason NOT IN (?, ?, ?, ?, ?) "; // 5 lý do chính
                params.add("Spam hoặc quảng cáo");
                params.add("Quấy rối hoặc bắt nạt");
                params.add("Ngôn từ thù địch");
                params.add("Nội dung không phù hợp");
                params.add("Thông tin sai lệch");
            } else {
                sql += "AND cr.reason = ? ";
                params.add(reason.trim());
            }
        }

        sql += "ORDER BY cr.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        int offset = (page - 1) * size;
        params.add(offset);
        params.add(size);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CommentReport r = new CommentReport();
                r.setReportId(rs.getInt("report_id"));
                r.setCommentId(rs.getInt("comment_id"));
                r.setCommentContent(rs.getString("comment_content"));
                r.setPostId(rs.getInt("post_id"));
                r.setCommentedUsername(rs.getString("commented_username"));
                r.setReporterUsername(rs.getString("reporter_username"));
                r.setReason(rs.getString("reason"));
                r.setCreatedAt(rs.getString("created_at"));
                list.add(r);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số bản ghi phù hợp với filter, cho phân trang
    public int countReports(String search, String reason) {
        String sql = "SELECT COUNT(*) "
                + "FROM CommentReports cr "
                + "LEFT JOIN Comments c ON cr.comment_id = c.comment_id "
                + "LEFT JOIN Users u_comment ON c.user_id = u_comment.user_id "
                + "LEFT JOIN Users u_report ON cr.reported_by = u_report.user_id "
                + "WHERE (1=1) ";
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (c.content LIKE ? OR u_comment.username LIKE ? OR u_report.username LIKE ?) ";
            String kw = "%" + search.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }
        if (reason != null && !reason.trim().isEmpty()) {
            if ("Khác".equals(reason.trim())) {
                sql += "AND cr.reason NOT IN (?, ?, ?, ?, ?) ";
                params.add("Spam hoặc quảng cáo");
                params.add("Quấy rối hoặc bắt nạt");
                params.add("Ngôn từ thù địch");
                params.add("Nội dung không phù hợp");
                params.add("Thông tin sai lệch");
            } else {
                sql += "AND cr.reason = ? ";
                params.add(reason.trim());
            }
        }

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean hideCommentByReport(int commentId, int handledByUserId) {
        String sql = "UPDATE Comments SET status = 0 WHERE comment_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
