/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.warehouse;

import ict.bean.*;
import ict.db.ProjectDB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;


/**
 *
 * @author HwH
 */
@WebServlet(name = "RestockController", urlPatterns = {"/Restock"})
public class RestockController extends HttpServlet {

    private ProjectDB db;

    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");
        db = new ProjectDB(dbUrl, dbUser, dbPassword);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        UserBean user = (UserBean) session.getAttribute("userInfo");

        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        if (user.getWarehouseType().equals("Source")) {
            orders = db.getWarehouseOrderSource(user.getWareHouseId());
        } else {
            orders = db.getWarehouseOrderCentral(user.getWareHouseId());
        }
        
        request.setAttribute("orderList", orders);

        int total = 0, pending = 0, processing = 0, finished = 0;

        for (OrderBean order : orders) {
            if (order.getStatus().equals("Pending")) {
                pending++;
            } else if (order.getStatus().equals("Finished")) {
                finished++;
            } else if (order.getStatus().equals("Processing")) {
                processing++;
            }
            total++;
        }

        StatusBean sb = new StatusBean();
        sb.setTotal(Integer.toString(total));
        sb.setPending(Integer.toString(pending));
        sb.setProcessing(Integer.toString(processing));
        sb.setFinished(Integer.toString(finished));
        request.setAttribute("StatusBean", sb);

        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/warehouse/restock.jsp");
            rd.forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
