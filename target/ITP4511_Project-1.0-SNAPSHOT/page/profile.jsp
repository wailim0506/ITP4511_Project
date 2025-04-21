<%-- 
    Document   : profile
    Created on : 2025年4月20日, 下午8:40:27
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ict.bean.*" %>
<%@ taglib uri="/WEB-INF/tlds/nav.tld" prefix="nav" %>
<%@ taglib uri="/WEB-INF/tlds/footer.tld" prefix="footer" %>
<%@ taglib uri="/WEB-INF/tlds/profile.tld" prefix="profile" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ACER - Profile</title>
        <!-- favicon -->
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
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
        <link href="${pageContext.request.contextPath}/css/profile.css" rel="stylesheet">
    </head>
    <body>
        <%
            String userType = (String) session.getAttribute("userType");
            UserBean ub = (UserBean) session.getAttribute("userInfo");
            
            String msg = (String) request.getAttribute("msg");
            String msgCollapse = (msg!=null)?"":"collapse";
            String errorMsg = (String) request.getAttribute("errorMsg");
            String errorMsgCollapse = (errorMsg!=null)?"":"collapse";
        %>
        <nav:nav userType="warehouse" staffName="<%=ub.getStaffName()%>"/>
        
        <div class="profile-container">
            <div class="profile-container-info">
                <h1 class="profile-container-title">Profile</h1>
                <div class="profile-container-data">
                    <div class="profile-container-info-box">
                        <form action="/ITP4511_Project/ProfileController" method="GET">
                            <div class="form-floating mb-3">
                                <input type="text" max="50" class="form-control" id="floatingInput" value="<%=ub.getStaffName()%>" name="staffName" required>
                                <label for="floatingInput">Staff Name</label>
                            </div>
                            <input type="hidden" name="action" value="updateStaffName">
                            <button class="btn btn-primary btn-sm" type="submit">Change Staff Name</button>
                        </form>
                        <br/>
                        <form action="/ITP4511_Project/ProfileController" method="GET" onsubmit="return confirmPasswordChange();">
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingInput" name="oPass" required>
                                <label for="floatingInput">Old Password</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingInput" name="nPass" required>
                                <label for="floatingInput">New Password</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingInput" name="cPass" required>
                                <label for="floatingInput">Confirm Password</label>
                            </div>
                            <input type="hidden" name="action" value="changePassword">
                            <button class="btn btn-primary btn-sm" type="submit">Change Password</button>
                        </form>
                    </div>
                    <div class="profile-container-info-box">
                        <img src="${pageContext.request.contextPath}/img/Staff.png" class="profile-img">
                        <profile:profile userBean="<%=ub%>" />
                    </div>
                </div>
                <div class="alert alert-success <%=msgCollapse%>" role="alert">
                    <%=msg%>
                </div>
                
                <div class="alert alert-danger <%=errorMsgCollapse%>" role="alert">
                    <%=errorMsg%>
                </div>
            </div>
        </div>



        <footer:footer userType="warehouse"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
    <script>
        function confirmPasswordChange() {
            return confirm("Are you sure to change your password? This operation will logout your account.");
        }
    </script>
</html>
