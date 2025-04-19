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
        <%-- Hardcoded for design purposes - would normally come from session --%>
        <% String staffName = "John Doe"; %>
        <nav:nav userType="shop" staffName="<%=staffName%>"/>

        <%-- Mock alert messages for design purposes --%>
        <div class='alertDiv d-none' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>
            <div class="alert alert-success alert-dismissible fade show" style='width: 80%; text-align: center; position: relative;'>
                <span>Request successfully processed!</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>
            </div>
        </div>

        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Incoming Borrow Requests</h2>
                <p class="lead">Review and respond to fruit borrow requests from other shops</p>
                <p class="text-muted small mb-0">Help other shops in your city by sharing your fruit inventory</p>
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
                                            <option value="all" selected>All Statuses</option>
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
                                        <input type="date" class="form-control" id="dateFilter">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Requests -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0"><i class="material-icons align-middle me-2">pending_actions</i>Pending Requests</h5>
                                <span class="badge bg-warning">3 Pending</span>
                            </div>

                            <!-- Request Item 1 -->
                            <div class="requestItem card mb-3">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6 class="fw-bold mb-2">Request #B001</h6>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">store</i> Sweet Bakery (Central)</p>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">event</i> April 18, 2025</p>
                                            <p class="mb-0 text-muted small"><i class="material-icons align-middle me-2 small">note</i> Urgent need for weekend special cake production</p>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="fruitRequestList">
                                                <p class="mb-2 fw-medium">Requested Items:</p>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item border-0 ps-0 py-1">
                                                        <span class="fw-medium">Strawberry (USA)</span> - 2 kg
                                                    </li>
                                                    <li class="list-group-item border-0 ps-0 py-1">
                                                        <span class="fw-medium">Blueberry (USA)</span> - 500 g
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between align-items-center actionButtons">
                                        <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B001">
                                            <i class="material-icons align-middle me-1 small">visibility</i> View Details
                                        </button>
                                        <div>
                                            <button class="btn btn-sm btn-danger me-2" data-bs-toggle="modal" data-bs-target="#rejectModal" data-request-id="B001">
                                                <i class="material-icons align-middle me-1 small">close</i> Reject
                                            </button>
                                            <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#approveModal" data-request-id="B001">
                                                <i class="material-icons align-middle me-1 small">check</i> Approve
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Request Item 2 -->
                            <div class="requestItem card mb-3">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6 class="fw-bold mb-2">Request #B002</h6>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">store</i> Happy Baker (Central)</p>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">event</i> April 19, 2025</p>
                                            <p class="mb-0 text-muted small"><i class="material-icons align-middle me-2 small">note</i> Need for special order tomorrow</p>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="fruitRequestList">
                                                <p class="mb-2 fw-medium">Requested Items:</p>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item border-0 ps-0 py-1">
                                                        <span class="fw-medium">Mango (Japan)</span> - 5 pieces
                                                    </li>
                                                    <li class="list-group-item border-0 ps-0 py-1">
                                                        <span class="fw-medium">Kiwi (Japan)</span> - 10 pieces
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between align-items-center actionButtons">
                                        <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B002">
                                            <i class="material-icons align-middle me-1 small">visibility</i> View Details
                                        </button>
                                        <div>
                                            <button class="btn btn-sm btn-danger me-2" data-bs-toggle="modal" data-bs-target="#rejectModal" data-request-id="B002">
                                                <i class="material-icons align-middle me-1 small">close</i> Reject
                                            </button>
                                            <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#approveModal" data-request-id="B002">
                                                <i class="material-icons align-middle me-1 small">check</i> Approve
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Request Item 3 -->
                            <div class="requestItem card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6 class="fw-bold mb-2">Request #B003</h6>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">store</i> Sunflower Bakery (Central)</p>
                                            <p class="mb-1"><i class="material-icons align-middle me-2 small">event</i> April 19, 2025</p>
                                            <p class="mb-0 text-muted small"><i class="material-icons align-middle me-2 small">note</i> Preparing for weekend promotion</p>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="fruitRequestList">
                                                <p class="mb-2 fw-medium">Requested Items:</p>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item border-0 ps-0 py-1">
                                                        <span class="fw-medium">Apple (Hong Kong)</span> - 20 pieces
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between align-items-center actionButtons">
                                        <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B003">
                                            <i class="material-icons align-middle me-1 small">visibility</i> View Details
                                        </button>
                                        <div>
                                            <button class="btn btn-sm btn-danger me-2" data-bs-toggle="modal" data-bs-target="#rejectModal" data-request-id="B003">
                                                <i class="material-icons align-middle me-1 small">close</i> Reject
                                            </button>
                                            <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#approveModal" data-request-id="B003">
                                                <i class="material-icons align-middle me-1 small">check</i> Approve
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Request History -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0"><i class="material-icons align-middle me-2">history</i>Recent Request History</h5>
                                <a href="#" class="text-decoration-none small">View All</a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Shop Name</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>B000</td>
                                            <td>Sweet Bakery</td>
                                            <td>Apr 15, 2025</td>
                                            <td><span class="badge bg-success">Approved</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B000">
                                                    <i class="material-icons align-middle small">visibility</i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>B999</td>
                                            <td>Happy Baker</td>
                                            <td>Apr 14, 2025</td>
                                            <td><span class="badge bg-danger">Rejected</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B999">
                                                    <i class="material-icons align-middle small">visibility</i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>B998</td>
                                            <td>Sunflower Bakery</td>
                                            <td>Apr 12, 2025</td>
                                            <td><span class="badge bg-success">Approved</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#requestDetailsModal" data-request-id="B998">
                                                    <i class="material-icons align-middle small">visibility</i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Request Statistics -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">bar_chart</i>Request Statistics</h5>
                            <div class="row g-3">
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-primary bg-opacity-10">
                                        <h3 class="fw-bold text-primary mb-0">3</h3>
                                        <p class="small mb-0">Pending</p>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-success bg-opacity-10">
                                        <h3 class="fw-bold text-success mb-0">8</h3>
                                        <p class="small mb-0">Approved</p>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="statCard text-center p-3 rounded bg-danger bg-opacity-10">
                                        <h3 class="fw-bold text-danger mb-0">2</h3>
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
                                        <tr>
                                            <td>Apple</td>
                                            <td>Hong Kong</td>
                                            <td>45 pieces</td>
                                        </tr>
                                        <tr>
                                            <td>Strawberry</td>
                                            <td>USA</td>
                                            <td>5 kg</td>
                                        </tr>
                                        <tr>
                                            <td>Blueberry</td>
                                            <td>USA</td>
                                            <td>2 kg</td>
                                        </tr>
                                        <tr>
                                            <td>Mango</td>
                                            <td>Japan</td>
                                            <td>15 pieces</td>
                                        </tr>
                                        <tr>
                                            <td>Kiwi</td>
                                            <td>Japan</td>
                                            <td>22 pieces</td>
                                        </tr>
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
                                    Respond to requests within 24 hours
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">priority_high</i>
                                    If rejecting, provide a clear reason
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
        <div class="modal fade" id="requestDetailsModal" tabindex="-1" aria-labelledby="requestDetailsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="requestDetailsModalLabel">Request Details: #B001</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h6 class="text-muted mb-2">Request Information</h6>
                                <p class="mb-1"><strong>Request ID:</strong> B001</p>
                                <p class="mb-1"><strong>Date:</strong> April 18, 2025</p>
                                <p class="mb-1"><strong>Status:</strong> <span class="badge bg-warning">Pending</span></p>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-muted mb-2">Shop Information</h6>
                                <p class="mb-1"><strong>Shop:</strong> Sweet Bakery</p>
                                <p class="mb-1"><strong>Location:</strong> Central, Tokyo</p>
                                <p class="mb-1"><strong>Contact:</strong> shop-central@acer.com</p>
                            </div>
                        </div>
                        <h6 class="text-muted mb-3">Requested Items</h6>
                        <div class="table-responsive mb-4">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Fruit</th>
                                        <th>Origin</th>
                                        <th>Quantity</th>
                                        <th>Your Current Stock</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Strawberry</td>
                                        <td>USA</td>
                                        <td>2 kg</td>
                                        <td>5 kg</td>
                                    </tr>
                                    <tr>
                                        <td>Blueberry</td>
                                        <td>USA</td>
                                        <td>500 g</td>
                                        <td>2 kg</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mb-3">
                            <h6 class="text-muted mb-2">Request Notes</h6>
                            <p>Urgent need for weekend special cake production. Would be greatly appreciated if we could receive these fruits by tomorrow afternoon.</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#rejectModal" data-bs-dismiss="modal">
                            <i class="material-icons align-middle me-1 small">close</i> Reject
                        </button>
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#approveModal" data-bs-dismiss="modal">
                            <i class="material-icons align-middle me-1 small">check</i> Approve
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Approve Modal -->
        <div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="approveModalLabel">Approve Request #B001</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>You're about to approve this fruit borrow request. The items will be marked as reserved for pickup.</p>
                        
                        <div class="alert alert-info mb-3">
                            <i class="material-icons align-middle me-2">info</i>
                            Approving will reduce your available stock accordingly
                        </div>
                        
                        <div class="mb-3">
                            <label for="pickupInstructions" class="form-label">Pickup Instructions (Optional)</label>
                            <textarea class="form-control" id="pickupInstructions" rows="2" placeholder="Add instructions for pickup..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-success" data-bs-dismiss="modal">
                            <i class="material-icons align-middle me-1 small">check</i> Confirm Approval
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Reject Modal -->
        <div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="rejectModalLabel">Reject Request #B001</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>You're about to reject this fruit borrow request.</p>
                        
                        <div class="alert alert-warning mb-3">
                            <i class="material-icons align-middle me-2">warning</i>
                            Please provide a reason for rejection to help the requesting shop
                        </div>
                        
                        <div class="mb-3">
                            <label for="rejectionReason" class="form-label">Reason for Rejection <span class="text-danger">*</span></label>
                            <select class="form-select mb-2" id="rejectionReasonSelect">
                                <option value="" selected disabled>Select a reason</option>
                                <option value="insufficientStock">Insufficient stock available</option>
                                <option value="scheduledReservation">Items already reserved for another shop</option>
                                <option value="qualityIssue">Quality issues with current stock</option>
                                <option value="other">Other (please specify)</option>
                            </select>
                            <textarea class="form-control" id="rejectionReason" rows="2" placeholder="Provide details about the rejection reason..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                            <i class="material-icons align-middle me-1 small">close</i> Confirm Rejection
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/borrowRequest.js"></script>
    </body>
</html>
