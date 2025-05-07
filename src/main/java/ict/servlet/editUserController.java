/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet;

import ict.db.ProjectDB;
import ict.bean.*;
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
 * @author wailim0506
 */
@WebServlet(name = "editUserController", urlPatterns = { "/editUser" })
public class editUserController extends HttpServlet {

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

        ArrayList<String> warehouseIdList = db.getAllWarehouseId();
        warehouseIdList.sort(Comparator.comparing(String::toString));
        request.setAttribute("warehouseIdList", warehouseIdList);

        ArrayList<ShopBean> shopList = db.getAllShop();
        shopList.sort(Comparator.comparing(ShopBean::getID));
        ArrayList<String> shopIdList = new ArrayList<>();
        for (ShopBean shop : shopList) {
            shopIdList.add(shop.getID());
        }
        request.setAttribute("shopIdList", shopIdList);

        String action = request.getParameter("action");
        if (action.equals("list")) {
            String id = request.getParameter("id");
            UserBean userInfo = (UserBean) db.getUserDetailForEdit(id);
            request.setAttribute("userInfo", userInfo);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/page/editUser.jsp");
            rd.forward(request, response);
        } else if (action.equals("edit")) {
            String userIdToBeEdit = request.getParameter("userIdToBeEdit");
            String placeType = request.getParameter("placeType");
            String placeId = request.getParameter("placeId");
            String staffName = request.getParameter("staffName");
            String roleString = request.getParameter("role");

            if (placeType.equals("warehouse")) {
                String staffId = db.getWarehouseStaffIdByUserId(userIdToBeEdit);
                if (staffId != null) {
                    if (db.updateWarehouseStaff(staffId, staffName, roleString, placeId)) {
                        session.setAttribute("successMsg", "Update successful");
                        response.sendRedirect(request.getContextPath() + "/userList");
                        return;
                    } else {
                        session.setAttribute("errorMsg", "Update failed");
                        response.sendRedirect(request.getContextPath() + "/userList");
                        return;
                    }
                } else {
                    session.setAttribute("errorMsg", "Update failed");
                    response.sendRedirect(request.getContextPath() + "/userList");
                    return;
                }

            } else if (placeType.equals("shop")) {
                String staffId = db.getShopStaffIdByUserId(userIdToBeEdit);
                if (staffId != null) {
                    if (db.updateShopStaff(staffId, staffName, roleString, placeId)) {
                        session.setAttribute("successMsg", "Update successful");
                        response.sendRedirect(request.getContextPath() + "/userList");
                        return;
                    } else {
                        session.setAttribute("errorMsg", "Update failed");
                        response.sendRedirect(request.getContextPath() + "/userList");
                        return;
                    }
                } else {
                    session.setAttribute("errorMsg", "Update failed");
                    response.sendRedirect(request.getContextPath() + "/userList");
                    return;
                }
            }
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
