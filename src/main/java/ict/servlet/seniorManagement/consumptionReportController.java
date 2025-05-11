/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.seniorManagement;

import ict.bean.*;
import ict.db.ProjectDB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 *
 * @author HwH
 */
@WebServlet(name = "consumptionReportController", urlPatterns = {"/consumption"})
public class consumptionReportController extends HttpServlet {

    private ProjectDB db;
    private boolean requested = false;
    ArrayList<ConsumptionBean> cbList;
    private String rangeFrom, rangeTo;

    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");
        db = new ProjectDB(dbUrl, dbUser, dbPassword);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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

        ArrayList<String> shopCityList = db.getAllShopCity();

        if (!requested) {
            cbList = db.getTotalConsumption();
        }
        request.setAttribute("cbList", cbList);
        request.setAttribute("shopCityList", shopCityList);
        requested = false;
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/seniorManagement/consumption.jsp");
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        requested = true;
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);

        String country = request.getParameter("countryRegion");
        String city = request.getParameter("city");
        String shop = request.getParameter("shop");
        String season = request.getParameter("season");

        if (season != null) {
            getSeasonDayRange(season);
            if (country != null && city == null && shop.isBlank()) {      //country or region
                requested = true;
                System.out.print(rangeFrom + rangeTo);
                cbList = db.getTotalConsumptionByRegion(country, rangeFrom, rangeTo);
            } else if (country == null && city != null && shop.isBlank()) {      //city
                requested = true;
                cbList = db.getTotalConsumptionByCity(city, rangeFrom, rangeTo);
            } else if (country == null && city == null && !shop.isBlank()) {     //shop
                if (db.checkShop(shop)) {
                    requested = true;
                    cbList = db.getTotalConsumptionByShop(shop, rangeFrom, rangeTo);
                } else {
                    session.setAttribute("errorMsg", "Shop not found! Please try again.");
                }
            } else if (country == null && city == null && shop.isBlank()) {       //not select
                requested = false;
                session.setAttribute("errorMsg", "Filter not selected! Please try again.");
            } else {        //select more than one
                requested = false;
                session.setAttribute("errorMsg", "Can only select one condition at once! Please try again.");
            }
        } else {
            session.setAttribute("errorMsg", "Please select a season! Please try again.");
        }

        processRequest(request, response);
    }

    private void getSeasonDayRange(String season) {
        season = season.toLowerCase().trim();
        int currentYear = LocalDate.now().getYear();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        switch (season) {
            case "spring":
                LocalDate springStart = LocalDate.of(currentYear, 3, 20);
                LocalDate springEnd = LocalDate.of(currentYear, 6, 20);
                rangeFrom = springStart.format(formatter);
                rangeTo = springEnd.format(formatter);
                break;
            case "summer":
                LocalDate summerStart = LocalDate.of(currentYear, 6, 21);
                LocalDate summerEnd = LocalDate.of(currentYear, 9, 22);
                rangeFrom = summerStart.format(formatter);
                rangeTo = summerEnd.format(formatter);
                break;
            case "autumn":
                LocalDate autumnStart = LocalDate.of(currentYear, 9, 23);
                LocalDate autumnEnd = LocalDate.of(currentYear, 12, 21);
                rangeFrom = autumnStart.format(formatter);
                rangeTo =autumnEnd.format(formatter);
                break;
            case "winter":
                LocalDate winterStart = LocalDate.of(currentYear, 12, 22);
                LocalDate winterEnd = LocalDate.of(currentYear + 1, 3, 19);
                rangeFrom = winterStart.format(formatter);
                rangeTo = winterEnd.format(formatter);
                break;
        }
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
