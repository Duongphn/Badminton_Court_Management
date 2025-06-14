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
    private String court_number;
    private String type;
    private String floor_material;
    private String lighting;
    private String description;
    private String image_url;
    private String status;
    private int area_id;

    public Courts() {
    }

    public Courts(int court_id, String court_number, String type, String floor_material,
                  String lighting, String description, String image_url,
                  String status, int area_id) {
        this.court_id = court_id;
        this.court_number = court_number;
        this.type = type;
        this.floor_material = floor_material;
        this.lighting = lighting;
        this.description = description;
        this.image_url = image_url;
        this.status = status;
        this.area_id = area_id;
    }

    public int getCourt_id() {
        return court_id;
    }

    public void setCourt_id(int court_id) {
        this.court_id = court_id;
    }

    public String getCourt_number() {
        return court_number;
    }

    public void setCourt_number(String court_number) {
        this.court_number = court_number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFloor_material() {
        return floor_material;
    }

    public void setFloor_material(String floor_material) {
        this.floor_material = floor_material;
    }

    public String getLighting() {
        return lighting;
    }

    public void setLighting(String lighting) {
        this.lighting = lighting;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
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
