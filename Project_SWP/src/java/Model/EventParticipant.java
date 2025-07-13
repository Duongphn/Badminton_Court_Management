package Model;

import java.sql.Timestamp;

public class EventParticipant {
    private int id;
    private int eventId;
    private int userId;
    private Timestamp registeredAt;
    private User user; // To hold user details

    // Constructors
    public EventParticipant() {
    }

    public EventParticipant(int id, int eventId, int userId, Timestamp registeredAt) {
        this.id = id;
        this.eventId = eventId;
        this.userId = userId;
        this.registeredAt = registeredAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getRegisteredAt() {
        return registeredAt;
    }

    public void setRegisteredAt(Timestamp registeredAt) {
        this.registeredAt = registeredAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
