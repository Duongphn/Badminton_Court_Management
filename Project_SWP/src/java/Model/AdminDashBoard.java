package Model;

/**
 * Model cho báo cáo quản lý sân trên dashboard Admin
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
}
