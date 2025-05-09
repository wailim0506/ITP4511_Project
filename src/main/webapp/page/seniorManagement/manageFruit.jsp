<%-- 
    Document   : manageFruit
    Created on : 2025年5月9日, 下午6:37:26
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>

<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Fruit - ACER</title>
        <!-- favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!-- Custom stylesheets -->
        <link href="${pageContext.request.contextPath}/css/darkModeControl.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/seniorManagement/manageFruit.css" rel="stylesheet">

        <!-- JavaScript libraries -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
        <script src="${pageContext.request.contextPath}/js/seniorManagement/fruitFilter.js"></script>
    </head>
    <body>
        <%
            UserBean bean = (UserBean)session.getAttribute("userInfo");
            String staffName = (String)bean.getStaffName();
            if (staffName == null) {
                throw new Exception();
            }
            
            boolean isEditMode =(boolean) request.getAttribute("isEditMode");
            boolean isAddFruit =(boolean) request.getAttribute("isAddFruit");
            boolean isAddSource =(boolean) request.getAttribute("isAddSource");
                        
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
        <nav:nav userType="seniorManagement" staffName="<%=staffName%>"/>
        <jsp:useBean id="fruitTypeList" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="countryRegionList" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="allCountryRegionList" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="fruitCity" class="java.util.ArrayList" scope="request"/>
        <%
            if(isEditMode){
                FruitsBean fbForEdit =(FruitsBean) request.getAttribute("fruitsBean");
                String status = fbForEdit.getStatus().equals("enable")?"Disable":"Enable";
                String enableChange = status.equals("Enable")?"hideBtn":"";
                String btnStatus = status.equals("Disable")?"danger":"success";
        %>
        <div class="modal <%= isEditMode ? "show" : "" %>">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/manageFruit" method="post">
                    <input type="hidden" name="formAction" value="change" >
                    <input type="hidden" name="editFruitId" value="<%=fbForEdit.getId()%>" >
                    <div class="form-edit">
                        <div class="form-row">
                            <div class="form-data">
                                <p>FruitID: <%=fbForEdit.getId()%></p>
                                <p>Fruit City: <%=fbForEdit.getCity()%>, <%=fbForEdit.getCountryRegion()%></p>
                                <br>
                                <div class="readWrite">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="editName" value="<%=fbForEdit.getName()%>" maxlength="20" required>
                                        <label for="editName">Name</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <select class="form-select" name="editType">
                                            <%
                                                for (int i = 0; i < fruitTypeList.size(); i++) {
                                                    String type = (String) fruitTypeList.get(i);
                                                    String selected = type.equals(fbForEdit.getType()) ? " selected" : "";
                                                    out.println("<option value=\"" + type + "\"" + selected + ">" + type + "</option>");
                                                }
                                            %>
                                        </select>
                                        <label for="editType">Type</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="editUnit" maxlength="10" value="<%=fbForEdit.getUnit()%>" required>
                                        <label for="editUnit">Unit</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="editImg" maxlength="30" value="<%=fbForEdit.getImgName()%>" required>
                                        <label for="editImg">Image Name</label>
                                    </div>

                                </div>
                            </div>
                            <div class="form-img">
                                <img src="${pageContext.request.contextPath}/img/<%=fbForEdit.getImgName()%>">
                            </div>
                        </div>
                    </div>

                    <div class="button">
                        <button type="button" class="btn btn-<%=btnStatus%>"
                                onclick="if (confirm('<%=status.equals("Disable") ? "All stock will be cleared and all order of the fruit will be finished"
                                        + ". Are you sure you want to disable this fruit?" : "Are you sure you want to enable this fruit?"%>')) {
                                            window.location.href = '${pageContext.request.contextPath}/manageFruit?action=<%=status%>&fruitID=<%=fbForEdit.getId()%>';
                                                    }">
                            <%=status%>
                        </button><button type="submit" class="btn btn-success <%=enableChange%>">Change</button>
                        <button type="button" class="btn btn-dark" 
                                onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit '">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <%
            }
        %>
        <%
            if(isAddFruit){
                String newFruitID = (String) request.getAttribute("newFruitID");
                String formattedID = "F" + String.format("%03d", Integer.parseInt(newFruitID));
        %>
        <div class="modal <%= isAddFruit ? "show" : "" %>">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/manageFruit" method="post">
                    <input type="hidden" name="formAction" value="addFruit" >

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="newFruitID" value="<%=formattedID%>" disabled>
                        <label for="newFruitID">FruitID</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="addFruitName" maxlength="20" required>
                        <label for="addFruitName">Name</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="addFruitCity" required>
                            <%
                                for (int i = 0; i < fruitCity.size(); i++) {
                                    FruitCityBean fcb = (FruitCityBean) fruitCity.get(i);
                                    out.println("<option value=\"" + fcb.getCountryRegionID() + "\">" + fcb.getCity() + "</option>");
                                }
                            %>
                        </select>
                        <label for="addFruitCity">City</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="addFruitType" required>
                            <%
                                for (int i = 0; i < fruitTypeList.size(); i++) {
                                    String type = (String) fruitTypeList.get(i);
                                    out.println("<option value=\"" + type + "\">" + type + "</option>");
                                }
                            %>
                        </select>
                        <label for="addFruitType">Type</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="addFruitUnit" maxlength="10"  required>
                        <label for="addFruitUnit">Unit</label>
                    </div>
                    <div class="mb-3">
                        <label for="formFile" class="form-label">Fruit Image File</label>
                        <input class="form-control" type="file" id="formFile">
                    </div>
                    <div class="button">
                        <button type="submit" class="btn btn-success">Add</button>
                        <button type="button" class="btn btn-dark" 
                                onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit '">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <%
            }
        %>
        <%
            if(isAddSource){
                String newWarehouseID = (String) request.getAttribute("newWarehouseID");
                String formattedWID = "W" + String.format("%03d", Integer.parseInt(newWarehouseID));
        %>
        <div class="modal <%= isAddSource ? "show" : "" %>">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/manageFruit" method="post">
                    <input type="hidden" name="formAction" value="addSource" >

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="newSourceID" value="<%=formattedWID%>" disabled>
                        <label for="newSourceID">WarehouseID</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" name="addSourceCountry" required>
                            <%
                                for (int i = 0; i < allCountryRegionList.size(); i++) {
                                    CountryRegionBean cb = (CountryRegionBean) allCountryRegionList.get(i);
                                    out.println("<option value=\""+cb.getId()+"\">"+cb.getName()+"</option>");
                                }
                            %>
                        </select>
                        <label for="addSourceCountry">Country/Regions</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="addSourceCity" maxlength="50"  required>
                        <label for="addSourceCity">City</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="addSourcePhone" maxlength="20"  required>
                        <label for="addSourcePhone">Phone</label>
                    </div>
                    <div class="button">
                        <button type="submit" class="btn btn-success">Add</button>
                        <button type="button" class="btn btn-dark" 
                                onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit '">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <%
            }
        %>

        <div class="container">
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Manage Fruit Types</h2>
                <p class="lead">Add, edit, or remove fruit types in the system.</p>
            </div>

            <div class="container py-4">
                <!-- Main Content -->
                <div class="row g-4">
                    <!-- Fruit Management Section -->
                    <div class="col-lg-9">
                        <div class="card border-0 shadow-sm mb-4">
                            <form method="post" action="/ITP4511_Project/inventory" id="stockForm">
                                <input type="hidden" name="action" value="update">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h4 class="mb-0"><i class="material-icons align-middle me-2">category</i>Fruits in system</h4>

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
                                                        <th style="width: 25%">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <jsp:useBean id="fruitsStockList" class="java.util.ArrayList" scope="request"/>
                                                    <%
                                                        for (int i = 0; i < fruitsStockList.size(); i++) {
                                                            FruitsBean fb = (FruitsBean) fruitsStockList.get(i);
                                                            String fruitName = fb.getName();
                                                            String type = fb.getType();
                                                            String unit = fb.getUnit();
                                                            String img = fb.getImgName();
                                                            String city = fb.getCity();
                                                            String countryRegion = fb.getCountryRegion();
                                                            String fruitId = fb.getId(); 
                                                            String status = fb.getStatus();
                                                            String rowClass = status.equalsIgnoreCase("enable") ? "enable-row" : "disable-row";
                                                    %>
                                                    <tr class="fruitItem <%=rowClass%>" data-fruit-name="<%=fruitName%>" data-type="<%=type%>">
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${pageContext.request.contextPath}/img/<%=img%>" alt="<%=fruitName%>" class="me-3 rounded fruitImg">
                                                                <div>
                                                                    <h6 class="mb-0"><%=fruitName%></h6>
                                                                    <small class="text-muted"><%=city%>, <%=countryRegion%></small>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><%=type%></td>
                                                        <td><%=unit%></td>
                                                        <td>
                                                            <button type="button" class="btn btn-warning" onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit?action=edit&fruitID=<%=fruitId%> '">
                                                                <i class="material-icons">edit</i></button>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center mt-2 fruitResultInfo d-none">
                                            <span class="badge bg-secondary">Showing <span id="visibleFruitCount">0</span> of <span id="totalFruitCount">0</span> fruits</span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Summary Section -->
                    <div class="col-lg-3">
                        <!-- Add Fruit -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-body p-4">
                                <h5 class="mb-3"><i class="material-icons align-middle me-2">add_circle</i>Add New Fruit</h5>
                                <div id="inventorySummary">
                                    <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                                        <div class="button-container">
                                            <button type="button" class="btn btn-success" 
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit?action=addFruit'">
                                                <i class="material-icons">category</i>Add new fruit
                                            </button>
                                            <button type="button" class="btn btn-warning"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/manageFruit?action=addSource'">
                                                <i class="material-icons">warehouse</i>Add new source
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Fruit Summary -->
                        <%
                            String total = (String) request.getAttribute("totalFruit");
                            String enable = (String) request.getAttribute("enableFruit");
                            String disable = (String) request.getAttribute("disableFruit");
                        %>
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-body p-4">
                                <h5 class="mb-3"><i class="material-icons align-middle me-2">summarize</i>Stock Summary</h5>
                                <div id="inventorySummary">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Enabled Fruit:</span>
                                        <span id="totalItems"><%=enable%></span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                                        <span>Disabled Fruit:</span>
                                        <span id="totalItems"><%=disable%></span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Total Items:</span>
                                        <span id="totalItems"><%=total%></span>
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
                                        Click the Edit button to modify the data of the fruit
                                    </li>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>





        <footer:footer userType="seniorManagement"/>
    </body>
</html>
