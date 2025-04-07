/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet;

import jakarta.servlet.*;
import java.io.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import ict.db.*;
import ict.bean.*;
import java.util.*;
import java.time.LocalDate;

/**
 *
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

        // country region list is need in every action for selection box
        ArrayList<CountryRegionBean> countryRegionList = db.getFruitCountryRegion();
        request.setAttribute("countryRegionList", countryRegionList);
        ArrayList<String> fruitTypeList = db.getFruitType();
        request.setAttribute("fruitTypeList", fruitTypeList);

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
            HttpSession session = request.getSession(false);
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

                UserBean user = (UserBean) session.getAttribute("userInfo");
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
                out.println("<p>Reserve successfully!</p>");
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
