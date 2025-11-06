package controller;

import dal.AdviceDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import models.Advice;
import models.Account;

public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdviceDAO dao = new AdviceDAO();
        List<Advice> list = dao.getAllAdvice();
        request.setAttribute("advices", list);

        RequestDispatcher rd = request.getRequestDispatcher("views/comment/Comments.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        String title = request.getParameter("title");
        String message = request.getParameter("message");

        if (title == null || message == null || title.trim().isEmpty() || message.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tiêu đề và nội dung.");
            doGet(request, response);
            return;
        }

        Advice ad = new Advice();
        ad.setRunnerID(acc.getuID());
        ad.setTitle(title);
        ad.setMessage(message);

        AdviceDAO dao = new AdviceDAO();
        dao.insertAdvice(ad);

        // Sau khi thêm mới, load lại danh sách
        response.sendRedirect("Comments");
    }
}
