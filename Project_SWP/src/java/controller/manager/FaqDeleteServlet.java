package controller.manager;

import DAO.FaqDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/faq-delete")
public class FaqDeleteServlet extends HttpServlet {
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

            FaqDAO dao = new FaqDAO();
            dao.deleteQuestionById(questionId);

            response.sendRedirect("faq-list");
        } catch (NumberFormatException e) {
            response.sendRedirect("faq-list");
        }
    }
}
