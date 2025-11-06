/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.EventTypeDAO;
import dal.MarathonEventDAO;
import dal.SponsorDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import models.MarathonEvent;
import models.MarathonType;
import models.Sponsor;
import java.sql.Date;

/**
 *
 * @author Administrator
 */
public class AddEventServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddEventServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddEventServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect("Login");
        return;
    }
        SponsorDAO sdao = new SponsorDAO();
        EventTypeDAO tdao = new EventTypeDAO();

        List<Sponsor> sponsors = sdao.getAllSponsors();
        List<MarathonType> types = tdao.getAllType();

        request.setAttribute("sponsors", sponsors);
        request.setAttribute("types", types);
        RequestDispatcher rd = request.getRequestDispatcher("views/admin/AddEvent.jsp");
        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect("Login");
        return;
    }
        try {

            String name = request.getParameter("eventName");
            String location = request.getParameter("location");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            double fee = Double.parseDouble(request.getParameter("fee"));
            String description = request.getParameter("description");
            String healthRequirement = request.getParameter("healthRequirement");
 
            String imagePath = request.getParameter("imagePath");
            int sponsorId = Integer.parseInt(request.getParameter("sponsorId"));
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            Sponsor sponsor = new Sponsor();
            sponsor.setSponsorId(sponsorId);
            MarathonType type = new MarathonType();
            type.setTypeID(typeId);

            MarathonEvent event = new MarathonEvent(0, name, location, startDate, fee, imagePath, description, healthRequirement, sponsor, type);
            
            MarathonEventDAO dao=new MarathonEventDAO();
            dao.addEvent(event);
            
            response.sendRedirect("list");
            
        } catch (Exception e) {
              e.printStackTrace();
    response.getWriter().println("Error: " + e.getMessage());
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
