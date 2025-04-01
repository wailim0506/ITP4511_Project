<%-- 
    Document   : reserveFruit
    Created on : 2025年4月1日, 下午6:56:11
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../components/store/navBar.jsp" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reserve Fruit - ACER Shop</title>
        <!-- favicon -->
        <link rel="icon" href="../../img/favicon.ico" type="image/x-icon">
        <link rel="shortcut icon" href="../../img/favicon.ico" type="image/x-icon">
        <!-- bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jquery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Google Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        
        <script src="../../js/darkModeControl.js"></script>
        <link href="../../css/store/reserveFruit.css" rel="stylesheet">
    </head>
    <body>
        <div class="container py-4">
            <!-- Header Section -->
            <div class="header-section text-center shadow-sm mb-4">
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
                            <h4 class="mb-4"><i class="material-icons align-middle me-2">shopping_cart</i>New Reservation</h4>
                            
                            <form id="reservationForm" action="submitReservation" method="post">
                                <!-- Date Selection -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium">Delivery Date <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent">
                                            <i class="material-icons text-muted">event</i>
                                        </span>
                                        <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" 
                                               required>
                                    </div>
                                    <div class="form-text">Select a date from tomorrow up to 14 days from now</div>
                                </div>
                                
                                <!-- Fruit Selection -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium">Select Fruits <span class="text-danger">*</span></label>
                                    
                                    <!-- Search and Filter Bar -->
                                    <div class="mb-3">
                                        <div class="row g-2">
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
                                                        <i class="material-icons text-muted">public</i>
                                                    </span>
                                                    <select class="form-select" id="countryFilter">
                                                        <option value="all" selected>All Countries/ Regions</option>
                                                        <option value="japan">Japan</option>
                                                        <option value="usa">USA</option>
                                                        <option value="hong-kong">Hong Kong</option>
                                                        <option value="other">Other Countries/ Regions</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Scrollable Container for Fruits -->
                                    <div class="fruit-selection-container">
                                        <div class="fruit-selection">
                                            <!-- Apple -->
                                            <div class="fruit-item card mb-3" data-fruit-name="apple" data-category="japan">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Apple" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Apple</h5>
                                                            <p class="text-muted mb-0 small">Origin: Japan</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">120 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_1_qty" min="0" max="120" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Banana -->
                                            <div class="fruit-item card mb-3" data-fruit-name="banana" data-category="usa">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Banana" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Banana</h5>
                                                            <p class="text-muted mb-0 small">Origin: USA</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">85 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_2_qty" min="0" max="85" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Strawberry -->
                                            <div class="fruit-item card mb-3" data-fruit-name="strawberry" data-category="hong-kong">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Strawberry" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Strawberry</h5>
                                                            <p class="text-muted mb-0 small">Origin: Hong Kong</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">50 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_3_qty" min="0" max="50" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Mango -->
                                            <div class="fruit-item card mb-3" data-fruit-name="mango" data-category="japan">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Mango" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Mango</h5>
                                                            <p class="text-muted mb-0 small">Origin: Japan</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">65 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_4_qty" min="0" max="65" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Blueberry -->
                                            <div class="fruit-item card mb-3" data-fruit-name="blueberry" data-category="usa">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Blueberry" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Blueberry</h5>
                                                            <p class="text-muted mb-0 small">Origin: USA</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">35 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_5_qty" min="0" max="35" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Dragon Fruit -->
                                            <div class="fruit-item card mb-3" data-fruit-name="dragon fruit" data-category="hong-kong">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Dragon Fruit" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Dragon Fruit</h5>
                                                            <p class="text-muted mb-0 small">Origin: Hong Kong</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">45 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_6_qty" min="0" max="45" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Durian -->
                                            <div class="fruit-item card mb-3" data-fruit-name="durian" data-category="other">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Durian" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Durian</h5>
                                                            <p class="text-muted mb-0 small">Origin: Thailand</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">30 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_7_qty" min="0" max="30" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Peach -->
                                            <div class="fruit-item card mb-3" data-fruit-name="peach" data-category="japan">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Peach" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Peach</h5>
                                                            <p class="text-muted mb-0 small">Origin: Japan</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">70 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_8_qty" min="0" max="70" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Kiwi -->
                                            <div class="fruit-item card mb-3" data-fruit-name="kiwi" data-category="other">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Kiwi" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Kiwi</h5>
                                                            <p class="text-muted mb-0 small">Origin: New Zealand</p>
                                                        </div>
                                                        <div class="col-md3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">55 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_9_qty" min="0" max="55" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Orange -->
                                            <div class="fruit-item card mb-3" data-fruit-name="orange" data-category="usa">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Orange" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Orange</h5>
                                                            <p class="text-muted mb-0 small">Origin: USA</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">90 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_10_qty" min="0" max="90" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Lychee -->
                                            <div class="fruit-item card mb-3" data-fruit-name="lychee" data-category="hong-kong">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Lychee" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Lychee</h5>
                                                            <p class="text-muted mb-0 small">Origin: Hong Kong</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">40 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_11_qty" min="0" max="40" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Watermelon -->
                                            <div class="fruit-item card mb-3" data-fruit-name="watermelon" data-category="japan">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Watermelon" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Watermelon</h5>
                                                            <p class="text-muted mb-0 small">Origin: Japan</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">150 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_12_qty" min="0" max="150" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Pineapple -->
                                            <div class="fruit-item card mb-3" data-fruit-name="pineapple" data-category="usa">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-2 col-sm-3 mb-3 mb-md-0">
                                                            <img src="../../img/F002_Orange.jpg" alt="Pineapple" class="img-fluid rounded fruit-img">
                                                        </div>
                                                        <div class="col-md-4 col-sm-9 mb-3 mb-md-0">
                                                            <h5 class="mb-1">Pineapple</h5>
                                                            <p class="text-muted mb-0 small">Origin: USA</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <p class="mb-1 small">Available: <span class="text-success">80 pc</span></p>
                                                            <p class="mb-0 small">Unit: pc</p>
                                                        </div>
                                                        <div class="col-md-3 col-sm-6">
                                                            <label class="form-label small">Quantity</label>
                                                            <input type="number" class="form-control form-control-sm" 
                                                                   name="fruit_13_qty" min="0" max="80" value="0">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center mt-2 fruit-results-info d-none">
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
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span>Total Items:</span>
                                <span id="totalItems">0</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reservation Guidelines -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">info</i>Guidelines</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">calendar_today</i>
                                    Reservations must be made 1-14 days in advance
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">update</i>
                                    Reservations can be modified up to 24 hours before delivery
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">inventory</i>
                                    Quantity is limited to current stock availability
                                </li>
                                <li class="list-group-item border-0 ps-0 py-2">
                                    <i class="material-icons text-muted align-middle me-2 small">swap_horiz</i>
                                    Unable to find what you need? Try borrowing from nearby shops
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
        
        <script src="../../js/shop/reserveFruit.js"></script>
    </body>
</html>
