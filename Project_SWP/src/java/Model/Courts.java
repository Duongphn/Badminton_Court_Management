/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Courts {
    private int court_id;
    private int court_number;
    private String status;
    private int area_id;

    public Courts() {
    }

    public Courts(int court_id, int court_number, String status, int area_id) {
        this.court_id = court_id;
        this.court_number = court_number;
        this.status = status;
        this.area_id = area_id;
    }

    public int getCourt_id() {
        return court_id;
    }

    public void setCourt_id(int court_id) {
        this.court_id = court_id;
    }

    public int getCourt_number() {
        return court_number;
    }

    public void setCourt_number(int court_number) {
        this.court_number = court_number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }

   
}
