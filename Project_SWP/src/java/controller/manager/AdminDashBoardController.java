/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.BookingDAO;
import DAO.CourtDAO;
import DAO.ReviewDAO;
import DAO.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import Model.AdminDashBoard;

/**
 *
 * @author admin
 */
@WebServlet(name = "AdminDashBoard", urlPatterns = {"/AdminDashBoard"})
public class AdminDashBoardController extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO(); 
    private UserDAO userDAO = new UserDAO();
//    private ReviewDAO reviewDAO = new ReviewDAO();
    private CourtDAO courtDAO = new CourtDAO();

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
            out.println("<title>Servlet AdminDashBoard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashBoard at " + request.getContextPath() + "</h1>");
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
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalBookings", bookingDAO.getTotalBookings());    
        summary.put("totalRevenue", bookingDAO.getTotalRevenue());      
        summary.put("returningUsers", userDAO.getReturningUserCount()); 
//        summary.put("avgRating", reviewDAO.getAverageRating());         

        request.setAttribute("summary", summary);

        // Lấy danh sách report từng sân
        List<AdminDashBoard> courts = courtDAO.getAllCourtReports();       
        request.setAttribute("courtReports", courts);

        // Xếp hạng top 10 sân doanh thu/lượt đặt/đánh giá (ví dụ theo doanh thu)
        courts.sort((a, b) -> Double.compare(b.getRevenue(), a.getRevenue()));
        List<AdminDashBoard> topCourts = courts.subList(0, Math.min(10, courts.size()));
        request.setAttribute("topCourts", topCourts);

        // Sau khi xử lý xong thì forward sang ViewAdminDashboardServlet
        RequestDispatcher rd = request.getRequestDispatcher("ViewAdminDashboardServlet");
        rd.forward(request, response);
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
        processRequest(request, response);
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
