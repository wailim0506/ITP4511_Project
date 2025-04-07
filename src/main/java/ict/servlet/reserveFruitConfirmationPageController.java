/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet;

import jakarta.persistence.criteria.Order;
import jakarta.servlet.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import ict.db.*;
import ict.bean.*;
import java.util.*;

/**
 *
 * @author Wai Lim Fung
 */
@WebServlet(name = "reserveFruitConfirmationPageController", urlPatterns = { "/rfcp" })
public class reserveFruitConfirmationPageController extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        RequestDispatcher rd;

        String orderId = request.getParameter("oid");
        if (orderId == null) {
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }

        OrderBean orderDetail = (OrderBean) db.getOrderById(orderId);
        if (orderDetail == null) {
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("orderDetail", orderDetail);
        }

        ArrayList<OrderBean> orderItemList = db.getOrderItemById(orderId);
        request.setAttribute("orderItemList", orderItemList);

        rd = getServletContext().getRequestDispatcher("/page/store/reserveFruitConfirmationPage.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
