/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.CoachDAO;
import Model.Coach;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

/**
 *
 * @author sang
 */
@WebServlet(name="CoachAdd", urlPatterns={"/CoachAdd"})
@MultipartConfig
public class CoachAdd extends HttpServlet {
   
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
            out.println("<title>Servlet CoachAdd</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CoachAdd at " + request.getContextPath () + "</h1>");
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
            request.setCharacterEncoding("UTF-8");

            String fullname = request.getParameter("fullname");
            int areaId = Integer.parseInt(request.getParameter("area_id"));
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String specialty = request.getParameter("specialty");
            String description = request.getParameter("description");

            Part imagePart = request.getPart("image_file");
            String fileName = "";
            String dbPath = "";
            if (imagePart != null && imagePart.getSize() > 0) {
                fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = request.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                String savePath = uploadPath + File.separator + fileName;
                imagePart.write(savePath);
                dbPath = "uploads/" + fileName;
            }

            Coach coach = new Coach();
            coach.setAreaId(areaId);
            coach.setFullname(fullname);
            coach.setEmail(email);
            coach.setPhone(phone);
            coach.setSpecialty(specialty);
            coach.setImageUrl(dbPath);
            coach.setDescription(description);
            coach.setStatus("active");
            new CoachDAO().insertCoach(coach);

            response.sendRedirect("CoachList");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi thêm huấn luyện viên!");
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
