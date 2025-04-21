<%-- 
    Document   : shopList
    Created on : 2025年4月15日, 上午10:30:00
    Author     : Wai Lim Fung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Shop List - ACER</title>
        <!-- favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/css/store/shopList.css" rel="stylesheet">
        <!-- Bootstrap and jQuery JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
        <!-- Dark Mode Control -->
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
    </head>
    <body>
        <%
            UserBean bean = (UserBean)session.getAttribute("userInfo");
            String staffName = (String)bean.getStaffName();
            if (staffName == null) {
                throw new Exception();
            }
        %>
        <nav:nav userType="shop" staffName="<%=staffName%>"/>
        
        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">AIB Shop Directory</h2>
                <p class="lead">View all AIB bakery shops across the globe</p>
            </div>
            
            <!-- Main Content -->
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h4 class="mb-4"><i class="material-icons align-middle me-2">store</i>Shops Directory</h4>
                    
                    <!-- Search and Filter Bar -->
                    <div class="mb-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-5 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">search</i>
                                    </span>
                                    <input type="text" class="form-control" id="shopSearch" placeholder="Search shops...">
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
                                        <option value="Japan">Japan</option>
                                        <option value="United States">United States</option>
                                        <option value="Hong Kong">Hong Kong</option>
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
                                        <jsp:useBean id="shopCityList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            for (int i = 0; i < shopCityList.size(); i++) {
                                                String city = (String)shopCityList.get(i);
                                                out.println("<option value='" + city + "'>" + city + "</option>");
                                            }
                                        %>
                                        <%-- <option value="Tokyo">Tokyo</option>
                                        <option value="Osaka">Osaka</option>
                                        <option value="Kyoto">Kyoto</option>
                                        <option value="New York">New York</option>
                                        <option value="Los Angeles">Los Angeles</option>
                                        <option value="San Francisco">San Francisco</option>
                                        <option value="Central">Central</option>
                                        <option value="Tsim Sha Tsui">Tsim Sha Tsui</option>
                                        <option value="Mong Kok">Mong Kok</option> --%>
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
                                    <th>Shop ID</th>
                                    <th>Address</th>
                                    <th>City</th>
                                    <th>Country/ Region</th>
                                    <th>Contact</th>
                                </tr>
                            </thead>
                            <tbody>
                                <jsp:useBean id="shopList" class="java.util.ArrayList" scope="request"/>
                                <%
                                    for (int i = 0; i < shopList.size(); i++) {
                                        ShopBean shop = (ShopBean)shopList.get(i);
                                        String shopId = shop.getID();
                                        String address = shop.getAddress();
                                        String city = shop.getCity();
                                        String country = shop.getCountryRegion();
                                        String contact = shop.getPhoneNumber();

                                        
                                        out.println("<tr class='shopItem' data-shop-id='" + shopId + "' data-country='" + country + "' data-city='" + city + "'>");
                                        out.println("<td><div class='d-flex align-items-center'><i class='material-icons text-primary me-2'>store</i>" + shopId + "</div></td>");
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
                    <div class="text-center mt-4 shopResultInfo d-none">
                        <span class="badge bg-secondary">Showing <span id="visibleShopCount">0</span> of <span id="totalShopCount">0</span> shops</span>
                    </div>
                </div>
            </div>
        </div>
        
        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        
        <script src="${pageContext.request.contextPath}/js/store/shopList.js"></script>
    </body>
</html>
