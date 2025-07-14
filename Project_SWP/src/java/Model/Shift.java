/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.sql.Time;

/**
 *
 * @author admin
 */
public class Shift {
     private int shiftId;
    private int areaId;
    private String shiftName;
    private Time startTime;
    private Time endTime;
    private BigDecimal price;
   
    public Shift() {}

    public Shift(int areaId, String shiftName, Time startTime, Time endTime) {
        this.areaId = areaId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Shift(int shiftId, int areaId, String shiftName, Time startTime, Time endTime) {
        this.shiftId = shiftId;
        this.areaId = areaId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Shift(int areaId, String shiftName, Time startTime, Time endTime, BigDecimal price) {
        
        this.areaId = areaId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
    }

    public Shift(int shiftId, int areaId, String shiftName, Time startTime, Time endTime, BigDecimal price) {
        this.shiftId = shiftId;
        this.areaId = areaId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
  
    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Shift{" +
                "shiftId=" + shiftId +
                ", areaId=" + areaId +
                ", shiftName='" + shiftName + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}
