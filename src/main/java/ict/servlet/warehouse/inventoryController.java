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
import java.util.*;

/**
 *
 * @author HwH
 */
@WebServlet(name = "inventoryController", urlPatterns = {"/inventory"})
public class inventoryController extends HttpServlet {

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

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        ArrayList<WarehouseFruitStockBean> warehouseStockList = db.getWarehouseFruitStock(user.getWareHouseId());
        request.setAttribute("warehouseStockList", warehouseStockList);

        int lowStock = 0, totalFruit = 0, outOfStock = 0;

        for (WarehouseFruitStockBean fruit : warehouseStockList) {
            if (Integer.parseInt(fruit.getQty()) <= 10) {
                lowStock++;
            }
            if (Integer.parseInt(fruit.getQty()) <= 0) {
                outOfStock++;
            }
            totalFruit++;
        }

        StatusBean sb = new StatusBean();
        sb.setLowStock(Integer.toString(lowStock));
        sb.setTotalFruits(Integer.toString(totalFruit));
        sb.setOutOfStock(Integer.toString(outOfStock));
        request.setAttribute("StatusBean", sb);
        
        ArrayList<CountryRegionBean> countryRegionList = db.getFruitCountryRegion();
        request.setAttribute("countryRegionList", countryRegionList);
        ArrayList<String> fruitTypeList = db.getFruitType();
        request.setAttribute("fruitTypeList", fruitTypeList);

        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<ShopFruitStockBean> fruitsStockList = db.getWarehouseStock(user.getWareHouseId());
            request.setAttribute("fruitsStockList", fruitsStockList);

            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/warehouse/inventory.jsp");
            rd.forward(request, response);
        }

    }

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
