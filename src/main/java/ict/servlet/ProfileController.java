/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ict.servlet;

import ict.bean.UserBean;
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
        if ("updateStaffName".equalsIgnoreCase(action)) {
            String type = (user.getShopId()!=null)?"shop":"warehouse";
            String newStaffName = request.getParameter("staffName");
            boolean isSuccess= db.updateStaffName(newStaffName, user.getUserId(), type);
            
            if(isSuccess){
                UserBean bean = db.getUserDetail(user.getUserName());
                session.setAttribute("userInfo", bean);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/page/profile.jsp");
                rd.forward(request, response);
            }else{
                request.setAttribute("errorMsg", "Profile: Fail to change Staff Name.");
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/error.jsp");
                rd.forward(request, response);
            }
        }else if ("changePassword".equalsIgnoreCase(action)){
        
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
