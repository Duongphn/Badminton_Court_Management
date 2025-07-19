package controller.manager;

import DAO.AreaDAO;
import DAO.UserDAO;
import Model.Branch;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "view-region", urlPatterns = {"/view-region"})
public class ViewBranch extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // --- Xác thực token, thiết lập user vào session nếu hợp lệ ---
    Cookie cookies[] = request.getCookies();
    String authToken = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("auth_token".equals(cookie.getName())) {
                authToken = cookie.getValue();
            }
        }
    }
    if (authToken != null && validateToken(authToken)) {
        String username = getUsernameFromToken(authToken);
        UserDAO userDAO = new UserDAO();
        User u = userDAO.getUserByUsername(username);
        HttpSession session = request.getSession();
        if (u != null && "admin".equals(u.getRole())) {
            session.setAttribute("user", u);
        }
    }

    HttpSession session = request.getSession(false);
    if (session != null) {
        User user = (User) session.getAttribute("user");
        if (user != null && "admin".equals(user.getRole())) {

            int page = 1;
            int recordsPerpage = 3;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException ignored) {}
            }

            AreaDAO areaDAO = new AreaDAO();
           
            int numberofRegion = areaDAO.countAllAreas(); 
            int numberofPage = (int) Math.ceil((double) numberofRegion / recordsPerpage);

         
            List<Branch> area = areaDAO.getAllAreas((page - 1) * recordsPerpage, recordsPerpage); 

            request.setAttribute("area", area);
            request.setAttribute("numberOfPages", numberofPage);
            request.setAttribute("currentPage", page);

            UserDAO userDAO = new UserDAO();
            List<User> staffList = userDAO.getAllStaff();
            request.setAttribute("staffList", staffList);

            String error = (String) session.getAttribute("error");
            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
            }

            request.getRequestDispatcher("manager-region.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    } else {
        response.sendRedirect("login");
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    private boolean validateToken(String token) {
        // Xác thực token, ví dụ kiểm tra token trong cơ sở dữ liệu
        return token.endsWith("_0810_token"); // Ví dụ đơn giản
    }

    private String getUsernameFromToken(String token) {
        // Lấy username từ token
        return token.replace("_0810_token", "");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
