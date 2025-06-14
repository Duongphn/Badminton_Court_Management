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

        // Lấy thông tin từ form
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String image_url = request.getParameter("image_url");
        String status = request.getParameter("status");
        if (status == null || status.isEmpty()) {
            status = "Active"; // giá trị mặc định
        }

        // Kiểm tra trùng tên dịch vụ
        if (ServiceDAO.isDuplicateService(name)) {
            List<Service> service = ServiceDAO.getAllService();
            request.setAttribute("service", service);
            request.setAttribute("status", "duplicate");
            request.getRequestDispatcher("ServiceView.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Service mới
        Service s = new Service(0, name, price, description, image_url, status);

        try {
            ServiceDAO.addService(s);

            List<Service> service = ServiceDAO.getAllService();
            request.setAttribute("service", service);
            request.setAttribute("status", "success");
            request.getRequestDispatcher("ServiceView.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();

            List<Service> service = ServiceDAO.getAllService();
            request.setAttribute("service", service);
            request.setAttribute("status", "fail");
            request.getRequestDispatcher("ServiceView.jsp").forward(request, response);
        }

    }


    @Override
    public String getServletInfo() {
        return "Add new equipment service";
    }
}
