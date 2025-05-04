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
import java.util.ArrayList;
import java.util.Comparator;
import ict.util.PasswordCrypto;

/**
 *
 * @author HwH
 */
@WebServlet(name = "userListController", urlPatterns = { "/userList" })
public class userListController extends HttpServlet {

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
        String userType = (String) session.getAttribute("userType");

        ArrayList<UserBean> userList = db.getAllUser(userType);
        request.setAttribute("userList", userList);

        ArrayList<ShopBean> shopList = db.getAllShop();
        shopList.sort(Comparator.comparing(ShopBean::getID));
        ArrayList<String> shopIdList = new ArrayList<>();
        for (ShopBean shop : shopList) {
            shopIdList.add(shop.getID());
        }
        request.setAttribute("shopIdList", shopIdList);

        ArrayList<String> warehouseIdList = db.getAllWarehouseId();
        warehouseIdList.sort(Comparator.comparing(String::toString));
        request.setAttribute("warehouseIdList", warehouseIdList);

        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                String userTypeForAdd = request.getParameter("userType");
                String userName = request.getParameter("userName");
                String staffName = request.getParameter("staffName");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String placeId = request.getParameter("placeId");

                int userCount = db.getUserCount();
                String newUserId = "U" + String.format("%03d", userCount + 1);
                PasswordCrypto.CryptoResult encryptedpassword = null;
                try {
                    encryptedpassword = PasswordCrypto.encrypt(password, newUserId);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (userTypeForAdd.equals("shop")) {
                    int newShopStaffId = db.getLastStaffId() + 1;
                    String newShopStaffIdString = newShopStaffId + "";
                    if (db.addNewUser(newUserId, userName, encryptedpassword.encryptedText)) {
                        if (db.addNewShopStaff(newShopStaffIdString, staffName, placeId, newUserId, role)) {
                            session.setAttribute("successMsg", "User added successfully!");
                            RequestDispatcher rd;
                            rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
                            rd.forward(request, response);
                            return;
                        } else {
                            session.setAttribute("errorMsg", "Failed to add user!");
                            RequestDispatcher rd;
                            rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
                            rd.forward(request, response);
                            return;
                        }
                    } else {
                        session.setAttribute("errorMsg", "Failed to add user!");
                        RequestDispatcher rd;
                        rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
                        rd.forward(request, response);
                        return;
                    }

                } else if (userTypeForAdd.equals("warehouse")) {
                    int newWarehouseStaffId = db.getLastWarehouseStaffId() + 1;
                    String newWarehouseStaffIdString = newWarehouseStaffId + "";
                    if (db.addNewUser(newUserId, userName, encryptedpassword.encryptedText)) {
                        if (db.addNewWarehouseStaff(newWarehouseStaffIdString, staffName, placeId, newUserId, role)) {
                            session.setAttribute("successMsg", "User added successfully!");
                            RequestDispatcher rd;
                            rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
                            rd.forward(request, response);
                            return;
                        } else {
                            session.setAttribute("errorMsg", "Failed to add user!");
                            RequestDispatcher rd;
                            rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
                            rd.forward(request, response);
                            return;
                        }
                    }
                }

                return;
            }
        }

        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/page/userList.jsp");
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
