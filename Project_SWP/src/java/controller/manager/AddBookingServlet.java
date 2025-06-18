package controller.manager;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.UserDAO;
import DAO.AreaDAO;
import DAO.ServiceDAO;
import Model.Branch;
import Model.Courts;
import Model.Service;
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
import java.time.LocalDateTime;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "AddBookingServlet", urlPatterns = {"/add-booking"})
public class AddBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        int managerId = user.getUser_Id();
        CourtDAO courtDAO = new CourtDAO();
        UserDAO userDAO = new UserDAO();
        List<Courts> courts = courtDAO.getCourtsByManager(managerId);
        List<User> customers = userDAO.getUsersByRole("user");
        List<Service> services = ServiceDAO.getAllService();
        request.setAttribute("courts", courts);
        request.setAttribute("customers", customers);
        request.setAttribute("services", services);
        request.getRequestDispatcher("add_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        int managerId = user.getUser_Id();

        // Lấy các tham số từ form
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String courtIdStr = request.getParameter("courtId");
        String userIdStr = request.getParameter("userId"); // nếu có
        String[] selectedServices = request.getParameterValues("selectedServices");

        // 1. Kiểm tra dữ liệu đầu vào
        if (dateStr == null || dateStr.isEmpty()
                || startStr == null || startStr.isEmpty()
                || endStr == null || endStr.isEmpty()
                || courtIdStr == null || courtIdStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin ngày, giờ và sân.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        int courtId, userId = 0;
        LocalDate date;
        Time startTime, endTime;
        try {
            date = LocalDate.parse(dateStr);  // yyyy-MM-dd
            startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr); // HH:mm
            endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);         // HH:mm
            courtId = Integer.parseInt(courtIdStr);
            if (userIdStr != null && !userIdStr.isEmpty()) {
                userId = Integer.parseInt(userIdStr);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Định dạng ngày hoặc giờ không hợp lệ!");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra logic thời gian
        if (!startTime.before(endTime)) {
            request.setAttribute("error", "Giờ bắt đầu phải trước giờ kết thúc.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        CourtDAO courtDAO = new CourtDAO();
        Courts court = courtDAO.getCourtById(courtId);
        AreaDAO areaDAO = new AreaDAO();
        Branch area = areaDAO.getAreaByIdWithManager(court.getArea_id());

        if (area != null) {
            Time open = area.getOpenTime();
            Time close = area.getCloseTime();
            if (startTime.before(open) || endTime.after(close)) {
                request.setAttribute("error", "Thời gian đặt sân phải trong khoảng mở cửa: " + open + " - " + close);
                populateFormData(request, managerId);
                request.getRequestDispatcher("add_booking.jsp").forward(request, response);
                return;
            }
        }

        LocalDateTime startDateTime = LocalDateTime.of(date, startTime.toLocalTime());
        if (startDateTime.isBefore(LocalDateTime.now())) {
            request.setAttribute("error", "Không thể đặt sân trong thời gian đã qua.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra trùng slot booking
        BookingDAO dao = new BookingDAO();
        boolean slotAvailable = dao.checkSlotAvailableAdmin(courtId, date, startTime, endTime);
        if (!slotAvailable) {
            request.setAttribute("error", "Sân này đã được đặt trong thời gian này. Vui lòng chọn thời gian khác.");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
            return;
        }

        // 4. Thêm booking mới (status: pending)
        int bookingId = dao.insertBooking1(userId, courtId, date, startTime, endTime, "pending");
        if (bookingId != -1) {
            if (selectedServices != null) {
                BookingServiceDAO bsDao = new BookingServiceDAO();
                for (String sidStr : selectedServices) {
                    try {
                        int sid = Integer.parseInt(sidStr);
                        bsDao.addServiceToBooking(bookingId, sid);
                    } catch (NumberFormatException ignored) {}
                }
            }
            String msg = URLEncoder.encode("Đặt sân thành công!", StandardCharsets.UTF_8);
            response.sendRedirect("manager-booking-schedule?msg=" + msg);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
            populateFormData(request, managerId);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
        }
    }

    private void populateFormData(HttpServletRequest request, int managerId) {
        CourtDAO courtDAO = new CourtDAO();
        UserDAO userDAO = new UserDAO();
        List<Courts> courts = courtDAO.getCourtsByManager(managerId);
        List<User> customers = userDAO.getUsersByRole("user");
        List<Service> services = ServiceDAO.getAllService();
        request.setAttribute("courts", courts);
        request.setAttribute("customers", customers);
        request.setAttribute("services", services);
    }
}
