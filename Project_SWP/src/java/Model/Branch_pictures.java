/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Branch_pictures {
    private int image_id;
    private int area_id;
    private String imageURL;

    public Branch_pictures() {
    }

    public Branch_pictures(int image_id, int area_id, String imageURL) {
        this.image_id = image_id;
        this.area_id = area_id;
        this.imageURL = imageURL;
    }

    public int getImage_id() {
        return image_id;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    @Override
    public String toString() {
        return "Branch_pictures{" + "image_id=" + image_id + ", area_id=" + area_id + ", imageURL=" + imageURL + '}';
    }
    
}
