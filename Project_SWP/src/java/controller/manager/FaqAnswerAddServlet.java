package controller.manager;

import DAO.FaqDAO;
import Model.FaqAnswer;
import Model.FaqQuestion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/faq-answer-add")
public class FaqAnswerAddServlet extends HttpServlet {

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
            request.getRequestDispatcher("faq_answer_add.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("faq-list");
        }
    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");

    String questionIdRaw = request.getParameter("questionId");
    String answerIdRaw = request.getParameter("answerId");
    String content = request.getParameter("content");

    if (questionIdRaw == null || content == null || content.trim().isEmpty()) {
        response.sendRedirect("faq-list");
        return;
    }

    try {
        int questionId = Integer.parseInt(questionIdRaw);
        FaqDAO dao = new FaqDAO();

        if (answerIdRaw != null && !answerIdRaw.trim().isEmpty()) {
            // Trường hợp chỉnh sửa
            int answerId = Integer.parseInt(answerIdRaw);
            dao.updateAnswer(answerId, content.trim());
        } else {
            // Trường hợp thêm mới
            dao.addAnswer(questionId, content.trim());
        }

        response.sendRedirect("faq-answer-add?id=" + questionId);
    } catch (NumberFormatException e) {
        response.sendRedirect("faq-list");
    }
}

    
}
