<%-- 
    Document   : delivery
    Created on : 2025年4月23日, 下午3:43:57
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>

<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<%@ taglib uri="/WEB-INF/tlds/order.tld" prefix="order" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Delivery - ACER</title>
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
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <script src="${pageContext.request.contextPath}/js/warehouse/filter.js" defer></script>
        <link href="${pageContext.request.contextPath}/css/warehouse/delivery.css" rel="stylesheet">
    </head>
    <body>
        <%
            UserBean ub = (UserBean)session.getAttribute("userInfo");
        %>
        <nav:nav userType="warehouse" staffName="<%=ub.getStaffName()%>"/>
        <%
            try{
                String errorMsg = (String) request.getAttribute("errorMsg");
                if(errorMsg != null && !errorMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-danger alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + errorMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                }
            }catch(Exception e){
            }  

            try{
                String successMsg = (String) request.getAttribute("successMsg");
                if(successMsg != null && !successMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-success alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + successMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                }
            }catch(Exception e){
            } 
        %>
        <jsp:useBean id="StatusBean" class="ict.bean.StatusBean" scope="request"/>
        
        <!-- Status Bar -->
        <div class="container">
            <div class="status">
                <div class="status-data">
                    <h3>Total Order</h3>
                    <p><jsp:getProperty name="StatusBean" property="total"/></p>
                </div>
                <div class="status-data statusBule">
                    <h3>Processing</h3>
                    <p><jsp:getProperty name="StatusBean" property="processing"/></p>
                </div>
                <div class="status-data statusYellow">
                    <h3>Delivered</h3>
                    <p><jsp:getProperty name="StatusBean" property="delivered"/></p>
                </div>
                <div class="status-data statusGreen">
                    <h3>Finished</h3>
                    <p><jsp:getProperty name="StatusBean" property="finished"/></p>
                </div>
            </div>     
                
             <!-- Order filter -->
            <div class="filter">
                <div class="filter-title">
                    <i class="material-icons align-middle me-2">filter_list</i><h4>Filter Orders</h4>
                </div>
                <div class="filter-condition">
                    <div class="filterbox-search">
                        <i class="material-icons text-muted iconfont">search</i>
                        <input type="text" id="orderIdFilter" onkeyup="filterTable()" placeholder="Search by orderID">
                    </div>
                    <div class="filterbox">
                        <i class="material-icons text-muted iconfont">filter_alt</i>
                        <select id="statusFilter" onchange="filterTable()">
                            <option value="">All Status</option>
                            <option value="Processing">Processing</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Finished">Finished</option>
                        </select>
                    </div>
                    <div class="filterbox">
                        <i class="material-icons text-muted iconfont">date_range</i>
                        <select id="dateFilter" onchange="filterTable()">
                            <option value="">All</option>
                            <option value="currentMonth">Current Month</option>
                            <option value="last90Days">Last 90 Days</option>
                            <option value="yearToDate">Year to Date</option>
                        </select>
                    </div>
                    <div class="filterbox-reset">
                        <button class="btn btn-outline-secondary w-100" onclick="resetFilters()" >
                                    <i class="material-icons align-middle small">refresh</i> Reset
                        </button>
                    </div>
                </div>
            </div>
        
        <!-- Order list and order detail -->
            <div class="order">
                <!-- Order list -->
                <div class="order-list">
                    <div class="order-list-title">
                        <i class="material-icons card-icon">receipt_long</i>
                        <h4>Order List</h4>
                    </div>
                    
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>OrderID</th>
                                <th>OrderDate</th>
                                <th>ShopID</th>
                                <th>Items</th>
                                <th>Status</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <jsp:useBean id="orderList" class="java.util.ArrayList" scope="request"/>
                        <tbody>
                        <%
                            if (orderList.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="6" class="text-center">No order found.</td>
                            </tr>
                        <%
                                } else {
                                    for (Object obj : orderList) {
                                        OrderBean order = (OrderBean) obj;
                                        String status = order.getStatus();
                                        String statusStyle = "";

                                        if ("processing".equalsIgnoreCase(status)) {
                                            statusStyle = "background-color: rgb(240, 255, 255); color: black;";
                                        } else if ("delivered".equalsIgnoreCase(status)) {
                                            statusStyle = "background-color: rgb(250, 250, 51); color: black;";
                                        } else if ("finished".equalsIgnoreCase(status)) {
                                            statusStyle = "background-color: rgb(159, 226, 191); color: black;";
                                        }
                            %>
                                    <tr>
                                        <td><%= order.getId() %></td>
                                        <td><%= order.getOrderDate() %></td>
                                        <td><%= order.getShopId() %></td>
                                        <td><%= order.getUnit() %></td>
                                        <td>
                                            <span class="order-status" style=" <%= statusStyle %>">
                                                <%= order.getStatus() %>
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-outline-info" 
                                            onclick="window.location.href='${pageContext.request.contextPath}/Delivery?action=view&orderID=<%=order.getId()%>'">
                                            <i class="material-icons small">visibility</i></button>
                                        </td>
                                    </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                    </table>
                </div>
                        
                <!-- Order detail -->
                <div class="order-detail">
                    <%
                        OrderBean orderBean = (OrderBean) request.getAttribute("order");
                        if (orderBean != null) {
                    %>
                        <order:order orderBean="<%=orderBean%>" userBean="<%=ub%>" page="delivery" />
                    <%
                        } else {
                    %>
                        <div class="order-list-title">
                            <i class="material-icons card-icon">info</i>
                            <h4>User Guide</h4>
                        </div>
                        <p class="info">
                            Click View to view the detail of the order and further operation.
                        </p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <footer:footer userType="warehouse"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
