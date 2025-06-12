/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.AreaDAO;
import DAO.EquipmentsDAO;

import Model.Branch_Equipments;
import Model.Branch_pictures;
import Model.Equipments;
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
            if (user.getRole().equals("staff")) {
                int area_id = Integer.parseInt(request.getParameter("area_id"));

                AreaDAO dao = new AreaDAO();
                EquipmentsDAO eDao = new EquipmentsDAO();
                
                List<Branch_pictures> areaImages = dao.getRoomImagesByDormID(area_id);
                List<Branch_Equipments> areaAllServices = eDao.getAllAreaServices(area_id);
                List<Equipments> allServicees = eDao.getAllEquipments();
                request.setAttribute("allServices", allServicees);
                request.setAttribute("areaAllServices", areaAllServices);

                request.setAttribute("areaImages", areaImages);
                request.setAttribute("area_id", area_id);
                request.getRequestDispatcher("DetailBranch.jsp").forward(request, response);
            } else {
                response.sendError(403);
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
