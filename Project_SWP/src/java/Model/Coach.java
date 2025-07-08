/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author sang
 */
public class Coach {
    private int coachId;
    private int areaId;
    private String fullname;
    private String email;
    private String phone;
    private String specialty;
    private String description;
    private String imageUrl;
    private String status;

    public Coach() {
    }

    public Coach(int coachId, int areaId, String fullname, String email, String phone, String specialty, String description, String imageUrl, String status) {
        this.coachId = coachId;
        this.areaId = areaId;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.specialty = specialty;
        this.description = description;
        this.imageUrl = imageUrl;
        this.status = status;
    }

    public int getCoachId() {
        return coachId;
    }

    public void setCoachId(int coachId) {
        this.coachId = coachId;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Coach{" + "coachId=" + coachId + ", areaId=" + areaId + ", fullname=" + fullname + ", email=" + email + ", phone=" + phone + ", specialty=" + specialty + ", description=" + description + ", imageUrl=" + imageUrl + ", status=" + status + '}';
    }
    
}
