/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Court_pricing {
    private String pricing_id;
    private String area_id;
    private String start_time;
    private String end_time;
    private String price;

    public Court_pricing() {
    }

    public Court_pricing(String pricing_id, String area_id, String start_time, String end_time, String price) {
        this.pricing_id = pricing_id;
        this.area_id = area_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.price = price;
    }

    public String getPricing_id() {
        return pricing_id;
    }

    public void setPricing_id(String pricing_id) {
        this.pricing_id = pricing_id;
    }

    public String getArea_id() {
        return area_id;
    }

    public void setArea_id(String area_id) {
        this.area_id = area_id;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    
}
