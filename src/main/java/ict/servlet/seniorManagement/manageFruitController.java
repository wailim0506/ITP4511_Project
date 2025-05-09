/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet.seniorManagement;

import ict.bean.CountryRegionBean;
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
import java.util.ArrayList;

/**
 *
 * @author 19647
 */
@WebServlet(name = "manageFruitController", urlPatterns = {"/manageFruit"})
public class manageFruitController extends HttpServlet {

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

        ArrayList<CountryRegionBean> countryRegionList = db.getFruitCountryRegion();
        ArrayList<CountryRegionBean> allCountryRegionList = db.getAllCountryRegion();
        ArrayList<String> fruitTypeList = db.getFruitType();
        ArrayList<FruitCityBean> fruitCity = db.getFruitCity();
        
        request.setAttribute("countryRegionList", countryRegionList);
        request.setAttribute("allCountryRegionList", allCountryRegionList);
        request.setAttribute("fruitTypeList", fruitTypeList);
        request.setAttribute("fruitCity", fruitCity);

        String totalFruit, enableFruit, disableFruit;
        totalFruit = db.getAllFruitCount();
        enableFruit = db.getAllFruitCountEnable();
        disableFruit = db.getAllFruitCountDisable();

        ArrayList<FruitsBean> fbList = db.getAllFruitManager();
        request.setAttribute("isEditMode", false);
        request.setAttribute("isAddFruit", false);
        request.setAttribute("isAddSource", false);

        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            String fruitId = request.getParameter("fruitID");
            FruitsBean fb = db.getFruitById(fruitId);
            request.setAttribute("fruitsBean", fb);
            request.setAttribute("isEditMode", true);
        } else if (action != null && (action.equals("Enable") || action.equals("Disable"))) {
            String fruitId = request.getParameter("fruitID");
            String fruitStatus = action.equals("Enable") ? "enable" : "disable";

            if (action.equals("Disable")) {

                if (db.updateFruitStatusById(fruitId, fruitStatus)) {
                    db.updateFruitDisableShopStock(fruitId);
                    db.updateFruitDisableWarehouseStock(fruitId);
                    db.updateFruitDisableOrder(fruitId);
                    db.updateFruitDisableBorrow(fruitId);
                    session.setAttribute("successMsg", "Update fruitID: " + fruitId + " status successful!");
                } else {
                    session.setAttribute("errorMsg", "Update fruitID: " + fruitId + " status failed! Please try again.");
                }
            } else {
                if (db.updateFruitStatusById(fruitId, fruitStatus)) {
                    session.setAttribute("successMsg", "Update fruitID: " + fruitId + " status successful!");
                } else {
                    session.setAttribute("errorMsg", "Update fruitID: " + fruitId + " status failed! Please try again.");
                }
            }

            totalFruit = db.getAllFruitCount();
            enableFruit = db.getAllFruitCountEnable();
            disableFruit = db.getAllFruitCountDisable();
            fbList = db.getAllFruitManager();
        } else if (action != null && action.equals("addFruit")) {
            String newFruitID = db.getNewFruitID();
            
            request.setAttribute("newFruitID", newFruitID);
            request.setAttribute("isAddFruit", true);
        } else if (action != null && action.equals("addSource")) {
            String newWarehouseID = db.getNewWarehouseID();
            
            request.setAttribute("newWarehouseID", newWarehouseID);
            request.setAttribute("isAddSource", true);
        }

        request.setAttribute("fruitsStockList", fbList);
        request.setAttribute("totalFruit", totalFruit);
        request.setAttribute("enableFruit", enableFruit);
        request.setAttribute("disableFruit", disableFruit);
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/seniorManagement/manageFruit.jsp");

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
        HttpSession session = request.getSession(false);
        UserBean user = (UserBean) session.getAttribute("userInfo");

        String formAction = request.getParameter("formAction");
        if (formAction.equals("change")) {
            String fruitId = request.getParameter("editFruitId");
            String name = request.getParameter("editName");
            String type = request.getParameter("editType");
            String unit = request.getParameter("editUnit");
            String imgName = request.getParameter("editImg");

            if (db.updateFruitById(fruitId, name, type, unit, imgName)) {
                session.setAttribute("successMsg", "Update fruitID: " + fruitId + " successful! Please try again.");
            } else {
                session.setAttribute("errorMsg", "Update fruitID: " + fruitId + " failed! Please try again.");
            }

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
