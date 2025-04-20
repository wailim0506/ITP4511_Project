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
import ict.util.*;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

    private ProjectDB db;

    public void init() {
        String dbUser = this.getServletContext().getInitParameter("dbUser");
        String dbPassword = this.getServletContext().getInitParameter("dbPassword");
        String dbUrl = this.getServletContext().getInitParameter("dbUrl");
        db = new ProjectDB(dbUrl, dbUser, dbPassword);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (!isAuthenticated(request)
                && !("authenticate".equals(action))) {
            doLogin(request, response);
            return;
        }
        if ("authenticate".equals(action)) {
            doAuthenticate(request, response);
        } else if ("logout".equals(action)) {
            doLogout(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void doAuthenticate(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String targetURL = "index.jsp";
        
        try {
            String passwordFromDB = db.getPassword(username);
            String UserIDFromDB = db.getUserID(username);
            byte[] getDecrptionIV = PasswordCrypto.normalizeIv(UserIDFromDB.getBytes("UTF-8"));
        
            if (password.equals(
                    PasswordCrypto.decrypt(passwordFromDB, Base64.getEncoder().encodeToString(getDecrptionIV)))) {
                // obtain session from request
                HttpSession session = request.getSession(true);
                UserBean bean = db.getUserDetail(username);
                // store the userInfo to the session
                session.setAttribute("userInfo", bean);
                if (bean.getShopId() != null) {
                    session.setAttribute("userType", "shop");
                    targetURL = "page/store/index.jsp"; // Change to shop homepage path
                } else if (bean.getWareHouseId() != null) {
                    session.setAttribute("userType", "warehouse");
                    int type = (bean.getWarehouseType().equals("Central"))? 0:1;
                    String v1 = (type == 0)? bean.getWarehouseCountry():bean.getWarehouseSourceCity();
                    request.setAttribute("orderList", db.getStatistics(v1, type)); // For order line chart
                    targetURL = "page/warehouse/index.jsp"; // Change to warehouse homepage path
                } else {
                    // Handle other user types if needed
                    targetURL = "index.jsp";
                    request.setAttribute("errorMsg", "Invalid user type");
                }
            } else {
                targetURL = "index.jsp";
                request.setAttribute("errorMsg", "Invalid username or password");
            }
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            targetURL = "index.jsp";
            request.setAttribute("errorMsg", "System error: " + ex.getMessage());
        }

        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/" + targetURL);
        rd.forward(request, response);
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        boolean result = false;
        HttpSession session = request.getSession();
        // get the UserInfo from session
        if (session.getAttribute("userInfo") != null) {
            result = true;
        }
        return result;
    }

    public void doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String targetURL = "index.jsp";
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/" + targetURL);
        rd.forward(request, response);
    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // remove the attribute from session
            session.removeAttribute("userInfo");
            // invalidate the session
            session.invalidate();

            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        doLogin(request, response);
    }

}
