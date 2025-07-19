/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;

import Model.FaqAnswer;
import Model.FaqQuestion;
import Model.FaqTag;
import java.sql.*;
import java.util.*;

public class FaqDAO extends DBContext {
    
    public boolean isQuestionTagExists(String title, int tagId) throws SQLException, ClassNotFoundException {
    String sql = "SELECT COUNT(*) FROM faq_question WHERE title = ? AND tag_id = ?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, title);
        stmt.setInt(2, tagId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    }
    return false;
}

    public List<FaqQuestion> getAllQuestionsWithTag() {
        List<FaqQuestion> list = new ArrayList<>();
        String sql = "SELECT q.question_id, q.title, q.created_at, q.updated_at, "
                + "t.tag_id, t.name AS tag_name "
                + "FROM faq_question q "
                + "JOIN faq_tag t ON q.tag_id = t.tag_id "
                + "ORDER BY q.created_at DESC";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FaqTag tag = new FaqTag(rs.getInt("tag_id"), rs.getString("tag_name"));
                FaqQuestion q = new FaqQuestion();
                q.setQuestionId(rs.getInt("question_id"));
                q.setTitle(rs.getString("title"));
                q.setTag(tag);
                q.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                Timestamp updated = rs.getTimestamp("updated_at");
                if (updated != null) {
                    q.setUpdatedAt(updated.toLocalDateTime());
                }
                list.add(q);
            }
        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách FAQ: " + e);
        }
        return list;
    }

    public List<FaqTag> getAllTags() {
        List<FaqTag> tags = new ArrayList<>();
        String sql = "SELECT tag_id, name FROM faq_tag ORDER BY name ASC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tags.add(new FaqTag(rs.getInt("tag_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách tag: " + e.getMessage());
        }
        return tags;
    }

    public int countFilteredFaqQuestions(String keyword, int tagId) {
        String sql = "SELECT COUNT(*) FROM faq_question WHERE title LIKE ? AND (? = 0 OR tag_id = ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, tagId);
            ps.setInt(3, tagId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi đếm FAQ: " + e.getMessage());
        }
        return 0;
    }

    public List<FaqQuestion> getFilteredFaqQuestions(String keyword, int tagId, int page, int PAGE_SIZE) {
        List<FaqQuestion> list = new ArrayList<>();
        String sql = "SELECT q.question_id, q.title, q.created_at, q.updated_at, "
                + "t.tag_id, t.name AS tag_name "
                + "FROM faq_question q "
                + "JOIN faq_tag t ON q.tag_id = t.tag_id "
                + "WHERE q.title LIKE ? AND (? = 0 OR q.tag_id = ?) "
                + "ORDER BY q.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, tagId);
            ps.setInt(3, tagId);
            ps.setInt(4, (page - 1) * PAGE_SIZE);
            ps.setInt(5, PAGE_SIZE);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FaqTag tag = new FaqTag(rs.getInt("tag_id"), rs.getString("tag_name"));
                    FaqQuestion q = new FaqQuestion();
                    q.setQuestionId(rs.getInt("question_id"));
                    q.setTitle(rs.getString("title"));
                    q.setTag(tag);
                    q.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        q.setUpdatedAt(updated.toLocalDateTime());
                    }
                    list.add(q);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi lọc FAQ: " + e.getMessage());
        }
        return list;
    }

    public FaqQuestion getQuestionById(int id) {
        String sql = "SELECT q.question_id, q.title, q.tag_id, q.created_at, q.updated_at, t.name AS tag_name "
                + "FROM faq_question q JOIN faq_tag t ON q.tag_id = t.tag_id WHERE q.question_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    FaqTag tag = new FaqTag(rs.getInt("tag_id"), rs.getString("tag_name"));
                    FaqQuestion q = new FaqQuestion();
                    q.setQuestionId(rs.getInt("question_id"));
                    q.setTitle(rs.getString("title"));
                    q.setTag(tag);
                    q.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        q.setUpdatedAt(updated.toLocalDateTime());
                    }
                    return q;
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi getQuestionById: " + e.getMessage());
        }
        return null;
    }

    public void updateQuestion(FaqQuestion q) {
        String sql = "UPDATE faq_question SET title = ?, tag_id = ?, updated_at = GETDATE() WHERE question_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, q.getTitle());
            ps.setInt(2, q.getTag().getTagId());
            ps.setInt(3, q.getQuestionId());
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Lỗi updateQuestion: " + e.getMessage());
        }
    }

    public void addQuestion(String title, int tagId) {
        String sql = "INSERT INTO faq_question (title, tag_id, created_at) VALUES (?, ?, GETDATE())";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setInt(2, tagId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Lỗi thêm FAQ: " + e.getMessage());
        }
    }

    public List<FaqAnswer> getAnswersByQuestionId(int questionId) {
        List<FaqAnswer> list = new ArrayList<>();
        String sql = "SELECT a.answer_id, a.question_id, a.content, a.created_at, a.updated_at, "
                + "q.question_id, q.title, q.tag_id "
                + "FROM faq_answer a "
                + "JOIN faq_question q ON a.question_id = q.question_id "
                + "WHERE a.question_id = ? "
                + "ORDER BY a.created_at DESC";

        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FaqAnswer answer = new FaqAnswer();
                    answer.setAnswerId(rs.getInt("answer_id"));
                    answer.setContent(rs.getString("content"));
                    answer.setCreatedAt(rs.getDate("created_at"));
                    answer.setUpdatedAt(rs.getDate("updated_at"));

                    // Gán FaqQuestion tối thiểu
                    FaqQuestion q = new FaqQuestion();
                    q.setQuestionId(rs.getInt("question_id"));
                    q.setTitle(rs.getString("title"));
                    answer.setQuestion(q);
                    System.out.println(answer);
                    list.add(answer);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách câu trả lời: " + e.getMessage());
        }
        return list;
    }

    public void addAnswer(int questionId, String content) {
        String sql = "INSERT INTO faq_answer (question_id, content, created_at) VALUES (?, ?, GETDATE())";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            ps.setString(2, content);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Lỗi thêm câu trả lời: " + e.getMessage());
        }
    }

    public void deleteAnswerById(int answerId) {
        String sql = "DELETE FROM faq_answer WHERE answer_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, answerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public void updateAnswer(int answerId, String content) {
    String sql = "UPDATE faq_answer SET content = ?, updated_at = GETDATE() WHERE answer_id = ?";
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, content);
        ps.setInt(2, answerId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

  public void deleteQuestionById(int questionId) {
    String deleteAnswers = "DELETE FROM faq_answer WHERE question_id = ?";
    String deleteQuestion = "DELETE FROM faq_question WHERE question_id = ?";
    try (Connection conn = getConnection()) {
        try (PreparedStatement ps1 = conn.prepareStatement(deleteAnswers)) {
            ps1.setInt(1, questionId);
            ps1.executeUpdate();
        }
        try (PreparedStatement ps2 = conn.prepareStatement(deleteQuestion)) {
            ps2.setInt(1, questionId);
            ps2.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    public static void main(String[] args) {
        FaqDAO dao = new FaqDAO();
        dao.getAnswersByQuestionId(1);
    }
}
