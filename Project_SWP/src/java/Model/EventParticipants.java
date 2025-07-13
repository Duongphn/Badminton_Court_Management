package Model;

import java.sql.Timestamp;

public class EventParticipants {
    private int id;
    private int event_id;
    private int user_id;
    private Timestamp registered_at;

    public EventParticipants() {
    }

    public EventParticipants(int id, int event_id, int user_id, Timestamp registered_at) {
        this.id = id;
        this.event_id = event_id;
        this.user_id = user_id;
        this.registered_at = registered_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Timestamp getRegistered_at() {
        return registered_at;
    }

    public void setRegistered_at(Timestamp registered_at) {
        this.registered_at = registered_at;
    }

    @Override
    public String toString() {
        return "EventParticipants{" +
                "id=" + id +
                ", event_id=" + event_id +
                ", user_id=" + user_id +
                ", registered_at=" + registered_at +
                '}';
    }
}
