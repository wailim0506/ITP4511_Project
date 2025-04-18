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
 * @author wailim0506
 */
@WebServlet(name = "borrowRecord", urlPatterns = { "/borrowRecord" })
public class borrowRecordController extends HttpServlet {
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
        ArrayList<BorrowBean> borrowList = new ArrayList<BorrowBean>();
        ArrayList<Integer> borrowItemQtyList = new ArrayList<>();
        ArrayList<ArrayList<BorrowBean>> borrowItemList = new ArrayList<ArrayList<BorrowBean>>();
        if ("listAll".equalsIgnoreCase(action)) {
            borrowList = db.getAllBorrow(user.getShopId());
            twoForLoop(borrowList, borrowItemQtyList, borrowItemList);
        } else if ("listByDateRange".equalsIgnoreCase(action)) {
            borrowList = db.getBorrowByDateRange(user.getShopId(), request.getParameter("dateRange"));
            twoForLoop(borrowList, borrowItemQtyList, borrowItemList);
            request.setAttribute("selectedDateRange", request.getParameter("dateRange"));
        } else if ("listByStatus".equalsIgnoreCase(action)) {
            borrowList = db.getBorrowByStatus(user.getShopId(), request.getParameter("status"));
            twoForLoop(borrowList, borrowItemQtyList, borrowItemList);
            request.setAttribute("selectedStatus", request.getParameter("status"));
        } else if ("listByBoth".equalsIgnoreCase(action)) {
            borrowList = db.getBorrowByStatusAndDateRange(user.getShopId(), request.getParameter("dateRange"),
                    request.getParameter("status"));
            twoForLoop(borrowList, borrowItemQtyList, borrowItemList);
            request.setAttribute("selectedDateRange", request.getParameter("dateRange"));
            request.setAttribute("selectedStatus", request.getParameter("status"));
        } else {
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }

        request.setAttribute("orderList", borrowList);
        request.setAttribute("orderItemQtyList", borrowItemQtyList);
        request.setAttribute("orderItemList", borrowItemList);

        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/store/borrowRecord.jsp");
        rd.forward(request, response);
    }

    public void twoForLoop(ArrayList<BorrowBean> borrowList, ArrayList<Integer> borrowItemQtyList,
            ArrayList<ArrayList<BorrowBean>> borrowItemList) {
        for (int i = 0; i < borrowList.size(); i++) {
            BorrowBean ob = borrowList.get(i);
            borrowItemQtyList.add(db.getBorrowItemQty(ob.getId()));
        }

        for (int i = 0; i < borrowList.size(); i++) {
            BorrowBean ob = borrowList.get(i);
            borrowItemList.add(db.getBorrowItemById(ob.getId()));
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
