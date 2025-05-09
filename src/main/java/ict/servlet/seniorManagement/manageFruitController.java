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
        request.setAttribute("countryRegionList", countryRegionList);
        ArrayList<String> fruitTypeList = db.getFruitType();
        request.setAttribute("fruitTypeList", fruitTypeList);
        
        String totalFruit;
        totalFruit = db.getAllFruitCount();

        ArrayList<FruitsBean> fbList = db.getAllFruitManager();
        request.setAttribute("fruitsStockList", fbList);
        request.setAttribute("isEditMode", false);
        
        try{
            String action = request.getParameter("action");
            if(action.equals("edit")){
                String fruitId = request.getParameter("fruitID");
                FruitsBean fb = db.getFruitById(fruitId);
                request.setAttribute("fruitsBean", fb);
                request.setAttribute("isEditMode",true);
            }
        }catch (Exception e){
        
        }
        
        
        request.setAttribute("totalFruit", totalFruit);
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
