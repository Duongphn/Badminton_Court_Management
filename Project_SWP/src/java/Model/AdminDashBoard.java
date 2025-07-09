/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class AdminDashBoard {
    private String courtName;
    private String managerName;
    private double revenue;
    private int bookings;
    private int returningUsers;
    private double avgRating;

    public AdminDashBoard() {
    }

    public AdminDashBoard(String courtName, String managerName, double revenue, int bookings, int returningUsers, double avgRating) {
        this.courtName = courtName;
        this.managerName = managerName;
        this.revenue = revenue;
        this.bookings = bookings;
        this.returningUsers = returningUsers;
        this.avgRating = avgRating;
    }

    public String getCourtName() {
        return courtName;
    }

    public void setCourtName(String courtName) {
        this.courtName = courtName;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public int getBookings() {
        return bookings;
    }

    public void setBookings(int bookings) {
        this.bookings = bookings;
    }

    public int getReturningUsers() {
        return returningUsers;
    }

    public void setReturningUsers(int returningUsers) {
        this.returningUsers = returningUsers;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    @Override
    public String toString() {
        return String.format("%-15s | %-12s | %10.0f | %7d | %7d | %5.2f",
                courtName, managerName, revenue, bookings, returningUsers, avgRating);
    }
    
}
