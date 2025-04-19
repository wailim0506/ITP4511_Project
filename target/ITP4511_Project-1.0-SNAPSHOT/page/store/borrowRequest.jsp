<%-- 
    Document   : borrowRequest
    Created on : 2025年4月19日, 下午2:01:30
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
        <title>Borrow Requests - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/store/borrowRequest.css" rel="stylesheet">
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
            // try{
            //     String errorMsg = (String) session.getAttribute("errorMsg");
            //     if(errorMsg != null && !errorMsg.isEmpty()){
            //         out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
            //                     "<div class=\"alert alert-danger alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
            //                     "<span>" + errorMsg + "</span>" +
            //                     "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);\"></button>" +
            //                     "</div></div>");                    
            //         session.removeAttribute("errorMsg");
            //     }
            // }catch(Exception e){
            // }  

            // try{
            //     String successMsg = (String) session.getAttribute("successMsg");
            //     if(successMsg != null && !successMsg.isEmpty()){
            //         out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
            //                     "<div class=\"alert alert-success alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
            //                     "<span>" + successMsg + "</span>" +
            //                     "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);\"></button>" +
            //                     "</div></div>");                    
            //         session.removeAttribute("successMsg");
            //     }
            // }catch(Exception e){
            // }  
        %>

        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Incoming Borrow Requests</h2>
                <p class="lead">Review and respond to fruit borrow requests from other shops</p>
            </div>

            <!-- Main Content -->
            <div class="row g-4">
                <!-- Requests Column -->
                <div class="col-lg-8">
                    <!-- Filters and Search -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">filter_list</i>Filter Requests</h5>
                            <div class="row g-3">
                                <div class="col-md-4 col-sm-12">
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">search</i>
                                        </span>
                                        <input type="text" class="form-control" id="requestSearch" placeholder="Search requests...">
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6">
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">sort</i>
                                        </span>
                                        <select class="form-select" id="statusFilter">
                                            <option value="all" selected>All Status</option>
                                            <option value="pending">Pending</option>
                                            <option value="approved">Approved</option>
                                            <option value="rejected">Rejected</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6">
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">date_range</i>
                                        </span>
                                        <input type="date" class="form-control" id="dateFilter" 
                                               pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" 
                                               placeholder="YYYY-MM-DD" lang="en">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <jsp:useBean id="pendingBorrowRequestList" class="java.util.ArrayList" scope="request" />
                    <jsp:useBean id="pendingBorrowRequestItemList" class="java.util.ArrayList" scope="request" />
                    <!-- Pending Requests -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0"><i class="material-icons align-middle me-2">pending_actions</i>Pending Requests</h5>
                                <span class="badge bg-warning"><%=pendingBorrowRequestList.size()%> Pending</span>
                            </div>

                            <%
                                for (int i = 0; i < pendingBorrowRequestList.size(); i++) {
                                    BorrowBean borrowBean = (BorrowBean) pendingBorrowRequestList.get(i);
                                    String requestId = borrowBean.getId();
                                    String shopName = borrowBean.getRequestByShopAddress();
                                    String date = borrowBean.getRequestDate();
                                    String note = borrowBean.getNotes();
                                    out.println("<div class=\"requestItem card mb-3\" data-request-date=\"" + date + "\">");
                                        out.println("<div class=\"card-body\">");
                                            out.println("<div class=\"row\">");
                                                out.println("<div class=\"col-md-6\">");
                                                    out.println("<h6 class=\"fw-bold mb-2\">Request #" + requestId + "</h6>");
                                                    out.println("<p class=\"mb-1\"><i class=\"material-icons align-middle me-2 small\">store</i> " + shopName + "</p>");
                                                    out.println("<p class=\"mb-1\"><i class=\"material-icons align-middle me-2 small\">event</i> " + date + "</p>");
                                                    out.println("<p class=\"mb-0 text-muted small\"><i class=\"material-icons align-middle me-2 small\">note</i> " + note + "</p>");
                                                out.println("</div>");
                                                out.println("<div class=\"col-md-6\">");
                                                    out.println("<div class=\"fruitRequestList\">");
                                                        out.println("<p class=\"mb-2 fw-medium\">Requested Items:</p>");
                                                            out.println("<ul class=\"list-group list-group-flush\">");
                                                                ArrayList<BorrowBean> pendingBorrowRequestItemListById = (ArrayList<BorrowBean>) pendingBorrowRequestItemList.get(i);
                                                                for (int j = 0; j < pendingBorrowRequestItemListById.size(); j++) {
                                                                    BorrowBean borrowItem = (BorrowBean) pendingBorrowRequestItemListById.get(j);
                                                                    String fruitName = borrowItem.getFruitName();
                                                                    String origin = borrowItem.getCity() + ", " + borrowItem.getCountryRegion();
                                                                    int quantity = borrowItem.getQty();
                                                                    String unit = borrowItem.getUnit();
                                                                    out.println("<li class=\"list-group-item border-0 ps-0 py-1\">");
                                                                    out.println("<span class=\"fw-medium\">" + fruitName + " (" + origin + ")</span> - " + quantity + " " + unit);
                                                                    out.println("</li>");
                                                                }
                                                                out.println("</ul>");
                                                     out.println("</div>");
                                                out.println("</div>");
                                            out.println("</div>");
                                            out.println("<hr>");
                                            out.println("<div class=\"d-flex justify-content-between align-items-center actionButtons\">");
                                                out.println("<button class=\"btn btn-sm btn-outline-secondary\" data-bs-toggle=\"modal\" data-bs-target=\"#requestDetailsModal" + requestId + "\" data-request-id=\"" + requestId + "\">");
                                                out.println("<i class=\"material-icons align-middle me-1 small\">visibility</i> View Details");
                                                out.println("</button>");
                                                out.println("<div>");
                                                    out.println("<button class=\"btn btn-sm btn-danger me-2\" data-bs-toggle=\"modal\" data-bs-target=\"#rejectModal" + requestId +"\" data-request-id=\"" + requestId + "\">");
                                                        out.println("<i class=\"material-icons align-middle me-1 small\">close</i> Reject");
                                                    out.println("</button>");
                                                    out.println("<button class=\"btn btn-sm btn-success\" data-bs-toggle=\"modal\" data-bs-target=\"#approveModal" + requestId +"\" data-request-id=\"" + requestId + "\">");
                                                        out.println("<i class=\"material-icons align-middle me-1 small\">check</i> Approve");
                                                    out.println("</button>");
                                                out.println("</div>");
                                            out.println("</div>");
                                        out.println("</div>");
                                    out.println("</div>");
                                }
                            %>
                        </div>
                    </div>

                    <jsp:useBean id="approvedBorrowRequestList" class="java.util.ArrayList" scope="request" />
                    <jsp:useBean id="approvedBorrowRequestItemList" class="java.util.ArrayList" scope="request" />
                    <jsp:useBean id="rejectedBorrowRequestList" class="java.util.ArrayList" scope="request" />
                    <jsp:useBean id="rejectedBorrowRequestItemList" class="java.util.ArrayList" scope="request" />
                    <!-- Recent Request History -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0"><i class="material-icons align-middle me-2">history</i>Recent Request History</h5>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Shop Name</th>
                                            <th>Request Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < approvedBorrowRequestList.size(); i++) {
                                                BorrowBean borrowBean = (BorrowBean) approvedBorrowRequestList.get(i);
                                                String requestId = borrowBean.getId();
                                                String shopName = borrowBean.getRequestByShopAddress();
                                                String date = borrowBean.getRequestDate();
                                                String status = "Approved";
                                                out.println("<tr data-request-date=\"" + date + "\">");
                                                    out.println("<td>" + requestId + "</td>");
                                                    out.println("<td>" + shopName + "</td>");
                                                    out.println("<td>" + date + "</td>");
                                                    out.println("<td><span class=\"badge bg-success\">" + status + "</span></td>");
                                                    out.println("<td>");
                                                        out.println("<button class=\"btn btn-sm btn-outline-secondary\" data-bs-toggle=\"modal\" data-bs-target=\"#requestDetailsModal" + requestId + "\" data-request-id=\"" + requestId + "\">");
                                                            out.println("<i class=\"material-icons align-middle small\">visibility</i>");
                                                        out.println("</button>");
                                                    out.println("</td>");
                                                out.println("</tr>");
                                            }
                                            for (int i = 0; i < rejectedBorrowRequestList.size(); i++) {
                                                BorrowBean borrowBean = (BorrowBean) rejectedBorrowRequestList.get(i);
                                                String requestId = borrowBean.getId();
                                                String shopName = borrowBean.getRequestByShopAddress();
                                                String date = borrowBean.getRequestDate();
                                                String status = "Rejected";
                                                out.println("<tr data-request-date=\"" + date + "\">");
                                                    out.println("<td>" + requestId + "</td>");
                                                    out.println("<td>" + shopName + "</td>");
                                                    out.println("<td>" + date + "</td>");
                                                    out.println("<td><span class=\"badge bg-danger\">" + status + "</span></td>");
                                                    out.println("<td>");
                                                        out.println("<button class=\"btn btn-sm btn-outline-secondary\" data-bs-toggle=\"modal\" data-bs-target=\"#requestDetailsModal" + requestId + "\" data-request-id=\"" + requestId + "\">");
                                                            out.println("<i class=\"material-icons align-middle small\">visibility</i>");
                                                        out.println("</button>");
                                                    out.println("</td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Request Statistics -->
                    <%
                        String pendingNumIn30Day = (String)request.getAttribute("pendingNumIn30Day");
                        String approvedNumIn30Day = (String)request.getAttribute("approvedNumIn30Day");
                        String rejectedNumIn30Day = (String)request.getAttribute("rejectedNumIn30Day");
                        if (pendingNumIn30Day == null || approvedNumIn30Day == null || rejectedNumIn30Day == null) {
                            throw new Exception();
                        }
                    %>
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">bar_chart</i>Request Statistics</h5>
                            <div class="row g-3">
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-primary bg-opacity-10">
                                        <h3 class="fw-bold text-primary mb-0"><%=pendingNumIn30Day%></h3>
                                        <p class="small mb-0">Pending</p>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-success bg-opacity-10">
                                        <h3 class="fw-bold text-success mb-0"><%=approvedNumIn30Day%></h3>
                                        <p class="small mb-0">Approved</p>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-danger bg-opacity-10">
                                        <h3 class="fw-bold text-danger mb-0"><%=rejectedNumIn30Day%></h3>
                                        <p class="small mb-0">Rejected</p>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <p class="text-muted small mb-0">Last 30 days activity</p>
                        </div>
                    </div>

                    <!-- Available Stock -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">inventory_2</i>Your Available Stock</h5>
                            <div class="table-responsive">
                                <table class="table table-sm">
                                    <thead>
                                        <tr>
                                            <th>Fruit</th>
                                            <th>Origin</th>
                                            <th>Available</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <jsp:useBean id="stockList" class="java.util.ArrayList" scope="request" />
                                        <%
                                            for (int i = 0; i < stockList.size(); i++) {
                                                ShopFruitStockBean stock = (ShopFruitStockBean) stockList.get(i);
                                                out.println("<tr>");
                                                out.println("<td>" + stock.getFruitName() + "</td>");
                                                out.println("<td>" + stock.getCity() + ", " + stock.getCountryRegion() + "</td>");
                                                out.println("<td>" + stock.getQty() + " " + stock.getUnit() + "</td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <button class="btn btn-sm btn-outline-primary w-100 mt-2">
                                <i class="material-icons align-middle me-1 small">refresh</i>Update Stock
                            </button>
                        </div>
                    </div>

                    <!-- Guidelines -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Guidelines</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">check_circle</i>
                                    Check your current stock before approving requests
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">schedule</i>
                                    Respond to requests as soon as possible
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">priority_high</i>
                                    If rejecting, provide a reason
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">swap_horiz</i>
                                    Coordinate pickup/delivery with the requesting shop
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modals -->
        <!-- Request Details Modal -->
        <%
            for (int i = 0; i < pendingBorrowRequestList.size(); i++) {
                BorrowBean borrowBean = (BorrowBean) pendingBorrowRequestList.get(i);
                String requestId = borrowBean.getId();
                String shopName = borrowBean.getRequestByShopAddress();
                String date = borrowBean.getRequestDate();
                String note = borrowBean.getNotes();
                out.println("<div class=\"modal fade\" id=\"requestDetailsModal" + requestId + "\" tabindex=\"-1\" aria-labelledby=\"requestDetailsModalLabel\" aria-hidden=\"true\">");
                    out.println("<div class=\"modal-dialog modal-lg\">");
                        out.println("<div class=\"modal-content\">");
                            out.println("<div class=\"modal-header\">");
                                out.println("<h5 class=\"modal-title\" id=\"requestDetailsModalLabel\">Request Details: #" + requestId + "</h5>");
                                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>");
                            out.println("</div>");
                            out.println("<div class=\"modal-body\">");
                                out.println("<div class=\"row mb-4\">");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Request Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Request ID:</strong> " + requestId + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Date:</strong> " + date + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Status:</strong> <span class=\"badge bg-warning\">Pending</span></p>");
                                    out.println("</div>");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Shop Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Shop:</strong> " + shopName + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Contact:</strong>" + borrowBean.getRequestByShopPhone() + "</p>");
                                    out.println("</div>");
                                out.println("</div>");
                                out.println("<h6 class=\"text-muted mb-3\">Requested Items</h6>");
                                out.println("<div class=\"table-responsive mb-4\">");
                                    out.println("<table class=\"table\">");
                                        out.println("<thead>");
                                            out.println("<tr>");
                                                out.println("<th>Fruit</th>");
                                                out.println("<th>Origin</th>");
                                                out.println("<th>Quantity</th>");
                                            out.println("</tr>");
                                        out.println("</thead>");
                                        out.println("<tbody>");
                                            ArrayList<BorrowBean> pendingBorrowRequestItemListById = (ArrayList<BorrowBean>) pendingBorrowRequestItemList.get(i);
                                            for (int j = 0; j < pendingBorrowRequestItemListById.size(); j++) {
                                                BorrowBean borrowItem = (BorrowBean) pendingBorrowRequestItemListById.get(j);
                                                String fruitName = borrowItem.getFruitName();
                                                String origin = borrowItem.getCity() + ", " + borrowItem.getCountryRegion();
                                                int quantity = borrowItem.getQty();
                                                String unit = borrowItem.getUnit();
                                                int currentStock = 5; 
                                                out.println("<tr>");
                                                    out.println("<td>" + fruitName + "</td>");
                                                    out.println("<td>" + origin + "</td>");
                                                    out.println("<td>" + quantity + " " + unit +"</td>");
                                                out.println("</tr>");
                                            }
                                        out.println("</tbody>");
                                    out.println("</table>");
                                out.println("</div>");
                                out.println("<div class=\"mb-3\">");
                                    out.println("<h6 class=\"text-muted mb-2\">Request Notes</h6>");
                                    out.println("<p>" + note + "</p>");
                                out.println("</div>");
                            out.println("</div>");
                            out.println("<div class=\"modal-footer\">");
                                out.println("<button type=\"button\" class=\"btn btn-outline-secondary\" data-bs-dismiss=\"modal\">Close</button>");
                                out.println("<button type=\"button\" class=\"btn btn-danger me-2\" data-bs-toggle=\"modal\" data-bs-target=\"#rejectModal" + requestId +"\" data-bs-dismiss=\"modal\">");
                                    out.println("<i class=\"material-icons align-middle me-1 small\">close</i> Reject");
                                out.println("</button>");
                                out.println("<button type=\"button\" class=\"btn btn-success\" data-bs-toggle=\"modal\" data-bs-target=\"#approveModal" + requestId + "\" data-bs-dismiss=\"modal\">");
                                    out.println("<i class=\"material-icons align-middle me-1 small\">check</i> Approve");
                                out.println("</button>");
                            out.println("</div>");
                        out.println("</div>");
                    out.println("</div>");
                out.println("</div>");
            }

            for (int i = 0; i < approvedBorrowRequestList.size(); i++) {
                BorrowBean borrowBean = (BorrowBean) approvedBorrowRequestList.get(i);
                String requestId = borrowBean.getId();
                String shopName = borrowBean.getRequestByShopAddress();
                String date = borrowBean.getRequestDate();
                String note = borrowBean.getNotes();
                out.println("<div class=\"modal fade\" id=\"requestDetailsModal" + requestId + "\" tabindex=\"-1\" aria-labelledby=\"requestDetailsModalLabel\" aria-hidden=\"true\">");
                    out.println("<div class=\"modal-dialog modal-lg\">");
                        out.println("<div class=\"modal-content\">");
                            out.println("<div class=\"modal-header\">");
                                out.println("<h5 class=\"modal-title\" id=\"requestDetailsModalLabel\">Request Details: #" + requestId + "</h5>");
                                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>");
                            out.println("</div>");
                            out.println("<div class=\"modal-body\">");
                                out.println("<div class=\"row mb-4\">");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Request Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Request ID:</strong> " + requestId + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Date:</strong> " + date + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Status:</strong> <span class=\"badge bg-success\">Approved</span></p>");
                                    out.println("</div>");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Shop Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Shop:</strong> " + shopName + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Contact:</strong>" + borrowBean.getRequestByShopPhone() + "</p>");
                                    out.println("</div>");
                                out.println("</div>");
                                out.println("<h6 class=\"text-muted mb-3\">Requested Items</h6>");
                                out.println("<div class=\"table-responsive mb-4\">");
                                    out.println("<table class=\"table\">");
                                        out.println("<thead>");
                                            out.println("<tr>");
                                                out.println("<th>Fruit</th>");
                                                out.println("<th>Origin</th>");
                                                out.println("<th>Quantity</th>");
                                            out.println("</tr>");
                                        out.println("</thead>");
                                        out.println("<tbody>");
                                            ArrayList<BorrowBean> approvedBorrowRequestItemListById = (ArrayList<BorrowBean>) approvedBorrowRequestItemList.get(i);
                                            for (int j = 0; j < approvedBorrowRequestItemListById.size(); j++) {
                                                BorrowBean borrowItem = (BorrowBean) approvedBorrowRequestItemListById.get(j);
                                                String fruitName = borrowItem.getFruitName();
                                                String origin = borrowItem.getCity() + ", " + borrowItem.getCountryRegion();
                                                int quantity = borrowItem.getQty();
                                                String unit = borrowItem.getUnit();
                                                int currentStock = 5; 
                                                out.println("<tr>");
                                                    out.println("<td>" + fruitName + "</td>");
                                                    out.println("<td>" + origin + "</td>");
                                                    out.println("<td>" + quantity + " " + unit +"</td>");
                                                out.println("</tr>");
                                            }
                                        out.println("</tbody>");
                                    out.println("</table>");
                                out.println("</div>");
                                out.println("<div class=\"mb-3\">");
                                    out.println("<h6 class=\"text-muted mb-2\">Request Notes</h6>");
                                    out.println("<p>" + note + "</p>");
                                out.println("</div>");
                            out.println("</div>");
                            out.println("<div class=\"modal-footer\">");
                                out.println("<button type=\"button\" class=\"btn btn-outline-secondary\" data-bs-dismiss=\"modal\">Close</button>");
                                out.println("<button type=\"button\" class=\"btn btn-danger me-2\" data-bs-toggle=\"modal\" data-bs-target=\"#rejectModal" + requestId +"\" data-bs-dismiss=\"modal\">");
                                    out.println("<i class=\"material-icons align-middle me-1 small\">close</i> Reject");
                                out.println("</button>");
                                out.println("<button type=\"button\" class=\"btn btn-success\" data-bs-toggle=\"modal\" data-bs-target=\"#approveModal" + requestId + "\" data-bs-dismiss=\"modal\">");
                                    out.println("<i class=\"material-icons align-middle me-1 small\">check</i> Approve");
                                out.println("</button>");
                            out.println("</div>");
                        out.println("</div>");
                    out.println("</div>");
                out.println("</div>");
            }

            for (int i = 0; i < rejectedBorrowRequestList.size(); i++) {
                BorrowBean borrowBean = (BorrowBean) rejectedBorrowRequestList.get(i);
                String requestId = borrowBean.getId();
                String shopName = borrowBean.getRequestByShopAddress();
                String date = borrowBean.getRequestDate();
                String note = borrowBean.getNotes();
                String rejectReasonSelect = borrowBean.getRejectReasonSelect();
                String rejectionReason = borrowBean.getRejectReason();
                out.println("<div class=\"modal fade\" id=\"requestDetailsModal" + requestId + "\" tabindex=\"-1\" aria-labelledby=\"requestDetailsModalLabel\" aria-hidden=\"true\">");
                    out.println("<div class=\"modal-dialog modal-lg\">");
                        out.println("<div class=\"modal-content\">");
                            out.println("<div class=\"modal-header\">");
                                out.println("<h5 class=\"modal-title\" id=\"requestDetailsModalLabel\">Request Details: #" + requestId + "</h5>");
                                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>");
                            out.println("</div>");
                            out.println("<div class=\"modal-body\">");
                                out.println("<div class=\"row mb-4\">");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Request Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Request ID:</strong> " + requestId + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Date:</strong> " + date + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Status:</strong> <span class=\"badge bg-danger\">Rejected</span></p>");
                                    out.println("</div>");
                                    out.println("<div class=\"col-md-6\">");
                                        out.println("<h6 class=\"text-muted mb-2\">Shop Information</h6>");
                                        out.println("<p class=\"mb-1\"><strong>Shop:</strong> " + shopName + "</p>");
                                        out.println("<p class=\"mb-1\"><strong>Contact:</strong> " + borrowBean.getRequestByShopPhone() + "</p>");
                                    out.println("</div>");
                                out.println("</div>");
                                out.println("<h6 class=\"text-muted mb-3\">Requested Items</h6>");
                                out.println("<div class=\"table-responsive mb-4\">");
                                    out.println("<table class=\"table\">");
                                        out.println("<thead>");
                                            out.println("<tr>");
                                                out.println("<th>Fruit</th>");
                                                out.println("<th>Origin</th>");
                                                out.println("<th>Quantity</th>");
                                            out.println("</tr>");
                                        out.println("</thead>");
                                        out.println("<tbody>");
                                            ArrayList<BorrowBean> rejectedBorrowRequestItemListById = (ArrayList<BorrowBean>) rejectedBorrowRequestItemList.get(i);
                                            for (int j = 0; j < rejectedBorrowRequestItemListById.size(); j++) {
                                                BorrowBean borrowItem = (BorrowBean) rejectedBorrowRequestItemListById.get(j);
                                                String fruitName = borrowItem.getFruitName();
                                                String origin = borrowItem.getCity() + ", " + borrowItem.getCountryRegion();
                                                int quantity = borrowItem.getQty();
                                                String unit = borrowItem.getUnit();
                                                out.println("<tr>");
                                                    out.println("<td>" + fruitName + "</td>");
                                                    out.println("<td>" + origin + "</td>");
                                                    out.println("<td>" + quantity + " " + unit +"</td>");
                                                out.println("</tr>");
                                            }
                                        out.println("</tbody>");
                                    out.println("</table>");
                                out.println("</div>");
                                out.println("<div class=\"mb-3\">");
                                    out.println("<h6 class=\"text-muted mb-2\">Request Notes</h6>");
                                    out.println("<p>" + note + "</p>");
                                out.println("</div>");
                                out.println("<div class=\"mb-3\">");
                                    out.println("<h6 class=\"text-muted mb-2 text-danger\">Reject Reason </h6>");
                                    out.println("<p>" + rejectReasonSelect + "</p>");
                                out.println("</div>");
                                out.println("<div class=\"mb-3\">");
                                    out.println("<h6 class=\"text-muted mb-2 text-danger\">Reject Detail</h6>");
                                    if (rejectionReason == null || rejectionReason.isEmpty()) {
                                        out.println("<p class=\"text-muted\">No detail provided</p>");
                                    } else {
                                        out.println("<p>" + rejectionReason + "</p>");
                                    }
                                out.println("</div>");
                            out.println("</div>");
                            out.println("<div class=\"modal-footer\">");
                                out.println("<button type=\"button\" class=\"btn btn-outline-secondary\" data-bs-dismiss=\"modal\">Close</button>");
                            out.println("</div>");
                        out.println("</div>");
                    out.println("</div>");
                out.println("</div>");
            }
        %>

        <!-- Approve Modal -->
        <%
            for (int i = 0; i < pendingBorrowRequestList.size(); i++) {
                BorrowBean borrowBean = (BorrowBean) pendingBorrowRequestList.get(i);
                String requestId = borrowBean.getId();
                out.println("<div class=\"modal fade\" id=\"approveModal" + requestId + "\" tabindex=\"-1\" aria-labelledby=\"approveModalLabel\" aria-hidden=\"true\">");
                    out.println("<div class=\"modal-dialog\">");
                        out.println("<div class=\"modal-content\">");
                            out.println("<div class=\"modal-header\">");
                                out.println("<h5 class=\"modal-title\" id=\"approveModalLabel\">Approve Request #" + requestId + "</h5>");
                                out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>");
                            out.println("</div>");
                            out.println("<div class=\"modal-body\">");
                                out.println("<p>You're about to approve this fruit borrow request.</p>");
                                out.println("<div class=\"alert alert-info mb-3\">");
                                    out.println("<i class=\"material-icons align-middle me-2\">info</i>");
                                    out.println("Stock will be deducted automatically.");
                                out.println("</div>");
                            out.println("</div>");
                            out.println("<div class=\"modal-footer\">");
                                out.println("<form method=\'post\' action=\"/ITP4511_Project/borrowRequest\">");
                                    out.println("<input type=\"hidden\" name=\"action\" value=\"approve\">");
                                    out.println("<input type=\"hidden\" name=\"requestId\" value=\"" + requestId + "\">");
                                    out.println("<button type=\"button\" class=\"btn btn-outline-secondary\" data-bs-dismiss=\"modal\">Cancel</button>");
                                    out.println("<button type=\"submit\" class=\"btn btn-success\" data-bs-dismiss=\"modal\">");
                                        out.println("<i class=\"material-icons align-middle me-1 small\">check</i> Confirm Approval");
                                    out.println("</button>");
                                out.println("</form>");
                            out.println("</div>");
                        out.println("</div>");
                    out.println("</div>");
                out.println("</div>");
            }
        %>

        
        <!-- Reject Modal -->
        <%
            for (int i = 0; i < pendingBorrowRequestList.size(); i++) {
                BorrowBean borrowBean = (BorrowBean) pendingBorrowRequestList.get(i);
                String requestId = borrowBean.getId();
                out.println("<div class=\"modal fade\" id=\"rejectModal" + requestId + "\" tabindex=\"-1\" aria-labelledby=\"rejectModalLabel\" aria-hidden=\"true\">");
                    out.println("<form method=\'post\' action=\"/ITP4511_Project/borrowRequest\">");
                        out.println("<div class=\"modal-dialog\">");
                            out.println("<div class=\"modal-content\">");
                                out.println("<div class=\"modal-header\">");
                                    out.println("<h5 class=\"modal-title\" id=\"rejectModalLabel\">Reject Request #" + requestId + "</h5>");
                                    out.println("<input type=\"hidden\" name=\"action\" value=\"reject\">");
                                    out.println("<input type=\"hidden\" name=\"requestId\" value=\"" + requestId + "\">");
                                    out.println("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>");
                                out.println("</div>");
                                out.println("<div class=\"modal-body\">");
                                    out.println("<p>You're about to reject this fruit borrow request.</p>");

                                    out.println("<div class=\"alert alert-warning mb-3\">");
                                        out.println("<i class=\"material-icons align-middle me-2\">warning</i>");
                                        out.println("Please provide a reason for rejection");
                                    out.println("</div>");

                                    out.println("<div class=\"mb-3\">");
                                        out.println("<label for=\"rejectionReason\" class=\"form-label\">Reason for Rejection <span class=\"text-danger\">*</span></label>");
                                        out.println("<select class=\"form-select mb-2\" id=\"rejectReasonSelect\" required name=\"rejectReasonSelect\">");
                                            out.println("<option value=\"\"  disabled>Select a reason</option>");
                                            out.println("<option value=\"Insufficient stock available\">Insufficient stock available</option>");
                                            out.println("<option value=\"Items already reserved for another shop\">Items already reserved for another shop</option>");
                                            out.println("<option value=\"Quality issues with current stock\">Quality issues with current stock</option>");
                                            out.println("<option value=\"Other (please specify)\">Other (please specify)</option>");
                                        out.println("</select>");
                                        out.println("<textarea class=\"form-control\" name=\"rejectReason\" id=\"rejectReason\" rows=\"2\" placeholder=\"Provide details about the rejection reason...\"></textarea>");
                                    out.println("</div>");
                                out.println("</div>");
                                out.println("<div class=\"modal-footer\">");
                                    out.println("<button type=\"button\" class=\"btn btn-outline-secondary\" data-bs-dismiss=\"modal\">Cancel</button>");
                                    out.println("<button type=\"submit\" class=\"btn btn-danger\" data-bs-dismiss=\"modal\">");
                                        out.println("<i class=\"material-icons align-middle me-1 small\">close</i> Confirm Rejection");
                                    out.println("</button>");
                                out.println("</div>");
                            out.println("</div>");
                        out.println("</div>");
                    out.println("</form>");
                out.println("</div>");
            }
        %>
        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/borrowRequest.js"></script>
    </body>
</html>
