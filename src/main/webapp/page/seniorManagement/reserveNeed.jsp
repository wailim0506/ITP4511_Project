<%-- 
    Document   : reserveNeed
    Created on : 2025年5月8日, 下午3:09:40
    Author     : wailim0506
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
        <title>Reserve Needs - ACER</title>
        <!-- favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">
        
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        <!-- Custom stylesheets -->
        <link href="${pageContext.request.contextPath}/css/darkModeControl.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/seniorManagement/reserveNeed.css" rel="stylesheet">
        
        <!-- JavaScript libraries -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- HTML2PDF.js library with improved version -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- Custom PDF helpers -->
        <script src="${pageContext.request.contextPath}/js/seniorManagement/pdfExport.js"></script>
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <script src="${pageContext.request.contextPath}/js/seniorManagement/reserveNeed.js"></script>
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
        
        <!-- Main Container -->
        <div class="container py-4">
            <!-- Page Header -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Reserve Needs Analysis</h2>
                <p class="lead">Track and manage fruit reservation needs across all locations</p>
            </div>
            
            <!-- Filter Section -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body p-4">
                    <h4 class="mb-4"><i class="material-icons align-middle me-2">filter_list</i>Filter Options</h4>
                    
                    <form id="filterForm" class="mb-3">
                        <div class="row g-3">
                            <!-- View Level Selection -->
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select class="form-select" id="viewLevel" name="viewLevel">
                                        <% String selectViewLevel = (String)request.getAttribute("viewLevel"); %>
                                        <option value="c" <%= (selectViewLevel == null || selectViewLevel.equals("c")) ? "selected" : "" %>>Country/ Region</option>
                                        <option value="city" <%= (selectViewLevel != null && selectViewLevel.equals("city")) ? "selected" : "" %>>City</option>
                                        <option value="shop" <%= (selectViewLevel != null && selectViewLevel.equals("shop")) ? "selected" : "" %>>Shop</option>
                                    </select>
                                    <label for="viewLevel">View Level</label>
                                </div>
                            </div>
                            
                            
                            <!-- Country Selection -->
                            <div class="col-md-3" id="countryFilterContainer" style="<%= (selectViewLevel != null && selectViewLevel.equals("city")) ? "display:none;" : "" %>">
                                <div class="form-floating">
                                    <select class="form-select" id="countryFilter" name="countryFilter">
                                        <% String selectCountry = (String)request.getAttribute("countryName"); %>
                                        <option value="all" <%= (selectCountry == null || selectCountry.equals("all")) ? "selected" : "" %>>All Countries/ Regions</option>
                                        <option value="JP" <%= (selectCountry != null && selectCountry.equals("JP")) ? "selected" : "" %>>Japan</option>
                                        <option value="US" <%= (selectCountry != null && selectCountry.equals("US")) ? "selected" : "" %>>USA</option>
                                        <option value="HK" <%= (selectCountry != null && selectCountry.equals("HK")) ? "selected" : "" %>>Hong Kong</option>
                                    </select>
                                    <label for="countryFilter">Country/ Region</label>
                                </div>
                            </div>
                            
                            
                            <div class="col-md-3 cityFilterContainer" style="<%= (selectViewLevel != null && selectViewLevel.equals("city")) ? "" : "display:none;" %>">
                                <div class="form-floating">
                                    <select class="form-select" id="cityFilter" name="cityFilter">
                                        <jsp:useBean id="cityList" scope="request" class="java.util.ArrayList" />
                                        <option value="all">All Cities</option>
                                        <% String selectCity = (String)request.getAttribute("cityName");; %>
                                        <%
                                            for (int i = 0; i < cityList.size(); i++) {
                                                String cityName = (String) cityList.get(i);
                                                out.println("<option value=\"" + cityName + "\" " + ((selectCity != null && selectCity.equals(cityName)) ? "selected" : "") + ">" + cityName + "</option>");
                                            }
                                        %>
                                    </select>
                                    <label for="cityFilter">City</label>
                                </div>
                            </div>

                            <%-- shop address filter --%>
                            <div class="col-md-3 shopFilterContainer" style="<%= (selectViewLevel != null && selectViewLevel.equals("shop")) ? "" : "display:none;" %>">
                                <div class="form-floating">
                                    <select class="form-select" id="shopFilter" name="shopFilter">
                                        <jsp:useBean id="shopList" scope="request" class="java.util.ArrayList" />
                                        <option value="all">All Shops</option>
                                        <% String selectShop = (String)request.getAttribute("shopAddress"); %>
                                        <%
                                            for (int i = 0; i < shopList.size(); i++) {
                                                String shopAddress = (String) shopList.get(i);
                                                out.println("<option value=\"" + shopAddress + "\" " + ((selectShop != null && selectShop.equals(shopAddress)) ? "selected" : "") + ">" + shopAddress + "</option>");
                                            }
                                        %>
                                    </select>
                                    <label for="shopFilter">Shop</label>
                                </div>
                            </div>
                            
                            <!-- Date Range Selection -->
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select class="form-select" id="dateRangeFilter" name="dateRangeFilter">
                                        <% String selectDateRange = (String)request.getAttribute("date"); %>
                                        <option value="lastMonth" <%= (selectDateRange != null && selectDateRange.equals("lastMonth")) ? "selected" : "" %>>Last Month</option>
                                        <option value="last3Months" <%= (selectDateRange != null && selectDateRange.equals("last3Months")) ? "selected" : "" %>>Last 3 Months</option>
                                        <option value="last6Months" <%= (selectDateRange != null && selectDateRange.equals("last6Months")) ? "selected" : "" %>>Last 6 Months</option>
                                        <option value="last12Months" <%= (selectDateRange == null || selectDateRange.equals("last12Months")) ? "selected" : "" %>>Last 12 Months</option>
                                    </select>
                                    <label for="dateRangeFilter">Date Range</label>
                                </div>
                            </div>
                            
                            <div class="col-md-3 ms-auto" id="filterButtonContainer">
                                <div class="d-flex gap-2 h-100">
                                    <button type="reset" class="btn btn-secondary w-100 h-100">
                                        <i class="material-icons align-middle me-2">refresh</i>Reset
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Results Section -->
            <div class="row g-4">
                <!-- Summary Cards -->
                <div class="col-12">
                    <div class="row g-4">
                        <!-- Total Reservations Card -->
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm summaryCard">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-primary bg-opacity-10 p-3 rounded me-3">
                                            <i class="material-icons text-primary">receipt</i>
                                        </div>
                                        <div>
                                            <jsp:useBean id="total" scope="request" class="java.lang.Integer" />
                                            <h6 class="mb-0">All Time Total Reservations</h6><h3 id='total'><%=total%></h3>
                                            <!--<h3 class="mb-0 fw-bold"><%=total%></h3>-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Total Fruit Items Card -->
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm summaryCard">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-success bg-opacity-10 p-3 rounded me-3">
                                            <i class="material-icons text-success">local_mall</i>
                                        </div>
                                        <div>
                                            <jsp:useBean id="totalFruit" scope="request" class="java.lang.Integer" />
                                            <h6 class="mb-0">All Time Total Fruit Items</h6><h3 id='totalFruit'><%=totalFruit%></h3>
                                            <!--<h3 class="mb-0 fw-bold"><%=totalFruit%></h3>-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Results Table -->
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0" id="tableTitle">
                                    <i class="material-icons align-middle me-2">analytics</i>
                                    <%
                                         if (selectViewLevel != null && selectViewLevel.equals("shop")) {
                                            out.println("<span id=\"tableTitleText\">Reservation Needs by Shop</span>");
                                        } else if (selectViewLevel != null && selectViewLevel.equals("city")) {
                                            out.println("<span id=\"tableTitleText\">Reservation Needs by City</span>");
                                        } else {
                                            out.println("<span id=\"tableTitleText\">Reservation Needs by Country/ Region</span>");
                                        }
                                    %>
                                    
                                </h4>
                                <div>
                                    <%-- AI analysis --%>
                                    <button class="btn btn-outline-secondary me-2" id="aiAnalysisBtn">
                                        <i class="material-icons align-middle me-1 small">analytics</i>AI Analysis
                                    </button>
                                    <button class="btn btn-outline-primary me-2" id="printReportBtn">
                                        <i class="material-icons align-middle me-1 small">print</i>Print
                                    </button>
                                    <button class="btn btn-outline-danger" id="exportPdfBtn">
                                        <i class="material-icons align-middle me-1 small">picture_as_pdf</i>Export as PDF
                                    </button>
                                </div>
                            </div>
                            
                            <div class="table-responsive reserveNeedTableContainer">
                                <!-- Country View Table -->
                                <table class="table table-hover reserveNeedTable <%= (selectViewLevel != null && !selectViewLevel.equals("c")) ? "d-none" : "" %>" id="countryView">
                                    <thead>
                                        <tr>
                                            <th>Country/ Region</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Fruit Type</th>
                                            <th>Origin</th>
                                            <th>Total Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <jsp:useBean id="reserveNeedList" scope="request" class="java.util.ArrayList" />
                                        <%
                                            HashMap <String, Integer> countryMap = new HashMap<String, Integer>();
                                            countryMap.put("JP", 0);
                                            countryMap.put("US", 0);
                                            countryMap.put("HK", 0);

                                            int JPCount = countryMap.get("JP");
                                            int USCount = countryMap.get("US");
                                            int HKCount = countryMap.get("HK");

                                            for (int i = 0; i < reserveNeedList.size(); i++) {
                                                
                                                ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList.get(i);
                                                String country = reserveNeed.getCountryRegionName();
                                                if (country.equals("Japan")) {
                                                    JPCount++;
                                                } else if (country.equals("United States")) {
                                                    USCount++;
                                                } else if (country.equals("Hong Kong")) {
                                                    HKCount++;
                                                }

                                                countryMap.put("JP", JPCount);
                                                countryMap.put("US", USCount);
                                                countryMap.put("HK", HKCount);
                                            }

                                            for (int i = 0; i < reserveNeedList.size(); i++) {
                                                ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList.get(i);
                                                int totalOrders = Integer.parseInt(reserveNeed.getTotalOrders());
                                                String fruitItem = reserveNeed.getFruitName();
                                                String fruitType = reserveNeed.getFruitType();
                                                String origin = reserveNeed.getOriginCity() + ", " + reserveNeed.getOriginCountry();
                                                int totalQuantity = Integer.parseInt(reserveNeed.getTotalQty());
                                                String unit = reserveNeed.getUnit();
                                                String country = (String)reserveNeed.getCountryRegionName();

                                                if (i == 0 || !((ReserveNeedBean)reserveNeedList.get(i-1)).getCountryRegionName().equals(country)) {
                                                    // First row for this country
                                                    out.println("<tr>");
                                                    if (country.equals("Japan")) {
                                                        out.println("<td rowspan=\"" + countryMap.get("JP") + "\" class=\"align-middle\">Japan</td>");
                                                        //out.println("<td rowspan=\"" + countryMap.get("JP") + "\" class=\"align-middle\">" + totalOrders + "</td>");
                                                    } else if (country.equals("United States")) {
                                                        out.println("<td rowspan=\"" + countryMap.get("US") + "\" class=\"align-middle\">USA</td>");
                                                        //out.println("<td rowspan=\"" + countryMap.get("US") + "\" class=\"align-middle\">" + totalOrders + "</td>");
                                                    } else if (country.equals("Hong Kong")) {
                                                        out.println("<td rowspan=\"" + countryMap.get("HK") + "\" class=\"align-middle\">Hong Kong</td>");
                                                        //out.println("<td rowspan=\"" + countryMap.get("HK") + "\" class=\"align-middle\">" + totalOrders + "</td>");
                                                    }
                                                } else {
                                                    // Continuation row for this country
                                                    out.println("<tr>");
                                                }

                                                // Add the individual fruit data cells (these appear on every row)
                                                out.println("<td>" + totalOrders + "</td>");
                                                out.println("<td>" + fruitItem + "</td>");
                                                out.println("<td>" + fruitType + "</td>");
                                                out.println("<td>" + origin + "</td>");
                                                out.println("<td>" + totalQuantity + "</td>");
                                                out.println("<td>" + unit + "</td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                                
                                <table class="table table-hover reserveNeedTable <%= (selectViewLevel != null && selectViewLevel.equals("city")) ? "" : "d-none" %>" id="cityView">
                                    <thead>
                                        <tr>
                                            <th>Country/ Region</th>
                                            <th>City</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Fruit Type</th>
                                            <th>Total Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                            <jsp:useBean id="reserveNeedList2" scope="request" class="java.util.ArrayList" />

                                            <%
                                                {
                                                HashMap<String, Integer> cityCountMap = new HashMap<>();
                                                HashMap<String, HashMap<String, Integer>> countryCityCountMap = new HashMap<>();
                                                
                                                // First pass: count rows for each city within each country
                                                for (int i = 0; i < reserveNeedList2.size(); i++) {
                                                    ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList2.get(i);
                                                    String country = reserveNeed.getCountryRegionName();
                                                    String city = reserveNeed.getCityName();
                                                    
                                                    // Count cities per country
                                                    if (!countryCityCountMap.containsKey(country)) {
                                                        countryCityCountMap.put(country, new HashMap<>());
                                                    }
                                                    
                                                    HashMap<String, Integer> cities = countryCityCountMap.get(country);
                                                    cities.put(city, cities.getOrDefault(city, 0) + 1);
                                                    
                                                    // Count items per city
                                                    String key = country + "-" + city;
                                                    cityCountMap.put(key, cityCountMap.getOrDefault(key, 0) + 1);
                                                }
                                                
                                                // Variables to track current country/city for rowspan
                                                String currentCountry = "";
                                                String currentCity = "";
                                                
                                                // Second pass: generate table rows
                                                for (int i = 0; i < reserveNeedList2.size(); i++) {
                                                    ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList2.get(i);
                                                    String country = reserveNeed.getCountryRegionName();
                                                    String city = reserveNeed.getCityName();
                                                    int totalOrders = Integer.parseInt(reserveNeed.getTotalOrders());
                                                    String fruitItem = reserveNeed.getFruitName();
                                                    String fruitType = reserveNeed.getFruitType();
                                                    int totalQuantity = Integer.parseInt(reserveNeed.getTotalQty());
                                                    String unit = reserveNeed.getUnit();
                                                    String cityKey = country + "-" + city;
                                                    
                                                    out.println("<tr>");
                                                    
                                                    // New country - add country cell with appropriate rowspan
                                                    if (!country.equals(currentCountry)) {
                                                        int countryRowCount = 0;
                                                        HashMap<String, Integer> cities = countryCityCountMap.get(country);
                                                        for (int count : cities.values()) {
                                                            countryRowCount += count;
                                                        }
                                                        out.println("<td rowspan=\"" + countryRowCount + "\" class=\"align-middle\">" + country + "</td>");
                                                        currentCountry = country;
                                                        currentCity = ""; // Reset current city when country changes
                                                    }
                                                    
                                                    // New city - add city cell with appropriate rowspan
                                                    if (!city.equals(currentCity)) {
                                                        int cityRowCount = cityCountMap.get(cityKey);
                                                        out.println("<td rowspan=\"" + cityRowCount + "\" class=\"align-middle\">" + city + "</td>");
                                                        //out.println("<td rowspan=\"" + cityRowCount + "\" class=\"align-middle\">" + totalOrders + "</td>");
                                                        currentCity = city;
                                                    }
                                                    
                                                    // Add fruit-specific data (these appear on every row)
                                                    out.println("<td>" + totalOrders + "</td>");
                                                    out.println("<td>" + fruitItem + "</td>");
                                                    out.println("<td>" + fruitType + "</td>");
                                                    out.println("<td>" + totalQuantity + "</td>");
                                                    out.println("<td>" + unit + "</td>");
                                                    
                                                    out.println("</tr>");
                                                }
                                                }
                                            %>
                                    
                                    </tbody>
                                </table>
                                
                                <!-- Shop View Table (Initially Hidden) -->
                                <table class="table table-hover reserveNeedTable <%= (selectViewLevel != null && !selectViewLevel.equals("shop")) ? "d-none" : "" %>" id="shopView">
                                    <thead>
                                        <tr>
                                            <th>Country/ Region</th>
                                            <th>City</th>
                                            <th>Shop</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Total Quantity</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <jsp:useBean id="reserveNeedList3" scope="request" class="java.util.ArrayList" />
                                        <%
                                            {
                                            HashMap<String, Integer> shopCountMap = new HashMap<>();
                                            HashMap<String, HashMap<String, Integer>> cityShopCountMap = new HashMap<>();
                                            HashMap<String, HashMap<String, HashMap<String, Integer>>> countryWithCityAndShopCounts = new HashMap<>();
                                            
                                            // First pass: count items for each shop/city/country combination
                                            for (int i = 0; i < reserveNeedList3.size(); i++) {
                                                ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList3.get(i);
                                                String country = reserveNeed.getCountryRegionName();
                                                String city = reserveNeed.getCityName();
                                                String shop = reserveNeed.getShopAddress();
                                                
                                                // Initialize country map if needed
                                                if (!countryWithCityAndShopCounts.containsKey(country)) {
                                                    countryWithCityAndShopCounts.put(country, new HashMap<>());
                                                }
                                                
                                                // Get city map for this country
                                                HashMap<String, HashMap<String, Integer>> cityMap = countryWithCityAndShopCounts.get(country);
                                                
                                                // Initialize city map if needed
                                                if (!cityMap.containsKey(city)) {
                                                    cityMap.put(city, new HashMap<>());
                                                }
                                                
                                                // Get shop map for this city
                                                HashMap<String, Integer> shops = cityMap.get(city);
                                                
                                                // Count items per shop
                                                shops.put(shop, shops.getOrDefault(shop, 0) + 1);
                                                
                                                // Count overall per shop
                                                String shopKey = country + "-" + city + "-" + shop;
                                                shopCountMap.put(shopKey, shopCountMap.getOrDefault(shopKey, 0) + 1);
                                            }
                                            
                                            // Variables to track current values
                                            String currentCountry = "";
                                            String currentCity = "";
                                            String currentShop = "";
                                            
                                            // Second pass: generate table rows
                                            for (int i = 0; i < reserveNeedList3.size(); i++) {
                                                ReserveNeedBean reserveNeed = (ReserveNeedBean) reserveNeedList3.get(i);
                                                String country = reserveNeed.getCountryRegionName();
                                                String city = reserveNeed.getCityName();
                                                String shop = reserveNeed.getShopAddress();
                                                int totalOrders = Integer.parseInt(reserveNeed.getTotalOrders());
                                                String fruitItem = reserveNeed.getFruitName();
                                                int totalQuantity = Integer.parseInt(reserveNeed.getTotalQty());
                                                String shopKey = country + "-" + city + "-" + shop;
                                                
                                                out.println("<tr>");
                                                
                                                // New country - add country cell with appropriate rowspan
                                                if (!country.equals(currentCountry)) {
                                                    int countryRowCount = 0;
                                                    HashMap<String, HashMap<String, Integer>> cityMap = countryWithCityAndShopCounts.get(country);
                                                    
                                                    // Count all rows for this country
                                                    for (String cityName : cityMap.keySet()) {
                                                        HashMap<String, Integer> shops = cityMap.get(cityName);
                                                        for (int count : shops.values()) {
                                                            countryRowCount += count;
                                                        }
                                                    }
                                                    
                                                    out.println("<td rowspan=\"" + countryRowCount + "\" class=\"align-middle\">" + country + "</td>");
                                                    currentCountry = country;
                                                    currentCity = ""; // Reset current city when country changes
                                                    currentShop = ""; // Reset current shop when country changes
                                                }
                                                
                                                // New city - add city cell with appropriate rowspan
                                                if (!city.equals(currentCity)) {
                                                    int cityRowCount = 0;
                                                    HashMap<String, Integer> shops = countryWithCityAndShopCounts.get(country).get(city);
                                                    
                                                    // Count all rows for this city
                                                    for (int count : shops.values()) {
                                                        cityRowCount += count;
                                                    }
                                                    
                                                    out.println("<td rowspan=\"" + cityRowCount + "\" class=\"align-middle\">" + city + "</td>");
                                                    currentCity = city;
                                                    currentShop = ""; // Reset current shop when city changes
                                                }
                                                
                                                // New shop - add shop cell with appropriate rowspan
                                                if (!shop.equals(currentShop)) {
                                                    int shopRowCount = shopCountMap.get(shopKey);
                                                    out.println("<td rowspan=\"" + shopRowCount + "\" class=\"align-middle\">" + shop + "</td>");
                                                    //out.println("<td rowspan=\"" + shopRowCount + "\" class=\"align-middle\">" + totalOrders + "</td>");
                                                    currentShop = shop;
                                                }
                                                
                                                // Add fruit-specific data (these appear on every row)
                                                out.println("<td>" + totalOrders + "</td>");
                                                out.println("<td>" + fruitItem + "</td>");
                                                out.println("<td>" + totalQuantity + "</td>");
                                                
                                                out.println("</tr>");
                                            }
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Visualization Section -->
                <div class="col-12">
                    <div class="row g-4">
                        <!-- Left Chart -->
                        <div class="col-md-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-4">
                                    <h4 class="mb-4">Top Requested Fruits</h4>
                                    <div class="chartPlaceholder">
                                       
                                        
                                        <div class="chartContainer">
                                            <%
                                                String[] colors = {
                                                    "rgba(13, 110, 253, 0.5)",
                                                    "rgba(25, 135, 84, 0.5)", 
                                                    "rgba(220, 53, 69, 0.5)", 
                                                    "rgba(255, 193, 7, 0.5)", 
                                                    "rgba(108, 117, 125, 0.5)"
                                                };

                                                String[] heights = {
                                                    "230",
                                                    "200",
                                                    "180",
                                                    "160",
                                                    "140"
                                                };
                                                HashMap<String, Integer> top5 = (HashMap<String, Integer>)request.getAttribute("top5");
                                                int heightIndex = 0;
                                                // Get the keys from the top5 HashMap
                                                Object[] fruitNames = top5.keySet().toArray();
                                                
                                                // Use a normal for loop to iterate through the keys
                                                for (int i = 0; i < fruitNames.length; i++) {
                                                    String fruitName = (String) fruitNames[i];
                                                    int quantity = top5.get(fruitName);
                                                    String color = colors[i];
                                                    String height = heights[i];
                                                    out.println("<div class=\"chartBar\" style=\"height: " + height + "px; background-color: " + color + "; width: 80%;\">");
                                                    out.println("<span class=\"chartLabel\">" + fruitName + "</span>");
                                                    out.println("<span class=\"chartValue\">" + quantity + "</span>");
                                                    out.println("</div>");
                                                }

                                            %>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <footer:footer userType="seniorManagement"/>
        
        <!-- AI Analysis Modal -->
        <div class="modal fade" id="aiAnalysisModal" tabindex="-1" aria-labelledby="aiAnalysisModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content border-0 shadow">
                    <div class="modal-header bg-primary bg-opacity-10">
                        <h5 class="modal-title" id="aiAnalysisModalLabel">
                            <i class="material-icons align-middle me-2">psychology</i>
                            AI Analysis Insights
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div id="aiAnalysisLoading" class="text-center py-5">
                            <div class="spinner-border text-primary mb-3" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mb-0">Analyzing your data...</p>
                            <p class="text-muted small">This may take a moment.</p>
                        </div>
                        <div id="aiAnalysisContent" class="d-none">
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Data Summary</h6>
                                <div id="aiDataSummary" class="border-start border-4 border-primary ps-3"></div>
                            </div>
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Key Insights</h6>
                                <div id="aiKeyInsights" class="border-start border-4 border-success ps-3"></div>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-3">Recommendations</h6>
                                <div id="aiRecommendations" class="border-start border-4 border-warning ps-3"></div>
                            </div>
                        </div>
                        <div style="position: absolute; bottom: 24px; right: 24px; z-index: 1055; font-size: 0.95rem; opacity: 0.85;">
                            <div class="d-flex align-items-center bg-white bg-opacity-75 rounded shadow-sm px-2 py-1" style="border: 1px solid #eee;">
                                <img src="/ITP4511_Project/img/deepseek.png" alt="Deepseek Logo" style="max-width: 26px; height: 26px;">
                                <span class="ms-2 text-muted" style="font-size: 1em;">Supported by Deepseek API</span>
                            </div>
                        </div>
                        <div id="aiAnalysisError" class="d-none">
                            <div class="alert alert-danger" role="alert">
                                <i class="material-icons align-middle me-2">error_outline</i>
                                <span id="aiErrorMessage">An error occurred while analyzing the data.</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary d-none" id="downloadAnalysisBtn">
                            <i class="material-icons align-middle me-1 small">download</i>
                            Download Analysis
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Dark Mode Toggle Button -->
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
