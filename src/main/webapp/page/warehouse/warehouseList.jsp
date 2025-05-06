<%-- 
    Document   : warehouseList
    Created on : 2025年4月23日, 下午3:47:20
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Warehouse List - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/warehouse/warehouseList.css" rel="stylesheet">
    </head>
    <body>
        <%
            UserBean ub = (UserBean)session.getAttribute("userInfo");
        %>
        <nav:nav userType="warehouse" staffName="<%=ub.getStaffName()%>"/>
        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">AIB Warehouse Directory</h2>
                <p class="lead">View all AIB bakery warehouse across the globe</p>
            </div>
            
            <!-- Main Content -->
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h4 class="mb-4"><i class="material-icons align-middle me-2">home</i>Warehouses Directory</h4>
                    
                    <!-- Search and Filter Bar -->
                    <div class="mb-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-5 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">search</i>
                                    </span>
                                    <input type="text" class="form-control" id="warehouseSearch" placeholder="Search warehouse...">
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">public</i>
                                    </span>
                                    <select class="form-select" id="countryFilter">
                                        <option value="all" selected>All Countries/Regions</option>
                                        <option value="--" disabled>------------------------------</option>
                                        <jsp:useBean id="warehouseCountryList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            for (int i = 0; i < warehouseCountryList.size(); i++) {
                                                String country = (String)warehouseCountryList.get(i);
                                                out.println("<option value='" + country + "'>" + country + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">location_city</i>
                                    </span>
                                    <select class="form-select" id="cityFilter">
                                        <option value="all" selected>All Cities</option>
                                        <option value="--" disabled>------------------------------</option>
                                        <jsp:useBean id="warehouseCityList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            for (int i = 0; i < warehouseCityList.size(); i++) {
                                                String city = (String)warehouseCityList.get(i);
                                                out.println("<option value='" + city + "'>" + city + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-1 col-sm-12">
                                <button type="button" id="resetFilterBtn" class="btn btn-outline-secondary w-100">
                                    <i class="material-icons align-middle me-1 small">refresh</i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Shop Table -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Warehouse ID</th>
                                    <th>Type</th>
                                    <th>City</th>
                                    <th>Country/ Region</th>
                                    <th>Contact</th>
                                </tr>
                            </thead>
                            <tbody>
                                <jsp:useBean id="warehouseList" class="java.util.ArrayList" scope="request"/>
                                <%
                                    for (int i = 0; i < warehouseList.size(); i++) {
                                        WarehouseBean warehouse = (WarehouseBean)warehouseList.get(i);
                                        String warehouseId = warehouse.getId();
                                        String address = warehouse.getType();
                                        String city = (warehouse.getCity()!=null)?warehouse.getCity():"";
                                        String country = warehouse.getCountryRegion();
                                        String contact = warehouse.getPhoneNumber();

                                        
                                        out.println("<tr class='warehouseItem' data-warehouse-id='" + warehouseId + "' data-country='" + country + "' data-city='" + city + "'>");
                                        out.println("<td><div class='d-flex align-items-center'><i class='material-icons text-primary me-2'>home</i>" + warehouseId + "</div></td>");
                                        out.println("<td>" + address + "</td>");
                                        out.println("<td>" + city + "</td>");
                                        out.println("<td>" + country + "</td>");
                                        out.println("<td>" + contact + "</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Result Info -->
                    <div class="text-center mt-4 warehouseResultInfo d-none">
                        <span class="badge bg-secondary">Showing <span id="visibleWarehouseCount">0</span> of <span id="totalWarehouseCount">0</span> warehouses</span>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        
        <footer:footer userType="warehouse"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
           
           <script src="${pageContext.request.contextPath}/js/warehouse/warehouseList.js"></script>
    </body>
</html>
