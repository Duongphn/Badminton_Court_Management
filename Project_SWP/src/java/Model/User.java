/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Hoang Tan Bao
 */
public class User {

    private int user_Id;
    private String username;
    private String password;
    private String email;
    private String phone_number;
    private String role;
    private LocalDateTime createdAt = LocalDateTime.now();
    private String status;
    private String note;
    private String gender;
    private String firstname;
    private String lastname;
    private String fullname;
    private Date dateOfBirth;
    private String fullName = firstname + lastname;
    private boolean sendMail;

    public User() {
    }

    public User(int user_Id, String username, String password, String email, String phone_number, String role, String status) {
        this.user_Id = user_Id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone_number = phone_number;
        this.role = role;
        this.status = status;
    }

    public User(int user_Id, String username, String password, String email, String phone_number, String role) {
        this.user_Id = user_Id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone_number = phone_number;
        this.role = role;
    }

    public User(int user_Id, String username, String password, String email, String phone_number, String role, String status, String note) {
        this.user_Id = user_Id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone_number = phone_number;
        this.role = role;
        this.status = status;
        this.note = note;
    }

    public User(int user_Id, String username, String password, String email, String phone_number, String role, String status, String note, String gender, String firstname, String lastname, String fullname, Date dateOfBirth) {
        this.user_Id = user_Id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone_number = phone_number;
        this.role = role;
        this.status = status;
        this.note = note;
        this.gender = gender;
        this.firstname = firstname;
        this.lastname = lastname;
        this.fullname = fullname;
        this.dateOfBirth = dateOfBirth;
    }

    public User(int user_Id, String username, String password, String email, String phone_number, String role, String status, String note, String gender, String firstname, String lastname, String fullname, Date dateOfBirth, boolean sendMail) {
        this.user_Id = user_Id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone_number = phone_number;
        this.role = role;
        this.status = status;
        this.note = note;
        this.gender = gender;
        this.firstname = firstname;
        this.lastname = lastname;
        this.fullname = fullname;
        this.dateOfBirth = dateOfBirth;
        this.sendMail = sendMail;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public boolean isSendMail() {
        return sendMail;
    }

    public void setSendMail(boolean sendMail) {
        this.sendMail = sendMail;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getUser_Id() {
        return user_Id;
    }

    public void setUser_Id(int user_Id) {
        this.user_Id = user_Id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

public String getCreatedAtDateOnly() {
    if (createdAt == null) return "";
    java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
    return createdAt.format(formatter);
}

    @Override
    public String toString() {
        return "User{" + "user_Id=" + user_Id + ", username=" + username + ", password=" + password + ", email=" + email + ", phone_number=" + phone_number + ", role=" + role + ", createdAt=" + createdAt + ", status=" + status + ", note=" + note + ", gender=" + gender + ", firstname=" + firstname + ", lastname=" + lastname + ", fullname=" + fullname + ", dateOfBirth=" + dateOfBirth + '}';
    }

}
