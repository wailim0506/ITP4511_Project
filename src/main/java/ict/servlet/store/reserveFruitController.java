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
import java.time.LocalDate;

/**
 * @author wailim0506
 */
@WebServlet(name = "reserveFruitServlet", urlPatterns = { "/reserveFruit" })
public class reserveFruitController extends HttpServlet {

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

        // country region list is need in every action for selection box
        ArrayList<CountryRegionBean> countryRegionList = db.getFruitCountryRegion();
        request.setAttribute("countryRegionList", countryRegionList);
        ArrayList<String> fruitTypeList = db.getFruitType();
        request.setAttribute("fruitTypeList", fruitTypeList);

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

        // get today month
        LocalDate today = LocalDate.now();
        String todayMonth = String.valueOf(today.getMonthValue());
        // get today date
        String todayDate = String.valueOf(today.getDayOfMonth());
        String cutOffDateStart;
        String cutOffDateEnd;
        if (Integer.parseInt(todayDate) <= 14) {
            cutOffDateStart = today.getYear() + "-" + todayMonth + "-01";
            cutOffDateEnd = today.getYear() + "-" + todayMonth + "-14";
        } else {
            cutOffDateStart = today.getYear() + "-" + todayMonth + "-15";
            cutOffDateEnd = today.getYear() + "-" + todayMonth + "-"
                    + lastDateOfMonth.get(todayMonth);
        }

        boolean haveOrder = db.checkOrderWithinCutOff(user.getShopId(), cutOffDateStart, cutOffDateEnd);
        if (haveOrder) {
            request.setAttribute("haveOrder", true);
            request.setAttribute("cutOffDate", cutOffDateEnd);
            request.setAttribute("orderMadeWithinDate",
                    db.getOrderByDate(user.getShopId(), cutOffDateStart, cutOffDateEnd));
        } else {
            request.setAttribute("haveOrder", false);
        }

