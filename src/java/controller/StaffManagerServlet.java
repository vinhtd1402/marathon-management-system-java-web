package controller;

import dal.RegistrationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import models.Registration;


public class StaffManagerServlet extends HttpServlet {

    private final RegistrationDAO dao = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        // 🔐 Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("Login");
            return;
        }

        
        
        
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            // 🟢 Hiển thị danh sách đơn đăng ký
            case "list": {
                List<Registration> list = dao.getAllRegistrations();
                request.setAttribute("registrations", list);
                request.getRequestDispatcher("views/staff/ListRegistration.jsp").forward(request, response);
                break;
            }

            // 🔴 Xóa đơn đăng ký (nếu cần)
            case "delete": {
                try {
                    int regID = Integer.parseInt(request.getParameter("id"));
                    dao.deleteRegistration(regID);
                    response.sendRedirect("staffManager?action=list");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                }
                break;
            }

            default:
                response.sendRedirect("staffManager?action=list");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            // 🟡 Staff cập nhật trạng thái đơn đăng ký
            case "update": {
                try {
                    int regID = Integer.parseInt(request.getParameter("regID"));
                    String status = request.getParameter("status"); // "Pending" hoặc "Paid"

                    // Cập nhật trạng thái + cộng dặm chạy nếu Paid
                    dao.updatePaymentStatusAndDistance(regID, status);

                    response.sendRedirect("staffManager?action=list");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                }
                break;
            }

           
            default:
                response.sendRedirect("staffManager?action=list");
                break;
        }
    }
}
