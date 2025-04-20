<%-- 
    Document   : stock
    Created on : 2025年4月20日, 下午3:13:06
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
        <title>Manage Stock - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/store/stock.css" rel="stylesheet">
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
                <h2 class="display-6 fw-bold text-primary">Inventory Management</h2>
                <p class="lead">Manage your shop's fruit inventory levels</p>
                <p class="text-muted small mb-0">Add or deduct stock quantities to maintain accurate inventory records</p>
            </div>

            <!-- Main Content -->
            <div class="row g-4">
                <!-- Stock Management Section -->
                <div class="col-lg-9">
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0"><i class="material-icons align-middle me-2">inventory</i>Current Inventory</h4>
                                <button id="editModeToggle" type="button" class="btn btn-outline-primary">
                                    <i class="material-icons align-middle me-1 small">edit</i> Edit Inventory
                                </button>
                            </div>

                            <!-- Search and Filter Bar -->
                            <div class="mb-4">
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-text border-0 bg-transparent">
                                                <i class="material-icons text-muted">search</i>
                                            </span>
                                            <input type="text" class="form-control" id="fruitSearch" placeholder="Search fruits...">
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <div class="input-group">
                                            <span class="input-group-text border-0 bg-transparent">
                                                <i class="material-icons text-muted">category</i>
                                            </span>
                                            <select class="form-select" id="typeFilter">
                                                <option value="all" selected>All Types</option>
                                                <option value="--" disabled>------------------------------</option>
                                                <option value="Single Fruit">Single Fruit</option>
                                                <option value="Bunch Fruit">Bunch Fruit</option>
                                                <option value="Berry">Berry</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Stock Table -->
                            <div class="stockTableContainer mb-4">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table">
                                            <tr>
                                                <th style="width: 40%">Fruit</th>
                                                <th style="width: 20%">Type</th>
                                                <th style="width: 15%">Unit</th>
                                                <th style="width: 25%">Current Stock</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Hardcoded inventory items for demo -->
                                            <tr class="fruitItem" data-fruit-name="apple" data-type="single fruit">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/img/apple.jpg" alt="Apple" class="me-3 rounded fruitImg">
                                                        <div>
                                                            <h6 class="mb-0">Apple</h6>
                                                            <small class="text-muted">Washington, USA</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Single Fruit</td>
                                                <td>kg</td>
                                                <td>
                                                    <!-- Read mode display -->
                                                    <div class="stockReadMode">
                                                        <span class="stockValue">25</span> <span class="stockUnit">kg</span>
                                                    </div>
                                                    <!-- Edit mode display (initially hidden) -->
                                                    <div class="stockEditMode d-none">
                                                        <div class="input-group stockControl">
                                                            <button type="button" class="btn btn-outline-danger btn-sm decrementBtn">
                                                                <i class="material-icons small">remove</i>
                                                            </button>
                                                            <input type="number" class="form-control form-control-sm text-center stockInput" 
                                                                   value="25" min="0" name="F001" data-original="25">
                                                            <button type="button" class="btn btn-outline-success btn-sm incrementBtn">
                                                                <i class="material-icons small">add</i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="fruitItem" data-fruit-name="banana" data-type="bunch fruit">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/img/banana.jpg" alt="Banana" class="me-3 rounded fruitImg">
                                                        <div>
                                                            <h6 class="mb-0">Banana</h6>
                                                            <small class="text-muted">Chiba, Japan</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Bunch Fruit</td>
                                                <td>bunch</td>
                                                <td>
                                                    <!-- Read mode display -->
                                                    <div class="stockReadMode">
                                                        <span class="stockValue">18</span> <span class="stockUnit">bunch</span>
                                                    </div>
                                                    <!-- Edit mode display (initially hidden) -->
                                                    <div class="stockEditMode d-none">
                                                        <div class="input-group stockControl">
                                                            <button type="button" class="btn btn-outline-danger btn-sm decrementBtn">
                                                                <i class="material-icons small">remove</i>
                                                            </button>
                                                            <input type="number" class="form-control form-control-sm text-center stockInput" 
                                                                   value="18" min="0" name="F002" data-original="18">
                                                            <button type="button" class="btn btn-outline-success btn-sm incrementBtn">
                                                                <i class="material-icons small">add</i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="fruitItem" data-fruit-name="strawberry" data-type="berry">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/img/strawberry.jpg" alt="Strawberry" class="me-3 rounded fruitImg">
                                                        <div>
                                                            <h6 class="mb-0">Strawberry</h6>
                                                            <small class="text-muted">California, USA</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Berry</td>
                                                <td>box</td>
                                                <td>
                                                    <!-- Read mode display -->
                                                    <div class="stockReadMode">
                                                        <span class="stockValue">12</span> <span class="stockUnit">box</span>
                                                    </div>
                                                    <!-- Edit mode display (initially hidden) -->
                                                    <div class="stockEditMode d-none">
                                                        <div class="input-group stockControl">
                                                            <button type="button" class="btn btn-outline-danger btn-sm decrementBtn">
                                                                <i class="material-icons small">remove</i>
                                                            </button>
                                                            <input type="number" class="form-control form-control-sm text-center stockInput" 
                                                                   value="12" min="0" name="F003" data-original="12">
                                                            <button type="button" class="btn btn-outline-success btn-sm incrementBtn">
                                                                <i class="material-icons small">add</i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="fruitItem" data-fruit-name="orange" data-type="single fruit">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/img/orange.jpg" alt="Orange" class="me-3 rounded fruitImg">
                                                        <div>
                                                            <h6 class="mb-0">Orange</h6>
                                                            <small class="text-muted">Valencia, Spain</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Single Fruit</td>
                                                <td>kg</td>
                                                <td>
                                                    <!-- Read mode display -->
                                                    <div class="stockReadMode">
                                                        <span class="stockValue">30</span> <span class="stockUnit">kg</span>
                                                    </div>
                                                    <!-- Edit mode display (initially hidden) -->
                                                    <div class="stockEditMode d-none">
                                                        <div class="input-group stockControl">
                                                            <button type="button" class="btn btn-outline-danger btn-sm decrementBtn">
                                                                <i class="material-icons small">remove</i>
                                                            </button>
                                                            <input type="number" class="form-control form-control-sm text-center stockInput" 
                                                                   value="30" min="0" name="F004" data-original="30">
                                                            <button type="button" class="btn btn-outline-success btn-sm incrementBtn">
                                                                <i class="material-icons small">add</i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="fruitItem" data-fruit-name="blueberry" data-type="berry">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/img/blueberry.jpg" alt="Blueberry" class="me-3 rounded fruitImg">
                                                        <div>
                                                            <h6 class="mb-0">Blueberry</h6>
                                                            <small class="text-muted">Maine, USA</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Berry</td>
                                                <td>box</td>
                                                <td>
                                                    <!-- Read mode display -->
                                                    <div class="stockReadMode">
                                                        <span class="stockValue">8</span> <span class="stockUnit">box</span>
                                                    </div>
                                                    <!-- Edit mode display (initially hidden) -->
                                                    <div class="stockEditMode d-none">
                                                        <div class="input-group stockControl">
                                                            <button type="button" class="btn btn-outline-danger btn-sm decrementBtn">
                                                                <i class="material-icons small">remove</i>
                                                            </button>
                                                            <input type="number" class="form-control form-control-sm text-center stockInput" 
                                                                   value="8" min="0" name="F005" data-original="8">
                                                            <button type="button" class="btn btn-outline-success btn-sm incrementBtn">
                                                                <i class="material-icons small">add</i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="text-center mt-2 fruitResultInfo d-none">
                                    <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                </div>
                            </div>

                            <!-- Action Buttons (Initially Hidden) -->
                            <div class="d-flex justify-content-end gap-2 mt-4" id="actionButtons" style="display: none !important;">
                                <button type="button" id="cancelEditBtn" class="btn btn-outline-secondary me-auto">
                                    <i class="material-icons align-middle me-1 small">close</i> Cancel
                                </button>
                                <button type="button" id="saveChangesBtn" class="btn btn-primary">
                                    <i class="material-icons align-middle me-1 small">save</i> Save Changes
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Summary Section -->
                <div class="col-lg-3">
                    <!-- Inventory Summary -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">summarize</i>Inventory Summary</h5>
                            <div id="inventorySummary">
                                <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                                    <span>Total Items:</span>
                                    <span id="totalItems">5</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2 border-bottom pb-2 d-none" id="modifiedItemsRow">
                                    <span>Modified Items:</span>
                                    <span id="modifiedItems">0</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Guidelines -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Guidelines</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">edit</i>
                                    Click the Edit button to modify inventory
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">add_circle</i>
                                    Use increment button to add new stock
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">remove_circle</i>
                                    Use decrement button to record usage
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">save</i>
                                    Remember to save changes before leaving
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Hidden Form for Submission -->
            <form id="stockForm" action="/ITP4511_Project/updateStock" method="post" style="display:none;">
                <input type="hidden" name="action" value="update">
                <!-- Hidden inputs will be dynamically added here before submission -->
            </form>
        </div>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons" 
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/stock.js"></script>
    </body>
</html>
