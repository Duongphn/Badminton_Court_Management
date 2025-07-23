package controller.manager;

import Model.Service;
import DAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "AddService", urlPatterns = {"/AddService"})
public class AddService extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String category = request.getParameter("category");
        if (status == null || status.isEmpty()) {
            status = "Active";
        }

// Xử lý file ảnh
        Part filePart = request.getPart("image_file");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);
        }

        if (ServiceDAO.isDuplicateService(name)) {
            response.sendRedirect("ViewEquipments?status=duplicate");
            return;
        }

        String imagePath = (fileName != null) ? "uploads/" + fileName : null; // có dấu /
        Service s = new Service(0, name, price, description, imagePath, status, category);

        try {
            ServiceDAO.addService(s);
            response.sendRedirect("ViewEquipments?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewEquipments?status=fail");
        }
    }

        @Override
        public String getServletInfo
        
            () {
        return "Add new equipment service";
        }
    
}
