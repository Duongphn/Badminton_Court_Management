package controller.manager;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import Model.Bookings;
import Model.Courts;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Time;
import java.time.LocalDate;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/update-booking")
public class UpdateBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        String idRaw = request.getParameter("bookingId");
        if (idRaw == null) {
            response.sendRedirect("manager-booking-schedule");
            return;
        }
        try {
            int bookingId = Integer.parseInt(idRaw);
            BookingDAO dao = new BookingDAO();
            Bookings booking = dao.getBookingById(bookingId);
            if (booking == null) {
                response.sendRedirect("manager-booking-schedule");
                return;
            }
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(booking.getCourt_id());
            UserDAO userDAO = new UserDAO();
            User customer = userDAO.getUserById(booking.getUser_id());
            request.setAttribute("booking", booking);
            request.setAttribute("court", court);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("manager-booking-schedule");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        // 1. Lấy tham số từ form
        String bookingIdStr = request.getParameter("bookingId");
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String status = request.getParameter("status");

        // 2. Kiểm tra null/rỗng
        if (bookingIdStr == null || bookingIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()
                || startStr == null || startStr.isEmpty()
                || endStr == null || endStr.isEmpty()
                || status == null || status.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
            return;
        }

        int bookingId, courtId;
        LocalDate date;
        Time startTime, endTime;
        Bookings currentBooking = null;

        try {
            bookingId = Integer.parseInt(bookingIdStr);
            date = LocalDate.parse(dateStr);
            startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
            endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

            // 3. Lấy booking hiện tại để lấy courtId và hiển thị lại thông tin
            BookingDAO dao = new BookingDAO();
            currentBooking = dao.getBookingById(bookingId);
            if (currentBooking == null) {
                request.setAttribute("error", "Booking không tồn tại!");
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }
            courtId = currentBooking.getCourt_id();

            // 4. Kiểm tra logic thời gian
            if (!startTime.before(endTime)) {
                request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
                // Gửi lại dữ liệu cho form để hiển thị
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }

            // 5. Kiểm tra trùng lịch (loại trừ chính booking này)
            if (!dao.checkSlotAvailableForUpdate(bookingId, courtId, date, startTime, endTime)) {
                request.setAttribute("error", "Khung giờ này đã có người đặt, vui lòng chọn khung giờ khác.");
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
                return;
            }

            // 6. Cập nhật booking
            boolean updateSuccess = dao.updateBooking(bookingId, date, startTime, endTime, status);

            if (updateSuccess) {
                String msg = URLEncoder.encode("Cập nhật thành công!", StandardCharsets.UTF_8);
                response.sendRedirect("manager-booking-schedule?msg=" + msg);
            } else {
                request.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(courtId));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
                request.getRequestDispatcher("update_booking.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc định dạng sai!");
            if (currentBooking != null) {
                request.setAttribute("booking", currentBooking);
                request.setAttribute("court", new CourtDAO().getCourtById(currentBooking.getCourt_id()));
                request.setAttribute("customer", new UserDAO().getUserById(currentBooking.getUser_id()));
            }
            request.getRequestDispatcher("update_booking.jsp").forward(request, response);
        }
    }
}
