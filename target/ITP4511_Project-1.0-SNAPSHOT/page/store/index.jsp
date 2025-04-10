<%-- 
    Document   : index
    Created on : 2025年3月27日, 下午7:21:34
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="ict" %>
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
        <ict:nav userType="shop"/>
        <div class="container py-4">
            <!-- Hero Section -->
            <div class="hero-section text-center shadow-sm">
                <h1 class="display-5 fw-bold text-primary">Acer International Bakery</h1>
                <p class="lead mb-4">Shop Management Dashboard</p>
                <p class="text-muted mb-0">Manage fruit inventory, reservations, and borrowing requests</p>
            </div>
            
            <!-- Dashboard Cards -->
            <div class="row g-4 py-4">
                <!-- Reserve Fruit -->
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
                
                <!-- My Reservation -->
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
                
                <!-- Borrowed Fruit -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">swap_horiz</i>
                            <h5 class="card-title">Borrow Fruit</h5>
                            <p class="card-text text-muted">Borrow fruits from other shops</p>
                            <a href="#" class="btn btn-outline-primary mt-2">View Borrowed</a>
                        </div>
                    </div>
                </div>
                
                <!-- Borrow Request -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">send</i>
                            <h5 class="card-title">Borrow Requests</h5>
                            <p class="card-text text-muted">Handle borrow requests from other shops</p>
                            <a href="#" class="btn btn-outline-primary mt-2">Manage Requests</a>
                        </div>
                    </div>
                </div>
                
                <!-- Stock Management -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">inventory</i>
                            <h5 class="card-title">Stock Management</h5>
                            <p class="card-text text-muted">Check and manage shop's fruit inventory</p>
                            <a href="#" class="btn btn-outline-primary mt-2">View Inventory</a>
                        </div>
                    </div>
                </div>
                
                <!-- Profile -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">account_circle</i>
                            <h5 class="card-title">Profile</h5>
                            <p class="card-text text-muted">View and update profile information</p>
                            <a href="#" class="btn btn-outline-primary mt-2">Go to Profile</a>
                        </div>
                    </div>
                </div>
                
                <!-- User List -->
                <div class="col-lg-4 col-md-6 mx-auto">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">people</i>
                            <h5 class="card-title">User List</h5>
                            <p class="card-text text-muted">View users associated with the system</p>
                            <a href="#" class="btn btn-outline-primary mt-2">View Users</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="../../components/store/footer.jsp" %>
        <i id="darkModeToogle" class="material-icons"
        style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
