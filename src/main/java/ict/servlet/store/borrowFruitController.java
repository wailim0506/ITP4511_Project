/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.store;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import ict.bean.ShopBean;
import ict.bean.ShopFruitStockBean;
import ict.bean.UserBean;
import ict.db.ProjectDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Wai Lim Fung
 */
@WebServlet(name = "borrowFruitController", urlPatterns = { "/borrowFruit" })
public class borrowFruitController extends HttpServlet {

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

        String action = request.getParameter("action");
        if ("select".equalsIgnoreCase(action)) {
            ArrayList<ShopBean> shopList = db.getShopInSameCity(user.getShopCity(), user.getShopId());
            ArrayList<ArrayList<ShopFruitStockBean>> shopStockList = new ArrayList<ArrayList<ShopFruitStockBean>>();
            for (int i = 0; i < shopList.size(); i++) {
                ArrayList<ShopFruitStockBean> stockList = db.getShopFruitStock(shopList.get(i).getID());
                shopStockList.add(stockList);
            }
            request.setAttribute("shopList", shopList);
            request.setAttribute("shopStockList", shopStockList);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/borrowFruit.jsp");
            rd.forward(request, response);
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
