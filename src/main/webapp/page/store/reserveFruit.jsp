<%-- 
    Document   : reserveFruit
    Created on : 2025年4月1日, 下午6:56:11
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reserve Fruit - ACER Shop</title>
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
        <link href="${pageContext.request.contextPath}/css/store/reserveFruit.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../../components/store/navBar.jsp" %>
        <%
            try{
                String errorMsg = (String) session.getAttribute("errorMsg");
                if(errorMsg != null && !errorMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-danger alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<strong>Error!</strong><span>" + errorMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                    session.removeAttribute("errorMsg");
                }
            }catch(Exception e){
            }  
        %>
        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Reserve Fruits</h2>
                <p class="lead">Reserve fruits for your bakery needs in the next 14 days</p>
                <p class="text-muted small mb-0">Your reservation helps us plan for efficient fruit deliveries</p>
            </div>

            <!-- Main Content -->
            <div class="row g-4">
                <!-- Reservation Form -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h4 class="mb-4"><i class="material-icons align-middle me-2">shopping_cart</i>Make Reservation for <span id="reserveCollectDate"></span></h4>

                            <form id="reservationForm" action="/ITP4511_Project/reserveFruit" method="post">
                                <input type="hidden" name="action" value="submit">
                                <!-- Date Selection -->
                                <%-- <div class="mb-4">
                                    <label class="form-label fw-medium">Delivery Date <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">event</i>
                                        </span>
                                        <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" 
                                               required>
                                    </div>
                                    <div class="form-text">Select a date from tomorrow up to 14 days from now</div>
                                </div> --%>

                                <!-- Fruit Selection -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium">Select Fruits <span class="text-danger">*</span></label>

                                    <!-- Search and Filter Bar -->
                                    <div class="mb-3">
                                        <div class="row g-2">
                                            <div class="col-md-4 col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-text border-0 bg-transparent">
                                                        <i class="material-icons text-muted">search</i>
                                                    </span>
                                                    <input type="text" class="form-control" id="fruitSearch" placeholder="Search fruits...">
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-text border-0 bg-transparent">
                                                        <i class="material-icons text-muted">category</i>
                                                    </span>
                                                    <select class="form-select" id="typeFilter">
                                                        <%
                                                            String selectedFruitType = (String) request.getAttribute("selectedType");
                                                            boolean isAllTypeSelected = selectedFruitType == null || "all".equals(selectedFruitType);
                                                        %>
                                                        <option value="all" selected>All Types</option>
                                                        <option value="--" disabled>------------------------------</option>
                                                        <jsp:useBean id="fruitTypeList" class="java.util.ArrayList" scope="request"/>
                                                        <%
                                                            for (int i = 0; i < fruitTypeList.size();i++){
                                                                String type = (String) fruitTypeList.get(i);
                                                                boolean isTypeSelected = !isAllTypeSelected && type.equals(selectedFruitType);
                                                                out.println("<option value=\"" + type + "\" " + 
                                                                           (isTypeSelected ? "selected" : "") + ">" + 
                                                                           type + "</option>");
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-sm-12">
                                                <div class="input-group">
                                                    <span class="input-group-text border-0 bg-transparent">
                                                        <i class="material-icons text-muted">public</i>
                                                    </span>
                                                    <select class="form-select" id="countryFilter">
                                                        <%
                                                            String selectedCountryRegionId = (String) request.getAttribute("selectedCountryRegionId");
                                                            boolean isAllSelected = selectedCountryRegionId == null || "all".equals(selectedCountryRegionId);
                                                        %>
                                                        <option value="all" <%= isAllSelected ? "selected" : "" %>>All Countries/ Regions</option>
                                                        <option value="--" disabled>------------------------------</option>
                                                        <jsp:useBean id="countryRegionList" class="java.util.ArrayList" scope="request"/>
                                                        <%
                                                            for (int i = 0; i < countryRegionList.size();i++){
                                                                CountryRegionBean crb = (CountryRegionBean) countryRegionList.get(i);
                                                                String crId = crb.getId();
                                                                boolean isSelected = !isAllSelected && crId.equals(selectedCountryRegionId);
                                                                out.println("<option value=\"" + crId + "\" " + 
                                                                           (isSelected ? "selected" : "") + ">" + 
                                                                           crb.getName() + "</option>");
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="button" class="btn btn-outline-secondary col-md-1 col-sm-12" id="resetFilterBtn">
                                                <i class="material-icons">refresh</i> 
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Scrollable Container for Fruits -->
                                    <div class="fruitSelectionContainer">
                                        <div class="fruitSelection">
                                            <%
                                                ArrayList<FruitsBean> fruitsList = (ArrayList<FruitsBean>)request.getAttribute("fruitsList");
                                                if (fruitsList != null && !fruitsList.isEmpty()) {
                                                    for (int i = 0; i < fruitsList.size(); i++) {
                                                        FruitsBean fruit = fruitsList.get(i);
                                            %>
                                            <% 
                                                HashMap<String, String> fruitUnitMap = new HashMap<>();
                                                fruitUnitMap.put("piece", "Piece (pc)");
                                                fruitUnitMap.put("gram", "Gram (g)");
                                                fruitUnitMap.put("bunch", "Bunch");
                                            %>
                                            <div class="fruitItem card mb-3" data-fruit-name="<%= fruit.getName().toLowerCase() %>">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="${pageContext.request.contextPath}/img/<%= fruit.getImgName() %>" alt="<%= fruit.getName() %>" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1"><%= fruit.getName() %></h5>
                                                            <p class="text-muted mb-0 small">Type: <%= fruit.getType() %></p>
                                                            <p class="text-muted mb-0 small">Origin: <%=fruit.getCity()%>, <%= fruit.getCountryRegion() %></p>

                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <%-- <p class="mb-1 small">Available: <span class="text-success">100</span></p> --%>
                                                            <p class="mb-0 small">Unit: <%=fruitUnitMap.get(fruit.getUnit())%></p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="<%= fruit.getId() %>" min="0" max="10000" value="0"
                                                                   data-unit="<%= fruit.getUnit() %>" data-name="fruit_<%= fruit.getId() %>_qty">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%}}%>
                                        </div>
                                    </div>
                                    <div class="text-center mt-2 fruitResultInfo d-none">
                                        <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                    </div>
                                </div>

                                <!-- Notes -->
                                <div class="mb-4">
                                    <label for="notes" class="form-label fw-medium">Additional Notes</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" 
                                              placeholder="Any specific requirements or comments"></textarea>
                                </div>

                                <!-- Buttons -->
                                <div class="d-flex justify-content-end gap-2 mt-4">
                                    <button type="button" id="resetFormBtn" class="btn btn-outline-danger me-auto">
                                        <i class="material-icons align-middle me-1 small">refresh</i> Reset
                                    </button>
                                    <a href="index.jsp" class="btn btn-outline-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-primary">Submit Reservation</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Reservation Summary -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt</i>Your Selection</h5>
                            <div id="reservationSummary" class="mb-3">
                                <p class="text-muted text-center py-4">No items selected yet</p>
                            </div>
                            <%-- <hr> --%>
                            <%-- <div class="d-flex justify-content-between">
                                <span>Total Items:</span>
                                <span id="totalItems">0</span>
                            </div> --%>
                        </div>
                    </div>

                    <!-- Reservation Guidelines -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Guidelines</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">calendar_today</i>
                                    Reservations will be collected every 14 days automatically (1st-14th, 15th-last day of month)
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">update</i>
                                    Reservations can be modified on the 13th and the day before the last day of month
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">inventory</i>
                                    Quantity is limited to current stock availability
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">swap_horiz</i>
                                    For immediate fruit requirements, we advise borrowing from other shops within the same city
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../../components/store/footer.jsp" %>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/reserveFruit.js"></script>
    </body>
</html>
