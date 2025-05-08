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
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <script src="${pageContext.request.contextPath}/js/seniorManagement/reserveNeed.js"></script>
    </head>
    <body>
        <%
            // Simulated user information
            UserBean bean = new UserBean();
            bean.setStaffName("Senior Manager");
            String staffName = bean.getStaffName();
            
            // In real code, this would be fetched from session
            // UserBean bean = (UserBean)session.getAttribute("userInfo");
            // String staffName = (String)bean.getStaffName();
            // if (staffName == null) {
            //     throw new Exception();
            // }
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
                                        <option value="country" selected>By Country</option>
                                        <option value="city">By City</option>
                                        <option value="shop">By Shop</option>
                                    </select>
                                    <label for="viewLevel">View Level</label>
                                </div>
                            </div>
                            
                            <!-- Country Selection -->
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select class="form-select" id="countryFilter" name="countryFilter">
                                        <option value="all" selected>All Countries</option>
                                        <option value="Japan">Japan</option>
                                        <option value="USA">USA</option>
                                        <option value="Hong Kong">Hong Kong</option>
                                    </select>
                                    <label for="countryFilter">Country</label>
                                </div>
                            </div>
                            
                            <!-- City Selection (Initially hidden, appears when country is selected) -->
                            <div class="col-md-3 cityFilterContainer">
                                <div class="form-floating">
                                    <select class="form-select" id="cityFilter" name="cityFilter">
                                        <option value="all" selected>All Cities</option>
                                        <option value="Tokyo">Tokyo</option>
                                        <option value="Osaka">Osaka</option>
                                        <option value="New York">New York</option>
                                        <option value="Los Angeles">Los Angeles</option>
                                        <option value="Hong Kong Island">Hong Kong Island</option>
                                        <option value="Kowloon">Kowloon</option>
                                    </select>
                                    <label for="cityFilter">City</label>
                                </div>
                            </div>
                            
                            <!-- Date Range Selection -->
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select class="form-select" id="dateRangeFilter" name="dateRangeFilter">
                                        <option value="thisMonth" selected>This Month</option>
                                        <option value="lastMonth">Last Month</option>
                                        <option value="last3Months">Last 3 Months</option>
                                        <option value="custom">Custom Range</option>
                                    </select>
                                    <label for="dateRangeFilter">Date Range</label>
                                </div>
                            </div>
                            
                            <!-- Custom Date Range (Initially hidden) -->
                            <div class="col-md-6 customDateRangeContainer d-none">
                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="date" class="form-control" id="startDate" name="startDate">
                                            <label for="startDate">Start Date</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="date" class="form-control" id="endDate" name="endDate">
                                            <label for="endDate">End Date</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Submit Button -->
                            <div class="col-md-3 ms-auto">
                                <button type="submit" class="btn btn-primary w-100 h-100">
                                    <i class="material-icons align-middle me-2">search</i>Apply Filters
                                </button>
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
                                            <h6 class="mb-0">Total Reservations</h6>
                                            <h3 class="mb-0 fw-bold">125</h3>
                                        </div>
                                    </div>
                                    <div class="progress" style="height: 8px">
                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
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
                                            <h6 class="mb-0">Total Fruit Items</h6>
                                            <h3 class="mb-0 fw-bold">1,482</h3>
                                        </div>
                                    </div>
                                    <div class="progress" style="height: 8px">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 68%" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100"></div>
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
                                    <span id="tableTitleText">Reservation Needs by Country</span>
                                </h4>
                                <div>
                                    <button class="btn btn-outline-primary me-2">
                                        <i class="material-icons align-middle me-1 small">print</i>Print
                                    </button>
                                    <button class="btn btn-outline-success">
                                        <i class="material-icons align-middle me-1 small">download</i>Export
                                    </button>
                                </div>
                            </div>
                            
                            <div class="table-responsive reserveNeedTableContainer">
                                <!-- Country View Table -->
                                <table class="table table-hover reserveNeedTable" id="countryView">
                                    <thead>
                                        <tr>
                                            <th>Country</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Fruit Type</th>
                                            <th>Origin</th>
                                            <th>Total Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Japan -->
                                        <tr>
                                            <td rowspan="4" class="align-middle">Japan</td>
                                            <td rowspan="4" class="align-middle">48</td>
                                            <td>Apple</td>
                                            <td>Single Fruit</td>
                                            <td>California, USA</td>
                                            <td>256</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Banana</td>
                                            <td>Bunch Fruit</td>
                                            <td>Manila, Philippines</td>
                                            <td>120</td>
                                            <td>Bunch</td>
                                        </tr>
                                        <tr>
                                            <td>Strawberry</td>
                                            <td>Berry</td>
                                            <td>Osaka, Japan</td>
                                            <td>45000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td>Grapes</td>
                                            <td>Bunch Fruit</td>
                                            <td>California, USA</td>
                                            <td>75</td>
                                            <td>Bunch</td>
                                        </tr>
                                        
                                        <!-- USA -->
                                        <tr>
                                            <td rowspan="3" class="align-middle">USA</td>
                                            <td rowspan="3" class="align-middle">35</td>
                                            <td>Mango</td>
                                            <td>Single Fruit</td>
                                            <td>Manila, Philippines</td>
                                            <td>180</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Blueberry</td>
                                            <td>Berry</td>
                                            <td>Oregon, USA</td>
                                            <td>32000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td>Peach</td>
                                            <td>Single Fruit</td>
                                            <td>Georgia, USA</td>
                                            <td>210</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        
                                        <!-- Hong Kong -->
                                        <tr>
                                            <td rowspan="4" class="align-middle">Hong Kong</td>
                                            <td rowspan="4" class="align-middle">42</td>
                                            <td>Dragon Fruit</td>
                                            <td>Single Fruit</td>
                                            <td>Vietnam</td>
                                            <td>95</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Lychee</td>
                                            <td>Single Fruit</td>
                                            <td>Guangdong, China</td>
                                            <td>28000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td>Durian</td>
                                            <td>Single Fruit</td>
                                            <td>Thailand</td>
                                            <td>60</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Mangosteen</td>
                                            <td>Single Fruit</td>
                                            <td>Thailand</td>
                                            <td>150</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <!-- City View Table (Initially Hidden) -->
                                <table class="table table-hover reserveNeedTable d-none" id="cityView">
                                    <thead>
                                        <tr>
                                            <th>Country</th>
                                            <th>City</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Fruit Type</th>
                                            <th>Total Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Japan Cities -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">Japan</td>
                                            <td rowspan="2" class="align-middle">Tokyo</td>
                                            <td rowspan="2" class="align-middle">28</td>
                                            <td>Apple</td>
                                            <td>Single Fruit</td>
                                            <td>156</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Strawberry</td>
                                            <td>Berry</td>
                                            <td>25000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2" class="align-middle">Japan</td>
                                            <td rowspan="2" class="align-middle">Osaka</td>
                                            <td rowspan="2" class="align-middle">20</td>
                                            <td>Banana</td>
                                            <td>Bunch Fruit</td>
                                            <td>120</td>
                                            <td>Bunch</td>
                                        </tr>
                                        <tr>
                                            <td>Grapes</td>
                                            <td>Bunch Fruit</td>
                                            <td>75</td>
                                            <td>Bunch</td>
                                        </tr>
                                        <!-- USA Cities -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">USA</td>
                                            <td rowspan="2" class="align-middle">New York</td>
                                            <td rowspan="2" class="align-middle">18</td>
                                            <td>Mango</td>
                                            <td>Single Fruit</td>
                                            <td>95</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Blueberry</td>
                                            <td>Berry</td>
                                            <td>18000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">USA</td>
                                            <td rowspan="1" class="align-middle">Los Angeles</td>
                                            <td rowspan="1" class="align-middle">17</td>
                                            <td>Peach</td>
                                            <td>Single Fruit</td>
                                            <td>210</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <!-- Hong Kong Cities -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">Hong Kong</td>
                                            <td rowspan="2" class="align-middle">Hong Kong Island</td>
                                            <td rowspan="2" class="align-middle">22</td>
                                            <td>Dragon Fruit</td>
                                            <td>Single Fruit</td>
                                            <td>45</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Lychee</td>
                                            <td>Single Fruit</td>
                                            <td>12000</td>
                                            <td>Gram (g)</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2" class="align-middle">Hong Kong</td>
                                            <td rowspan="2" class="align-middle">Kowloon</td>
                                            <td rowspan="2" class="align-middle">20</td>
                                            <td>Durian</td>
                                            <td>Single Fruit</td>
                                            <td>60</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                        <tr>
                                            <td>Mangosteen</td>
                                            <td>Single Fruit</td>
                                            <td>150</td>
                                            <td>Piece (pc)</td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <!-- Shop View Table (Initially Hidden) -->
                                <table class="table table-hover reserveNeedTable d-none" id="shopView">
                                    <thead>
                                        <tr>
                                            <th>Country</th>
                                            <th>City</th>
                                            <th>Shop</th>
                                            <th>Total Orders</th>
                                            <th>Fruit Item</th>
                                            <th>Total Quantity</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Tokyo Shops -->
                                        <tr>
                                            <td rowspan="3" class="align-middle">Japan</td>
                                            <td rowspan="3" class="align-middle">Tokyo</td>
                                            <td rowspan="1" class="align-middle">Shibuya Store</td>
                                            <td rowspan="1" class="align-middle">15</td>
                                            <td>Apple</td>
                                            <td>86</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Shinjuku Store</td>
                                            <td rowspan="1" class="align-middle">8</td>
                                            <td>Strawberry</td>
                                            <td>15000</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Ginza Store</td>
                                            <td rowspan="1" class="align-middle">5</td>
                                            <td>Apple</td>
                                            <td>70</td>
                                        </tr>
                                        
                                        <!-- Osaka Shops -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">Japan</td>
                                            <td rowspan="2" class="align-middle">Osaka</td>
                                            <td rowspan="1" class="align-middle">Namba Store</td>
                                            <td rowspan="1" class="align-middle">12</td>
                                            <td>Banana</td>
                                            <td>80</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Umeda Store</td>
                                            <td rowspan="1" class="align-middle">8</td>
                                            <td>Grapes</td>
                                            <td>75</td>
                                        </tr>
                                        
                                        <!-- New York Shops -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">USA</td>
                                            <td rowspan="2" class="align-middle">New York</td>
                                            <td rowspan="1" class="align-middle">Manhattan Store</td>
                                            <td rowspan="1" class="align-middle">10</td>
                                            <td>Mango</td>
                                            <td>55</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Brooklyn Store</td>
                                            <td rowspan="1" class="align-middle">8</td>
                                            <td>Blueberry</td>
                                            <td>18000</td>
                                        </tr>
                                        
                                        <!-- Los Angeles Shop -->
                                        <tr>
                                            <td rowspan="1" class="align-middle">USA</td>
                                            <td rowspan="1" class="align-middle">Los Angeles</td>
                                            <td rowspan="1" class="align-middle">Downtown Store</td>
                                            <td rowspan="1" class="align-middle">17</td>
                                            <td>Peach</td>
                                            <td>210</td>
                                        </tr>
                                        
                                        <!-- Hong Kong Island Shops -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">Hong Kong</td>
                                            <td rowspan="2" class="align-middle">Hong Kong Island</td>
                                            <td rowspan="1" class="align-middle">Central Store</td>
                                            <td rowspan="1" class="align-middle">12</td>
                                            <td>Dragon Fruit</td>
                                            <td>25</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Causeway Bay Store</td>
                                            <td rowspan="1" class="align-middle">10</td>
                                            <td>Lychee</td>
                                            <td>12000</td>
                                        </tr>
                                        
                                        <!-- Kowloon Shops -->
                                        <tr>
                                            <td rowspan="2" class="align-middle">Hong Kong</td>
                                            <td rowspan="2" class="align-middle">Kowloon</td>
                                            <td rowspan="1" class="align-middle">Mong Kok Store</td>
                                            <td rowspan="1" class="align-middle">12</td>
                                            <td>Durian</td>
                                            <td>40</td>
                                        </tr>
                                        <tr>
                                            <td rowspan="1" class="align-middle">Tsim Sha Tsui Store</td>
                                            <td rowspan="1" class="align-middle">8</td>
                                            <td>Mangosteen</td>
                                            <td>150</td>
                                        </tr>
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
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-4">
                                    <h4 class="mb-4">Top Requested Fruits</h4>
                                    <div class="chartPlaceholder">
                                        <!-- This would be replaced by an actual chart in a real implementation -->
                                        <div class="chartContainer">
                                            <div class="chartBar" style="height: 180px; background-color: rgba(13, 110, 253, 0.5); width: 80%;">
                                                <span class="chartLabel">Apple</span>
                                                <span class="chartValue">256</span>
                                            </div>
                                            <div class="chartBar" style="height: 150px; background-color: rgba(25, 135, 84, 0.5); width: 80%;">
                                                <span class="chartLabel">Banana</span>
                                                <span class="chartValue">210</span>
                                            </div>
                                            <div class="chartBar" style="height: 130px; background-color: rgba(220, 53, 69, 0.5); width: 80%;">
                                                <span class="chartLabel">Mango</span>
                                                <span class="chartValue">180</span>
                                            </div>
                                            <div class="chartBar" style="height: 110px; background-color: rgba(255, 193, 7, 0.5); width: 80%;">
                                                <span class="chartLabel">Durian</span>
                                                <span class="chartValue">150</span>
                                            </div>
                                            <div class="chartBar" style="height: 90px; background-color: rgba(108, 117, 125, 0.5); width: 80%;">
                                                <span class="chartLabel">Peach</span>
                                                <span class="chartValue">120</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Chart -->
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-4">
                                    <h4 class="mb-4">Needs by Country</h4>
                                    <div class="chartPlaceholder">
                                        <!-- This would be replaced by an actual chart in a real implementation -->
                                        <div class="pieChartContainer">
                                            <div class="pieChart">
                                                <div class="pieSlice" style="--percentage: 38%; --color: rgba(13, 110, 253, 0.7);">
                                                    <span class="pieLabel">Japan</span>
                                                </div>
                                                <div class="pieSlice" style="--percentage: 28%; --color: rgba(25, 135, 84, 0.7);">
                                                    <span class="pieLabel">USA</span>
                                                </div>
                                                <div class="pieSlice" style="--percentage: 34%; --color: rgba(220, 53, 69, 0.7);">
                                                    <span class="pieLabel">Hong Kong</span>
                                                </div>
                                            </div>
                                            <div class="pieLegend">
                                                <div class="legendItem"><span class="legendColor" style="background-color: rgba(13, 110, 253, 0.7);"></span>Japan (38%)</div>
                                                <div class="legendItem"><span class="legendColor" style="background-color: rgba(25, 135, 84, 0.7);"></span>USA (28%)</div>
                                                <div class="legendItem"><span class="legendColor" style="background-color: rgba(220, 53, 69, 0.7);"></span>Hong Kong (34%)</div>
                                            </div>
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
        
        <!-- Dark Mode Toggle Button -->
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
