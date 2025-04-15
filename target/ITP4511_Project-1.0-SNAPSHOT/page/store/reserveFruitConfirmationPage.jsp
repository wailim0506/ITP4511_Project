<%-- 
    Document   : reserveFruitConfirmationPage
    Created on : 2025年4月7日, 下午4:05:43
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
        <title>Reservation Confirmed - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/store/reserveFruitConfirmationPage.css" rel="stylesheet">
    </head>
    <body>
        <nav:nav userType="shop"/>
        <% 
            //get order detail from shop_fruit_order
            OrderBean orderDetail = (OrderBean)request.getAttribute("orderDetail");
            if (orderDetail == null) {
                throw new Exception();
            }
        %>
        <!-- get order item from shop_fruit_order_item -->
        <jsp:useBean id="orderItemList" class="java.util.ArrayList" scope="request"/>

        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Reservation Submitted</h2>
                <p class="text-muted small mb-0">Your reservation has been successfully submitted and will be processed</p>
            </div>

            <!-- Main Content -->
            <div class="row g-4 justify-content-center">
                <div class="col-lg-8">
                    <!-- Success Card -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <div class="confirmationIcon mb-3">
                                    <i class="material-icons text-success">check_circle</i>
                                </div>
                                <h4 class="mb-2">Your Reservation is Submitted</h4>
                                <p class="text-muted">Reservation ID: <span class="fw-medium"><%=orderDetail.getId()%></span></p>
                            </div>
                            
                            <!-- Collection Details -->
                            <div class="collectionDetails p-3 mb-4 rounded">
                                <h5 class="mb-3"><i class="material-icons align-middle me-2">calendar_today</i>Collection Details</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <span class="mb-1 fw-medium me-2">Reservation Date:</span>
                                        <span class="mb-0"><%=orderDetail.getOrderDate()%></span>
                                    </div>
                                    <div class="col-md-6">
                                        <span class="mb-1 fw-medium me-2">Reservation Cut Off Date:</span>
                                        <span class="mb-0" id="reserveCollectDate"></span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Summary -->
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt</i>Reservation Summary</h5>
                            <div class="table-responsive mb-4">
                                <table class="table orderSummaryTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Origin</th>
                                            <th>Quantity</th>
                                            <th>Unit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                            HashMap<String, String> fruitUnitMap = new HashMap<>();
                                            fruitUnitMap.put("piece", "Piece (pc)");
                                            fruitUnitMap.put("gram", "Gram (g)");
                                            fruitUnitMap.put("bunch", "Bunch");
                                            for (int i = 0; i < orderItemList.size(); i++) {
                                                OrderBean ob = (OrderBean) orderItemList.get(i);
                                                out.println("<tr>");
                                                out.println("<td>" + ob.getFruidId() + "</td>");
                                                out.println("<td>" + ob.getFruitName() + "</td>");
                                                out.println("<td>" + ob.getCity() + ", " + ob.getCountryRegion() + "</td>");
                                                out.println("<td>" + ob.getQty() + "</td>");
                                                out.println("<td>" + fruitUnitMap.get(ob.getUnit()) + "</td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Additional Notes -->
                            <% if((orderDetail.getNotes() != null) && !orderDetail.getNotes().isEmpty()) { %>
                                <div class="additionalNotes mb-4">
                                    <h5 class="mb-2"><i class="material-icons align-middle me-2">note</i>Additional Notes</h5>
                                    <div class="p-3 rounded noteContainer">
                                        <p class="mb-0"><%=orderDetail.getNotes()%></p>
                                    </div>
                                </div>
                            <% } %>
                            
                            <!-- Buttons -->
                            <div class="d-flex flex-column flex-sm-row justify-content-center gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/page/store/index.jsp" class="btn btn-outline-secondary">
                                    <i class="material-icons align-middle me-1 small">home</i> Return to Dashboard
                                </a>
                                <a href="#" class="btn btn-primary">
                                    <i class="material-icons align-middle me-1 small">bookmark</i> View My Reservations
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Information Card -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>What Happens Next?</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">inventory</i>
                                    Your reservation will be processed and sent to the warehouse
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">edit</i>
                                    You can modify your reservation on the 13th or day before the last day of the month
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/reserveFruitConfirmationPage.js"></script>
    </body>
</html>
