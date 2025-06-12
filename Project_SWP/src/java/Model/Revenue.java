/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDate;

/**
 *
 * @author admin
 */
public class Revenue {
    private String revenue_id;
    private String court_id;
    private LocalDate date;
    private String amount;
    private String description;
    private String created_at;

    public Revenue() {
    }

    public Revenue(String revenue_id, String court_id, LocalDate date, String amount, String description, String created_at) {
        this.revenue_id = revenue_id;
        this.court_id = court_id;
        this.date = date;
        this.amount = amount;
        this.description = description;
        this.created_at = created_at;
    }

    public String getRevenue_id() {
        return revenue_id;
    }

    public void setRevenue_id(String revenue_id) {
        this.revenue_id = revenue_id;
    }

    public String getCourt_id() {
        return court_id;
    }

    public void setCourt_id(String court_id) {
        this.court_id = court_id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
    
}
