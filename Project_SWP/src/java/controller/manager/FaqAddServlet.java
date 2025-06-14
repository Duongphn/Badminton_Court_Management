package controller.manager;

import DAO.FaqDAO;
import Model.FaqTag;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/faq-add")
public class FaqAddServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FaqDAO dao = new FaqDAO();
        List<FaqTag> tagList = dao.getAllTags();
        request.setAttribute("tagList", tagList);
        request.getRequestDispatcher("faq-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        int tagId = Integer.parseInt(request.getParameter("tagId"));

        FaqDAO dao = new FaqDAO();
        dao.addQuestion(title, tagId);

        response.sendRedirect("faq-list");
    }
}
