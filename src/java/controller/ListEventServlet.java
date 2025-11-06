/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.MarathonEventDAO;
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

/**
 *
 * @author Administrator
 */
public class ListEventServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ListEventServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListEventServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
        MarathonEventDAO dao = new MarathonEventDAO();
     List<MarathonEvent> events = dao.getAllEvent();
      request.setAttribute("events", events);
        
        RequestDispatcher rd= request.getRequestDispatcher("views/admin/ManagerEvent.jsp");
        rd.forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
         String search = request.getParameter("search");
      MarathonEventDAO dao = new MarathonEventDAO();
    List<MarathonEvent> events;
     if (search != null && !search.trim().isEmpty()) {
        events = dao.searchEvent(search.trim());
    } else {
        events = dao.getAllEvent();
    }
    request.setAttribute("events", events);
    request.setAttribute("search", search);
    request.getRequestDispatcher("views/admin/ManagerEvent.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
