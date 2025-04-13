<%-- 
    Document   : borrowFruit
    Created on : 2025年4月13日, 下午5:53:07
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
        <title>Borrow Fruit - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/store/borrowFruit.css" rel="stylesheet">
    </head>
    <body>
        <nav:nav userType="shop"/>
        
        <div class="container py-4">
            <!-- Header Section -->
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Borrow Fruits</h2>
                <p class="lead">Borrow fruits from other shops in your city for immediate needs</p>
                <p class="text-muted small mb-0">Quick and efficient local fruit sharing system</p>
            </div>
            
            <!-- Main Content -->
            <div class="row g-4">
                <!-- Borrowing Form -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h4 class="mb-4"><i class="material-icons align-middle me-2">swap_horiz</i>Find Fruits to Borrow</h4>
                            
                            <!-- Shop Selection Section -->
                            <div class="mb-4">
                                <h5 class="mb-3"><i class="material-icons align-middle me-2 small">store</i>Select a Shop</h5>
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="input-group">
                                            <span class="input-group-text border-0 bg-transparent">
                                                <i class="material-icons text-muted">store</i>
                                            </span>
                                            <select class="form-select" id="shopFilter">
                                                <option value="" selected disabled>-- Select a shop to see available fruits --</option>
                                                <option value="--" disabled>------------------------------</option>
                                                <option value="S001">Baker's Heaven (2.3km away)</option>
                                                <option value="S002">Sweet Delight (3.1km away)</option>
                                                <option value="S003">Flour Power (5.2km away)</option>
                                            </select>
                                        </div>
                                        <div class="form-text">Select a shop to view available fruits for borrowing</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Fruit Selection Section (Initially Hidden) -->
                            <div id="fruitSelectionSection" class="d-none">
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
                                                    <option value="Tropical Fruit">Tropical Fruit</option>
                                                    <option value="Berry">Berry</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Available Fruits List -->
                                <div class="fruitSelectionContainer mb-4">
                                    <h5 class="mb-3"><i class="material-icons align-middle me-2 small">inventory_2</i>Available Fruits at <span id="selectedShopName">Shop</span></h5>
                                    <div class="fruitSelection">
                                        <!-- Fruit Items - Each shop's fruits have a data-shop attribute to filter by shop -->
                                        <!-- Fruit Item - Shop 1 -->
                                        <div class="fruitItem card mb-3" data-fruit-name="fuji apple" data-shop="S001">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                        <img src="${pageContext.request.contextPath}/img/apple.jpg" alt="Fuji Apple" class="img-fluid rounded fruit-img">
                                                    </div>
                                                    <div class="col-md-5 col-sm-9 mb-3 mb-md-0">
                                                        <h5 class="mb-1">Fuji Apple</h5>
                                                        <p class="text-muted mb-0 small">Type: Single Fruit</p>
                                                        <p class="text-muted mb-0 small">Origin: Aomori, Japan</p>
                                                        <p class="mb-0 small">Available: <span class="text-success">24 pcs</span></p>
                                                    </div>
                                                    <div class="col-md-5 col-sm-12">
                                                        <div class="d-flex align-items-center">
                                                            <label class="form-label small me-2">Quantity:</label>
                                                            <input type="number" class="form-control form-control-sm me-2" 
                                                                   name="FA001" min="0" max="24" value="0">
                                                            <button class="btn btn-sm btn-primary addToRequestBtn">
                                                                <i class="material-icons small">add</i> Request
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Fruit Item - Shop 2 -->
                                        <div class="fruitItem card mb-3" data-fruit-name="strawberry" data-shop="S002">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                        <img src="${pageContext.request.contextPath}/img/strawberry.jpg" alt="Strawberry" class="img-fluid rounded fruit-img">
                                                    </div>
                                                    <div class="col-md-5 col-sm-9 mb-3 mb-md-0">
                                                        <h5 class="mb-1">Strawberry</h5>
                                                        <p class="text-muted mb-0 small">Type: Berry</p>
                                                        <p class="text-muted mb-0 small">Origin: California, USA</p>
                                                        <p class="mb-0 small">Available: <span class="text-success">3 kg</span></p>
                                                    </div>
                                                    <div class="col-md-5 col-sm-12">
                                                        <div class="d-flex align-items-center">
                                                            <label class="form-label small me-2">Quantity:</label>
                                                            <input type="number" class="form-control form-control-sm me-2" 
                                                                   name="SB001" min="0" max="3" value="0" step="0.1">
                                                            <button class="btn btn-sm btn-primary addToRequestBtn">
                                                                <i class="material-icons small">add</i> Request
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Fruit Item - Shop 3 -->
                                        <div class="fruitItem card mb-3" data-fruit-name="banana" data-shop="S003">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                        <img src="${pageContext.request.contextPath}/img/banana.jpg" alt="Banana" class="img-fluid rounded fruit-img">
                                                    </div>
                                                    <div class="col-md-5 col-sm-9 mb-3 mb-md-0">
                                                        <h5 class="mb-1">Banana</h5>
                                                        <p class="text-muted mb-0 small">Type: Tropical Fruit</p>
                                                        <p class="text-muted mb-0 small">Origin: Philippines</p>
                                                        <p class="mb-0 small">Available: <span class="text-success">5 bunches</span></p>
                                                    </div>
                                                    <div class="col-md-5 col-sm-12">
                                                        <div class="d-flex align-items-center">
                                                            <label class="form-label small me-2">Quantity:</label>
                                                            <input type="number" class="form-control form-control-sm me-2" 
                                                                   name="BN001" min="0" max="5" value="0">
                                                            <button class="btn btn-sm btn-primary addToRequestBtn">
                                                                <i class="material-icons small">add</i> Request
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center mt-2 fruitResultInfo">
                                        <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                    </div>
                                </div>
                                
                                <!-- Borrowing Request Form -->
                                <div class="borrowingForm mt-4">
                                    <h5 class="mb-3"><i class="material-icons align-middle me-2 small">assignment</i>Borrowing Request</h5>
                                    <form id="borrowingForm" action="#" method="post">
                                        <input type="hidden" name="action" value="submit">
                                        <input type="hidden" id="selectedShopId" name="shopId" value="">
                                        
                                        <div class="mb-3">
                                            <label for="notes" class="form-label">Additional Notes</label>
                                            <textarea class="form-control" id="notes" name="notes" rows="2" 
                                                      placeholder="Any specific requirements or comments"></textarea>
                                        </div>
                                        
                                        <div class="d-flex justify-content-end gap-2 mt-4">
                                            <button type="button" id="resetFormBtn" class="btn btn-outline-danger me-auto">
                                                <i class="material-icons align-middle me-1 small">refresh</i> Reset
                                            </button>
                                            <a href="${pageContext.request.contextPath}/page/store/index.jsp" class="btn btn-outline-secondary">Cancel</a>
                                            <button type="submit" class="btn btn-primary">Submit Request</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Request Summary -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">receipt</i>Your Request</h5>
                            <div id="requestSummary" class="mb-3">
                                <p class="text-muted text-center py-4">No items selected yet</p>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span>Total Items:</span>
                                <span id="totalItems">0</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Borrowing Guidelines -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Guidelines</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">home_work</i>
                                    Only shops in the same city can be choose to borrow
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">verified</i>
                                    Verify the quality and quantity upon receipt
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">shopping_cart</i>
                                    For regular needs, use the reservation system
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
        
        <script src="${pageContext.request.contextPath}/js/store/borrowFruit.js"></script>
    </body>
</html>
