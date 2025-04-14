/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.store;

import jakarta.persistence.criteria.Order;
import jakarta.servlet.*;

import java.io.*;

import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import ict.db.*;
import ict.bean.*;

import java.util.*;

/**
 * @author wailim0506
 */
@WebServlet(name = "reserveRecord", urlPatterns = { "/reserveRecord" })
public class reserveRecordController extends HttpServlet {
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

        HashMap<String, Integer> lastDateOfMonth = new HashMap<>();
        lastDateOfMonth.put("1", 31);
        lastDateOfMonth.put("2", 28);
        lastDateOfMonth.put("3", 31);
        lastDateOfMonth.put("4", 30);
        lastDateOfMonth.put("5", 31);
        lastDateOfMonth.put("6", 30);
        lastDateOfMonth.put("7", 31);
        lastDateOfMonth.put("8", 31);
        lastDateOfMonth.put("9", 30);
        lastDateOfMonth.put("10", 31);
        lastDateOfMonth.put("11", 30);
        lastDateOfMonth.put("12", 31);

        String action = request.getParameter("action");
        ArrayList<OrderBean> orderList = new ArrayList<OrderBean>();
        ArrayList<Integer> orderItemQtyList = new ArrayList<>();
        ArrayList<String> orderCutOffDateList = new ArrayList<>();
        ArrayList<ArrayList<OrderBean>> orderItemList = new ArrayList<ArrayList<OrderBean>>();
        if ("listAll".equalsIgnoreCase(action)) {
            orderList = db.getAllOrder(user.getShopId());
            threeForLoop(orderList, orderItemQtyList, orderCutOffDateList, orderItemList, lastDateOfMonth);
        } else if ("listByDateRange".equalsIgnoreCase(action)) {
            orderList = db.getOrderByDateRange(user.getShopId(), request.getParameter("dateRange"));
            threeForLoop(orderList, orderItemQtyList, orderCutOffDateList, orderItemList, lastDateOfMonth);
            request.setAttribute("selectedDateRange", request.getParameter("dateRange"));
        } else if ("listByStatus".equalsIgnoreCase(action)) {
            orderList = db.getOrderByStatus(user.getShopId(), request.getParameter("status"));
            threeForLoop(orderList, orderItemQtyList, orderCutOffDateList, orderItemList, lastDateOfMonth);
            request.setAttribute("selectedStatus", request.getParameter("status"));
        } else if ("listByBoth".equalsIgnoreCase(action)) {
            orderList = db.getOrderByStatusAndDateRange(user.getShopId(), request.getParameter("dateRange"),
                    request.getParameter("status"));
            threeForLoop(orderList, orderItemQtyList, orderCutOffDateList, orderItemList, lastDateOfMonth);
            request.setAttribute("selectedDateRange", request.getParameter("dateRange"));
            request.setAttribute("selectedStatus", request.getParameter("status"));
        } else {
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }

        request.setAttribute("fruitsList", db.getAllFruit()); // for add fruit
        request.setAttribute("orderList", orderList);
        request.setAttribute("orderItemQtyList", orderItemQtyList);
        request.setAttribute("orderCutOffDateList", orderCutOffDateList);
        request.setAttribute("orderItemList", orderItemList);

        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/store/reserveRecord.jsp");
        rd.forward(request, response);
    }

    public void threeForLoop(ArrayList<OrderBean> orderList, ArrayList<Integer> orderItemQtyList,
            ArrayList<String> orderCutOffDateList, ArrayList<ArrayList<OrderBean>> orderItemList,
            HashMap<String, Integer> lastDateOfMonth) {
        for (int i = 0; i < orderList.size(); i++) {
            OrderBean ob = orderList.get(i);
            orderItemQtyList.add(db.getOrderItemQty(ob.getId()));
        }

        for (int i = 0; i < orderList.size(); i++) {
            OrderBean ob = orderList.get(i);
            String orderDate = ob.getOrderDate();
            String[] split = orderDate.split("-");
            int orderMonth = Integer.parseInt(split[1]);
            int orderYear = Integer.parseInt(split[0]);
            int orderDate2 = Integer.parseInt(split[2]);
            String cutOffDate;

            if (orderDate2 <= 14) {
                cutOffDate = orderYear + "-" + orderMonth + "-14";
            } else {
                cutOffDate = orderYear + "-" + orderMonth + "-"
                        + lastDateOfMonth.get(String.valueOf(orderMonth));
            }
            orderCutOffDateList.add(cutOffDate);
        }

        for (int i = 0; i < orderList.size(); i++) {
            OrderBean ob = orderList.get(i);
            orderItemList.add(db.getOrderItemById(ob.getId()));
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
