package controller.manager;

import Model.Service;
import DAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "AddService", urlPatterns = {"/AddService"})
public class AddService extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String image_url = request.getParameter("image_url");
        String status = request.getParameter("status");

        if (status == null || status.isEmpty()) {
            status = "Active";
        }

        // Kiểm tra trùng tên
        if (ServiceDAO.isDuplicateService(name)) {
            response.sendRedirect("ViewService?status=duplicate");
            return;
        }

        // Tạo mới
        Service s = new Service(0, name, price, description, image_url, status);

        try {
            ServiceDAO.addService(s);
            response.sendRedirect("ViewEquipments?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewEquipments?status=fail");
        }
    }
    @Override
    public String getServletInfo() {
        return "Add new equipment service";
    }
}
