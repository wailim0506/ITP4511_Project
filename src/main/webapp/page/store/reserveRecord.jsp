<%-- 
    Document   : reserveRecord
    Created on : 2025年4月9日, 下午12:40:01
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <link href="${pageContext.request.contextPath}/css/store/reserveRecord.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../../components/store/navBar.jsp" %>

        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Reservation Records</h2>
                <p class="lead">View and manage your fruit reservation history</p>
                <p class="text-muted small mb-0">Track all your past and upcoming fruit reservations for planning</p>
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
                                        <input type="text" class="form-control" id="recordSearch" placeholder="Search by order ID">
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">filter_alt</i>
                                        </span>
                                        <select class="form-select" id="statusFilter">
                                            <option value="all" selected>All Status</option>
                                            <option value="Pending">Pending</option>
                                            <option value="Processing">Processing</option>
                                            <option value="Delivered">Delivered</option>
                                            <option value="Completed">Completed</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">date_range</i>
                                        </span>
                                        <select class="form-select" id="dateRangeFilter">
                                            <option value="all">All Time</option>
                                            <option value="currentMonth">Current Month</option>
                                            <option value="last90">Last 90 Days</option>
                                            <option value="ytd">Year to Date</option>
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
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt_long</i>Reservation History</h5>
                            
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
                                        <tbody>
                                            <!-- Sample Record 1 -->
                                            <tr class="reserveRecordItem">
                                                <td>
                                                    <span class="fw-medium">O0001</span>
                                                </td>
                                                <td>2025-04-01</td>
                                                <td>2025-04-15</td>
                                                <td>
                                                    <span class="badge bg-secondary">8 items</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="View Details">
                                                            <i class="material-icons small">visibility</i>
                                                        </a>
                                                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="tooltip" title="Cancel Order">
                                                            <i class="material-icons small">delete</i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <!-- Sample Record 2 -->
                                            <tr class="reserveRecordItem">
                                                <td>
                                                    <span class="fw-medium">O0002</span>
                                                </td>
                                                <td>2025-03-15</td>
                                                <td>2025-03-31</td>
                                                <td>
                                                    <span class="badge bg-secondary">12 items</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-success">Delivered</span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="View Details">
                                                            <i class="material-icons small">visibility</i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <!-- Sample Record 3 -->
                                            <tr class="reserveRecordItem">
                                                <td>
                                                    <span class="fw-medium">O0003</span>
                                                </td>
                                                <td>2025-03-14</td>
                                                <td>2025-03-15</td>
                                                <td>
                                                    <span class="badge bg-secondary">5 items</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-primary">Processing</span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="View Details">
                                                            <i class="material-icons small">visibility</i>
                                                        </a>
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="tooltip" title="Request Modification">
                                                            <i class="material-icons small">edit</i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <!-- Sample Record 4 -->
                                            <tr class="reserveRecordItem">
                                                <td>
                                                    <span class="fw-medium">O0004</span>
                                                </td>
                                                <td>2025-02-14</td>
                                                <td>2025-02-28</td>
                                                <td>
                                                    <span class="badge bg-secondary">10 items</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary">Completed</span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="View Details">
                                                            <i class="material-icons small">visibility</i>
                                                        </a>
                                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="tooltip" title="Reorder">
                                                            <i class="material-icons small">refresh</i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
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
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">calendar_today</i>Current Reservation Period</h6>
                                        <p class="mb-1 small">1st - 14th: Collection on 15th of month</p>
                                        <p class="mb-0 small">15th - End of month: Collection on 1st of next month</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="infoCard p-3 rounded bg-light">
                                        <h6 class="mb-2"><i class="material-icons align-middle me-2 small">edit_note</i>Modification Rules</h6>
                                        <p class="mb-1 small">Modifications allowed on the 13th (for first half period)</p>
                                        <p class="mb-0 small">Or day before month end (for second half period)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Record Details Modal -->
        <div class="modal fade" id="recordDetailsModal" tabindex="-1" aria-labelledby="recordDetailsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="recordDetailsModalLabel">Order Details - O0001</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="orderInfoSection mb-4">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center">
                                        <i class="material-icons text-muted me-2 small">receipt</i>
                                        <span class="text-muted">Order ID:</span>
                                    </div>
                                    <p class="fw-medium mb-0">O0001</p>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center">
                                        <i class="material-icons text-muted me-2 small">calendar_today</i>
                                        <span class="text-muted">Order Date:</span>
                                    </div>
                                    <p class="fw-medium mb-0">2025-04-01</p>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex align-items-center">
                                        <i class="material-icons text-muted me-2 small">event</i>
                                        <span class="text-muted">Collection Date:</span>
                                    </div>
                                    <p class="fw-medium mb-0">2025-04-15</p>
                                </div>
                            </div>
                        </div>
                        
                        <h6 class="mb-3"><i class="material-icons align-middle me-2 small">shopping_basket</i>Order Items</h6>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="">
                                    <tr>
                                        <th>Item</th>
                                        <th>Origin</th>
                                        <th>Quantity</th>
                                        <th>Unit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Apple</td>
                                        <td>Tokyo, Japan</td>
                                        <td>20</td>
                                        <td>Piece</td>
                                    </tr>
                                    <tr>
                                        <td>Banana</td>
                                        <td>Okinawa, Japan</td>
                                        <td>5</td>
                                        <td>Bunch</td>
                                    </tr>
                                    <tr>
                                        <td>Orange</td>
                                        <td>Osaka, Japan</td>
                                        <td>15</td>
                                        <td>Piece</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="notesSection mt-3">
                            <h6 class="mb-2"><i class="material-icons align-middle me-2 small">notes</i>Additional Notes</h6>
                            <p class="small p-3  rounded">Please ensure the apples are fresh and firm. Prefer greener bananas if possible.</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Print Details</button>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../../components/store/footer.jsp" %>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/reserveRecord.js"></script>
    </body>
</html>
