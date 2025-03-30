<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html id="html" lang="en" data-bs-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ACER - Login</title>
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
        <style>
            body {
                min-height: 100vh;
                font-family: 'Poppins', sans-serif;
                background-color: var(--bs-body-bg);
                background-image: radial-gradient(rgba(0, 0, 0, 0.03) 1px, transparent 1px);
                background-size: 25px 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
            }
            
            .login-container {
                width: 100%;
                max-width: 420px;
                padding: 15px;
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .logo-icon {
                font-size: 60px;
                color: var(--bs-primary);
                margin-bottom: 1rem;
                display: inline-block;
                background: rgba(var(--bs-primary-rgb), 0.1);
                border-radius: 50%;
                padding: 15px;
            }
            
            .login-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            
            [data-bs-theme="dark"] .login-card {
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
                background-color: rgba(var(--bs-dark-rgb), 0.8);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            .login-body {
                padding: 2rem;
            }
            
            .form-control {
                border-radius: 8px;
                padding: 12px;
                border: 1px solid rgba(var(--bs-body-color-rgb), .1);
                background-color: rgba(var(--bs-body-bg-rgb), .8);
                transition: all 0.2s ease-in-out;
            }
            
            .form-control:focus {
                box-shadow: 0 0 0 3px rgba(var(--bs-primary-rgb), .25);
                border-color: var(--bs-primary);
            }
            
            .login-btn {
                border-radius: 8px;
                padding: 12px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                background-color: var(--bs-primary);
                border: none;
            }
            
            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(var(--bs-primary-rgb), .3);
            }
            
            .form-label {
                font-weight: 500;
                margin-bottom: 8px;
            }
            
            .form-check-input:checked {
                background-color: var(--bs-primary);
                border-color: var(--bs-primary);
            }
            
            .login-footer {
                text-align: center;
                margin-top: 2rem;
                color: var(--bs-secondary-color);
                font-size: 14px;
            }
            
            .toggle-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 1000;
            }
            
            .toggle-icon {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
                transition: all 0.3s ease;
            }
            
            [data-bs-theme="light"] .toggle-icon {
                background-color: white;
            }
            
            [data-bs-theme="dark"] .toggle-icon {
                background-color: #343a40;
            }
        </style>
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
