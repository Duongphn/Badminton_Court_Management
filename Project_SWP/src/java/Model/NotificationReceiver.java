/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;

public class NotificationReceiver {

    private int id;
    private Notification notificationId;
    private User userId;
    private boolean isRead;
    private LocalDateTime readAt;
    private LocalDateTime openedAt;

    public NotificationReceiver() {
    }

    public NotificationReceiver(int id, Notification notificationId, User userId, boolean isRead, LocalDateTime readAt, LocalDateTime openedAt) {
        this.id = id;
        this.notificationId = notificationId;
        this.userId = userId;
        this.isRead = isRead;
        this.readAt = readAt;
        this.openedAt = openedAt;
    }

  

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Notification getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(Notification notificationId) {
        this.notificationId = notificationId;
    }

   
    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public LocalDateTime getReadAt() {
        return readAt;
    }

    public void setReadAt(LocalDateTime readAt) {
        this.readAt = readAt;
    }

    public LocalDateTime getOpenedAt() {
        return openedAt;
    }

    public void setOpenedAt(LocalDateTime openedAt) {
        this.openedAt = openedAt;
    }

    @Override
    public String toString() {
        return "NotificationReceiver{" + "id=" + id + ", notificationId=" + notificationId + ", userId=" + userId + ", isRead=" + isRead + ", readAt=" + readAt + ", openedAt=" + openedAt + '}';
    }

}