        String action = request.getParameter("action");
        if ("listAll".equalsIgnoreCase(action)) {
            ArrayList<FruitsBean> fruitsList = db.getAllFruit();
            request.setAttribute("fruitsList", fruitsList);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/reserveFruit.jsp");
            rd.forward(request, response);
        } else if ("listByCountryRegion".equalsIgnoreCase(action)) {
            String id = request.getParameter("cr");
            ArrayList<FruitsBean> fruitsList = db.getFruitsByCountryRegion(id);
            request.setAttribute("fruitsList", fruitsList);
            request.setAttribute("selectedCountryRegionId", id);

            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/reserveFruit.jsp");
            rd.forward(request, response);
        } else if ("listByType".equalsIgnoreCase(action)) {
            String type = request.getParameter("type");
            ArrayList<FruitsBean> fruitsList = db.getFruitsByType(type);
            request.setAttribute("fruitsList", fruitsList);
            request.setAttribute("selectedCountryRegionId", "all");
            request.setAttribute("selectedType", type);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/reserveFruit.jsp");
            rd.forward(request, response);
        } else if ("listByBoth".equalsIgnoreCase(action)) {
            String id = request.getParameter("cr");
            String type = request.getParameter("type");
            ArrayList<FruitsBean> fruitsList = db.getFruitsByCountryAndType(id, type);
            request.setAttribute("fruitsList", fruitsList);
            request.setAttribute("selectedCountryRegionId", id);
            request.setAttribute("selectedType", type);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/store/reserveFruit.jsp");
            rd.forward(request, response);
        } else if ("submit".equalsIgnoreCase(action)) {
            session = request.getSession(false);
            ArrayList<String> allFruitID = db.getAllFruitID();
            ArrayList<String> selectedFruitID = new ArrayList<String>();
            ArrayList<String> selectedFruitQty = new ArrayList<String>();
            String notes = request.getParameter("notes");
            try {
                for (int i = 0; i < allFruitID.size(); i++) {
                    String selected = request.getParameter(allFruitID.get(i));
                    if (selected != null && !selected.equals("0")) {
                        selectedFruitID.add(allFruitID.get(i));
                        selectedFruitQty.add(selected);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (selectedFruitID.size() == 0) {
                session.setAttribute("errorMsg", "Please select at least one fruit to reserve.");
                response.sendRedirect(request.getContextPath() + "/reserveFruit?action=listAll");
            } else { // create order
                int currentNumberOfOrder = Integer.parseInt(db.getNumberOfOrder());
                String newOrderId = "O";
                if (currentNumberOfOrder == 0) {
                    newOrderId += "0001";
                } else {
                    currentNumberOfOrder++;
                    String orderId = String.valueOf(currentNumberOfOrder);
                    int length = orderId.length();
                    for (int i = 0; i < 4 - length; i++) {
                        newOrderId += "0";
                    }
                    newOrderId += orderId;
                }

                user = (UserBean) session.getAttribute("userInfo");
                if (db.createOrder(newOrderId, user.getShopId(), String.valueOf(LocalDate.now()),
                        notes)) {
                    for (int i = 0; i < selectedFruitID.size(); i++) {
                        if (db.insertOrderItem(newOrderId, selectedFruitID.get(i),
                                Integer.parseInt(selectedFruitQty.get(i)))) {
                            continue;
                        } else {
                            session.setAttribute("errorMsg", "Please try again.");
                            response.sendRedirect(request.getContextPath() + "/reserveFruit?action=listAll");
                            return;
                        }
                    }
                } else {
                    session.setAttribute("errorMsg", "Please try again.");
                    response.sendRedirect(request.getContextPath() + "/reserveFruit?action=listAll");
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/rfcp?oid=" + newOrderId);
            }

        } else if ("modifyOrder".equalsIgnoreCase(action)) {
            String orderId = request.getParameter("oid");
            ArrayList<OrderBean> orderItemList = db.getOrderItemById(orderId);
            ArrayList<String> orderItemID = new ArrayList<String>();
            ArrayList<String> newOrderItemQty = new ArrayList<String>();
            ArrayList<String> deleteItemID = new ArrayList<String>();
            ArrayList<String> toRemove = new ArrayList<>();
            ArrayList<String> newItemId = new ArrayList<>();
            ArrayList<String> newItemQty = new ArrayList<>();
            ArrayList<String> allId = db.getAllFruitID();
            for (int i = 0; i < orderItemList.size(); i++) {
                orderItemID.add(orderItemList.get(i).getFruidId());
                allId.remove(orderItemList.get(i).getFruidId());
            }

            for (int i = 0; i < allId.size(); i++) {
                String selected = request.getParameter(allId.get(i));
                if (selected != null && !selected.equals("0")) {
                    newItemId.add(allId.get(i));
                    newItemQty.add(selected);
                }
            }

            for (int i = 0; i < orderItemID.size(); i++) {
                String fruitId = orderItemID.get(i);
                String qty = request.getParameter(fruitId);
                if (qty == null || qty.trim().isEmpty()) {
                    deleteItemID.add(fruitId);
                    toRemove.add(fruitId);
                } else {
                    newOrderItemQty.add(qty);
                }
            }
            orderItemID.removeAll(toRemove);

            boolean UpdateQtyresult = false;
            boolean deleteItemResult = false;
            boolean insertItemResult = false;
            for (int i = 0; i < newItemId.size(); i++) {
                insertItemResult = db.insertOrderItem(orderId, newItemId.get(i),
                        Integer.parseInt(newItemQty.get(i)));
                if (!insertItemResult) {
                    break;
                }
            }

            if (newItemId.size() <= 0) {
                insertItemResult = true;
            }

            for (int i = 0; i < newOrderItemQty.size(); i++) {
                UpdateQtyresult = db.updateOrderItemQty(orderId, orderItemID.get(i),
                        Integer.parseInt(newOrderItemQty.get(i)));
                if (!UpdateQtyresult) {
                    break;
                }
            }

            if (newOrderItemQty.size() <= 0) {
                UpdateQtyresult = true;
            }

            for (int i = 0; i < deleteItemID.size(); i++) {
                deleteItemResult = db.deleteOrderItem(orderId, deleteItemID.get(i));
                if (!deleteItemResult) {
                    break;
                }
            }

            if (deleteItemID.size() <= 0) {
                deleteItemResult = true;
            }

            if (!UpdateQtyresult || !deleteItemResult || !insertItemResult) {
                session.setAttribute("errorMsg", "Please try again.");
                response.sendRedirect(request.getContextPath() +
                        "/reserveRecord?action=listAll");
                return;
            } else {
                session.setAttribute("successMsg", "Order Edited successfully.");
                response.sendRedirect(request.getContextPath() +
                        "/reserveRecord?action=listAll");
                return;
            }
        } else if ("changeToFinish".equalsIgnoreCase(action)) {
            String orderId = request.getParameter("Id");
            String shopIdString = request.getParameter("shopId");
            if (db.changeOrderStatusToFinish(orderId)) {
                ArrayList<OrderBean> orderItemList = db.getOrderItemById(orderId);
                for (int i = 0; i < orderItemList.size(); i++) {
                    int OriginalQty = db.getShopFruitStockQty(shopIdString,
                            orderItemList.get(i).getFruidId());
                    int newQty = OriginalQty + orderItemList.get(i).getQty();
                    if (db.updateShopFruitStock(shopIdString, orderItemList.get(i).getFruidId(), newQty)) {
                        continue;
                    } else {
                        session.setAttribute("errorMsg", "Please try again. Stock still not updated.");
                        response.sendRedirect(request.getContextPath() + "/reserveRecord?action=listAll");
                        return;
                    }
                }
                session.setAttribute("successMsg", "Order Status Changed Successfully.");
                response.sendRedirect(request.getContextPath() + "/reserveRecord?action=listAll");
            } else {
                session.setAttribute("errorMsg", "Please try again. Stock still not updated.");
                response.sendRedirect(request.getContextPath() + "/reserveRecord?action=listAll");
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
