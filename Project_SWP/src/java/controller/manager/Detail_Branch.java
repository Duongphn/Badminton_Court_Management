/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.AreaDAO;
import DAO.Branch_ImageDAO;
import DAO.CourtDAO;
import DAO.ServiceDAO;
import DAO.Service_BranchDAO;
import DAO.ShiftDAO;


import Model.Branch;

import Model.Branch_Service;
import Model.Branch_pictures;
import Model.Courts;
import Model.Service;
import Model.Shift;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name="Detail_Branch", urlPatterns={"/detailBranch"})
public class Detail_Branch extends HttpServlet {
   
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
            out.println("<title>Servlet Detail_Branch</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Detail_Branch at " + request.getContextPath () + "</h1>");
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
    HttpSession session = request.getSession(false);
    if (session != null) {
        User user = (User) session.getAttribute("user");
        if (user != null && "staff".equals(user.getRole())) {
            int area_id = Integer.parseInt(request.getParameter("area_id"));

            AreaDAO dao = new AreaDAO();

            
            Service_BranchDAO sdao = new Service_BranchDAO();
            Branch_ImageDAO idao = new Branch_ImageDAO();
            CourtDAO cdao = new CourtDAO();
            ServiceDAO eDao = new ServiceDAO();
            ShiftDAO shiftDao = new ShiftDAO();
            List <Shift> listShift = shiftDao.getShiftsByArea(area_id);
            request.setAttribute("listShift", listShift);
            
           

            Branch areaDetail = dao.getAreaByIdWithManager(area_id);
            request.setAttribute("areaDetail", areaDetail);

            
            List<Branch_pictures> areaImages = idao.getRoomImagesByDormID(area_id);
            request.setAttribute("areaImages", areaImages);

            List<Courts> areaCourts = cdao.getCourtsByAreaId(area_id);
            request.setAttribute("areaCourts", areaCourts);

            List<Branch_Service> areaAllServices = eDao.getAllAreaServices(area_id);

            request.setAttribute("areaAllServices", areaAllServices);

           
            List<Service> allServicees = eDao.getAllService();
            request.setAttribute("allServices", allServicees);

            
            request.setAttribute("area_id", area_id);
  request.getRequestDispatcher("DetailBranch.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    } else {
        response.sendRedirect("login");
    }
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
        processRequest(request, response);
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
