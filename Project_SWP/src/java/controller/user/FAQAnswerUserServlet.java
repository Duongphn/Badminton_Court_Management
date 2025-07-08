package controller.user;

import DAO.FaqDAO;
import Model.FaqAnswer;
import Model.FaqQuestion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name="FAQAnswerUserServlet", urlPatterns={"/faq-answer"})
public class FAQAnswerUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idRaw = request.getParameter("id");
        if (idRaw == null) {
            response.sendRedirect("faq-list");
            return;
        }

        try {
            int questionId = Integer.parseInt(idRaw);
            FaqDAO faqDAO = new FaqDAO();

            FaqQuestion question = faqDAO.getQuestionById(questionId);
            if (question == null) {
                response.sendRedirect("faq-list");
                return;
            }

            List<FaqAnswer> answerList = faqDAO.getAnswersByQuestionId(questionId);

            request.setAttribute("question", question);
            request.setAttribute("answerList", answerList);
            request.getRequestDispatcher("faq_answer_user.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("faq-list");
        }
    }
}
