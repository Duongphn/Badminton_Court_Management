/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class Promotion {
     private int promotionId;

    private String title;
    private String description;
    private double discountPercent;
    private double discountAmount;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
     private LocalDateTime createdAt;
    private List<String> areaNames;

    public List<String> getAreaNames() {
        return areaNames;
    }

    public void setAreaNames(List<String> areaNames) {
        this.areaNames = areaNames;
    }

    public Promotion(int promotionId, String title, String description, double discountPercent, double discountAmount, LocalDate startDate, LocalDate endDate, String status, LocalDateTime createdAt, List<String> areaNames, LocalDateTime updatedAt) {
        this.promotionId = promotionId;
        this.title = title;
        this.description = description;
        this.discountPercent = discountPercent;
        this.discountAmount = discountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.createdAt = createdAt;
        this.areaNames = areaNames;
        this.updatedAt = updatedAt;
    }
    
    private LocalDateTime updatedAt;

    public Promotion() {
    }

    public Promotion(int promotionId, String title, String description, double discountPercent, double discountAmount, LocalDate startDate, LocalDate endDate, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.promotionId = promotionId;
        this.title = title;
        this.description = description;
        this.discountPercent = discountPercent;
        this.discountAmount = discountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
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

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
  
    

}
