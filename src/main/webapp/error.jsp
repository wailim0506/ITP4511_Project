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
            String navType = (String) request.getAttribute("navType");
            String footerType = (String) request.getAttribute("footerType");
            String errorTitle =  (String) request.getAttribute("errorTitle");
            String errorMsg = (String) request.getAttribute("errorMsg");
            
            if (errorTitle == null)
                errorTitle = "Oops! Something went wrong.";
            if (errorMsg == null)
                errorMsg = "";
        %>
        
        <% if(navType != null){ %>
            <jsp:include page="navType" />
        <% }else{ %>
            <nav class="navbar navbar-expand-lg sticky-top shadow-sm" style="border-bottom: var(--bs-border-width) solid var(--bs-border-color); z-index: 1000; background-color: var(--bs-body-bg);">
                <div class="container">
                    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                        <i class="material-icons text-primary me-2">bakery_dining</i>
                        <span class="fw-bold">ACER</span>
                    </a>
                </div>
            </nav>
        <% } %>

        <div class="error-container">
            <div class="error-row"> 
                <div class="error-col">
                    <p class="align-items-center">
                        <i class="material-icons text-primary me-2 icon">bakery_dining</i>
                        <span class="fw-bold icon-font">ACER</span>
                    </p>

                    <h1>Oops! We can't find that page.</h1>
                    </br>
                    <h6><b><%= errorMsg%></b></h6>
                </div>
                <img src="img/Error.png" class="errorImg">
            </div>
        </div>
                        
        <% if(footerType != null){ %>    
            <jsp:include page="<%= footerType%>" />
        <% }else{ %>
            <div class="mt-4 py-3" style="border-top: var(--bs-border-width) solid var(--bs-border-color);">
                <div class="container">
                    <!-- Copyright -->
                    <div class="text-center text-muted small mt-2">
                        <div class="d-flex align-items-center justify-content-center">
                            <i class="material-icons small me-1">bakery_dining</i>
                            <span>ACER International Bakery</span>
                        </div>
                        <p class="mb-0 mt-1">&copy; 2025 ACER. All rights reserved.</p>
                    </div>
                </div>
            </div>
        <% } %>
    </body>
</html>
