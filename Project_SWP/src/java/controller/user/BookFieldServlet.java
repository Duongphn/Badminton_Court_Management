/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.CourtPricingDAO;
import Model.Courts;
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
            String courtIdStr = request.getParameter("courtId");
            if (courtIdStr == null || courtIdStr.isEmpty()) {
                response.sendRedirect("home");
                return;
            }

            int courtId = Integer.parseInt(courtIdStr);
            CourtDAO courtDAO = new CourtDAO();
            Courts court = courtDAO.getCourtById(courtId);

            request.setAttribute("court", court);
            request.getRequestDispatcher("book_field.jsp").forward(request, response);

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
        Time startTime,endTime;
        
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

        CourtPricingDAO pricingDAO = new CourtPricingDAO();
        double totalPrice = pricingDAO.calculatePrice(court.getArea_id(), startTime, endTime);

        request.setAttribute("court", court);
        request.setAttribute("date", date);
        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("totalPrice", totalPrice);
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
