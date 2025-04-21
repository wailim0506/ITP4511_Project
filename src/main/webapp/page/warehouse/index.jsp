<%-- 
    Document   : index
    Created on : 2025年4月5日, 下午5:09:20
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ACER Warehouse Dashboard</title>
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
        <link href="${pageContext.request.contextPath}/css/warehouse/index.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="${pageContext.request.contextPath}/js/warehouse/chart.js"></script>
    </head>
    <body>
        <%
            UserBean ub = (UserBean)session.getAttribute("userInfo");
            
            Date currentDate = new Date();
            SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM", Locale.ENGLISH);
            SimpleDateFormat weekdayFormat = new SimpleDateFormat("EEEE", Locale.ENGLISH);
            SimpleDateFormat dayFormat = new SimpleDateFormat("d", Locale.ENGLISH);

            String month = monthFormat.format(currentDate);
            String weekday = weekdayFormat.format(currentDate);
            String day = dayFormat.format(currentDate);
        %>
        <nav:nav userType="warehouse" staffName="<%=ub.getStaffName()%>"/>

        <div class="container py-4">
            <!-- Today & line chart -->
            <div class="date-statistics-box">
                <div class="date-box">
                    <p>
                        <span class="month"><%= month %></span>
                        <span class="weekday"><%= weekday %></span>
                    </p>
                    <p class="day"><%= day %></p>
                </div>
                
                <div class="statistics-box">
                    <canvas id="orderChart"></canvas>
                </div>
            </div>


            <!-- Dashboard Cards -->
            <div class="row g-4 py-4">
                <!-- Inventory -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">inventory_2</i>
                            <h5 class="card-title">Inventory</h5>
                            <p class="card-text text-muted">View and edit inventory</p>
                            <a href="#" class="btn btn-outline-primary mt-2">Inventory management</a>
                        </div>
                    </div>
                </div>

                <!-- Order -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">receipt_long</i>
                            <h5 class="card-title">Order</h5>
                            <p class="card-text text-muted">View and change order status</p>
                            <a href="#" class="btn btn-outline-primary mt-2">Process order</a>
                        </div>
                    </div>
                </div>

                <!-- Delivery -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">local_shipping</i>
                            <h5 class="card-title">Delivery</h5>
                            <p class="card-text text-muted">Check the status of goods</p>
                            <a href="#" class="btn btn-outline-primary mt-2">View delivery</a>
                        </div>
                    </div>
                </div>

                <!-- Staffing -->
                <div class="col-lg-4 col-md-6 mx-auto">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="material-icons card-icon mb-3">manage_accounts</i>
                            <h5 class="card-title">Staffing</h5>
                            <p class="card-text text-muted">View users associated with the system</p>
                            <a href="#" class="btn btn-outline-primary mt-2">View Users</a>
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

                <!-- Empty -->
                <div class="col-lg-4 col-md-6">
                    <div class="card dashboard-card border-0 shadow-sm">
                        <div class="card-body text-center p-4">        
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer:footer userType="warehouse"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        
        <!-- Order Statistics -->
        <script>
            const orderData = [
                <%
                    List<OrderBean> orderList = (List<OrderBean>) request.getAttribute("orderList");
                    if (orderList != null) {
                        for (int i = 0; i < orderList.size(); i++) {
                            OrderBean order = orderList.get(i);
                            out.print("{ date: \"" + order.getOrderDate() + "\", total: " + order.getQty() + " }");
                            if (i < orderList.size() - 1) {
                                out.print(",");
                            }
                        }
                    }
                %>
            ];

            renderOrderChart(orderData);
        </script>
    </body>
</html>
