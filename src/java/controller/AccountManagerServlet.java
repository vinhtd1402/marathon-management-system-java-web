/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import models.Account;

/**
 *
 * @author Administrator
 */
public class AccountManagerServlet extends HttpServlet {

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
            out.println("<title>Servlet AccountManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountManagerServlet at " + request.getContextPath() + "</h1>");
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
    AccountDAO dao = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Account acc = dao.getAccountById(id);
                request.setAttribute("account", acc);
                request.getRequestDispatcher("views/account/EditAccount.jsp").forward(request, response);
                break;
            case "delete":
                dao.softDeleteAccount(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("accountManager");
                break;
            case "add":
                request.getRequestDispatcher("views/account/AddAccount.jsp").forward(request, response);
                break;
            case"search":
                request.getRequestDispatcher("views/account/ManagerAccount.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("accounts", dao.getAccounts());
                request.getRequestDispatcher("views/account/ManagerAccount.jsp").forward(request, response);
                break;
        }
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
         String action = request.getParameter("action");

    if ("update".equals(action)) {
        // 🟡 Cập nhật account
        Account a = new Account();
        a.setuID(Integer.parseInt(request.getParameter("uID")));
        a.setFullName(request.getParameter("fullName"));
        a.setGender(request.getParameter("gender"));
        a.setUsername(request.getParameter("username"));
        a.setPassword(request.getParameter("password"));
        a.setAge(Integer.parseInt(request.getParameter("age")));
        a.setHealthStatus(request.getParameter("healthStatus"));
        a.setEmail(request.getParameter("email"));
        a.setPhone(request.getParameter("phone"));
        a.setTotalDistance(Double.parseDouble(request.getParameter("totalDistance")));
        
        dao.updateAccount(a);
        response.sendRedirect("accountManager");
    } 
    else if ("add".equals(action)) {

        Account a = new Account(); 
        a.setFullName(request.getParameter("fullName"));
        a.setGender(request.getParameter("gender"));
        a.setUsername(request.getParameter("username"));
        a.setPassword(request.getParameter("password"));
        a.setAge(Integer.parseInt(request.getParameter("age")));
        a.setHealthStatus(request.getParameter("healthStatus"));
        a.setEmail(request.getParameter("email"));
        a.setPhone(request.getParameter("phone"));
        a.setRoleID(2); 
        a.setTotalDistance(0); 
        dao.CreateAccount(a);

        response.sendRedirect("accountManager");
    }else if ("search".equals(action)){
        request.setCharacterEncoding("UTF-8");
        String search = request.getParameter("search");
        List<Account> list= new ArrayList<>();
    if (search != null && !search.trim().isEmpty()) {
        list = dao.searchAccount(search.trim());
    } else {
        list = dao.getAccounts(); 
    }
    request.setAttribute("accounts", list);
    request.setAttribute("search", search); 
    request.getRequestDispatcher("views/account/ManagerAccount.jsp").forward(request, response);
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
