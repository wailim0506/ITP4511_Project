<%-- 
    Document   : editUser
    Created on : 2025年5月7日, 下午4:28:30
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>
<%@page import="java.util.ArrayList" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<%@ taglib uri="/WEB-INF/tlds/profile.tld" prefix="profile" %>

<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit User - ACER</title>
        <!-- favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
         <link href="${pageContext.request.contextPath}/css/editUser.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <!-- Bootstrap and jQuery JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
        <!-- Dark Mode Control -->
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
    </head>
    <body>
        <%
            String userType = (String) session.getAttribute("userType");
            UserBean ub = (UserBean) session.getAttribute("userInfo");
            
            String type = (userType.equals("shop"))?"shop":(userType.equals("warehouse"))?"warehouse":"all";
            String idTitle = (userType.equals("shop"))?"Shop ID":(userType.equals("warehouse"))?"Warehouse ID":"Place ID";
            
            if(userType.equals("warehouse")){
                userType = ub.getWarehouseType().equals("Central")?"Central":"Source";
            }
       
            UserBean user = (UserBean) request.getAttribute("userInfo");  //user to be edited
            String role = user.getRole();
            String placeId = "";
            String placeType = "";
            if (user.getShopId() != null) {
                placeId = user.getShopId();
                placeType = "shop";
                idTitle = "Shop ID";
            }else if (user.getWareHouseId() != null) {
                placeId = user.getWareHouseId();
                placeType = "warehouse";
                idTitle = "Warehouse ID";
            }
        %>
        <nav:nav userType="<%=userType%>" staffName="<%=ub.getStaffName()%>"/>
        
        <div class="container editUserContainer">
            <!-- Header Section -->
            <div class="editUserHeader">
                <h2 class="display-6 fw-bold text-primary">Edit User</h2>
                <p class="text-muted mb-0">Update user information and access rights</p>
            </div>
            
            <!-- Main Content -->
            <div class="editUserForm">
                <div class="formTitle">
                    <i class="material-icons text-primary me-2">edit</i>
                    <h4>Edit User Details</h4>
                </div>
                
                <form id="editUserForm" method="post" action="${pageContext.request.contextPath}/editUser">
                    
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="userIdToBeEdit" value="<%=user.getUserId()%>">
                    <input type="hidden" name="placeType" value="<%=placeType%>">
                    <%
                        if (!userType.equals("seniorManagement")){
                            out.println("<input type=\"hidden\" name=\"placeId\" value=\"" + placeId + "\">");
                        }
                    %>
                    
                    
                    <div class="row g-3 formSection">
                        
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="userId" value="<%=user.getUserId()%>" disabled>
                                <label for="userId">User ID</label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="staffName" name="staffName" value="<%=user.getStaffName()%>" required>
                                <label for="staffName">Staff Name</label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <select class="form-select" id="role" name="role" required>
                                    <option value="Staff" <%=role.equals("Staff") ? "selected" : ""%>>Staff</option>
                                    <option value="Manager" <%=role.equals("Manager") ? "selected" : ""%>>Manager</option>
                                </select>
                                <label for="role">Role</label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <%
                                    if (userType.equals("seniorManagement")){
                                        out.println("<select class='form-select' id='placeId' name='placeId' required>");
                                    } else {
                                        out.println("<select class='form-select' id='placeId' name='placeId' required disabled>");
                                    }
                                %>
                                    <jsp:useBean id="shopIdList" class="java.util.ArrayList" scope="request"/>
                                    <jsp:useBean id="warehouseIdList" class="java.util.ArrayList" scope="request"/>

                                    <option value="" disabled selected>Select Place ID</option>
                                    <%
                                        if (placeType.equals("shop")) {
                                            for (int i = 0; i < shopIdList.size(); i++) {
                                                String shopId = (String) shopIdList.get(i);
                                                String selected = placeId.equals(shopId) ? "selected" : ""; 
                                                out.println("<option value='" + shopId + "' " + selected + ">" + shopId + "</option>");
                                            }
                                        } else if (placeType.equals("warehouse")) {
                                            for (int i = 0; i < warehouseIdList.size(); i++) {
                                                String warehouseId = (String) warehouseIdList.get(i);
                                                String selected = placeId.equals(warehouseId) ? "selected" : ""; 
                                                out.println("<option value='" + warehouseId + "' " + selected + ">" + warehouseId + "</option>");
                                            }
                                        } else {
                                            out.println("<option value='shop' " + (placeType.equals("shop") ? "selected" : "") + ">Shop</option>");
                                            out.println("<option value='warehouse' " + (placeType.equals("warehouse") ? "selected" : "") + ">Warehouse</option>");
                                        }
                                    %>

                                    
                                </select>
                                <label for="placeId"><%=idTitle%></label>
                                <% if(userType.equals("shop") || userType.equals("warehouse")) { %>
                                    <input type="hidden" name="placeId" value="<%=placeId%>">
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="actionButtons">
                        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='${pageContext.request.contextPath}/userList'">
                            <i class="material-icons align-middle me-1 small">arrow_back</i>
                            Back to User List
                        </button>
                        
                        <div>                            
                            <button type="submit" class="btn btn-primary">
                                <i class="material-icons align-middle me-1 small">save</i>
                                Save Changes
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <footer:footer userType="<%=userType%>"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
