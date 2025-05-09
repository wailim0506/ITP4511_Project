<%-- 
    Document   : userList
    Created on : 2025年4月22日, 上午1:42:28
    Author     : HwH
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
        <title>User List - ACER</title>
        <!-- favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/css/userList.css" rel="stylesheet">
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
            
            if(userType.equals("warehouse")){
                userType = ub.getWarehouseType().equals("Central")?"Central":"Source";
            }
            
            String type = (userType.equals("shop"))?"shop":(userType.equals("warehouse"))?"warehouse":"all";
            String idTitle = (userType.equals("shop"))?"Shop ID":(userType.equals("warehouse"))?"Warehouse ID":"Place ID";
        %>
        <nav:nav userType="<%=userType%>" staffName="<%=ub.getStaffName()%>"/>
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
                <h2 class="display-6 fw-bold text-primary">AIB User List</h2>
                <p class="lead">View all AIB bakery <%=userType%> users</p>
            </div>
            
            <!-- Main Content -->
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h4 class="mb-4"><i class="material-icons align-middle me-2">people</i>User List</h4>
                    
                    <!-- Search and Filter Bar -->
                    <div class="mb-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">search</i>
                                    </span>
                                    <input type="text" class="form-control" id="userSearch" placeholder="Search User by Staff Name">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">manage_accounts</i>
                                    </span>
                                    <select class="form-select" id="roleFilter">
                                        <option value="all" selected>Role</option>
                                        <option value="--" disabled>------------------------------</option>
                                        <option value="Staff">Staff</option>
                                        <option value="Manager">Manager</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">place</i>
                                    </span>
                                    <select class="form-select" id="placeIdFilter">
                                        <option value="all" selected><%=idTitle%></option>
                                        <option value="--" disabled>------------------------------</option>
                                        <%
                                            if (userType.equals("shop")) {
                                                ArrayList shopIdList = (ArrayList)request.getAttribute("shopIdList");
                                                for (int i = 0; i < shopIdList.size(); i++) {
                                                    String placeId = (String)shopIdList.get(i);
                                                    out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                                }
                                            }else if (userType.equals("warehouse")) {
                                                ArrayList warehouseIdList = (ArrayList)request.getAttribute("warehouseIdList");
                                                for (int i = 0; i < warehouseIdList.size(); i++) {
                                                    String placeId = (String)warehouseIdList.get(i);
                                                    out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                                }
                                            }else{
                                                ArrayList shopIdList = (ArrayList)request.getAttribute("shopIdList");
                                                ArrayList warehouseIdList = (ArrayList)request.getAttribute("warehouseIdList");
                                                out.println("<option value='--' disabled>------------Shop------------</option>");
                                                for (int i = 0; i < shopIdList.size(); i++) {
                                                    String placeId = (String)shopIdList.get(i);
                                                    out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                                }
                                                out.println("<option value='--' disabled>----------Warehouse----------</option>");
                                                for (int i = 0; i < warehouseIdList.size(); i++) {
                                                    String placeId = (String)warehouseIdList.get(i);
                                                    out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                                }

                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-1 col-sm-12">
                                <button type="button" id="resetFilterBtn" class="btn btn-outline-secondary w-100">
                                    <i class="material-icons align-middle me-1 small">refresh</i>
                                </button>
                            </div>

                            <%
                                if (ub.getRole().equals("Manager") || ub.getRole().equals("SeniorManagement")) {
                            %>
                                <div class="col-md-3 col-sm-12">
                                    <button type="button" id="addUserBtn" class="btn btn-primary w-100">
                                        <i class="material-icons align-middle me-1 small">person_add</i> Add User
                                    </button>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <!-- Shop Table -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Staff Name</th>
                                    <th>Role</th>
                                    <th><%=idTitle%></th>
                                    <%
                                        if (ub.getRole().equals("Manager") || ub.getRole().equals("SeniorManagement")) {
                                            out.println("<th>Action</th>");
                                        }
                                    %>
                                </tr>
                            </thead>
                            <tbody>
                                <jsp:useBean id="userList" class="java.util.ArrayList" scope="request"/>
                                <%
                                    for (int i = 0; i < userList.size(); i++) {
                                        UserBean user = (UserBean)userList.get(i);
                                        
                                        String userId = user.getUserId();
                                        String staffName = user.getStaffName();
                                        String role = user.getRole();
                                        String placeId = user.getPlaceId();

                                        
                                        out.println("<tr class='user' data-place-id='" +placeId+"'data-user-id='" + staffName + "' data-role='" + role + "'>");
                                        out.println("<td><div class='d-flex align-items-center'><i class='material-icons text-primary me-2'>people</i>" + userId + "</div></td>");
                                        out.println("<td>" + staffName + "</td>");
                                        out.println("<td>" + role + "</td>");
                                        out.println("<td>" + placeId + "</td>");
                                        if (ub.getRole().equals("Manager") || ub.getRole().equals("SeniorManagement")) {
                                            if (ub.getRole().equals("Manager")){
                                                if (placeId.equals(ub.getShopId()) || placeId.equals(ub.getWareHouseId())){
                                                    out.println("<td>"
                                                                +"<button type='button' class='btn btn-primary btn-sm editUserBtn me-1' data-user-id='" + userId + "'><i class='material-icons'>edit</i></button>"
                                                                +"<button type='button' class='btn btn-danger btn-sm deleteUserBtn ms-1' data-user-id='" + userId + "'><i class='material-icons'>delete</i></button>"
                                                            +"</td>");
                                                }else{
                                                    out.println("<td>"
                                                                +"<p></p>"
                                                                +"<p></p>"
                                                            +"</td>");
                                                }
                                            }else{
                                                out.println("<td>"
                                                            +"<button type='button' class='btn btn-primary btn-sm editUserBtn me-1' data-user-id='" + userId + "'><i class='material-icons'>edit</i></button>"
                                                            +"<button type='button' class='btn btn-danger btn-sm deleteUserBtn ms-1' data-user-id='" + userId + "'><i class='material-icons'>delete</i></button>"
                                                        +"</td>");
                                            }
                                            
                                        }
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Result Info -->
                    <div class="text-center mt-4 userResultInfo d-none">
                        <span class="badge bg-secondary">Showing <span id="visibleUserCount">0</span> of <span id="totalUserCount">0</span> users</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">
                            <i class="material-icons align-middle me-2">person_add</i>Add New User
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addUserForm" method="post" action="${pageContext.request.contextPath}/userList?action=add">
                            <input type="hidden" name="userType" value="<%=userType%>">
                            <div class="mb-3">
                                <label for="staffName" class="form-label">Staff Name</label>
                                <input type="text" class="form-control" id="staffName" name="staffName" required>
                            </div>
                            <div class="mb-3">
                                <label for="userName" class="form-label">User Name</label>
                                <input type="text" class="form-control" id="userName" name="userName" required>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="role" class="form-label">Role</label>
                                <select class="form-select" id="role" name="role" required>
                                    <option value="" selected disabled>Select Role</option>
                                    <option value="Staff">Staff</option>
                                    <option value="Manager">Manager</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="placeId" class="form-label"><%=idTitle%></label>
                                <%
                                    if (userType.equals("shop") || userType.equals("warehouse")) {
                                        out.println("<select class='form-select' id='placeId' name='placeId' required readonly >");
                                    } else {
                                        out.println("<select class='form-select' id='placeId' name='placeId' required>");
                                    }
                                %>
                                    <option value="" selected disabled>Select <%=idTitle%></option>
                                    <%
                                        if (userType.equals("shop")) {
                                            ArrayList shopIdList = (ArrayList)request.getAttribute("shopIdList");
                                            for (int i = 0; i < shopIdList.size(); i++) {
                                                String placeId = (String)shopIdList.get(i);
                                                if (placeId.equals(ub.getShopId())){
                                                    out.println("<option selected  value='" + placeId + "'>" + placeId + "</option>");
                                                }
                                            }
                                        } else if (userType.equals("warehouse")) {
                                            ArrayList warehouseIdList = (ArrayList)request.getAttribute("warehouseIdList");
                                            for (int i = 0; i < warehouseIdList.size(); i++) {
                                                String placeId = (String)warehouseIdList.get(i);
                                                
                                                if (placeId.equals(ub.getWareHouseId())){
                                                    out.println("<option selected  value='" + placeId + "'>" + placeId + "</option>");
                                                }
                                            }
                                        }else{
                                            ArrayList shopIdList = (ArrayList)request.getAttribute("shopIdList");
                                            ArrayList warehouseIdList = (ArrayList)request.getAttribute("warehouseIdList");
                                            out.println("<option value='--' disabled>------------Shop------------</option>");
                                            for (int i = 0; i < shopIdList.size(); i++) {
                                                String placeId = (String)shopIdList.get(i);
                                                out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                            }
                                            out.println("<option value='--' disabled>----------Warehouse----------</option>");
                                            for (int i = 0; i < warehouseIdList.size(); i++) {
                                                String placeId = (String)warehouseIdList.get(i);
                                                out.println("<option value='" + placeId + "'>" + placeId + "</option>");
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" form="addUserForm" class="btn btn-primary">Add User</button>
                    </div>
                </div>
            </div>
        </div>

        <footer:footer userType="<%=userType%>"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
        <script src="${pageContext.request.contextPath}/js/userList.js"></script>
        
        <script>
            $(document).ready(function() {
                // Add user button click handler
                $("#addUserBtn").click(function() {
                    $('#addUserModal').modal('show');
                });
            });
        </script>
    </body>
</html>
