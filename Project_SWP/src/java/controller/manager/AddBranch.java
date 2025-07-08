package controller.manager;

import DAO.AreaDAO;
import DAO.UserDAO;
import Model.Branch;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Time;

@WebServlet(name = "AddRegionController", urlPatterns = {"/add-region"})
public class AddBranch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
       
    }

  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null) {
        response.sendRedirect("login");
        return;
    }

    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("login");
        return;
    }

    String name = request.getParameter("regionName");
    String address = request.getParameter("address");
    Time openTime = Time.valueOf(request.getParameter("openTime") + ":00");
    Time closeTime = Time.valueOf(request.getParameter("closeTime") + ":00");
    String description = request.getParameter("description");
    String phone_branch = request.getParameter("phone_branch");
    int empty = 0;

    try {
        empty = Integer.parseInt(request.getParameter("emptyCourt"));
    } catch (NumberFormatException e) {
        System.out.println("Lỗi chuyển đổi số lượng sân: " + e.getMessage());
    }

    
int managerId = Integer.parseInt(request.getParameter("manager_id"));


   
    UserDAO userDAO = new UserDAO();
    User staff = userDAO.getUserById(managerId);

    Branch area = new Branch();
    area.setName(name);
    area.setLocation(address);
    area.setEmptyCourt(empty);
    area.setOpenTime(openTime);
    area.setCloseTime(closeTime);
    area.setDescription(description);
    area.setManager_id(managerId); 
    area.setNameStaff(staff.getLastname() + " " + staff.getFirstname());
    area.setPhone_branch(phone_branch);

    AreaDAO dao = new AreaDAO();
    
    boolean exists = dao.isRegionNameExist(name, managerId); 
    if (exists) {
        session.setAttribute("error", "Tồn tại địa điểm rồi!");
    } else {
        dao.addRegion(area);
        session.setAttribute("success", "Thêm khu vực thành công!");
    }

    response.sendRedirect("view-region");
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
