package controller.manager;

import DAO.AreaDAO;
import DAO.PromotionDAO;
import Model.Branch;
import Model.Promotion;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name="PromotionAdmin", urlPatterns={"/promotion-admin"})
public class PromotionAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        PromotionDAO dao = new PromotionDAO();
        dao.updateExpiredPromotions(); 

        String status = request.getParameter("status");
        String areaIdStr = request.getParameter("areaId");

        List<Promotion> list;

        if ((status != null && !status.isEmpty()) || (areaIdStr != null && !areaIdStr.isEmpty())) {
            
            list = dao.filterPromotion(status, areaIdStr);
        } else {
            
            int page = 1;
            int pageSize = 6;
            String pageParam = request.getParameter("page");

            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalPromotions = dao.getTotalPromotionCount();
            int numberOfPages = (int) Math.ceil((double) totalPromotions / pageSize);
            if (page > numberOfPages) page = numberOfPages;

            int offset = (page - 1) * pageSize;
            list = dao.getPromotionsByPage(offset, pageSize);

            request.setAttribute("currentPage", page);
            request.setAttribute("numberOfPages", numberOfPages);
        }

      
        for (Promotion p : list) {
            List<String> areaNames = dao.getAreaNamesByPromotionId(p.getPromotionId());
            p.setAreaNames(areaNames);
        }

        AreaDAO areaDAO = new AreaDAO();
        List<Branch> areaList = areaDAO.getAllAreas();

        request.setAttribute("promotionList", list); 
        request.setAttribute("areaList", areaList);

        request.getRequestDispatcher("manage-promotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("promotion-admin");
    }

    @Override
    public String getServletInfo() {
        return "Promotion Admin Management";
    }
}