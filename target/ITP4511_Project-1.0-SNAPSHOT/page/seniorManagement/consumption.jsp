<%-- 
    Document   : consumption
    Created on : 2025年5月11日, 下午4:41:26
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
        <title>Consumption Report - ACER</title>
        <!-- favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!-- Custom stylesheets -->
        <link href="${pageContext.request.contextPath}/css/darkModeControl.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/seniorManagement/consumption.css" rel="stylesheet">

        <!-- JavaScript libraries -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/darkModeControl.js"></script>
    </head>
    <body>
        <%
            UserBean bean = (UserBean)session.getAttribute("userInfo");
            String staffName = (String)bean.getStaffName();
            if (staffName == null) {
                throw new Exception();
            }
        %>
        <nav:nav userType="seniorManagement" staffName="<%=staffName%>"/>

        <div class="container">
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Consumption Report</h2>
                <p class="lead">View and analyze fruit consumption data</p>
            </div>

            <div class="filter">
                <div class="filter-title">
                    <i class="material-icons align-middle me-2">filter_list</i><h4>Filter Orders</h4>
                </div>
                <form>
                    <div class="mb-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">public</i>
                                    </span>
                                    <select class="form-select" name="countryRegion">
                                        <option value="--" disabled selected>Counity / Region</option>
                                        <option value="HK">Hong Kong</option>
                                        <option value="JP">Japan</option>
                                        <option value="US">United States</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">location_city</i>
                                    </span>
                                    <select class="form-select" name="city">
                                        <option value="--" disabled selected>City</option>
                                        <jsp:useBean id="shopCityList" class="java.util.ArrayList" scope="request"/>
                                        <%
                                            for (int i = 0; i < shopCityList.size(); i++) {
                                                String city = (String)shopCityList.get(i);
                                                out.println("<option value='" + city + "'>" + city + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">storefront</i>
                                    </span>
                                    <input type="text" class="form-control" name="shop" placeholder="Search shop...">
                                </div>
                            </div>
                            <div class="col-md-1 col-sm-12">
                                <button type="reset" class="btn btn-outline-secondary w-100">
                                    <i class="material-icons align-middle me-1 small">refresh</i>
                                </button>
                            </div>
                            <div class="col-md-2 col-sm-12">
                                <button type="submit" class="btn btn-success w-100">
                                    Apply
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
                                 
            <jsp:useBean id="cbList" class="java.util.ArrayList" scope="request"/>                        
            <div class="fruitList">
                <div class="fruitList-title">
                    <i class="material-icons card-icon mb-1">category</i>
                    <h4>Fruit Consumption</h4>
                </div>
                <div class="fruit">
                    <%
                        for(Object obj:cbList){
                            ConsumptionBean cb = (ConsumptionBean)obj;
                            
                    %>
                    <div class="fruit-card">
                        <img src="${pageContext.request.contextPath}/img/<%=cb.getFruitImg()%>" alt="Apple">
                        <div class="fruit-info">
                            
                            <h5><%=cb.getFruitName()%></h5>
                            <p><%=cb.getFruitCity()%>, <%=cb.getFruitCountry()%></p>
                            <h4><%=cb.getTotal()%> <%=cb.getFruitUnit()%></h4>
                            
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>

        </div>

        <footer:footer userType="seniorManagement"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
