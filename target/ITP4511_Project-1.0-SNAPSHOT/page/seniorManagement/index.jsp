<%-- 
    Document   : index
    Created on : 2025年3月27日, 下午7:21:34
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ACER Shop Dashboard</title>
        <!-- favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">
        <!-- bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jquery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Google Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <link href="${pageContext.request.contextPath}/css/store/index.css" rel="stylesheet">
    </head>
    <body>
        <%
            UserBean bean = (UserBean)session.getAttribute("userInfo");
            String staffName = (String)bean.getStaffName();
            if (staffName == null) {
                throw new Exception();
            }
        %>
        <nav:nav userType="seniorManagement" staffName="<%=staffName%>"/>
        <div class="container py-4">
            <div class="hero-section text-center shadow-sm">
                <h1 class="display-5 fw-bold text-primary">Acer International Bakery</h1>
                <p class="lead mb-4">Senior Management Dashboard</p>
                
                <div class="d-flex align-items-center justify-content-center mb-3">
                    <%
                        bean = (UserBean)session.getAttribute("userInfo");
                        staffName = (String)bean.getStaffName();
                        if (staffName == null) {
                            throw new Exception();
                        }
                    %>
                    <span class="text-muted mx-2">Staff: <%=staffName %></span>
                    <span class="text-muted mx-2">Role: Senior Management</span>

                </div>
                <div id="current-time" class="mt-2 fw-light text-primary"></div>
            </div>
            
            <div class="row g-4 py-4">
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">bar_chart</i>
                            <h5 class="card-title">Consumption Report</h5>
                            <p class="card-text text-muted">View and analyze fruit consumption data</p>
                            <a href="/ITP4511_Project/consumption" class="btn btn-outline-primary mt-2">View Reports</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">assessment</i>
                            <h5 class="card-title">Reserve Needs Report</h5>
                            <p class="card-text text-muted">View reserve needs by shop/city/country</p>
                            <a href="/ITP4511_Project/reserveNeed?viewLevel=c&cn=all&date=last12Months" class="btn btn-outline-primary mt-2">View Report</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">category</i>
                            <h5 class="card-title">Manage Fruit Types</h5>
                            <p class="card-text text-muted">Add, edit, or remove fruit types in the system</p>
                            <a href="/ITP4511_Project/manageFruit" class="btn btn-outline-primary mt-2">Manage Types</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">manage_accounts</i>
                            <h5 class="card-title">User Account Management</h5>
                            <p class="card-text text-muted">Manage user roles and permissions</p>
                            <a href="/ITP4511_Project/userList" class="btn btn-outline-primary mt-2">Manage Users</a>
                        </div>
                    </div>
                </div>
                

                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">storefront</i>
                            <h5 class="card-title">Shop List</h5>
                            <p class="card-text text-muted">View all shops in the company network</p>
                            <a href="/ITP4511_Project/shopList" class="btn btn-outline-primary mt-2">View Shops</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">home</i>
                            <h5 class="card-title">Warehouse List</h5>
                            <p class="card-text text-muted">View all warehouses in the company network</p>
                            <a href="/ITP4511_Project/WarehouseList" class="btn btn-outline-primary mt-2">View warehouses</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">account_circle</i>
                            <h5 class="card-title">Profile</h5>
                            <p class="card-text text-muted">View and update profile information</p>
                            <a href="/ITP4511_Project/page/profile.jsp" class="btn btn-outline-primary mt-2">Go to Profile</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <footer:footer userType="seniorManagement"/>
        <i id="darkModeToogle" class="material-icons"
        style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        
        <script src="${pageContext.request.contextPath}/js/store/index.js"></script>
    </body>
</html>
