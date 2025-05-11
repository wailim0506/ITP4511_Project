<%-- 
    Document   : consumption
    Created on : 2025年5月11日, 下午4:41:26
    Author     : HwH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="ict.bean.*, java.util.*" %>
<%@page errorPage="${pageContext.request.contextPath}/error.jsp" %>
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
        <script src="${pageContext.request.contextPath}/js/seniorManagement/pieChart.js"></script>
    </head>
    <body>
        <%
            UserBean bean = (UserBean)session.getAttribute("userInfo");
            boolean requested = (boolean)request.getAttribute("requested");
            String staffName = (String)bean.getStaffName();
            if (staffName == null) {
                throw new Exception();
            }
        %>
        <nav:nav userType="seniorManagement" staffName="<%=staffName%>"/>
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
        <div class="container">
            <div class="headerSection text-center shadow-sm mb-4">
                <h2 class="display-6 fw-bold text-primary">Consumption Report</h2>
                <p class="lead">View and analyze fruit consumption data</p>
            </div>

            <div class="filter">
                <div class="filter-title">
                    <i class="material-icons align-middle me-2">filter_list</i><h4>Filter Orders</h4>
                </div>
                <form action="${pageContext.request.contextPath}/consumption" method="POST">
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
                        <div class="row g-3 mb-3">
                            <div class="col-md-3 col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent">
                                        <i class="material-icons text-muted">calendar_month</i>
                                    </span>
                                    <select class="form-select" name="season">
                                        <option value="--" disabled selected>Season</option>
                                        <option value="spring">Spring</option>
                                        <option value="summer">Summer</option>
                                        <option value="autumn">Autumn</option>
                                        <option value="winter">Winter</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <%
                if(requested){
                String rangeFrom = (String)request.getAttribute("rangeFrom");
                String rangeTo = (String)request.getAttribute("rangeTo");
                String season = (String)request.getAttribute("season");
                String type = (String)request.getAttribute("type");
            %>
            <div class="selectedFilter">
                <p><%=type%></p>
                <p><b>Season:</b> <%=season%></p>
                <p><b>Date Range:</b> <%=rangeFrom%> - <%=rangeTo%></p>
            </div>
            <%
                }
            %>

            <jsp:useBean id="cbList" class="java.util.ArrayList" scope="request"/>                        
            <div class="fruitList">
                <div class="fruitList-title">
                    <div class="fruitList-tit">
                        <i class="material-icons card-icon mb-1">category</i>
                        <h4>Fruit Consumption</h4>
                    </div>
                    <button class="btn btn-warning" onclick="window.print()">Print Report</button>
                </div>
                <div class="fruit">
                    <%
                        if (cbList.isEmpty()) {
                    %>
                    <p>No records found</p>
                    <%
                        } else {
                            for (Object obj : cbList) {
                                ConsumptionBean cb = (ConsumptionBean) obj;
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
                        }
                    %>
                </div>
            </div>

            <script>
                window.fruitData = [
                <%
                                    for(Object obj:cbList){
                                        ConsumptionBean cb = (ConsumptionBean)obj;
                %>
                    {
                        name: '<%=cb.getFruitName()%>',
                        total: <%=cb.getTotal()%>
                    },
                <%
                                    }
                %>
                ];
            </script>

            <div class="statistics">
                <div class="pieChart">
                    <h3>Fruit Consumption Distribution</h3>

                </div>
                <div class="lineChart">
                    <h3>Fruit Consumption Totals</h3>

                </div>
            </div>
        </div>

        <footer:footer userType="seniorManagement"/>
        <i id="darkModeToogle" class="material-icons"
           style="position:fixed; bottom: 20px; right: 20px; cursor: pointer; font-size: 32px; border-radius: 50%; padding: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">wb_sunny</i>
    </body>
</html>
