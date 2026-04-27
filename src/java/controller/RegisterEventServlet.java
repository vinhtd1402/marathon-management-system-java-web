package controller;

import dal.MarathonEventDAO;
import dal.RegistrationDAO;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.*;
import java.io.IOException;
import models.Account;
import models.MarathonEvent;


public class RegisterEventServlet extends HttpServlet {

    private MarathonEventDAO eventDAO = new MarathonEventDAO();
    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account acc = (session != null) ? (Account) session.getAttribute("account") : null;

        if (acc == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            MarathonEvent event = eventDAO.getEventById(eventID);

            request.setAttribute("eventID", eventID);
            request.setAttribute("event", event);

            request.getRequestDispatcher("views/runner/RegisterEvent.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account acc = (session != null) ? (Account) session.getAttribute("account") : null;

        if (acc == null) {
            response.sendRedirect("Login");
            return;
        }

        int runnerID = acc.getuID();
        int eventID = Integer.parseInt(request.getParameter("eventID"));

        try {
            // Kiểm tra xem runner có đăng ký nào đang Pending không
            if (registrationDAO.hasPendingRegistration(runnerID)) {
                MarathonEvent event = eventDAO.getEventById(eventID);
                request.setAttribute("error", "Bạn đang có một đăng ký chưa được duyệt. Vui lòng chờ staff duyệt trước khi đăng ký thêm.");
                request.setAttribute("eventID", eventID);
                request.setAttribute("event", event);
                request.getRequestDispatcher("views/runner/RegisterEvent.jsp").forward(request, response);
                return;
                
            }

            // Thêm đăng ký
            boolean success = registrationDAO.addRegistration(eventID, runnerID);

            if (success) {
                // Redirect về trang chi tiết sự kiện
                response.sendRedirect(request.getContextPath() + "/eventDetail?id=" + eventID);
            } else {
                MarathonEvent event = eventDAO.getEventById(eventID);
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.setAttribute("eventID", eventID);
                request.setAttribute("event", event);
                request.getRequestDispatcher("views/runner/RegisterEvent.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
