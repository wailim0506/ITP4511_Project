/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.seniorManagement;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.*;

import java.io.*;
import java.time.LocalDate;

import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import ict.db.*;
import ict.bean.*;

import java.util.*;

/**
 *
 * @author wailim0506
 */
@WebServlet(name = "reserveNeedController", urlPatterns = { "/reserveNeed" })
public class reserveNeedController extends HttpServlet {

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

        String viewLevel = request.getParameter("viewLevel");
        String startDate = "";
        String endDate = "";
        String date = request.getParameter("date");

        // Date range processing - same for all view levels
        if (date != null) {
            if (date.equals("thisMonth")) {
                startDate = LocalDate.now().withDayOfMonth(1).toString();
                endDate = LocalDate.now().toString();
            } else if (date.equals("lastMonth")) {
                startDate = LocalDate.now().minusMonths(1).withDayOfMonth(1).toString();
                endDate = LocalDate.now().minusMonths(1).withDayOfMonth(LocalDate.now().minusMonths(1).lengthOfMonth())
                        .toString();
            } else if (date.equals("last3Months")) {
                startDate = LocalDate.now().minusMonths(3).withDayOfMonth(1).toString();
                endDate = LocalDate.now().toString();
            } else if (date.equals("last6Months")) {
                startDate = LocalDate.now().minusMonths(6).withDayOfMonth(1).toString();
                endDate = LocalDate.now().toString();
            } else if (date.equals("last12Months")) {
                startDate = LocalDate.now().minusMonths(12).withDayOfMonth(1).toString();
                endDate = LocalDate.now().toString();
            }
        }
        if ("c".equalsIgnoreCase(viewLevel)) {
            String countryName = request.getParameter("cn");
            ArrayList<ReserveNeedBean> countryData = db.getResreveNeedByCountryRegion(countryName, startDate, endDate);
            request.setAttribute("reserveNeedList", countryData);
            request.setAttribute("countryName", countryName);
            request.setAttribute("date", date);
            request.setAttribute("viewLevel", "c");
        } else if ("city".equalsIgnoreCase(viewLevel)) {
            String city = request.getParameter("city");
            ArrayList<ReserveNeedBean> cityData = db.getResreveNeedByCity(city, startDate, endDate);
            request.setAttribute("reserveNeedList2", cityData);
            request.setAttribute("cityName", city);
            request.setAttribute("date", date);
            request.setAttribute("viewLevel", "city");
        } else if ("shop".equalsIgnoreCase(viewLevel)) {
            String shop = request.getParameter("shop");
            ArrayList<ReserveNeedBean> shopData = db.getResreveNeedByShop(shop, startDate, endDate);
            request.setAttribute("reserveNeedList3", shopData);
            request.setAttribute("shopAddress", shop);
            request.setAttribute("date", date);
            request.setAttribute("viewLevel", "shop");
        } else {
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
            return;
        }

        ArrayList<String> cityList = db.getAllShopCity();
        request.setAttribute("cityList", cityList);
        ArrayList<String> shopList = db.getAllShopAddress();
        request.setAttribute("shopList", shopList);
        request.setAttribute("total", db.getTotalReserveNumber());
        request.setAttribute("totalFruit", db.getTotalFruitOrdered());
        request.setAttribute("top5", db.getTopFive());
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/seniorManagement/reserveNeed.jsp");
        rd.forward(request, response);
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
