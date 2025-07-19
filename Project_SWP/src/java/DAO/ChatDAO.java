/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.ChatMessage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ChatDAO  extends DBContext{
    Connection conn;

    public ChatDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }
    public void saveMessage(ChatMessage msg) {
        String sql = "INSERT INTO ChatbotMessages (user_id, message_content, sender_type) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            if (msg.getUserId() != null){
                ps.setInt(1, msg.getUserId());
            }
            else
                ps.setNull(1, Types.INTEGER);

            ps.setString(2, msg.getContent());
            ps.setString(3, msg.getSenderType());
            ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }
    public List<ChatMessage> getMessagesByUser(int userId) {
    List<ChatMessage> messages = new ArrayList<>();
    String sql = "SELECT message_id, user_id, message_content, created_at, sender_type "
               + "FROM ChatbotMessages WHERE user_id = ? ORDER BY created_at ASC";
    try (
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            messages.add(new ChatMessage(
    rs.getInt("message_id"),
    rs.getInt("user_id"),
    rs.getString("message_content"),
    rs.getTimestamp("created_at"),
    rs.getString("sender_type")
));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return messages;
}
    public static void main(String[] args) {
        ChatDAO dao = new ChatDAO();
        List<ChatMessage> list = dao.getMessagesByUser(1);
        for(ChatMessage l : list){
            System.out.println(l);
        }
    }

}
