<%-- 
    Document   : reserveRecord
    Created on : 2025年4月9日, 下午12:40:01
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="ict.bean.*, java.util.*" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="jakarta.persistence.criteria.Order" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Fruit Reservation Records - ACER</title>
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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
              rel="stylesheet">

        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <link href="${pageContext.request.contextPath}/css/store/reserveRecord.css" rel="stylesheet">
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
        <%
            try{
                String errorMsg = (String) session.getAttribute("errorMsg");
                if(errorMsg != null && !errorMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-danger alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + errorMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                    session.removeAttribute("errorMsg");
                }
            }catch(Exception e){
            }  

            try{
                String successMsg = (String) session.getAttribute("successMsg");
                if(successMsg != null && !successMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-success alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + successMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                    session.removeAttribute("successMsg");
                }
            }catch(Exception e){
            }  
        %>

        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Reservation Records</h2>
                <p class="lead">View and manage your fruit reservation history</p>
            </div>

            <!-- Main Content -->
            <div class="row g-4">
                <!-- Filters and Search -->
                <div class="col-12">
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">filter_list</i>Filter Records</h5>
                            <div class="row g-3">
                                <div class="col-md-4 col-sm-12">
                                    <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">search</i>
                                                </span>
                                        <input type="text" class="form-control" id="recordSearch"
                                               placeholder="Search by order ID">
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">filter_alt</i>
                                                </span>
                                        <select class="form-select" id="statusFilter">
                                            <%
                                                String selectedStatus = (String) request.getAttribute("selectedStatus");
                                                if (selectedStatus == null) {
                                                    selectedStatus = "all";
                                                }
                                            %>
                                            <option value="all" <%= "all".equals(selectedStatus) ? "selected" : "" %>>All
                                                Status
                                            </option>
                                            <option value="Pending" <%= "Pending".equals(selectedStatus) ? "selected" : "" %>>
                                                Pending
                                            </option>
                                            <option value="Processing" <%= "Processing".equals(selectedStatus) ? "selected" : "" %>>
                                                Processing
                                            </option>
                                            <option value="Delivered" <%= "Delivered".equals(selectedStatus) ? "selected" : "" %>>
                                                Delivered
                                            </option>
                                            <option value="Finished" <%= "Finished".equals(selectedStatus) ? "selected" : "" %>>
                                                Finished
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">date_range</i>
                                                </span>
                                        <select class="form-select" id="dateRangeFilter">
                                            <%
                                                String selectedDateRange = (String) request.getAttribute("selectedDateRange");
                                                if (selectedDateRange == null) {
                                                    selectedDateRange = "all";
                                                }
                                            %>
                                            <option value="all" <%= "all".equals(selectedDateRange) ? "selected" : "" %>>All
                                                Time
                                            </option>
                                            <option value="currentMonth" <%= "currentMonth".equals(selectedDateRange) ? "selected" : "" %>>
                                                Current Month
                                            </option>
                                            <option value="last90" <%= "last90".equals(selectedDateRange) ? "selected" : "" %>>
                                                Last 90 Days
                                            </option>
                                            <option value="ytd" <%= "ytd".equals(selectedDateRange) ? "selected" : "" %>>Year to
                                                Date
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2 col-sm-12 d-flex">
                                    <button class="btn btn-outline-secondary w-100" id="resetFilterBtn">
                                        <i class="material-icons align-middle small">refresh</i> Reset
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reservation Records Table -->
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt_long</i>Reservation History
                            </h5>

                            <div class="reservationRecordsContainer">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead>
                                        <tr class="">
                                            <th scope="col">Order ID</th>
                                            <th scope="col">Date Created</th>
                                            <th scope="col">Cut-off Date</th>
                                            <th scope="col">Items</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody class="orderItemsTable">
                                        <jsp:useBean id="orderList" class="java.util.ArrayList" scope="request"/>
                                        <jsp:useBean id="orderItemQtyList" class="java.util.ArrayList" scope="request"/>
                                        <jsp:useBean id="orderCutOffDateList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            HashMap<String, String> statusColorMap = new HashMap<>();
                                            statusColorMap.put("Pending", "bg-warning text-dark");
                                            statusColorMap.put("Processing", "bg-primary");
                                            statusColorMap.put("Delivered", "bg-success");
                                            statusColorMap.put("Finished", "bg-secondary");

                                            if ((orderList != null && !orderList.isEmpty()) && (orderItemQtyList != null && !orderItemQtyList.isEmpty())) {
                                                for (int i = 0; i < orderList.size(); i++) {
                                                    OrderBean order = (OrderBean) orderList.get(i);
                                                    out.println("<tr class='reserveRecordItem'>");
                                                    out.println("<td><span class='fw-medium'>" + order.getId() + "</span></td>");
                                                    out.println("<td>" + order.getOrderDate() + "</td>");
                                                    out.println("<td>" + orderCutOffDateList.get(i) + "</td>");
                                                    out.println("<td><span class='badge bg-secondary'>" + orderItemQtyList.get(i) + " items</span></td>");
                                                    out.println("<td><span class=\"badge " + statusColorMap.get(order.getStatus()) + "\">" + order.getStatus() + "</span></td>");
                                                    out.println("<td>");
                                                    out.println("<div class='d-flex gap-2'>");
                                                    out.println("<a href='#' class='btn btn-sm btn-outline-primary' data-bs-toggle='modal' data-bs-target='#recordDetailsModal" + order.getId() + "' title='View Details'>");
                                                    out.println("<i class='material-icons small'>visibility</i>");
                                                    out.println("</a>");
                                                    
                                                    // Add "Mark as Complete" button for Delivered orders
                                                    if (order.getStatus().equals("Delivered")) {
                                                        out.println("<form method='post' action='/ITP4511_Project/reserveFruit'>");
                                                        out.println("<input type='hidden' name='action' value='markAsFinish'>");
                                                        out.println("<input type='hidden' name='id' value='" + order.getId() + "'>");
                                                        out.println("<button type='submit' class='btn btn-sm btn-outline-success' title='Mark as Finsished'>");
                                                        out.println("<i class='material-icons small'>check_circle</i>");
                                                        out.println("</button>");
                                                        out.println("</form>");
                                                    }
                                                    
                                                    out.println("</div>");
                                                    out.println("</td>");
                                                }
                                            } else {
                                                out.println("<tr><td colspan='6' class='text-center'>No records found</td></tr>");
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Information Panel -->
                <div class="col-12">
                    <div class="card border-0 shadow-sm mt-2">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Reservation Information</h5>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="infoCard p-3 rounded bg-light">
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">calendar_today</i>Current
                                            Reservation Period</h6>
                                        <p class="mb-1 small">1st - 14th: Collection on 15th of month</p>
                                        <p class="mb-0 small">15th - End of month: Collection on 1st of next month</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="infoCard p-3 rounded bg-light">
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">edit_note</i>Modification
                                            Rules</h6>
                                        <p class="mb-1 small">Modifications only allowed when the status is 'Pending'</p>
                                        <p class="mb-0 small" style="visibility:hidden">--</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Order Details -->
        <jsp:useBean id="orderItemList" class="java.util.ArrayList" scope="request"/>
        <% 
            for (int i = 0; i < orderList.size(); i++) { 
                OrderBean order = (OrderBean) orderList.get(i);
                ArrayList<OrderBean> items = (ArrayList<OrderBean>) orderItemList.get(i);
        %>
        <div class="modal fade" id="recordDetailsModal<%= order.getId() %>" tabindex="-1" aria-labelledby="recordDetailsModalLabel<%= order.getId() %>" aria-hidden="true">
            <form method="post" action="/ITP4511_Project/reserveFruit">
                <input type="hidden" name="action" value="modifyOrder">
                <input type="hidden" name="oid" value="<%= order.getId() %>">
                <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="recordDetailsModalLabel<%= order.getId() %>">Order Details - <%= order.getId() %></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="window.location.href = '/ITP4511_Project/reserveRecord?action=listAll';"></button>
                        </div>
                        <div class="modal-body">
                            <div class="orderInfoSection mb-4">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">receipt</i>
                                            <span class="text-muted">Order ID:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%= order.getId() %></p>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">calendar_today</i>
                                            <span class="text-muted">Order Date:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%= order.getOrderDate() %></p>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">event</i>
                                            <span class="text-muted">Cut-off Date:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%= orderCutOffDateList.get(i) %></p>
                                    </div>
                                </div>
                            </div>


                            <%
                                if (order.getStatus().equals("Pending")) {
                            %>
                            <div class='mb-3 d-flex flex-row justify-content-between'>
                                <h6><i class="material-icons align-middle me-2 small">shopping_basket</i>Order Items</h6>
                                <button type="button" class="btn btn-warning editBtn">Edit Order</button>
                            </div>
                            <%
                                } else {
                            %>
                            <h6 class="mb-3"><i class="material-icons align-middle me-2 small">shopping_basket</i>Order Items</h6>
                            <% }%>


                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th>Origin</th>
                                            <th>Quantity</th>
                                            <th>Unit</th>
                                            <th class="actionCol d-none">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="orderItemsTable">
                                        <% for (OrderBean item : items) { %>
                                        <tr>
                                            <td><%= item.getFruitName() %></td>
                                            <td><%= item.getCity() %>, <%= item.getCountryRegion() %></td>
                                            <td class='readQty'><%= item.getQty() %></td>
                                            <td class='d-none editQty'>
                                                <input type="number" class="form-control w-50 h-25" value="<%= item.getQty() %>" min="1" name="<%=item.getFruidId()%>">
                                            </td>
                                            <td><%= item.getUnit() %></td>
                                            <td class='d-none editQty'>
                                                <button type="button" class="btn btn-danger btn-sm deleteItemBtn">
                                                    <i class="material-icons small">delete</i>
                                                </button>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-none addItem">
                                <div class="row g-3 align-items-center mb-3">
                                    <div class="col-md-6">
                                        <select class="form-select newFruitSelect">
                                            <option value="" disabled selected>Select a fruit</option>
                                            <%
                                            ArrayList<FruitsBean> fruitsList = (ArrayList<FruitsBean>) request.getAttribute("fruitsList");
                                            ArrayList<OrderBean> items2 = (ArrayList<OrderBean>) orderItemList.get(i);
                                            HashSet<String> existingFruitIds = new HashSet<>();
                                            for (OrderBean item : items2) {
                                                existingFruitIds.add(item.getFruidId());
                                            }
                                            if (fruitsList != null && !fruitsList.isEmpty()) {
                                                for (int u = 0; u < fruitsList.size(); u++) {
                                                    FruitsBean fruit = fruitsList.get(u);
                                                    if (!existingFruitIds.contains(fruit.getId())) {
                                                        out.println("<option value='" + fruit.getId() + "' data-origin='" + fruit.getCity() + ", " + fruit.getCountryRegion() + "' data-unit='" + fruit.getUnit() + "' data-name='" + fruit.getName() + "'>" + fruit.getName() + " - " + fruit.getCity() + ", " + fruit.getCountryRegion() + "</option>");
                                                    }
                                                }
                                            }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" class="form-control newFruitQty" placeholder="Quantity" min="1">
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-success addNewItemBtn">
                                            <i class="material-icons small">add</i> Add
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="notesSection mt-3">
                                <h6 class="mb-2"><i class="material-icons align-middle me-2 small">notes</i>Additional Notes</h6>
                                <p class="small p-3 rounded"><%= order.getNotes() != null ? order.getNotes() : "No additional notes." %></p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Print Details</button>
                            <button type="submit" class="btn btn-warning d-none submitBtn">Save Changes</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <% } %>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/reserveRecord.js"></script>
    </body>
</html>
