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
import java.time.LocalDate;

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
        } else if ("borrow".equalsIgnoreCase(action)) {
            ArrayList<String> allFruitID = db.getAllFruitID();
            ArrayList<String> selectedFruitID = new ArrayList<String>();
            ArrayList<String> selectedFruitQty = new ArrayList<String>();
            String shopIdString = request.getParameter("shopId");

            if (shopIdString == null || shopIdString.isEmpty()) {
                session.setAttribute("errorMsg", "Please select a shop to borrow from.");
                response.sendRedirect(request.getContextPath() + "/borrowFruit?action=select");
                return;
            }

            String notes = request.getParameter("notes");

            try {
                for (int i = 0; i < allFruitID.size(); i++) {
                    String selected = request.getParameter(shopIdString + "_" + allFruitID.get(i));
                    if (selected != null && !selected.equals("0")) {
                        selectedFruitID.add(allFruitID.get(i));
                        selectedFruitQty.add(selected);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // for (int i = 0; i < selectedFruitID.size(); i++) {
            // out.println("Selected Fruit ID: " + selectedFruitID.get(i));
            // out.println("Selected Fruit Quantity: " + selectedFruitQty.get(i));
            // }
            if (selectedFruitID.size() == 0) {
                session.setAttribute("errorMsg", "Please select at least one fruit to borrow.");
                response.sendRedirect(request.getContextPath()
                        + "/borrowFruit?action=select");
            } else { // create borrow request
                int currentNumberOfBorrowRequest = Integer.parseInt(db.getNumberOfBorrow());
                String newBorrowRequestId = "B";
                if (currentNumberOfBorrowRequest == 0) {
                    newBorrowRequestId += "001";
                } else {
                    currentNumberOfBorrowRequest++;
                    String requestId = String.valueOf(currentNumberOfBorrowRequest);
                    int length = requestId.length();
                    for (int i = 0; i < 3 - length; i++) {
                        newBorrowRequestId += "0";
                    }
                    newBorrowRequestId += requestId;
                }
                if (db.createBorrowRequest(newBorrowRequestId, user.getShopId(),
                        shopIdString,
                        String.valueOf(LocalDate.now()), notes)) {
                    for (int i = 0; i < selectedFruitID.size(); i++) {
                        if (db.insertBorrowItem(newBorrowRequestId, selectedFruitID.get(i),
                                Integer.parseInt(selectedFruitQty.get(i)))) {
                            continue;
                        } else {
                            session.setAttribute("errorMsg", "Please try again.");
                            response.sendRedirect(request.getContextPath() + "/borrowFruit?action=select");
                            return;
                        }
                    }
                } else {
                    session.setAttribute("errorMsg", "Please try again.");
                    response.sendRedirect(request.getContextPath() + "/borrowFruit?action=select");
                    return;
                }
                session.setAttribute("successMsg", "Borrow request created successfully.");
                response.sendRedirect(request.getContextPath() + "/borrowFruit?action=select");
                return;
            }
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
