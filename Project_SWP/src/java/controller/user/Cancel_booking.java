/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import DAO.BookingDAO;
import Model.Bookings;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 *
 * @author admin
 */
@WebServlet(name="Cancel_booking", urlPatterns={"/cancel_booking"})
public class Cancel_booking extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet Cancel_booking</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Cancel_booking at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        BookingDAO bookingDAO = new BookingDAO();
        Bookings booking = bookingDAO.getBookingById(bookingId);

        if (booking == null || booking.getUser_id() != user.getUser_Id()) {
            response.sendRedirect("booking-list?error=unauthorized");
            return;
        }

        
        LocalDate date = booking.getDate();
        LocalTime time = booking.getStart_time().toLocalTime();
        LocalDateTime startDateTime = LocalDateTime.of(date, time);
        LocalDateTime now = LocalDateTime.now();

       Duration duration = Duration.between(now, startDateTime);
if (duration.isNegative() || duration.isZero()) {
    session.setAttribute("cancelMessage", "Đặt sân đã quá hạn, không thể hủy.");
    response.sendRedirect("booking-list?error=expired-cancel");
    return;
} else if (duration.toHours() < 4) {
    session.setAttribute("cancelMessage", "Không thể hủy đặt sân vì còn dưới 4 tiếng trước giờ chơi.");
    response.sendRedirect("booking-list?error=late-cancel");
    return;
}

        // Cập nhật trạng thái
        boolean success = bookingDAO.cancelBookingById(bookingId);
        session.setAttribute("cancelMessage", "Bạn đã huỷ đặt sân thành công! ");
        response.sendRedirect("booking-list?cancel=" + (success ? "success" : "failed"));
    }
   

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}