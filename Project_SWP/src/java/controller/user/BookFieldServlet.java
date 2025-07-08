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
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
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

            // Mặc định dùng ca đầu tiên
            Shift shift = shifts.get(0);

            BookingDAO bookingDAO = new BookingDAO();
            List<Bookings> bookings = bookingDAO.getBookingsByCourtAndDate(courtId, date);
            List<Slot> allSlots = new ArrayList<>();
            for (Shift shifted : shifts) {
                List<Slot> slotsForShift = SlotTime.generateSlots(shifted, bookings, 60);
                allSlots.addAll(slotsForShift);
            }
            request.setAttribute("court", court);
            request.setAttribute("slots", allSlots);
            request.setAttribute("selectedDate", date);

            request.getRequestDispatcher("book_field.jsp").forward(request, response);
            for (Slot s : allSlots) {
                System.out.println(">>> SLOT: " + s.getStart() + " - " + s.getEnd() + " | Avail: " + s.isAvailable());
            }

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
            int courtId = Integer.parseInt(request.getParameter("courtId"));
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);

            if (date.isBefore(LocalDate.now())) {
                request.setAttribute("message", "Không thể đặt lịch cho ngày đã qua.");
                request.setAttribute("court", court);
                request.setAttribute("selectedDate", date);
                request.getRequestDispatcher("book_field.jsp").forward(request, response);
                return;
            }
            Shift shift = new Shift();
            Time startTime, endTime;
            try {
                startTime = Time.valueOf(request.getParameter("startTime") + ":00");
                endTime = Time.valueOf(request.getParameter("endTime") + ":00");
                System.out.println("Start Time: " + shift.getStartTime());
                System.out.println("End Time: " + shift.getEndTime());
            } catch (Exception e) {
                request.setAttribute("message", "Lỗi định dạng giờ.");
                request.setAttribute("court", court);
                request.setAttribute("selectedDate", date);
                request.getRequestDispatcher("book_field.jsp").forward(request, response);
                return;
            }

            BookingDAO bookingDAO = new BookingDAO();
            boolean isAvailable = bookingDAO.checkSlotAvailable(courtId, date, startTime, endTime);

            if (!isAvailable) {
                request.setAttribute("message", "Khoảng thời gian này đã có người đặt.");
                request.setAttribute("court", court);
                request.setAttribute("selectedDate", date);
                request.getRequestDispatcher("book_field.jsp").forward(request, response);
                return;
            }
            CourtDAO cDao = new CourtDAO();
            BigDecimal pricePerHour = cDao.getCourtPrice(courtId);
            PromotionDAO proDAO = new PromotionDAO();
            Promotion promotion = proDAO.getCurrentPromotionForArea(court.getArea_id(), date);

            System.out.println("Promotion for areaId " + court.getArea_id() + ": " + promotion);
            if (promotion != null) {
                System.out.println("Title: " + promotion.getTitle());
            }

            BigDecimal totalPrice = bookingDAO.calculateSlotPriceWithPromotion(startTime, endTime, pricePerHour, promotion);
            System.out.println("Toltol>>>>" + totalPrice);
            Service_BranchDAO sDao = new Service_BranchDAO();
            List<Branch_Service> services = sDao.getAllAreaServices(court.getArea_id());
            request.setAttribute("promotion", promotion);
            request.setAttribute("court", court);
            request.setAttribute("date", date);
            request.setAttribute("startTime", startTime);
            request.setAttribute("endTime", endTime);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("availableServices", services);
            request.getRequestDispatcher("confirm_booking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Đã xảy ra lỗi khi đặt sân.");
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
