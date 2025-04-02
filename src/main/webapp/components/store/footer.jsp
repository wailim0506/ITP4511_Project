<%-- 
    Document   : footer
    Created on : 2025年3月27日, 下午7:18:16
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="mt-4 py-3" style="border-top: var(--bs-border-width) solid var(--bs-border-color);">
    <div class="container">
        <!-- Navigation Links -->
        <nav class="nav justify-content-center flex-nowrap">
            <a class="nav-link text-secondary" href="${pageContext.request.contextPath}/page/store/reserveFruit.jsp">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">home</i>
                    <span>Dashboard</span>
                </div>
            </a>
            <a class="nav-link text-secondary" href="/ITP4511_Project/reserveFruit?action=list">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">shopping_cart</i>
                    <span>Reserve</span>
                </div>
            </a>
            <a class="nav-link text-secondary" href="#">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">bookmark</i>
                    <span>Reservations</span>
                </div>
            </a>
            <a class="nav-link text-secondary" href="#">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">swap_horiz</i>
                    <span>Borrowed</span>
                </div>
            </a>
            <a class="nav-link text-secondary" href="#">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">inventory</i>
                    <span>Stock</span>
                </div>
            </a>
            <a class="nav-link text-secondary" href="#">
                <div class="d-flex align-items-center">
                    <i class="material-icons small me-1">person</i>
                    <span>Profile</span>
                </div>
            </a>
        </nav>
        
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
