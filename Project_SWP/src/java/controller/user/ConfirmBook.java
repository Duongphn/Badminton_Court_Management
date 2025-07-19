/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import DAO.CourtDAO;
import DAO.PromotionDAO;
import DAO.Service_BranchDAO;
import Model.Branch_Service;
import Model.Courts;
import Model.Promotion;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Time;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "ConfirmBook", urlPatterns = {"/confirm-booking"})
public class ConfirmBook extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConfirmBook</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmBook at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    try {
        int userId = user.getUser_Id();
        int courtId = Integer.parseInt(request.getParameter("courtId"));
        String dateStr = request.getParameter("date");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        LocalDate date = LocalDate.parse(dateStr);
        Time startTime = Time.valueOf(startTimeStr);
        Time endTime = Time.valueOf(endTimeStr);

        // LẤY totalPrice từ request (giá thuê sân đã tính, đã KM, chưa dịch vụ)
        String totalPriceStr = request.getParameter("totalPrice");
        BigDecimal totalPrice = new BigDecimal(totalPriceStr);

        // CỘNG GIÁ DỊCH VỤ (nếu có)
        BigDecimal extraServicePrice = BigDecimal.ZERO;
        String[] selectedServices = request.getParameterValues("selectedServices");
        if (selectedServices != null) {
            Service_BranchDAO serviceDAO = new Service_BranchDAO();
            for (String serviceIdStr : selectedServices) {
                int serviceId = Integer.parseInt(serviceIdStr);
                BigDecimal servicePrice = serviceDAO.getServicePriceById(serviceId);
                if (servicePrice != null) {
                    extraServicePrice = extraServicePrice.add(servicePrice);
                }
            }
        }

        // Tổng cuối cùng
        totalPrice = totalPrice.add(extraServicePrice);

        // Đảm bảo không âm và làm tròn (nếu muốn)
        if (totalPrice.compareTo(BigDecimal.ZERO) < 0) {
            totalPrice = BigDecimal.ZERO;
        }
        totalPrice = totalPrice.setScale(0, BigDecimal.ROUND_HALF_UP);

        // Tiếp tục lưu booking, lưu dịch vụ...
        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.insertBooking1(userId, courtId, date, startTime, endTime, "pending", totalPrice);

        if (selectedServices != null && bookingId != -1) {
            BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
            for (String serviceIdStr : selectedServices) {
                int serviceId = Integer.parseInt(serviceIdStr);
                bookingServiceDAO.addServiceToBooking(bookingId, serviceId);
            }
        }

        response.sendRedirect("booking-list");

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Có lỗi xảy ra khi xử lý đặt sân.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}





    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}