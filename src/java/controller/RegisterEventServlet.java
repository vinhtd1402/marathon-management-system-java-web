package controller;

import dal.MarathonEventDAO;
import dal.RegistrationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import models.Account;
import models.MarathonEvent;
import models.Registration;

public class RegisterEventServlet extends HttpServlet {
    private MarathonEventDAO dal= new MarathonEventDAO();
    private  RegistrationDAO dao = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession(false);
        Account acc = (Account) (session != null ? session.getAttribute("account") : null);
        if (acc == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            MarathonEvent event= dal.getEventById(eventID);
            
            
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

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Account acc = (Account) (session != null ? session.getAttribute("account") : null);

        if (acc == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            int runnerID = acc.getuID(); 
            dao.addRegistration(eventID, runnerID);

           
         response.sendRedirect("eventDetail?id=" + eventID);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
