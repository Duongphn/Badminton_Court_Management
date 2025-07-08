/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Dal.DBContext;
import Model.ChatMessage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

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
}
