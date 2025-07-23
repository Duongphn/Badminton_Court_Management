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
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Time;
import java.util.List;

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
       request.getRequestDispatcher("DetailBranch.jsp").forward(request, response);
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
        String priceStr = request.getParameter("price");

        if (start == null || end == null || start.isEmpty() || end.isEmpty() ||
            priceStr == null || priceStr.isEmpty()) {
            String msg = URLEncoder.encode("Thiếu thông tin thời gian hoặc giá ca", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }

        
        BigDecimal price;
        try {
            price = new BigDecimal(priceStr);
            if (price.compareTo(BigDecimal.ZERO) < 0) throw new NumberFormatException();
        } catch (NumberFormatException ex) {
            String msg = URLEncoder.encode("Giá ca phải là số hợp lệ lớn hơn hoặc bằng 0", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }

        Time startTime = Time.valueOf(start + ":00");
        Time endTime = Time.valueOf(end + ":00");

        ShiftDAO dao = new ShiftDAO();
        AreaDAO aDao = new AreaDAO();

        Time[] openClose = aDao.getAreaOpenAndCloseTime(areaId);
        if (openClose == null) {
            String msg = URLEncoder.encode("Không tìm thấy giờ hoạt động của khu vực.", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }

        Time openTime = openClose[0];
        Time closeTime = openClose[1];

        if (startTime.compareTo(endTime) >= 0) {
            String msg = URLEncoder.encode("Giờ bắt đầu phải trước giờ kết thúc.", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }
        if (startTime.before(openTime)) {
            String msg = URLEncoder.encode("Giờ bắt đầu không được trước giờ mở cửa (" + openTime + ").", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }
        if (endTime.after(closeTime)) {
            String msg = URLEncoder.encode("Giờ kết thúc không được sau giờ đóng cửa (" + closeTime + ").", "UTF-8");
            response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
            return;
        }

        List<Shift> existingShifts = dao.getShiftsByArea(areaId);
        for (Shift s : existingShifts) {
            boolean overlap = !(endTime.compareTo(s.getStartTime()) <= 0 || startTime.compareTo(s.getEndTime()) >= 0);
            if (overlap) {
                String msg = URLEncoder.encode("Ca mới bị trùng với ca đã có: " + s.getShiftName(), "UTF-8");
                response.sendRedirect("detailBranch?area_id=" + areaId + "&message=" + msg);
                return;
            }
        }

        Shift shift = new Shift(areaId, shiftName, startTime, endTime, price);
        dao.addShift(shift);
         String msg = URLEncoder.encode("Thêm ca thành công.", "UTF-8");
                response.sendRedirect("detailBranch?area_id=" + areaId + "&message" + msg);
//        response.sendRedirect("detailBranch?area_id=" + areaId);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login");
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
