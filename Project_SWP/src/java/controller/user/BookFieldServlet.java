/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.PromotionDAO;

import DAO.Service_BranchDAO;
import DAO.ShiftDAO;
import Model.Bookings;
import Model.Branch_Service;
import Model.Courts;
import Model.Promotion;
import Model.Shift;
import Model.Slot;
import Model.SlotTime;
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
import java.math.RoundingMode;
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
@WebServlet(name = "BookFieldServlet", urlPatterns = {"/book-field"})
public class BookFieldServlet extends HttpServlet {

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
            out.println("<title>Servlet BookFieldServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookFieldServlet at " + request.getContextPath() + "</h1>");
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
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    try {
        int courtId = Integer.parseInt(request.getParameter("courtId"));
        String dateParam = request.getParameter("date");
        LocalDate date = (dateParam != null && !dateParam.isEmpty()) ? LocalDate.parse(dateParam) : LocalDate.now();

        CourtDAO courtDAO = new CourtDAO();
        Courts court = courtDAO.getCourtById(courtId);

        ShiftDAO shiftDAO = new ShiftDAO();
        List<Shift> shifts = shiftDAO.getShiftsByCourt(courtId);
        if (shifts == null || shifts.isEmpty()) {
            request.setAttribute("message", "Không tìm thấy ca hoạt động cho sân.");
            request.setAttribute("court", court);
            request.setAttribute("selectedDate", date);
            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        List<Bookings> bookings = bookingDAO.getBookingsByCourtAndDate(courtId, date);

       
        Map<Shift, List<Slot>> shiftSlots = new LinkedHashMap<>();
        for (Shift shifted : shifts) {
            List<Slot> slotsForShift = SlotTime.generateSlots(shifted, bookings, 60); 
            shiftSlots.put(shifted, slotsForShift);
        }
        request.setAttribute("court", court);
        request.setAttribute("shiftSlots", shiftSlots);
        request.setAttribute("selectedDate", date);

        request.getRequestDispatcher("book_field.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Đã xảy ra lỗi.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
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
    String shiftIdStr = request.getParameter("shiftId");

    LocalDate date = LocalDate.parse(dateStr);
    if (startTimeStr.length() == 5) { 
        startTimeStr += ":00";
    }
    if (endTimeStr.length() == 5) {
        endTimeStr += ":00";
    }
    Time startTime = Time.valueOf(startTimeStr);
    Time endTime = Time.valueOf(endTimeStr);

    int shiftId = Integer.parseInt(shiftIdStr);
    ShiftDAO shiftDAO = new ShiftDAO();
    Shift shift = shiftDAO.getShiftById(shiftId);

    if (shift == null) {
        request.setAttribute("message", "Không tìm thấy ca đã chọn.");
        request.getRequestDispatcher("book_field.jsp").forward(request, response);
        return;
    }

    
    BookingDAO bookingDAO = new BookingDAO();
    boolean isAvailable = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);
    if (!isAvailable) {
        request.setAttribute("message", "Khoảng thời gian này đã có người đặt.");
        request.getRequestDispatcher("book_field.jsp").forward(request, response);
        return;
    }

    
    BigDecimal totalPrice = shift.getPrice();

  
    PromotionDAO proDAO = new PromotionDAO();
    Courts court = new CourtDAO().getCourtById(courtId); 
    Promotion promotion = proDAO.getCurrentPromotionForArea(
        court.getArea_id(), date
    );
    if (promotion != null) {
        
        if (promotion.getDiscountPercent() > 0) {
            BigDecimal percent = BigDecimal.valueOf(promotion.getDiscountPercent())
                    .divide(BigDecimal.valueOf(100), 4, RoundingMode.HALF_UP);
            totalPrice = totalPrice.subtract(totalPrice.multiply(percent));
        }
        
        if (promotion.getDiscountAmount() > 0) {
            totalPrice = totalPrice.subtract(BigDecimal.valueOf(promotion.getDiscountAmount()));
        }
    }
    if (totalPrice.compareTo(BigDecimal.ZERO) < 0) totalPrice = BigDecimal.ZERO;

    
    Service_BranchDAO sDao = new Service_BranchDAO();
    List<Branch_Service> services = sDao.getAllAreaServices(court.getArea_id());

    
    request.setAttribute("court", court);
    request.setAttribute("availableServices", services);
    request.setAttribute("courtId", courtId);
    request.setAttribute("date", date);
    request.setAttribute("startTime", startTime);
    request.setAttribute("endTime", endTime);
    request.setAttribute("shift", shift);
    request.setAttribute("totalPrice", totalPrice.setScale(0, RoundingMode.HALF_UP));
    request.setAttribute("promotion", promotion);

    request.getRequestDispatcher("confirm_booking.jsp").forward(request, response);

} catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Có lỗi xảy ra khi đặt sân.");
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