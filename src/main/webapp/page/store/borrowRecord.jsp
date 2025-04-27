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
        <title>Fruit Borrow Records - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/store/borrowRecord.css" rel="stylesheet">
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
                <h2 class="display-6 fw-bold text-primary">Borrow Records</h2>
                <p class="lead">View and manage your fruit borrowing history</p>
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
                                               placeholder="Search by Borrow ID">
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
                                            <option value="Approved" <%= "Approved".equals(selectedStatus) ? "selected" : "" %>>
                                                Approved
                                            </option>
                                            <option value="Rejected" <%= "Rejected".equals(selectedStatus) ? "selected" : "" %>>
                                                Rejected
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
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt_long</i>Borrow History
                            </h5>

                            <div class="reservationRecordsContainer">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead>
                                        <tr class="">
                                            <th scope="col">Borrow ID</th>
                                            <th scope="col">Date Created</th>
                                            <th scope="col">Borrow From</th>
                                            <th scope="col">Items</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody class="orderItemsTable">
                                        <jsp:useBean id="orderList" class="java.util.ArrayList" scope="request"/>
                                        <jsp:useBean id="orderItemQtyList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            HashMap<String, String> statusColorMap = new HashMap<>();
                                            statusColorMap.put("Pending", "bg-warning text-dark");
                                            statusColorMap.put("Approved", "bg-success");
                                            statusColorMap.put("Rejected", "bg-danger");

                                            if ((orderList != null && !orderList.isEmpty()) && (orderItemQtyList != null && !orderItemQtyList.isEmpty())) {
                                                for (int i = 0; i < orderList.size(); i++) {
                                                    BorrowBean order = (BorrowBean) orderList.get(i);
                                                    String completed = order.getCompleted();
                                                    out.println("<tr class='reserveRecordItem'>");
                                                    out.println("<td><span class='fw-medium'>" + order.getId() + "</span></td>");
                                                    out.println("<td>" + order.getRequestDate() + "</td>");
                                                    out.println("<td>" + order.getRequestToShopAddress() + "</td>");
                                                    out.println("<td><span class='badge bg-secondary'>" + orderItemQtyList.get(i) + " items</span></td>");
                                                    if (order.getStatus().equals("Approved")){
                                                        if (completed.equals("Y")){
                                                            out.println("<td><span class=\"badge " + statusColorMap.get(order.getStatus()) + "\">" + order.getStatus() + "</span><span class=\"badge bg-info ms-2\">Completed</span></td>");
                                                        }else{
                                                            out.println("<td><span class=\"badge " + statusColorMap.get(order.getStatus()) + "\">" + order.getStatus() + "</span></td>");
                                                        }
                                                    }else{
                                                        out.println("<td><span class=\"badge " + statusColorMap.get(order.getStatus()) + "\">" + order.getStatus() + "</span></td>");
                                                    }
                                                    out.println("<td>");
                                                    out.println("<div class='d-flex gap-2'>");
                                                    out.println("<a href='#' class='btn btn-sm btn-outline-primary' data-bs-toggle='modal' data-bs-target='#recordDetailsModal" + order.getId() + "' title='View Details'>");
                                                    out.println("<i class='material-icons small'>visibility</i>");
                                                    out.println("</a>");
                                                    if (order.getStatus().equals("Approved") && completed.equals("N")) {
                                                        out.println("<form method='post' action='/ITP4511_Project/borrowFruit'>");
                                                        out.println("<input type='hidden' name='action' value='markAsCompleted'>");
                                                        out.println("<input type='hidden' name='id' value='" + order.getId() + "'>");
                                                        out.println("<button type='submit' class='btn btn-sm btn-outline-success' title='Mark as Completed'>");
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
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Borrowing Policies</h5>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="infoCard p-3 rounded bg-light">
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">store</i>Fruit Borrowing Information</h6>
                                        <p class="mb-1 small">Shops can borrow fruits only from other shops in the same city</p>
                                        <p class="mb-0 small">Check stock levels first before creating a borrowing request</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="infoCard p-3 rounded bg-light">
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">event_note</i>Edit Borrowing Policy</h6>
                                        <p class="mb-0 small">No modifications allowed once submitted - create a new request if changes needed</p>
                                        <p class="mb-0 small" style="visibility:hidden">--</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Detail Modal --%>
        <jsp:useBean id="orderItemList" class="java.util.ArrayList" scope="request"/>
        <% 
            for (int i = 0; i < orderList.size(); i++) { 
                BorrowBean order = (BorrowBean) orderList.get(i);
                ArrayList<BorrowBean> items = (ArrayList<BorrowBean>) orderItemList.get(i);
        %>
        <div class="modal fade" id="recordDetailsModal<%= order.getId() %>" tabindex="-1" aria-labelledby="recordDetailsModalLabel<%= order.getId() %>" aria-hidden="true">
            <form method="post" action="/ITP4511_Project/reserveFruit">
                <input type="hidden" name="action" value="modifyOrder">
                <input type="hidden" name="oid" value="<%= order.getId() %>">
                <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="recordDetailsModalLabel<%= order.getId() %>">Borrow Details - <%= order.getId() %></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="orderInfoSection mb-4">
                                <div class="row g-3">
                                    <div class="col-md-2">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">receipt</i>
                                            <span class="text-muted">Borrow ID:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%= order.getId() %></p>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">calendar_today</i>
                                            <span class="text-muted">Request Date:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%= order.getRequestDate() %></p>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">store</i>
                                            <span class="text-muted">Borrow From:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%=order.getRequestToShopAddress()%></p>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="d-flex align-items-center">
                                            <i class="material-icons text-muted me-2 small">phone</i>
                                            <span class="text-muted">Contact Number:</span>
                                        </div>
                                        <p class="fw-medium mb-0"><%=order.getRequestToShopPhone()%></p>
                                    </div>
                                </div>
                            </div>


                            
                            <h6 class="mb-3"><i class="material-icons align-middle me-2 small">shopping_basket</i>Borrow Items</h6>
                


                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th>Origin</th>
                                            <th>Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody class="orderItemsTable">
                                        <% for (BorrowBean item : items) { %>
                                            <tr>
                                                <td><%= item.getFruitName() %></td>
                                                <td><%= item.getCity() %>, <%= item.getCountryRegion() %></td>
                                                <td class='readQty'><%= item.getQty() %></td>
                                                <td><%= item.getUnit() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="notesSection mt-3">
                                <h6 class="mb-2"><i class="material-icons align-middle me-2 small">notes</i>Additional Notes</h6>
                                <p class="small p-3 rounded"><%= order.getNotes() != null ? order.getNotes() : "No additional notes." %></p>
                            </div>
                            
                            <% if ("Rejected".equals(order.getStatus())) { %>
                            <div class="rejectionSection mt-3 border-top pt-3">
                                <div class="mb-3">
                                    <h6 class="mb-2"><i class="material-icons align-middle me-2 small">cancel</i>Reject Reason</h6>
                                    <p class="small p-3 rounded "><%= order.getRejectReasonSelect() != null ? order.getRejectReasonSelect() : "No reason specified" %></p>
                                </div>
                                <div class="mb-3">
                                    <h6 class="mb-2 "><i class="material-icons align-middle me-2 small">description</i>Reject Detail</h6>
                                    <% if (order.getRejectReason() == null || order.getRejectReason().isEmpty()) { %>
                                        <p class="small p-3 rounded">No detail provided</p>
                                    <% } else { %>
                                        <p class="small p-3 rounded "><%= order.getRejectReason() %></p>
                                    <% } %>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Print Details</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <% } %>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/borrowRecord.js"></script>
    </body>
</html>
