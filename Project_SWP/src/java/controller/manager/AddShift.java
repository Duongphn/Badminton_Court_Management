/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.AreaDAO;
import DAO.ShiftDAO;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Time;

/**
 *
 * @author admin
 */
@WebServlet(name="AddShift", urlPatterns={"/add-shift"})
public class AddShift extends HttpServlet {
   
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
            out.println("<title>Servlet AddShift</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddShift at " + request.getContextPath () + "</h1>");
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

    try {
        int areaId = Integer.parseInt(request.getParameter("area_id"));
        String shiftName = request.getParameter("shiftName");
       String start = request.getParameter("startTime");
String end = request.getParameter("endTime");

if (start == null || end == null || start.isEmpty() || end.isEmpty()) {
    response.sendRedirect("detailBranch?area_id=" + areaId + "&message=Thiếu thời gian bắt đầu hoặc kết thúc");
    return;
}

Time startTime = Time.valueOf(start + ":00"); // nếu chỉ có HH:mm
Time endTime = Time.valueOf(end + ":00");

        ShiftDAO dao = new ShiftDAO();
        AreaDAO aDao = new AreaDAO();
        
        Time[] openClose = aDao.getAreaOpenAndCloseTime(areaId);
        if (openClose == null) {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=Không tìm thấy giờ hoạt động của khu vực.");
            return;
        }

        Time openTime = openClose[0];
        Time closeTime = openClose[1];

       
        if (startTime.compareTo(endTime) >= 0) {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=Giờ bắt đầu phải trước giờ kết thúc.");
            return;
        }
        if (startTime.before(openTime)) {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=Giờ bắt đầu không được trước giờ mở cửa (" + openTime + ").");
            return;
        }
        if (endTime.after(closeTime)) {
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=Giờ kết thúc không được sau giờ đóng cửa (" + closeTime + ").");
            return;
        }

        // Nếu hợp lệ thì thêm shift
        Shift shift = new Shift(areaId, shiftName, startTime, endTime);
        dao.addShift(shift);

        response.sendRedirect("detailBranch?area_id=" + areaId);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
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
