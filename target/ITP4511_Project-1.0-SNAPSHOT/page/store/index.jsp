<%-- 
    Document   : index
    Created on : 2025年3月27日, 下午7:21:34
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../components/store/navBar.jsp" %>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jquery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Google Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../js/darkModeControl.js"></script>
    </head>
    <body>
        <h1>This is store home page.</h1>
        <%@include file="../../components/store/footer.jsp" %>
        <i id="darkModeToogle" class="material-icons"
        style="position:fixed; bottom: 10px; right: 10px; cursor: pointer;">wb_sunny</i>
    </body>
</html>
