package controller.manager;

import DAO.FaqDAO;
import Model.FaqTag;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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

        try {
            if (dao.isQuestionTagExists(title, tagId)) {
                // Gửi lỗi về lại trang jsp
                request.setAttribute("error", "❌ Câu hỏi với tag này đã tồn tại!");
                List<FaqTag> tagList = dao.getAllTags();
                request.setAttribute("tagList", tagList);
                request.getRequestDispatcher("faq-add.jsp").forward(request, response);
            } else {
                dao.addQuestion(title, tagId);
                response.sendRedirect("faq-list");
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn cơ sở dữ liệu", e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FaqAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
