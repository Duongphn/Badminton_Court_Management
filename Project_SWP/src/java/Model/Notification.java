/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;

public class Notification {

    private int notificationId;
    private String title;
    private String content;
    private String imageUrl;
    private User createdBy;
    private LocalDateTime scheduledTime;
    private LocalDateTime sentTime;
    private String status;
    private LocalDateTime createdAt;
    private boolean isEditable;  // Thêm thuộc tính để xác định thông báo có thể sửa không

    public Notification() {
    }

    public Notification(int notificationId, String title, String content, String imageUrl, User createdBy, LocalDateTime scheduledTime, LocalDateTime sentTime, String status, LocalDateTime createdAt) {
        this.notificationId = notificationId;
        this.title = title;
        this.content = content;
        this.imageUrl = imageUrl;
        this.createdBy = createdBy;
        this.scheduledTime = scheduledTime;
        this.sentTime = sentTime;
        this.status = status;
        this.createdAt = createdAt;
        this.isEditable = !"sent".equals(status);  // Nếu trạng thái là "sent", không thể chỉnh sửa
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(LocalDateTime scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public LocalDateTime getSentTime() {
        return sentTime;
    }

    public void setSentTime(LocalDateTime sentTime) {
        this.sentTime = sentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsEditable() {
        return isEditable;
    }

    public void setIsEditable(boolean isEditable) {
        this.isEditable = isEditable;
    }

   

    public boolean isEditable() {
        return isEditable;
    }

    public void setEditable(boolean editable) {
        isEditable = editable;
    }


    @Override
    public String toString() {
        return "Notification{" + "notificationId=" + notificationId + ", title=" + title + ", content=" + content + ", imageUrl=" + imageUrl + ", createdBy=" + createdBy + ", scheduledTime=" + scheduledTime + ", sentTime=" + sentTime + ", status=" + status + ", createdAt=" + createdAt + '}';
    }
}
