/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author admin
 */
public class ChatMessage {
     private int messageId;
    private Integer userId;
    private String content;
    private Timestamp createdAt;
    private String senderType; 

    public ChatMessage() {
    }

    public ChatMessage( Integer userId, String content, String senderType) {
       
        this.userId = userId;
        this.content = content;
        
        this.senderType = senderType;
    }

    public ChatMessage(int messageId, Integer userId, String content, Timestamp createdAt, String senderType) {
        this.messageId = messageId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        this.senderType = senderType;
    }

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    @Override
    public String toString() {
        return "ChatMessage{" + "messageId=" + messageId + ", userId=" + userId + ", content=" + content + ", createdAt=" + createdAt + ", senderType=" + senderType + '}';
    }

    
    
}
