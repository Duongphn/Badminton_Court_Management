package controller.manager;

import DAO.FaqDAO;
import Model.FaqQuestion;
import Model.FaqTag;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/faq-list")
public class FaqListServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String tagIdRaw = request.getParameter("tagId");
        String pageRaw = request.getParameter("page");
        String forUser = request.getParameter("for");

        String safeKeyword = (keyword != null) ? keyword.trim() : "";
        int tagId = (tagIdRaw != null && !tagIdRaw.isEmpty()) ? Integer.parseInt(tagIdRaw) : 0;
        int page = (pageRaw != null && !pageRaw.isEmpty()) ? Integer.parseInt(pageRaw) : 1;

        FaqDAO dao = new FaqDAO();
        List<FaqTag> tagList = dao.getAllTags();
        List<FaqQuestion> faqList = dao.getFilteredFaqQuestions(safeKeyword, tagId, page, PAGE_SIZE);
        int totalItems = dao.countFilteredFaqQuestions(safeKeyword, tagId);
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        request.setAttribute("faqList", faqList);
        request.setAttribute("tagList", tagList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", safeKeyword);
        request.setAttribute("selectedTag", tagId);

        if ("user".equalsIgnoreCase(forUser)) {
            request.getRequestDispatcher("faq-user.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("faq_list.jsp").forward(request, response);
        }
    }
}
