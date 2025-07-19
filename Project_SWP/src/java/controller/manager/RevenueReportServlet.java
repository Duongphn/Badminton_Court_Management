/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.BookingDAO;
import Model.Bookings;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/revenue-report")
public class RevenueReportServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        String courtIdStr = request.getParameter("courtId");

        // Kiểm tra và xử lý từ ngày và đến ngày
        LocalDate from = (fromDateStr != null && !fromDateStr.isEmpty()) ? LocalDate.parse(fromDateStr) : null;
        LocalDate to = (toDateStr != null && !toDateStr.isEmpty()) ? LocalDate.parse(toDateStr) : null;

        // Nếu fromDate hoặc toDate là null thì lấy tất cả các ngày
        // Nếu from và to đều là null, thì bỏ điều kiện ngày trong SQL
        if (from == null && to == null) {
            from = LocalDate.MIN;  // Hoặc có thể là một giá trị mặc định để lấy tất cả các ngày
            to = LocalDate.MAX;    // Tương tự, lấy hết các ngày trong tương lai
        } else if (from == null) {
            from = LocalDate.MIN;  // Nếu chỉ có toDate, lấy tất cả các ngày trước ngày toDate
        } else if (to == null) {
            to = LocalDate.MAX;    // Nếu chỉ có fromDate, lấy tất cả các ngày từ ngày fromDate trở đi
        }

        Integer courtId = (courtIdStr != null && !courtIdStr.isEmpty()) ? Integer.parseInt(courtIdStr) : null;

        // Lấy danh sách bookings từ DAO với filter từ, đến và courtId (nếu có)
        List<Bookings> bookings = bookingDAO.getBookingHistoryByFilter(from, to, courtId);

        // Tính tổng doanh thu từ DAO
        BigDecimal totalRevenue = bookingDAO.getTotalRevenue(from, to, courtId);

        // Thống kê doanh thu theo tháng và theo tuần
        Map<String, BigDecimal> revenueByMonth = bookingDAO.getRevenueByMonth(from.getYear(), courtId);
        Map<String, BigDecimal> revenueByWeek = bookingDAO.getRevenueByWeek(from.getYear(), courtId);

        // Convert dữ liệu doanh thu theo tháng và tuần sang JSON để JS vẽ biểu đồ
        Gson gson = new Gson();
        String revenueByMonthJson = gson.toJson(revenueByMonth);
        String revenueByWeekJson = gson.toJson(revenueByWeek);

        // Đặt các thuộc tính vào request để hiển thị trong JSP
        request.setAttribute("bookings", bookings);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("fromDate", from);
        request.setAttribute("toDate", to);
        request.setAttribute("courtId", courtId);
        request.setAttribute("revenueByMonthJson", revenueByMonthJson);
        request.setAttribute("revenueByWeekJson", revenueByWeekJson);

        // Forward tới trang JSP để hiển thị kết quả
        request.getRequestDispatcher("revenueReport.jsp").forward(request, response);
    }
}