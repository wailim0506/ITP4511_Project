/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet;

import ict.bean.UserBean;
import ict.db.ProjectDB;
import ict.util.PasswordCrypto;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Base64;

/**
 *
 * @author HwH
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/ProfileController"})
public class ProfileController extends HttpServlet {
    
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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
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

        String action = request.getParameter("action");
        if ("updateStaffName".equalsIgnoreCase(action)) {               //Update staff name
            String type = (user.getShopId()!=null)?"shop":"warehouse";
            String newStaffName = request.getParameter("staffName");
            boolean isSuccess= db.updateStaffName(newStaffName, user.getUserId(), type);
            
            if(isSuccess){
                UserBean bean = db.getUserDetail(user.getUserName());
                session.setAttribute("userInfo", bean);
                
                request.setAttribute("msg", "Staff Name changed successfully!");
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/page/profile.jsp");
                rd.forward(request, response);
            }else{
                request.setAttribute("errorMsg", "Profile: Fail to change Staff Name.");
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/error.jsp");
                rd.forward(request, response);
            }
        }else if ("changePassword".equalsIgnoreCase(action)){               //Update password
            String oPass = request.getParameter("oPass");
            String nPass = request.getParameter("nPass");
            String cPass = request.getParameter("cPass");
            try {
                String passwordFromDB = db.getPassword(user.getUserName());
                String UserIDFromDB = db.getUserID(user.getUserName());
                byte[] getDecrptionIV = PasswordCrypto.normalizeIv(UserIDFromDB.getBytes("UTF-8"));

                if (oPass.equals(           //Old password matched
                        PasswordCrypto.decrypt(passwordFromDB, Base64.getEncoder().encodeToString(getDecrptionIV)))){
                    if(!nPass.equals(cPass)){           //password not match
                        request.setAttribute("errorMsg", "Confirm password not match.");
                        RequestDispatcher rd;
                        rd = getServletContext().getRequestDispatcher("/page/profile.jsp");
                        rd.forward(request, response);
                    }else{
                        PasswordCrypto.CryptoResult result1 = PasswordCrypto.encrypt(nPass, user.getUserId());
                        db.updatePassword(user.getUserId(), result1.encryptedText);

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

                        RequestDispatcher rd;
                        rd = getServletContext().getRequestDispatcher("/index.jsp");
                        rd.forward(request, response);
                    }
                }else{          //Old password not match.
                    request.setAttribute("errorMsg", "Old password not match.");
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/page/profile.jsp");
                    rd.forward(request, response);  
                }
            }catch (Exception ex) {
                request.setAttribute("errorMsg", "Profile: Fail to change password.");
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/error.jsp");
                rd.forward(request, response);
            }
        } else {
            request.setAttribute("errorMsg", "Profile: Illegal operation.");
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
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
