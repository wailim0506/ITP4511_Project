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
            String role = (String)bean.getRole();
            if (staffName == null) {
                throw new Exception();
            }
        %>
        <nav:nav userType="shop" staffName="<%=staffName%>"/>
        <div class="container py-4">
            <div class="hero-section text-center shadow-sm">
                <h1 class="display-5 fw-bold text-primary">Acer International Bakery</h1>
                <p class="lead mb-4">Shop Management Dashboard</p>
                
                <div class="d-flex align-items-center justify-content-center mb-3">
                    <i class="material-icons text-primary me-2" style="font-size: 1.2rem;">store</i>
                    <%
                        bean = (UserBean)session.getAttribute("userInfo");
                        String shop = (String)bean.getShopAddress();
                        String shopCity = (String)bean.getShopCity();
                        String shopCountry = (String)bean.getShopCountry();
                        staffName = (String)bean.getStaffName();
                        if (shop == null || shopCity == null || shopCountry == null || staffName == null) {
                            throw new Exception();
                        }
                    %>
                    <span class="fw-medium">Shop: <%=shop%>, <%=shopCity%>, <%=shopCountry%> </span>
                    <span class="mx-2 text-muted">|</span>
                    <span class="text-muted mx-2">Staff: <%=staffName %></span>
                    <span class="text-muted mx-2">Role: <%=role %></span>

                </div>
                <div id="current-time" class="mt-2 fw-light text-primary"></div>
            </div>
            
            <div class="row g-4 py-4">
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">shopping_cart</i>
                            <h5 class="card-title">Reserve Fruit</h5>
                            <p class="card-text text-muted">Place reservations for fruits in the next 14 days</p>
                            <a href="/ITP4511_Project/reserveFruit?action=listAll" class="btn btn-outline-primary mt-2">Go to Reservation</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">bookmark</i>
                            <h5 class="card-title">My Reservations</h5>
                            <p class="card-text text-muted">View and manage current fruit reservations</p>
                            <a href="/ITP4511_Project/reserveRecord?action=listAll" class="btn btn-outline-primary mt-2">See Reservations</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">swap_horiz</i>
                            <h5 class="card-title">Borrow Fruit</h5>
                            <p class="card-text text-muted">Borrow fruits from other shops</p>
                            <a href="/ITP4511_Project/borrowFruit?action=select" class="btn btn-outline-primary mt-2">Go to Borrow</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">history</i>
                            <h5 class="card-title">Borrow Records</h5>
                            <p class="card-text text-muted">View and manage your fruit borrowing history</p>
                            <a href="/ITP4511_Project/borrowRecord?action=listAll" class="btn btn-outline-primary mt-2">View Records</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">send</i>
                            <h5 class="card-title">Borrow Requests</h5>
                            <p class="card-text text-muted">Handle borrow requests from other shops</p>
                            <a href="/ITP4511_Project/borrowRequest?action=all" class="btn btn-outline-primary mt-2">Manage Requests</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">inventory</i>
                            <h5 class="card-title">Stock Management</h5>
                            <p class="card-text text-muted">Check and manage shop's fruit inventory</p>
                            <a href="/ITP4511_Project/stock?action=list" class="btn btn-outline-primary mt-2">View Inventory</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">people</i>
                            <h5 class="card-title">User List</h5>
                            <p class="card-text text-muted">View users associated with the system</p>
                            <a href="/ITP4511_Project/userList" class="btn btn-outline-primary mt-2">View Users</a>
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
                            <i class="material-icons card-icon mb-3">account_circle</i>
                            <h5 class="card-title">Profile</h5>
                            <p class="card-text text-muted">View and update profile information</p>
                            <a href="/ITP4511_Project/page/profile.jsp" class="btn btn-outline-primary mt-2">Go to Profile</a>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
        style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        
        <script src="${pageContext.request.contextPath}/js/store/index.js"></script>
    </body>
</html>
