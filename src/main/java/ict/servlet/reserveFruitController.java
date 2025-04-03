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
        ArrayList<CountryRegionBean> countryRegionList = db.getAllCountryRegion();
        request.setAttribute("countryRegionList", countryRegionList);

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
