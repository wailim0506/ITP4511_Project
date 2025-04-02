<%-- 
    Document   : error
    Created on : 2025年4月2日, 下午10:25:12
    Author     : 19647
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Error!</title>
        <!-- favicon -->
        <link rel="icon" href="../../img/favicon.ico" type="image/x-icon">
        <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
        <!-- bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jquery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Google Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../js/darkModeControl.js"></script>
        <link href="./css/error.css" rel="stylesheet">
    </head>
    <body>
        <% 
            String navType = request.getParameter("navType");
            String footerType = request.getParameter("footerType");
        %>
        <jsp:include page="<%= navType%>" />
        <div class="error-container">
            <div class="error-row"> 
                <div class="error-col">
                    <p class="align-items-center">
                        <i class="material-icons text-primary me-2 icon">bakery_dining</i>
                        <span class="fw-bold icon-font">ACER</span>
                    </p>

                    <h1>Oops! We can't find that page.</h1>
                    </br>
                    <h3><b><%= exception%></b></h3>
                </div>
                <img src="img/Error.png" class="errorImg">
            </div>
        </div>
        <jsp:include page="<%=footerType%>" />
    </body>
</html>
