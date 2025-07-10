/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author sang
 */
public class Banner {
    private int id;
    private String imageUrl;
    private String title;
    private String caption;
    private boolean status;

    public Banner() {
    }

    public Banner(int id, String imageUrl, String title, String caption, boolean status) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.title = title;
        this.caption = caption;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Banner{" + "id=" + id + ", imageUrl=" + imageUrl + ", title=" + title + ", caption=" + caption + ", status=" + status + '}';
    }
    
}
