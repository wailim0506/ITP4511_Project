<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ACER - Login</title>
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
        <script src="./js/darkModeControl.js"></script>
        <link href="./css/index.css" rel="stylesheet">
    
    </head>
    <body>
        <div class="login-container">
            <!-- Logo Header -->
            <div class="login-header">
                <i class="material-icons logo-icon">bakery_dining</i>
                <h2 class="fw-bold">ACER Bakery</h2>
                <p class="text-muted">Web Management System</p>
            </div>
            
            <!-- Login Form Card -->
            <div class="login-card card">
                <div class="login-body">
                    <h4 class="mb-4">Sign In to Your Account</h4>
                    
                    <form action="login" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <div class="input-group">
                                <span class="input-group-text border-0 bg-transparent">
                                    <i class="material-icons small text-muted">person</i>
                                </span>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text border-0 bg-transparent">
                                    <i class="material-icons small text-muted">lock</i>
                                </span>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                                <label class="form-check-label small" for="rememberMe">
                                    Remember me
                                </label>
                            </div>
                            <a href="#" class="small text-decoration-none">Forgot password?</a>
                        </div>
                        
                        <button type="submit" class="btn login-btn w-100 text-white">Sign In</button>
                    </form>
                </div>
            </div>
            
            <div class="login-footer">
                <p>&copy; 2025 ACER International Bakery. All rights reserved.</p>
            </div>
        </div>
        
        <div class="toggle-container">
            <div class="toggle-icon">
                <i id="darkModeToogle" class="material-icons">wb_sunny</i>
            </div>
        </div>
    </body>
</html>
