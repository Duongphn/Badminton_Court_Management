/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.FaqDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/faq-answer-delete")
public class FaqAnswerDeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String answerIdRaw = request.getParameter("answerId");
        String questionIdRaw = request.getParameter("questionId");

        if (answerIdRaw == null || questionIdRaw == null) {
            response.sendRedirect("faq-list");
            return;
        }

        try {
            int answerId = Integer.parseInt(answerIdRaw);
            int questionId = Integer.parseInt(questionIdRaw);

            FaqDAO dao = new FaqDAO();
            dao.deleteAnswerById(answerId);

            response.sendRedirect("faq-answer-add?id=" + questionId);
        } catch (NumberFormatException e) {
            response.sendRedirect("faq-list");
        }
    }
}
