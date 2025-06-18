/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.BookingDAO;
import DAO.CourtDAO;

import DAO.Service_BranchDAO;
import DAO.ShiftDAO;
import Model.Bookings;
import Model.Branch_Service;
import Model.Courts;
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
import java.sql.Time;
import java.time.LocalDate;
import java.util.List;
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
        
        // Lấy ngày từ request, mặc định là ngày hiện tại
        String dateParam = request.getParameter("date");
        LocalDate date = (dateParam != null && !dateParam.isEmpty()) 
                            ? LocalDate.parse(dateParam) 
                            : LocalDate.now();

        CourtDAO courtDAO = new CourtDAO();
        Courts court = courtDAO.getCourtById(courtId);
        ShiftDAO shiftDAO = new ShiftDAO();
        Shift shift = shiftDAO.getShiftByCourt(courtId);
        if (shift == null) {
            request.setAttribute("message", "Không tìm thấy ca hoạt động cho sân.");
            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        List<Bookings> bookings = bookingDAO.getBookingsByCourtAndDate(courtId, date);

        List<Slot> slots = SlotTime.generateSlots(shift, bookings, 60); // 60 phút mỗi slot

        request.setAttribute("court", court);
        request.setAttribute("slots", slots);
        request.setAttribute("selectedDate", date); // Truyền ngày vào JSP để hiển thị
        request.getRequestDispatcher("book_field.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        request.setAttribute("message", "Tham số sân không hợp lệ.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
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

        int courtId = Integer.parseInt(request.getParameter("courtId"));
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        

        BookingDAO bookingDAO = new BookingDAO();
        CourtDAO courtDAO = new CourtDAO();
        Courts court = courtDAO.getCourtById(courtId);
        Time startTime, endTime;
        LocalDate today = LocalDate.now();

        if (date.isBefore(today)) {
            request.setAttribute("message", "Không thể đặt lịch cho ngày đã qua.");
            request.setAttribute("court", court);
            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            return;
        }
int areaId = court.getArea_id();
        try {
            startTime = Time.valueOf(request.getParameter("startTime") + ":00");
            endTime = Time.valueOf(request.getParameter("endTime") + ":00");
        } catch (Exception e) {
            request.setAttribute("message", "Lỗi định dạng giờ. Vui lòng kiểm tra lại.");
            request.setAttribute("court", court);
            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            return;
        }
        boolean isAvailable = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);

        if (!isAvailable) {
            request.setAttribute("message", "Khoảng thời gian này đã có người đặt.");
            request.setAttribute("court", court);
            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            return;
        }

        
//        int totalPrice = pricingDAO.calculatePrice(court.getCourt_id(), startTime, endTime);
        Service_BranchDAO sDao = new Service_BranchDAO();
        List<Branch_Service> availableServices = sDao.getAllAreaServices(areaId);
        request.setAttribute("availableServices", availableServices);
        System.out.println(">>>>>>>>>>>>>>>>>" + availableServices);
        request.setAttribute("court", court);
        request.setAttribute("date", date);
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
//        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("confirm_booking.jsp").forward(request, response);
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
