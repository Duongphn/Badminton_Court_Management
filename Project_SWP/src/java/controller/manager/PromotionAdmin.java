/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.AreaDAO;
import DAO.PromotionDAO;
import Model.Branch;
import Model.Promotion;
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
@WebServlet(name="PromotionAdmin", urlPatterns={"/promotion-admin"})
public class PromotionAdmin extends HttpServlet {
   
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
            out.println("<title>Servlet PromotionAdmin</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PromotionAdmin at " + request.getContextPath () + "</h1>");
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
            if (user != null && "admin".equals(user.getRole())) {
                // Phân trang
                int page = 1;
                int pageSize = 6;
                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        page = Integer.parseInt(pageParam);
                        if (page < 1) {
                            page = 1;
                        }
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }
                PromotionDAO dao = new PromotionDAO();
                dao.updateExpiredPromotions();
                int totalPromotions = dao.getTotalPromotionCount();
                int numberOfPages = (int) Math.ceil((double) totalPromotions / pageSize);

                if (page > numberOfPages) {
                    page = numberOfPages;
                }

                int offset = (page - 1) * pageSize;
                List<Promotion> list = dao.getPromotionsByPage(offset, pageSize);
                for (Promotion p : list) {
                    List<String> areaNames = dao.getAreaNamesByPromotionId(p.getPromotionId());
                    p.setAreaNames(areaNames);
                    System.out.println("Promotion ID: " + p.getPromotionId() + " - areaNames: " + p.getAreaNames());
                }

                AreaDAO areaDAO = new AreaDAO();
                List<Branch> areaList = areaDAO.getAllAreas();
                request.setAttribute("areaList", areaList);
                request.setAttribute("promotionList", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("numberOfPages", numberOfPages);
                request.getRequestDispatcher("manage-promotion.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("login");
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
