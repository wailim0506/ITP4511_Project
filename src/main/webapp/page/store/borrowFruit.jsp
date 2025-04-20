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
                <h2 class="display-6 fw-bold text-primary">Borrow Fruits</h2>
                <p class="lead">Borrow fruits from other shops in your city for immediate needs</p>
            </div>
            <form id="borrowingForm" action="/ITP4511_Project/borrowFruit" method="post">
                <input type="hidden" name="action" value="borrow">
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
                                                <jsp:useBean id="shopList" class="java.util.ArrayList" scope="request"/>
                                                <%
                                                    if (shopList.size() == 0) {
                                                        throw new Exception();
                                                    }
                                                %>
                                                <select class="form-select w-25" id="shopFilter" name="shopId" required>
                                                    <option value="" selected disabled>Select a shop</option>
                                                    <%
                                                        for (int i = 0; i < shopList.size();i++){
                                                            ShopBean sb = (ShopBean)shopList.get(i);
                                                            out.println("<option value=\"" + sb.getID() + "\">" + sb.getAddress() + ", " + sb.getCity() + "</option>");
                                                        }
                                                    %>
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
                                                        <option value="Bunch Fruit">Bunch Fruit</option>
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
                                            <%
                                                ArrayList<ArrayList<ShopFruitStockBean>> shopStockList = (ArrayList<ArrayList<ShopFruitStockBean>>) request.getAttribute("shopStockList");
                                                if (shopStockList.size() == 0) {
                                                    throw new Exception();
                                                }
                                            %>

                                            <%
                                                for (int i = 0; i < shopList.size(); i++){
                                                    ArrayList<ShopFruitStockBean> stockList = (ArrayList<ShopFruitStockBean>) shopStockList.get(i);
                                                    for (int j = 0; j < stockList.size(); j++) {
                                                        ShopFruitStockBean fruit = stockList.get(j);
                                                        String imgPath = "/ITP4511_Project/img/" + fruit.getImgName();
                                                        String origin = fruit.getCity() + ", " + fruit.getCountryRegion();
                                                    
                                                        out.println("<div class=\"fruitItem card mb-3\" data-fruit-name=\"" + fruit.getFruitName().toLowerCase() + "\" data-shop=\"" + fruit.getShopId() + "\" data-type=\"" + fruit.getType() + "\">" +
    "                                                                   <div class=\"card-body\">" +
    "                                                                       <div class=\"row align-items-center\">" +
    "                                                                           <div class=\"col-md-2 col-sm-3 mb-3 mb-md-0\">" +
    "                                                                               <img src=\"" + imgPath + "\" alt=\"" + fruit.getFruitName() + "\" class=\"img-fluid rounded fruitImg\">" +
    "                                                                           </div>" +
    "                                                                       <div class=\"col-md-5 col-sm-9 mb-3 mb-md-0\">" +
    "                                                                           <h5 class=\"mb-1\">" + fruit.getFruitName() + "</h5>" +
    "                                                                           <p class=\"text-muted mb-0 small\">Type: " + fruit.getType() + "</p>" +
    "                                                                           <p class=\"text-muted mb-0 small\">Origin: " + origin + "</p>" +
    "                                                                           <p class=\"mb-0 small\">Available: <span class=\"text-success\">" + fruit.getQty() + " " + fruit.getUnit() + "</span></p>" +
    "                                                                       </div>" +
    "                                                                       <div class=\"col-md-5 col-sm-12\">" +
    "                                                                           <div class=\"d-flex align-items-center\">" +
    "                                                                           <label class=\"form-label small me-2\">Quantity:</label>" +
    "                                                                           <input type=\"number\" class=\"form-control form-control-sm me-2\" " +
    "                                                                                   name=\"" + fruit.getShopId() + "_" + fruit.getFruitId() + "\" min=\"0\" max=\"" + fruit.getQty() + "\" value=\"0\">" +
    "                                                                           </div>" +
    "                                                                       </div>" +
    "                                                                   </div>" +
    "                                                               </div>" +
    "                                                           </div>");
                                                    }
                                                }
                                            %>
                                        </div>
                                        <div class="text-center mt-2 fruitResultInfo">
                                            <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                        </div>
                                    </div>

                                    <div class="borrowingForm mt-4">
                                        <h5 class="mb-3"><i class="material-icons align-middle me-2 small">assignment</i>Borrowing Request</h5>
                                        <div class="mb-3">
                                            <label for="notes" class="form-label">Additional Notes</label>
                                            <textarea class="form-control" id="notes" name="notes" rows="2" 
                                                      placeholder="Any specific requirements or comments" required></textarea>
                                        </div>
                                        <div class="d-flex justify-content-end gap-2 mt-4">
                                            <button type="button" id="resetFormBtn" class="btn btn-outline-danger me-auto">
                                                <i class="material-icons align-middle me-1 small">refresh</i> Reset
                                            </button>
                                            <a href="${pageContext.request.contextPath}/page/store/index.jsp" class="btn btn-outline-secondary">Cancel</a>
                                            <button type="submit" class="btn btn-primary">Submit Request</button>
                                        </div>
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
                                        Only shops in the same city can be chosen to borrow from
                                    </li>
                                    <li class="list-group-item border-0 ps-0 py-2">
                                        <i class="material-icons text-muted align-middle me-2 small">inventory</i>
                                        Check stock levels first before creating a borrowing request
                                    </li>
                                    <li class="list-group-item border-0 ps-0 py-2">
                                        <i class="material-icons text-muted align-middle me-2 small">verified</i>
                                        Verify the quality and quantity upon receipt
                                    </li>
                                    <li class="list-group-item border-0 ps-0 py-2">
                                        <i class="material-icons text-muted align-middle me-2 small">edit_off</i>
                                        No modifications allowed once submitted - create a new borrow request if changes needed
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
            </form>
        </div>

        <footer:footer userType="shop"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>

        <script src="${pageContext.request.contextPath}/js/store/borrowFruit.js"></script>
    </body>
</html>
