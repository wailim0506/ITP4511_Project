<%-- 
    Document   : inventory
    Created on : 2025年4月22日, 上午1:31:10
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>

<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inventory - ACER</title>
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
        <link href="${pageContext.request.contextPath}/css/warehouse/inventory.css" rel="stylesheet">
    </head>
    <body>
        <%
            UserBean ub = (UserBean)session.getAttribute("userInfo");
        %>
        <nav:nav userType="warehouse" staffName="<%=ub.getStaffName()%>"/>
        <jsp:useBean id="StatusBean" class="ict.bean.StatusBean" scope="request"/>
        <%
            try{
                String errorMsg = (String) request.getAttribute("errorMsg");
                if(errorMsg != null && !errorMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-danger alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + errorMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                }
            }catch(Exception e){
            }  

            try{
                String successMsg = (String) request.getAttribute("successMsg");
                if(successMsg != null && !successMsg.isEmpty()){
                    out.println("<div class='alertDiv' style='display: flex;justify-content: center; align-items: center;margin-top: 20px;position: fixed;bottom: 0;left: 0;right: 0;z-index: 1000;margin-top: 0;padding-bottom: 20px;'>" +
                                "<div class=\"alert alert-success alert-dismissible fade show\" style='width: 80%; text-align: center; position: relative;'>" + 
                                "<span>" + successMsg + "</span>" +
                                "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" style='position: absolute; right: 10px; top: 50%; transform: translateY(-50%);'></button>" +
                                "</div></div>");                    
                }
            }catch(Exception e){
            }  
        %>
        <div class="container">
            <!-- Status bar -->
            <div class="status">
                <div class="status-data">
                    <h3>Total Fruits</h3>
                    <p><jsp:getProperty name="StatusBean" property="totalFruits"/></p>
                </div>
                <div class="status-data">
                    <h3>Low Stock Fruits</h3>
                    <p><jsp:getProperty name="StatusBean" property="lowStock"/></p>
                </div>
                <div class="status-data">
                    <h3>Out of Stock Fruits</h3>
                    <p><jsp:getProperty name="StatusBean" property="outOfStock"/></p>
                </div>
            </div>

            <div class="container py-4">
            <!-- Main Content -->
            <div class="row g-4">
                <!-- Stock Management Section -->
                <div class="col-lg-9">
                    <div class="card border-0 shadow-sm mb-4">
                        <form method="post" action="/ITP4511_Project/inventory" id="stockForm"> <-------------------------------------------------------------------------------------------------------------------------------->
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="shopId" value="<%=ub.getWareHouseId()%>">
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0"><i class="material-icons align-middle me-2">inventory</i>Current Stock</h4>
                                    <button id="editModeToggle" type="button" class="btn btn-outline-primary">
                                        <i class="material-icons align-middle me-1 small">edit</i> Edit Stock
                                    </button>
                                </div>

                                <!-- Search and Filter Bar -->
                                <div class="mb-4">
                                    <div class="row g-3 mb-3">
                                        <div class="col-md-3 col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">search</i>
                                                </span>
                                                <input type="text" class="form-control" id="fruitSearch" placeholder="Search fruits...">
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">category</i>
                                                </span>
                                                <jsp:useBean id="fruitTypeList" class="java.util.ArrayList" scope="request"/>
                                                <select class="form-select" id="typeFilter">
                                                    <option value="all" selected>All Types</option>
                                                    <option value="--" disabled>------------------------------</option>
                                                    <%
                                                        for (int i = 0; i < fruitTypeList.size(); i++) {
                                                            String type = (String) fruitTypeList.get(i);
                                                            out.println("<option value=\""+type+"\">"+type+"</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-text border-0 bg-transparent">
                                                    <i class="material-icons text-muted">public</i>
                                                </span>
                                                <jsp:useBean id="countryRegionList" class="java.util.ArrayList" scope="request"/>
                                                <select class="form-select" id="countryFilter">
                                                    <option value="all" selected>All Countries/Regions</option>
                                                    <option value="--" disabled>------------------------------</option>
                                                    <%
                                                        for (int i = 0; i < countryRegionList.size(); i++) {
                                                            CountryRegionBean cb = (CountryRegionBean) countryRegionList.get(i);
                                                            out.println("<option value=\""+cb.getName()+"\">"+cb.getName()+"</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-12">
                                            <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100">
                                                <i class="material-icons align-middle me-1 small">refresh</i> Reset
                                            </button>
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
                                                <jsp:useBean id="fruitsStockList" class="java.util.ArrayList" scope="request"/>
                                                <%
                                                    for (int i = 0; i < fruitsStockList.size(); i++) {
                                                        ShopFruitStockBean sb = (ShopFruitStockBean) fruitsStockList.get(i);
                                                        String fruitName = sb.getFruitName();
                                                        String type = sb.getType();
                                                        String unit = sb.getUnit();
                                                        String qty = sb.getQty();
                                                        String img = sb.getImgName();
                                                        String city = sb.getCity();
                                                        String countryRegion = sb.getCountryRegion();
                                                        String fruitId = sb.getFruitId();

                                                        out.println("<tr class=\"fruitItem\" data-fruit-name=\""+fruitName+"\" data-type=\""+type+"\">");
                                                            out.println("<td>");
                                                                out.println("<div class=\"d-flex align-items-center\">");
                                                                        out.println("<img src=\""+request.getContextPath()+"/img/"+img+"\" alt=\""+fruitName+"\" class=\"me-3 rounded fruitImg\">");out.println("<div>");
                                                                        out.println("<h6 class=\"mb-0\">"+fruitName+"</h6>");
                                                                        out.println("<small class=\"text-muted\">"+city+", "+countryRegion+"</small>");
                                                                    out.println("</div>");
                                                                out.println("</div>");
                                                            out.println("</td>");
                                                            out.println("<td>"+type+"</td>");
                                                            out.println("<td>"+unit+"</td>");
                                                            out.println("<td>");
                                                                out.println("<div class=\"stockReadMode\">");
                                                                    out.println("<span class=\"stockValue ms-4\">"+qty+"</span>");
                                                                out.println("</div>");
                                                                out.println("<div class=\"stockEditMode d-none\">");
                                                                    out.println("<div class=\"input-group stockControl\">");
                                                                        out.println("<button type=\"button\" class=\"btn btn-outline-danger btn-sm decrementBtn\">");
                                                                            out.println("<i class=\"material-icons small\">remove</i>");
                                                                        out.println("</button>");
                                                                        out.println("<input type=\"number\" class=\"form-control form-control-sm text-center stockInput\" value=\""+qty+"\" min=\"0\" name=\""+fruitId+"\" data-original=\""+qty+"\">");
                                                                        out.println("<button type=\"button\" class=\"btn btn-outline-success btn-sm incrementBtn\">");
                                                                            out.println("<i class=\"material-icons small\">add</i>");
                                                                        out.println("</button>");
                                                                    out.println("</div>");
                                                                out.println("</div>");
                                                            out.println("</td>");
                                                        out.println("</tr>");
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-center mt-2 fruitResultInfo d-none">
                                        <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-4" id="actionButtons" style="display: none !important;">
                                    <button type="button" id="cancelEditBtn" class="btn btn-outline-secondary me-auto">
                                        <i class="material-icons align-middle me-1 small">close</i> Cancel
                                    </button>
                                    <button type="submit" id="saveChangesBtn" class="btn btn-primary">
                                        <i class="material-icons align-middle me-1 small">save</i> Save Changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Summary Section -->
                <div class="col-lg-3">
                    <!-- Inventory Summary -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="mb-3"><i class="material-icons align-middle me-2">summarize</i>Stock Summary</h5>
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
                                    Click the Edit button to modify stock
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
        </div>
                
        </div>
        <footer:footer userType="warehouse"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        <script src="${pageContext.request.contextPath}/js/store/stock.js"></script>
    </body>
</html>
