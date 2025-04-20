/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.store;

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
@WebServlet(name = "stockController", urlPatterns = { "/stock" })
public class stockController extends HttpServlet {

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
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        UserBean user = (UserBean) session.getAttribute("userInfo");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        ArrayList<CountryRegionBean> countryRegionList = db.getFruitCountryRegion();
        request.setAttribute("countryRegionList", countryRegionList);
        ArrayList<String> fruitTypeList = db.getFruitType();
        request.setAttribute("fruitTypeList", fruitTypeList);

        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<ShopFruitStockBean> fruitsStockList = db.getShopFruitStock(user.getShopId());
            request.setAttribute("fruitsStockList", fruitsStockList);

            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/stock.jsp");
            rd.forward(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            String shopId = request.getParameter("shopId");
            ArrayList<String> fruitIdList = db.getAllFruitID();
            ArrayList<String> fruitQtyToStoreInDb = new ArrayList<String>();
            for (int i = 0; i < fruitIdList.size(); i++) {
                String fruitId = fruitIdList.get(i);
                String fruitQty = request.getParameter(fruitId);
                if (fruitQty != null && !fruitQty.isEmpty()) {
                    fruitQtyToStoreInDb.add(fruitQty);
                } else {
                    fruitQtyToStoreInDb.add("0");
                }
            }

            for (int i = 0; i < fruitQtyToStoreInDb.size(); i++) {
                String fruitId = fruitIdList.get(i);
                String fruitQty = fruitQtyToStoreInDb.get(i);
                if (db.updateShopFruitStock(shopId, fruitId, Integer.parseInt(fruitQty))) {
                    continue;
                } else {
                    session.setAttribute("errorMsg", "Update failed! Please try again.");
                    response.sendRedirect(request.getContextPath() +
                            "/stock?action=list");
                    return;
                }
            }

            session.setAttribute("successMsg", "Stock Level Updated successfully!");
            response.sendRedirect(request.getContextPath() +
                    "/stock?action=list");

        } else {
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }
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
