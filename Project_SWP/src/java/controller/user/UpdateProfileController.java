/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import DAO.UserDAO;
import Model.User;
import utils.PasswordUtil;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.ParseException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateProfileController", urlPatterns = {"/updateprofile"})
public class UpdateProfileController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserDAO userDao = new UserDAO();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String dobStr = request.getParameter("date_of_birth");

        // Validation
        if (firstname == null || lastname == null || firstname.trim().isEmpty() || lastname.trim().isEmpty()) {
            request.setAttribute("error", "Họ và tên không được để trống");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }
        
        if (username == null || username.trim().isEmpty() || !username.matches("^[a-zA-Z0-9_\\.]{3,20}$")) {
            request.setAttribute("error", "Tên đăng nhập không hợp lệ! Chỉ cho phép chữ cái, số, dấu gạch dưới (_) và dấu chấm (.). Độ dài từ 3-20 ký tự.");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }

        if (!phoneNumber.matches("^(0)\\d{9}$")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ! Phải bắt đầu bằng 0và có chính xác 10 chữ số.");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }

        
        UserDAO userDAO = new UserDAO();
        if (userDAO.isPhoneExists(phoneNumber)) {
            request.setAttribute("error", "Số điện thoại đã tồn tại");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }


        User newUser = new User();
        newUser.setUser_Id(user.getUser_Id()); 
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPhone_number(phoneNumber);
        newUser.setGender(gender);
        newUser.setFirstname(firstname);
        newUser.setLastname(lastname);
//        newUser.setFullname(lastname + " " + firstname);
        newUser.setRole(user.getRole()); // Giữ nguyên role từ user cũ

        // Xử lý dateOfBirth
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(dobStr);
                newUser.setDateOfBirth(new java.sql.Date(utilDate.getTime()));
            } else {
                newUser.setDateOfBirth(null);
            }
        } catch (java.text.ParseException ex) {
            Logger.getLogger(UpdateProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        userDao.updateUser(newUser);
        session.setAttribute("user", newUser);
        response.sendRedirect("viewprofile.jsp");
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
