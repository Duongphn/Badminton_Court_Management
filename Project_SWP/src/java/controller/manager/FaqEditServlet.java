/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import DAO.FaqDAO;
import Model.FaqQuestion;
import Model.FaqTag;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet("/faq-edit")
public class FaqEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FaqDAO dao = new FaqDAO();
        FaqQuestion question = dao.getQuestionById(id);
        List<FaqTag> tags = dao.getAllTags();

        request.setAttribute("question", question);
        request.setAttribute("tagList", tags);
        request.getRequestDispatcher("faq-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int tagId = Integer.parseInt(request.getParameter("tagId"));

        FaqQuestion question = new FaqQuestion();
        question.setQuestionId(id);
        question.setTitle(title);
        question.setTag(new FaqTag(tagId, null)); // chỉ cần ID

        FaqDAO dao = new FaqDAO();
        dao.updateQuestion(question);

        response.sendRedirect("faq-list");
    }
}
