/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class SlotTime {
    
    public static List<Slot> generateSlots(Shift shift, List<Bookings> bookings, int slotMinutes) {
        List<Slot> result = new ArrayList<>();

        LocalTime current = shift.getStartTime().toLocalTime();
        LocalTime end = shift.getEndTime().toLocalTime();

        while (current.plusMinutes(slotMinutes).compareTo(end) <= 0) {
            LocalTime slotStart = current;
            LocalTime slotEnd = current.plusMinutes(slotMinutes);
            current = slotEnd;

            boolean isBooked = false;

            for (Bookings b : bookings) {
                // Chuyển đổi Time → LocalTime
                LocalTime bookedStart = b.getStart_time().toLocalTime();
                LocalTime bookedEnd = b.getEnd_time().toLocalTime();

                // Bỏ qua booking đã huỷ
                String status = b.getStatus().toLowerCase();
                if (!status.equals("cancelled") && !status.equals("rejected")) {
                    boolean overlap = !(slotEnd.compareTo(bookedStart) <= 0 || slotStart.compareTo(bookedEnd) >= 0);
                    if (overlap) {
                        isBooked = true;
                        break;
                    }
                }
            }

            result.add(new Slot(slotStart, slotEnd, !isBooked));
        }

        return result;
    }
}
