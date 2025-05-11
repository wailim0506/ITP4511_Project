/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.seniorManagement;

import ict.bean.*;
import ict.db.ProjectDB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        
        if(!requested){
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
        
        if(country != null && city == null && shop.isBlank()){      //country or region
            requested = true;
            cbList = db.getTotalConsumptionByRegion(country); 
        } else if (country == null && city != null && shop.isBlank()){      //city
            requested = true;
            cbList = db.getTotalConsumptionByCity(city);
        } else if (country == null && city == null && !shop.isBlank()){     //shop
            if(db.checkShop(shop)){
                requested = true;
                cbList = db.getTotalConsumptionByShop(shop);
            } else {
                session.setAttribute("errorMsg", "Shop not found! Please try again.");
            }
        } else if(country == null && city == null && shop.isBlank()){       //not select
            requested = false;
            session.setAttribute("errorMsg", "Filter not selected! Please try again.");
        } else {        //select more than one
            requested = false;
            session.setAttribute("errorMsg", "Can only select one condition at once! Please try again.");
        }
        processRequest(request, response);
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
