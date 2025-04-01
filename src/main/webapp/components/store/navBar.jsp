<%-- 
    Document   : navBar
    Created on : 2025年3月27日, 下午7:18:08
    Author     : wailim0506
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg sticky-top shadow-sm" style="border-bottom: var(--bs-border-width) solid var(--bs-border-color); z-index: 1000; background-color: var(--bs-body-bg);">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="material-icons text-primary me-2">bakery_dining</i>
            <span class="fw-bold">ACER</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">home</i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">shopping_cart</i> Reserve</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">bookmark</i> Reservations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">swap_horiz</i> Borrowed</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">inventory</i> Stock</a>
                </li>
                <%-- logout --%>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="material-icons small align-middle me-1">logout</i> Logout</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <a class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center" href="#" role="button" 
                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons me-2">account_circle</i>
                        <span>User Name</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="#"><i class="material-icons small me-2">person</i>Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="material-icons small me-2">settings</i>Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#"><i class="material-icons small me-2">logout</i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
