/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import Dal.DBContext;
import Model.BookingScheduleDTO;
import Model.Bookings;
import Model.Courts;
import Model.Promotion;
import Model.Service;
import Model.Shift;
import Model.Slot;
import Model.SlotTime;

/**
 *
 * @author admin
 */
public class BookingDAO extends DBContext {

    Connection conn;

    public BookingDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public void autoCancelExpiredPendingBookings() {
        String sql = "UPDATE Bookings SET status = 'cancelled' "
                + "WHERE status = 'pending' "
                + "AND DATEADD(MILLISECOND, DATEDIFF(MILLISECOND,0,start_time), CAST(date AS DATETIME)) <= GETDATE()";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countBookingsByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ?";

        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public int countBookingsByArea(int areaId) {
        String sql = "SELECT COUNT(*) "
                + "FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "WHERE c.area_id = ?";

        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, areaId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1); // return the count
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return 0;
    }

    // Count number of bookings for current date of manager
    public int countBookingsTodayByManager(int managerId) {
        String sql = "SELECT COUNT(*) FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ? AND b.date = CAST(GETDATE() AS DATE)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    // Sum of revenue in last 7 days for manager
    public BigDecimal getRevenueLast7DaysByManager(int managerId) {
        String sql = "SELECT SUM(total_price) FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ? AND b.status = 'completed' "
                + "AND b.date >= DATEADD(day,-6, CAST(GETDATE() AS DATE)) "
                + "AND b.date <= CAST(GETDATE() AS DATE)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                BigDecimal sum = rs.getBigDecimal(1);
                return sum != null ? sum : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    // Booking count per start hour in last 7 days for manager
    public Map<Integer, Integer> getHourlyBookingDistribution(int managerId) {
        Map<Integer, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT DATEPART(HOUR, b.start_time) AS h, COUNT(*) AS c FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ? AND b.status != 'cancelled' "
                + "AND b.date >= DATEADD(day,-6, CAST(GETDATE() AS DATE)) "
                + "AND b.date <= CAST(GETDATE() AS DATE) "
                + "GROUP BY DATEPART(HOUR, b.start_time) ORDER BY h";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getInt("h"), rs.getInt("c"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    // Top booked courts of manager
    public Map<String, Integer> getTopBookedCourts(int managerId, int limit) {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT TOP " + limit + " c.court_number AS name, COUNT(*) AS c FROM Bookings b "
                + "JOIN Courts c ON b.court_id = c.court_id "
                + "JOIN Areas a ON c.area_id = a.area_id "
                + "WHERE a.manager_id = ? GROUP BY c.court_number ORDER BY c DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getString("name"), rs.getInt("c"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public List<Bookings> getBookingsByCourtAndDate(int courtId, LocalDate date) {
        List<Bookings> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE court_id = ? AND date = ? AND status NOT IN ('cancelled', 'rejected')";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ps.setDate(2, java.sql.Date.valueOf(date));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setUser_id(rs.getInt("user_id"));
                booking.setCourt_id(rs.getInt("court_id"));
                booking.setDate(rs.getDate("date").toLocalDate());
                booking.setStart_time(rs.getTime("start_time"));
                booking.setEnd_time(rs.getTime("end_time"));
                booking.setStatus(rs.getString("status"));
                booking.setRating(rs.getInt("rating"));
                booking.setTotal_price(rs.getDouble("total_price"));
                booking.setReviewComment(rs.getString("review_comment"));

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public List<Slot> getAvailableSlots(int courtId, LocalDate date) {
        List<Slot> availableSlots = new ArrayList<>();
        try {
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);
            ShiftDAO shiftDAO = new ShiftDAO();
            List<Shift> shifts = shiftDAO.getShiftsByCourt(courtId);

            if (shifts.isEmpty()) {
                return availableSlots;
            }

            // Lấy toàn bộ booking đã có trong ngày
            List<Bookings> bookings = getBookingsByCourtAndDate(courtId, date);

            // Duyệt từng ca hoạt động để lấy slot trống
            for (Shift shift : shifts) {
                List<Slot> slots = SlotTime.generateSlots(shift, bookings, 60);
                for (Slot slot : slots) {
                    if (slot.isAvailable()) {
                        availableSlots.add(slot);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableSlots;
    }

    public boolean checkSlotAvailable(int courtId, LocalDate date, Time startTime, Time endTime) {
        String sql = "SELECT * FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND status != 'cancelled' "
                + "AND NOT (end_time <= CAST(? AS TIME) OR start_time >= CAST(? AS TIME))";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ps.setDate(2, java.sql.Date.valueOf(date));
            // Check overlap using new booking's startTime and endTime
            ps.setObject(3, startTime, java.sql.Types.TIME);
            ps.setObject(4, endTime, java.sql.Types.TIME);

            ResultSet rs = ps.executeQuery();
            boolean hasConflict = rs.next();

            // 🪵 Log ra kết quả kiểm tra
            System.out.println("⚠️ Đặt sân kiểm tra: courtId=" + courtId + ", date=" + date);
            System.out.println("Giờ bắt đầu: " + startTime + ", kết thúc: " + endTime);
            if (hasConflict) {
                System.out.println("❌ Đã trùng với lịch trước đó:");
                do {
                    System.out.println(" -> bookingId=" + rs.getInt("booking_id")
                            + " [" + rs.getTime("start_time") + " - " + rs.getTime("end_time") + "]");
                } while (rs.next());
            } else {
                System.out.println("✅ Không trùng, được phép đặt.");
            }

            return !hasConflict;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check all 60-minute slots between startTime and endTime are available
    public boolean checkContinuousSlotsAvailable(int courtId, LocalDate date, Time startTime, Time endTime) {
        List<Slot> slots = getAvailableSlots(courtId, date);
        java.time.LocalTime current = startTime.toLocalTime();
        java.time.LocalTime end = endTime.toLocalTime();
        while (current.isBefore(end)) {
            java.time.LocalTime next = current.plusMinutes(60);
            boolean found = false;
            for (Slot s : slots) {
                if (s.getStart().equals(current) && s.getEnd().equals(next) && s.isAvailable()) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                return false;
            }
            current = next;
        }
        return true;
    }

    public boolean checkSlotAvailableAdmin(int courtId, LocalDate date, Time startTime, Time endTime) {
        String sql = "SELECT COUNT(*) FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND status NOT IN ('cancelled', 'rejected') "
                + "AND (start_time < ? AND end_time > ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courtId);
            ps.setDate(2, Date.valueOf(date));
            ps.setTime(3, endTime); // start_time < endTime mới
            ps.setTime(4, startTime); // end_time > startTime mới
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Trả về true nếu không có bản ghi giao nhau
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Insert a booking and specify the total price for the reservation.
     *
     * @param userId     id of the user making the booking
     * @param courtId    id of the court
     * @param date       booking date
     * @param startTime  shift start time
     * @param endTime    shift end time
     * @param status     booking status
     * @param totalPrice total price to persist
     * @return generated booking id or -1 on failure
     */
    public int insertBookingWithTotalPrice(int userId, int courtId, LocalDate date,
            Time startTime, Time endTime, String status,
            BigDecimal totalPrice) {
        String sql = "INSERT INTO Bookings (user_id, court_id, date, start_time, end_time, status, total_price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        int bookingId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, courtId);
            ps.setDate(3, java.sql.Date.valueOf(date));
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setString(6, status);
            ps.setBigDecimal(7, totalPrice);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bookingId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookingId;
    }

    public boolean createBooking(Bookings booking) {
        String sql = "INSERT INTO Bookings(user_id, court_id, date, start_time, end_time, status, total_price) VALUES (?, ?, ?, ?, ?, 'pending', ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getUser_id());
            ps.setInt(2, booking.getCourt_id());
            ps.setDate(3, java.sql.Date.valueOf(booking.getDate()));
            ps.setTime(4, booking.getStart_time());
            ps.setTime(5, booking.getEnd_time());
            ps.setDouble(6, booking.getTotal_price());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int insertBooking(int userId, int courtId, LocalDate date, Time startTime, Time endTime, String status) {
        String sql = "INSERT INTO Bookings (user_id, court_id, date, start_time, end_time, status, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int bookingId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, courtId);
            ps.setDate(3, java.sql.Date.valueOf(date));
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setString(6, status);

            double totalPrice = 0;
            Courts c = new CourtDAO().getCourtById(courtId);
            if (c != null) {
                totalPrice = c.getPrice();
            }
            ps.setDouble(7, totalPrice);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bookingId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookingId;
    }

    public int insertBooking1(int userId, int courtId, LocalDate date, Time startTime, Time endTime, String status,
            BigDecimal totalPrice) {
        String sql = "INSERT INTO Bookings (user_id, court_id, date, start_time, end_time, status, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int bookingId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, courtId);
            ps.setDate(3, java.sql.Date.valueOf(date));
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setString(6, status); // e.g., "pending"
            ps.setBigDecimal(7, totalPrice); // truyền giá đã tính toán

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bookingId = rs.getInt(1); // lấy booking_id vừa tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookingId;
    }

    public Bookings getBookingById1(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                return b;
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return null;
    }

    public Bookings getBookingById(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                b.setRating(rs.getInt("rating"));
                b.setTotal_price(rs.getDouble("total_price"));
                return b;

            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Bookings> getBookingsByUserId(int userId) {
        autoCancelExpiredPendingBookings();
        List<Bookings> bookings = new ArrayList<>();

        String sql = "SELECT b.*, c.court_number, c.area_id, " +
                "       s.name AS service_name, " +
                "       (SELECT TOP 1 comment FROM Reviews r " +
                "        WHERE r.user_id = b.user_id AND r.area_id = c.area_id " +
                "          AND r.rating = b.rating ORDER BY r.created_at DESC) AS review_comment " +
                "FROM Bookings b " +
                "JOIN Courts c ON b.court_id = c.court_id " +
                "LEFT JOIN Booking_Services bs ON b.booking_id = bs.booking_id " +
                "LEFT JOIN BadmintonService s ON bs.service_id = s.service_id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Bookings> bookingMap = new LinkedHashMap<>();

            while (rs.next()) {
                int bookingId = rs.getInt("booking_id");
                Bookings booking = bookingMap.get(bookingId);

                if (booking == null) {
                    booking = new Bookings();
                    booking.setBooking_id(bookingId);
                    booking.setCourt_id(rs.getInt("court_id"));

                    booking.setDate(rs.getDate("date").toLocalDate());
                    booking.setStart_time(rs.getTime("start_time"));
                    booking.setEnd_time(rs.getTime("end_time"));
                    booking.setStatus(rs.getString("status"));
                    booking.setRating(rs.getInt("rating"));
                    booking.setTotal_price(rs.getDouble("total_price"));
                    booking.setReviewComment(rs.getString("review_comment"));

                    booking.setServices(new ArrayList<>());
                    bookingMap.put(bookingId, booking);
                }

                String serviceName = rs.getString("service_name");
                if (serviceName != null && !booking.getServices().contains(serviceName)) {
                    booking.getServices().add(serviceName);
                }
            }

            bookings.addAll(bookingMap.values());

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return bookings;
    }
    
    public List<Bookings> getBookingsForUser(int userId, LocalDate from, LocalDate to, String status) {
        autoCancelExpiredPendingBookings();
        List<Bookings> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Bookings WHERE user_id = ?");
        if (from != null) {
            sql.append(" AND date >= ?");
        }
        if (to != null) {
            sql.append(" AND date <= ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY date, start_time");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setInt(idx++, userId);
            if (from != null) {
                ps.setDate(idx++, Date.valueOf(from));
            }
            if (to != null) {
                ps.setDate(idx++, Date.valueOf(to));
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(idx++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                b.setRating(rs.getInt("rating"));
                b.setTotal_price(rs.getDouble("total_price"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public boolean cancelBookingById(int bookingId) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "cancelled");
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<BookingScheduleDTO> getManagerBookings(int managerId, Integer areaId,
            LocalDate start, LocalDate end, String status) {
        autoCancelExpiredPendingBookings();
        List<BookingScheduleDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.booking_id, b.user_id, b.court_id, b.date, b.start_time, ")
                .append("b.end_time, b.status, b.total_price, u.username, c.court_number, c.area_id, a.name AS area_name ")
                .append("FROM Bookings b ")
                .append("JOIN Courts c ON b.court_id = c.court_id ")
                .append("JOIN Areas a ON c.area_id = a.area_id ")
                .append("JOIN Users u ON b.user_id = u.user_id ")
                .append("WHERE a.manager_id = ?");
        if (areaId != null) {
            sql.append(" AND a.area_id = ?");
        }
        if (start != null) {
            sql.append(" AND b.date >= ?");
        }
        if (end != null) {
            sql.append(" AND b.date <= ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND b.status = ?");
        }

        sql.append(" ORDER BY b.booking_id DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, managerId);

            if (areaId != null) {
                ps.setInt(paramIndex++, areaId);
            }
            if (start != null) {
                ps.setDate(paramIndex++, Date.valueOf(start));
            }
            if (end != null) {
                ps.setDate(paramIndex++, Date.valueOf(end));
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingScheduleDTO dto = new BookingScheduleDTO();
                dto.setBooking_id(rs.getInt("booking_id"));
                dto.setUser_id(rs.getInt("user_id"));
                dto.setCourt_id(rs.getInt("court_id"));
                dto.setDate(rs.getDate("date").toLocalDate());
                dto.setStart_time(rs.getTime("start_time"));
                dto.setEnd_time(rs.getTime("end_time"));
                dto.setStatus(rs.getString("status"));
                dto.setTotalPrice(rs.getDouble("total_price"));
                dto.setCustomerName(rs.getString("username"));
                dto.setCourtNumber(rs.getString("court_number"));
                dto.setArea_id(rs.getInt("area_id"));
                dto.setAreaName(rs.getString("area_name"));

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieve bookings across all areas. This is used by admin accounts to
     * view every booking in the system without filtering by manager.
     */
    public List<BookingScheduleDTO> getAllBookings(Integer areaId, LocalDate start, LocalDate end, String status) {
        autoCancelExpiredPendingBookings();
        List<BookingScheduleDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append(
                "SELECT b.booking_id, b.user_id, b.court_id, b.date, b.start_time, b.end_time, b.status, b.total_price, u.username, c.court_number, c.area_id, a.name AS area_name "
                        + "FROM Bookings b JOIN Courts c ON b.court_id = c.court_id "
                        + "JOIN Areas a ON c.area_id = a.area_id "
                        + "JOIN Users u ON b.user_id = u.user_id WHERE 1=1");
        if (areaId != null) {
            sql.append(" AND a.area_id = ?");
        }
        if (start != null) {
            sql.append(" AND b.date >= ?");
        }
        if (end != null) {
            sql.append(" AND b.date <= ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND b.status = ?");
        }
        sql.append(" ORDER BY b.booking_id DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (areaId != null) {
                ps.setInt(idx++, areaId);
            }
            if (start != null) {
                ps.setDate(idx++, Date.valueOf(start));
            }
            if (end != null) {
                ps.setDate(idx++, Date.valueOf(end));
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(idx++, status);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingScheduleDTO dto = new BookingScheduleDTO();
                dto.setBooking_id(rs.getInt("booking_id"));
                dto.setUser_id(rs.getInt("user_id"));
                dto.setCourt_id(rs.getInt("court_id"));
                dto.setDate(rs.getDate("date").toLocalDate());
                dto.setStart_time(rs.getTime("start_time"));
                dto.setEnd_time(rs.getTime("end_time"));
                dto.setStatus(rs.getString("status"));
                dto.setTotalPrice(rs.getDouble("total_price"));
                dto.setCustomerName(rs.getString("username"));
                dto.setCourtNumber(rs.getString("court_number"));
                dto.setArea_id(rs.getInt("area_id"));
                dto.setAreaName(rs.getString("area_name"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE Bookings SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBooking(int bookingId, LocalDate date, Time startTime, Time endTime,
            String status, List<Integer> serviceIds) {
        String sql = "UPDATE Bookings SET date = ?, start_time = ?, end_time = ?, status = ?, total_price = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(date));
            ps.setTime(2, startTime);
            ps.setTime(3, endTime);
            ps.setString(4, status);

            // Recalculate price based on court and services
            Bookings current = getBookingById(bookingId);
            Courts court = new CourtDAO().getCourtById(current.getCourt_id());
            PromotionDAO proDao = new PromotionDAO();
            Promotion pro = court != null ? proDao.getCurrentPromotionForArea(court.getArea_id(), date) : null;
            BigDecimal total = calculateSlotPriceWithPromotionByShift(current.getCourt_id(), startTime, endTime, pro);
            if (serviceIds != null) {
                for (int sid : serviceIds) {
                    Service s = ServiceDAO.getServiceById(sid);
                    if (s != null) {
                        total = total.add(BigDecimal.valueOf(s.getPrice()));
                    }
                }
            }
            ps.setBigDecimal(5, total);
            ps.setInt(6, bookingId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                BookingServiceDAO bsDao = new BookingServiceDAO();
                bsDao.removeServicesByBookingId(bookingId);
                if (serviceIds != null) {
                    for (int sid : serviceIds) {
                        bsDao.addServiceToBooking(bookingId, sid);
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkSlotAvailableForUpdate(int bookingId, int courtId, LocalDate date,
            Time startTime, Time endTime) {
        // Use the same overlap logic as when creating a new booking and exclude the
        // current booking by its id. Also ignore cancelled or rejected bookings.
        String sql = "SELECT COUNT(*) FROM Bookings "
                + "WHERE court_id = ? AND date = ? AND booking_id <> ? "
                + "AND status NOT IN ('cancelled', 'rejected') "
                + "AND NOT (end_time <= ? OR start_time >= ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courtId);
            ps.setDate(2, Date.valueOf(date));
            ps.setInt(3, bookingId);
            ps.setTime(4, startTime); // compare new slot with existing ones
            ps.setTime(5, endTime);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Slot is available when there is no overlapping booking
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Similar to checkContinuousSlotsAvailable but ignore current booking
    public boolean checkContinuousSlotsAvailableForUpdate(int bookingId, int courtId, LocalDate date,
            Time startTime, Time endTime) {
        List<Slot> slots = new ArrayList<>();
        try {
            ShiftDAO shiftDAO = new ShiftDAO();
            List<Shift> shifts = shiftDAO.getShiftsByCourt(courtId);
            List<Bookings> bookings = getBookingsByCourtAndDate(courtId, date);
            bookings.removeIf(b -> b.getBooking_id() == bookingId);
            for (Shift sh : shifts) {
                List<Slot> sl = SlotTime.generateSlots(sh, bookings, 60);
                for (Slot s : sl) if (s.isAvailable()) slots.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        java.time.LocalTime current = startTime.toLocalTime();
        java.time.LocalTime end = endTime.toLocalTime();
        while (current.isBefore(end)) {
            java.time.LocalTime next = current.plusMinutes(60);
            boolean found = false;
            for (Slot s : slots) {
                if (s.getStart().equals(current) && s.getEnd().equals(next) && s.isAvailable()) {
                    found = true;
                    break;
                }
            }
            if (!found) return false;
            current = next;
        }
        return true;
    }

    public List<Bookings> getBookingsByCourtId(int courtId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE court_id = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courtId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setCourt_id(rs.getInt("court_id"));
                booking.setUser_id(rs.getInt("user_id"));
                booking.setDate(rs.getDate("date").toLocalDate());
                booking.setStart_time(rs.getTime("start_time"));
                booking.setEnd_time(rs.getTime("end_time"));
                booking.setStatus(rs.getString("status"));

                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateRating(int bookingId, int rating) {
        String sql = "UPDATE Bookings SET rating = ? WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, rating);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Bookings> getBookingHistoryByFilter(LocalDate from, LocalDate to, Integer courtId) {
        List<Bookings> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Bookings WHERE status != 'cancelled'");

        // Kiểm tra và thêm điều kiện lọc ngày
        if (from != null) {
            sql.append(" AND date >= ?");
        }
        if (to != null) {
            sql.append(" AND date <= ?");
        }

        // Kiểm tra và thêm điều kiện lọc theo court_id
        if (courtId != null) {
            sql.append(" AND court_id = ?");
        }

        sql.append(" ORDER BY date DESC, start_time");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int parameterIndex = 1;

            // Gán giá trị cho các tham số PreparedStatement
            if (from != null) {
                ps.setDate(parameterIndex++, java.sql.Date.valueOf(from));
            }
            if (to != null) {
                ps.setDate(parameterIndex++, java.sql.Date.valueOf(to));
            }
            if (courtId != null) {
                ps.setInt(parameterIndex++, courtId);
            }

            // Thực thi truy vấn
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCourt_id(rs.getInt("court_id"));
                b.setDate(rs.getDate("date").toLocalDate());
                b.setStart_time(rs.getTime("start_time"));
                b.setEnd_time(rs.getTime("end_time"));
                b.setStatus(rs.getString("status"));
                b.setRating(rs.getInt("rating"));
                b.setTotal_price(rs.getDouble("total_price"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public BigDecimal getTotalRevenue(LocalDate from, LocalDate to, Integer courtId) {
        StringBuilder sql = new StringBuilder(
                "SELECT SUM(total_price) FROM Bookings WHERE date >= ? AND date <= ? AND status != 'cancelled'");
        if (courtId != null) {
            sql.append(" AND court_id = ?");
        }

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));
            if (courtId != null) {
                ps.setInt(3, courtId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                BigDecimal sum = rs.getBigDecimal(1);
                return sum != null ? sum : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

   // Doanh thu từng tháng trong 1 năm
public Map<String, BigDecimal> getRevenueByMonth(int year, Integer courtId) {
    Map<String, BigDecimal> result = new LinkedHashMap<>();
    StringBuilder sql = new StringBuilder("SELECT MONTH([date]) AS month, SUM([total_price]) AS total " +
                 "FROM [Bookings] WHERE YEAR([date]) = ? AND [status] != 'cancelled'");

    if (courtId != null) {
        sql.append(" AND court_id = ?");
    }

    sql.append(" GROUP BY MONTH([date]) ORDER BY month");

    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        ps.setInt(1, year);
        if (courtId != null) {
            ps.setInt(2, courtId);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int month = rs.getInt("month");
            BigDecimal total = rs.getBigDecimal("total");
            result.put(String.format("%02d", month), total != null ? total : BigDecimal.ZERO);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}

// Doanh thu từng tuần (ISO week) trong 1 năm

public Map<String, BigDecimal> getRevenueByWeek(int year, Integer courtId) {
    Map<String, BigDecimal> result = new LinkedHashMap<>();
    StringBuilder sql = new StringBuilder(
        "SELECT DATEPART(iso_week, [date]) AS week, SUM([total_price]) AS total " +
        "FROM [Bookings] WHERE YEAR([date]) = ? AND [status] != 'cancelled'"
    );

    if (courtId != null) {
        sql.append(" AND court_id = ?");
    }

    sql.append(" GROUP BY DATEPART(iso_week, [date]) ORDER BY week");

    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        ps.setInt(1, year);
        if (courtId != null) {
            ps.setInt(2, courtId);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int week = rs.getInt("week");
            BigDecimal total = rs.getBigDecimal("total");
            result.put(String.valueOf(week), total != null ? total : BigDecimal.ZERO);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return result;
}
    public BigDecimal calculateSlotPriceWithPromotionByShift(int courtId,
            Time startTime, Time endTime, Promotion promotion) {
        BigDecimal total = BigDecimal.ZERO;
        try {
            ShiftDAO shiftDAO = new ShiftDAO();
            List<Shift> shifts = shiftDAO.getShiftsByCourt(courtId);
            LocalTime start = startTime.toLocalTime();
            LocalTime end = endTime.toLocalTime();
            for (Shift sh : shifts) {
                LocalTime shStart = sh.getStartTime().toLocalTime();
                LocalTime shEnd = sh.getEndTime().toLocalTime();
                if (end.isAfter(shStart) && start.isBefore(shEnd)) {
                    LocalTime segmentStart = start.isAfter(shStart) ? start : shStart;
                    LocalTime segmentEnd = end.isBefore(shEnd) ? end : shEnd;
                    long minutes = java.time.Duration.between(segmentStart, segmentEnd).toMinutes();
                    long shiftMinutes = java.time.Duration.between(shStart, shEnd).toMinutes();
                    if (minutes > 0 && shiftMinutes > 0) {
                        BigDecimal pricePerMinute = sh.getPrice().divide(BigDecimal.valueOf(shiftMinutes), 4, RoundingMode.HALF_UP);
                        total = total.add(pricePerMinute.multiply(BigDecimal.valueOf(minutes)));
                    }
                }
            }

            if (promotion != null) {
                if (promotion.getDiscountPercent() > 0) {
                    BigDecimal percent = BigDecimal.valueOf(promotion.getDiscountPercent()).divide(BigDecimal.valueOf(100));
                    total = total.subtract(total.multiply(percent));
                }
                if (promotion.getDiscountAmount() > 0) {
                    total = total.subtract(BigDecimal.valueOf(promotion.getDiscountAmount()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (total.compareTo(BigDecimal.ZERO) < 0) total = BigDecimal.ZERO;
        return total.setScale(0, RoundingMode.HALF_UP);
    }


    public BigDecimal calculateSlotPriceWithPromotion(
            Time startTime,
            Time endTime,
            BigDecimal pricePerHour,
            Promotion promotion) {

        long millisStart = startTime.getTime();
        long millisEnd = endTime.getTime();
        long durationMillis = millisEnd - millisStart;
        long minutes = durationMillis / (1000 * 60);
        BigDecimal slotPrice;
        if (minutes == 60) {
            slotPrice = pricePerHour;
        } else {
            BigDecimal hours = new BigDecimal(minutes).divide(new BigDecimal(60), 2, RoundingMode.HALF_UP);
            slotPrice = hours.multiply(pricePerHour);
        }

        if (promotion != null) {

            if (promotion.getDiscountPercent() > 0) {
                BigDecimal percent = BigDecimal.valueOf(promotion.getDiscountPercent()).divide(BigDecimal.valueOf(100));
                BigDecimal discount = slotPrice.multiply(percent);
                slotPrice = slotPrice.subtract(discount);
            }

            if (promotion.getDiscountAmount() > 0) {
                slotPrice = slotPrice.subtract(BigDecimal.valueOf(promotion.getDiscountAmount()));
            }
        }

        if (slotPrice.compareTo(BigDecimal.ZERO) < 0) {
            slotPrice = BigDecimal.ZERO;
        }
        return slotPrice.setScale(0, RoundingMode.HALF_UP);
    }

    // Lấy tổng số lượt đặt sân
    public int getTotalBookings(String filter) {
        String sql = "SELECT COUNT(*) FROM Bookings " + getDateCondition(filter);
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy tổng doanh thu
    public double getTotalRevenue(String filter) {
        String sql = "SELECT SUM(total_price) FROM Bookings " + getDateCondition(filter);
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy đánh giá trung bình
    public double getAvgRating(String filter) {
        String sql = "SELECT AVG(CAST(rating AS float)) FROM Bookings WHERE rating IS NOT NULL " + getExtraDateCondition(filter);
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Điều kiện lọc ngày
    private String getDateCondition(String filter) {
        switch (filter) {
            case "today":
                return "WHERE CAST(date AS DATE) = CAST(GETDATE() AS DATE)";
            case "week":
                return "WHERE DATEPART(week, date) = DATEPART(week, GETDATE()) AND YEAR(date) = YEAR(GETDATE())";
            case "month":
                return "WHERE MONTH(date) = MONTH(GETDATE()) AND YEAR(date) = YEAR(GETDATE())";
            default:
                return "";
        }
    }

    // Cho AVG (phía sau WHERE rating IS NOT NULL)
    private String getExtraDateCondition(String filter) {
        switch (filter) {
            case "today":
                return " AND CAST(date AS DATE) = CAST(GETDATE() AS DATE)";
            case "week":
                return " AND DATEPART(week, date) = DATEPART(week, GETDATE()) AND YEAR(date) = YEAR(GETDATE())";
            case "month":
                return " AND MONTH(date) = MONTH(GETDATE()) AND YEAR(date) = YEAR(GETDATE())";
            default:
                return "";
        }
    }

}