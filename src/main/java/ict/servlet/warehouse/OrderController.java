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
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author HwH
 */
@WebServlet(name = "OrderController", urlPatterns = {"/Order"})
public class OrderController extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        UserBean user = (UserBean) session.getAttribute("userInfo");

        if (session == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        if (user.getWarehouseType().equals("Source")) {
            orders = db.getWarehouseOrderSource(user.getWareHouseId());
            ArrayList<TotalQtyBean> hk = db.getTotalQtyByCountry(user.getWareHouseId(), "HK", "Pending");
            ArrayList<TotalQtyBean> jp = db.getTotalQtyByCountry(user.getWareHouseId(), "jp", "Pending");
            ArrayList<TotalQtyBean> us = db.getTotalQtyByCountry(user.getWareHouseId(), "us", "Pending");

            request.setAttribute("TotalQtyHK", hk);
            request.setAttribute("TotalQtyJP", jp);
            request.setAttribute("TotalQtyUS", us);
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
            rd = getServletContext().getRequestDispatcher("/page/warehouse/order.jsp");
            rd.forward(request, response);
        } else if ("view".equalsIgnoreCase(action)) {
            String orderID = request.getParameter("orderID");
            OrderBean order = new OrderBean();
            if (user.getWarehouseType().equals("Source")) {
                order = db.getOrderByIdSource(user.getWareHouseId(), orderID);
            } else {
                order = db.getOrderByIdCental(orderID);
            }

            request.setAttribute("order", order);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/warehouse/order.jsp");
            rd.forward(request, response);
        } else if ("process".equalsIgnoreCase(action)) {
            String orderID = request.getParameter("orderID");
            OrderBean order = new OrderBean();

            if (user.getWarehouseType().equals("Central")) {
                int noOfItem = db.getNoOfItemInOrder(orderID);
                int noOfItemHaveStock = db.checkStockCentral(user.getWareHouseId(), orderID);

                if (noOfItem == noOfItemHaveStock) {
                    if (db.updateWarehouseStock(orderID, user.getWareHouseId()) && db.processOrderCentral(orderID)) {
                        request.setAttribute("successMsg", "Order: " + orderID + " status have change to Processing!");
                    } else {
                        request.setAttribute("errorMsg", "Fail to process order: " + orderID + ".");
                    }
                } else {
                    request.setAttribute("errorMsg", "Not have enought stock to process the order: " + orderID + ". Please restock!");
                }
            } else if (user.getWarehouseType().equals("Source")) {
                int noOfItem = db.getNoOfItemInOrderSource(orderID, user.getWareHouseId());
                int noOfItemHaveStock = db.checkStockCentral(user.getWareHouseId(), orderID);

                if (noOfItem == noOfItemHaveStock) {
                    if (db.updateWarehouseStock(orderID, user.getWareHouseId()) && db.processOrderSource(orderID, user.getWareHouseId())) {
                        request.setAttribute("successMsg", "Order: " + orderID + " status have change to Processing!");
                    } else {
                        request.setAttribute("errorMsg", "Fail to process order: " + orderID + ".");
                    }
                } else {
                    request.setAttribute("errorMsg", "Not have enought stock to process the order: " + orderID + ". Please restock!");
                }
            }

            orders = new ArrayList<OrderBean>();
            if (user.getWarehouseType().equals("Source")) {
                orders = db.getWarehouseOrderSource(user.getWareHouseId());
                ArrayList<TotalQtyBean> hk = db.getTotalQtyByCountry(user.getWareHouseId(), "HK", "Pending");
                ArrayList<TotalQtyBean> jp = db.getTotalQtyByCountry(user.getWareHouseId(), "jp", "Pending");
                ArrayList<TotalQtyBean> us = db.getTotalQtyByCountry(user.getWareHouseId(), "us", "Pending");

                request.setAttribute("TotalQtyHK", hk);
                request.setAttribute("TotalQtyJP", jp);
                request.setAttribute("TotalQtyUS", us);
            } else {
                orders = db.getWarehouseOrderCentral(user.getWareHouseId());
            }

            if (user.getWarehouseType().equals("Source")) {
                order = db.getOrderByIdSource(user.getWareHouseId(), orderID);
            } else {
                order = db.getOrderByIdCental(orderID);
            }

            total = 0;
            pending = 0;
            processing = 0;
            finished = 0;
            for (OrderBean od : orders) {
                if (od.getStatus().equals("Pending")) {
                    pending++;
                } else if (od.getStatus().equals("Finished")) {
                    finished++;
                } else if (od.getStatus().equals("Processing")) {
                    processing++;
                }
                total++;
            }

            sb.setTotal(Integer.toString(total));
            sb.setPending(Integer.toString(pending));
            sb.setProcessing(Integer.toString(processing));
            sb.setFinished(Integer.toString(finished));
            request.setAttribute("StatusBean", sb);

            request.setAttribute("orderList", orders);
            request.setAttribute("order", order);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/warehouse/order.jsp");
            rd.forward(request, response);

        } else if ("acceptAll".equalsIgnoreCase(action) && user.getWarehouseType().equals("Source")) {
            String country = request.getParameter("country");

            int noOfItem = db.checkStockAcceptAllGetTotalItem(user.getWareHouseId(), country);
            int noOfItemHaveStock = db.checkStockAcceptAll(user.getWareHouseId(), country);

            if(noOfItem != 0){
                if (noOfItem == noOfItemHaveStock) {
                    if (db.upadateOrderAcceptAll(user.getWareHouseId(), country) && db.processOrderAcceptAll(user.getWareHouseId(), country)) {
                        request.setAttribute("successMsg", "All orders from " + country + " has changed to Processing!");
                    } else {
                        request.setAttribute("errorMsg", "Fail to process orders from " + country + ".");
                    }
                } else {
                    request.setAttribute("errorMsg", "Not have enought stock to process the order. Please restock!");
                }
            } else {
                request.setAttribute("errorMsg", "No orders to process!");
            }

            orders = db.getWarehouseOrderSource(user.getWareHouseId());
            ArrayList<TotalQtyBean> hk = db.getTotalQtyByCountry(user.getWareHouseId(), "HK", "Pending");
            ArrayList<TotalQtyBean> jp = db.getTotalQtyByCountry(user.getWareHouseId(), "jp", "Pending");
            ArrayList<TotalQtyBean> us = db.getTotalQtyByCountry(user.getWareHouseId(), "us", "Pending");

            request.setAttribute("TotalQtyHK", hk);
            request.setAttribute("TotalQtyJP", jp);
            request.setAttribute("TotalQtyUS", us);
            
            total = 0;
            pending = 0;
            processing = 0;
            finished = 0;
            for (OrderBean od : orders) {
                if (od.getStatus().equals("Pending")) {
                    pending++;
                } else if (od.getStatus().equals("Finished")) {
                    finished++;
                } else if (od.getStatus().equals("Processing")) {
                    processing++;
                }
                total++;
            }

            sb.setTotal(Integer.toString(total));
            sb.setPending(Integer.toString(pending));
            sb.setProcessing(Integer.toString(processing));
            sb.setFinished(Integer.toString(finished));
            request.setAttribute("StatusBean", sb);

            request.setAttribute("orderList", orders);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/warehouse/order.jsp");
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
