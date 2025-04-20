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
@WebServlet(name = "borrowRequestController", urlPatterns = { "/borrowRequest" })
public class borrowRequestController extends HttpServlet {

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
        if ("all".equalsIgnoreCase(action)) {
            ArrayList<ShopFruitStockBean> stockList = db.getShopFruitStock(user.getShopId());
            String pendingNumIn30Day = db.getPendingStatistics(user.getShopId());
            String approvedNumIn30Day = db.getApprovedStatistics(user.getShopId());
            String rejectedNumIn30Day = db.getRejectedStatistics(user.getShopId());

            ArrayList<BorrowBean> pendingBorrowRequestList = db.getBorrowByStatusForHandleRequest(user.getShopId(),
                    "Pending");
            ArrayList<ArrayList<BorrowBean>> pendingBorrowRequestItemList = new ArrayList<>();
            for (int i = 0; i < pendingBorrowRequestList.size(); i++) {
                BorrowBean borrow = pendingBorrowRequestList.get(i);
                ArrayList<BorrowBean> borrowItemList = db.getBorrowItemById(borrow.getId());
                pendingBorrowRequestItemList.add(borrowItemList);

            }

            ArrayList<BorrowBean> approvedBorrowRequestList = db.getBorrowByStatusForHandleRequest(user.getShopId(),
                    "Approved");
            ArrayList<ArrayList<BorrowBean>> approvedBorrowRequestItemList = new ArrayList<>();
            for (int i = 0; i < approvedBorrowRequestList.size(); i++) {
                BorrowBean borrow = approvedBorrowRequestList.get(i);
                ArrayList<BorrowBean> borrowItemList = db.getBorrowItemById(borrow.getId());
                approvedBorrowRequestItemList.add(borrowItemList);

            }
            ArrayList<BorrowBean> rejectedBorrowRequestList = db.getBorrowByStatusForHandleRequest(user.getShopId(),
                    "Rejected");
            ArrayList<ArrayList<BorrowBean>> rejectedBorrowRequestItemList = new ArrayList<>();
            for (int i = 0; i < rejectedBorrowRequestList.size(); i++) {
                BorrowBean borrow = rejectedBorrowRequestList.get(i);
                ArrayList<BorrowBean> borrowItemList = db.getBorrowItemById(borrow.getId());
                rejectedBorrowRequestItemList.add(borrowItemList);

            }

            request.setAttribute("pendingNumIn30Day", pendingNumIn30Day);
            request.setAttribute("approvedNumIn30Day", approvedNumIn30Day);
            request.setAttribute("rejectedNumIn30Day", rejectedNumIn30Day);
            request.setAttribute("stockList", stockList);
            request.setAttribute("pendingBorrowRequestList", pendingBorrowRequestList);
            request.setAttribute("pendingBorrowRequestItemList", pendingBorrowRequestItemList);
            request.setAttribute("approvedBorrowRequestList", approvedBorrowRequestList);
            request.setAttribute("approvedBorrowRequestItemList", approvedBorrowRequestItemList);
            request.setAttribute("rejectedBorrowRequestList", rejectedBorrowRequestList);
            request.setAttribute("rejectedBorrowRequestItemList", rejectedBorrowRequestItemList);

            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/borrowRequest.jsp");
            rd.forward(request, response);
        } else if ("approve".equalsIgnoreCase(action)) {
            String requestId = request.getParameter("requestId");
            if (requestId == null || requestId.isEmpty()) {
                session.setAttribute("errorMsg", "Invalid borrow request ID. Please try again.");
                response.sendRedirect(request.getContextPath() +
                        "/borrowRequest?action=all");
                return;
            } else {
                if (db.updateBorrowRequestStatus(requestId, "Approved", "", "")) {
                    session.setAttribute("successMsg", "Borrow Request (ID: " + requestId + ") Approved.");
                    response.sendRedirect(request.getContextPath() +
                            "/borrowRequest?action=all");
                } else {
                    session.setAttribute("errorMsg", "Failed to approve borrow request. Please try again.");
                    response.sendRedirect(request.getContextPath() +
                            "/borrowRequest?action=all");
                }
            }
        } else if ("reject".equalsIgnoreCase(action)) {
            String requestId = request.getParameter("requestId");
            String reasonSelect = request.getParameter("rejectReasonSelect");
            String reasonText = request.getParameter("rejectReason");

            if (requestId == null || requestId.isEmpty()) {
                session.setAttribute("errorMsg", "Invalid borrow request ID. Please try again.");
                response.sendRedirect(request.getContextPath() +
                        "/borrowRequest?action=all");
                return;
            } else {
                if (db.updateBorrowRequestStatus(requestId, "Rejected", reasonSelect, reasonText)) {
                    session.setAttribute("successMsg", "Borrow Request (ID: " + requestId + ") Rejected.");
                    response.sendRedirect(request.getContextPath() +
                            "/borrowRequest?action=all");
                } else {
                    session.setAttribute("errorMsg", "Failed to reject borrow request. Please try again.");
                    response.sendRedirect(request.getContextPath() +
                            "/borrowRequest?action=all");
                }
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
