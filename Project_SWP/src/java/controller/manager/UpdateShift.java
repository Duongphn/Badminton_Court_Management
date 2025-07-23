/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import DAO.ShiftDAO;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Time;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateShift", urlPatterns = {"/update-shift"})
public class UpdateShift extends HttpServlet {

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
            out.println("<title>Servlet UpdateShift</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateShift at " + request.getContextPath() + "</h1>");
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
        int shiftId = Integer.parseInt(request.getParameter("shiftId"));
        int areaId = Integer.parseInt(request.getParameter("area_id"));
        String shiftName = request.getParameter("shiftName");

        String rawStartTime = request.getParameter("startTime");
        if (rawStartTime != null && rawStartTime.length() == 5) {
            rawStartTime += ":00";
        }
        Time startTime = Time.valueOf(rawStartTime);

        String rawEndTime = request.getParameter("endTime");
        if (rawEndTime != null && rawEndTime.length() == 5) {
            rawEndTime += ":00";
        }
        Time endTime = Time.valueOf(rawEndTime);
        BigDecimal price = new BigDecimal(request.getParameter("price"));

        Shift shift = new Shift(shiftId, areaId, shiftName, startTime, endTime, price);
        ShiftDAO shiftDAO = new ShiftDAO();
        boolean success = shiftDAO.updateShift(shift);

        if (success) {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&shift_updated=true");
        } else {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&error=update_failed");
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
