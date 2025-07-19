/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class CommentReport {

    private int reportId;
    private int commentId;
    private String commentContent;
    private int postId;
    private String commentedUsername;
    private String reporterUsername;
    private String reason;
    private String createdAt;

    public CommentReport() {

    }

    public CommentReport(int reportId, int commentId, String commentContent, int postId, String commentedUsername, String reporterUsername, String reason, String createdAt) {
        this.reportId = reportId;
        this.commentId = commentId;
        this.commentContent = commentContent;
        this.postId = postId;
        this.commentedUsername = commentedUsername;
        this.reporterUsername = reporterUsername;
        this.reason = reason;
        this.createdAt = createdAt;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getCommentedUsername() {
        return commentedUsername;
    }

    public void setCommentedUsername(String commentedUsername) {
        this.commentedUsername = commentedUsername;
    }

    public String getReporterUsername() {
        return reporterUsername;
    }

    public void setReporterUsername(String reporterUsername) {
        this.reporterUsername = reporterUsername;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

}
