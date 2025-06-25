<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Login | Coputer Element System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- EduChamp CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            .login-main-row {
                min-height: 100vh;
                display: flex;
            }
            .login-left {
                position: relative;
                background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
                color: #fff;
                flex: 1;
                display: flex;
                align-items: stretch;
                min-width: 400px;
                overflow: hidden;
            }
            .login-left::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(93,46,188,0.85); /* overlay tím */
                z-index: 1;
            }
            .login-left > * {
                position: relative;
                z-index: 2;
            }
            .login-left .logo {
                margin-bottom: 30px;
            }
            .login-left .logo img {
                width: 80px;
                margin-bottom: 10px;
            }
            .login-left .brand-title {
                font-size: 2rem;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .login-left .brand-desc {
                font-size: 1.1rem;
                opacity: 0.9;
            }
            .login-right {
                flex: 1.2;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f4f6fb;
                min-height: 100vh;
            }
            .login-form-box {
                width: 100%;
                max-width: 400px;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 32px rgba(44, 62, 80, 0.12);
                padding: 48px 36px 36px 36px;
                margin: 32px 0;
                display: flex;
                flex-direction: column;
                align-items: stretch;
                transition: box-shadow 0.2s;
            }
            .login-form-box:hover {
                box-shadow: 0 12px 40px rgba(44, 62, 80, 0.18);
            }
            .login-form-box h2 {
                font-family: 'Times New Roman', Times, serif;
                font-size: 2.1rem;
                font-weight: 800;
                margin-bottom: 10px;
                text-align: center;
                color: #222;
                letter-spacing: -1px;
            }
            .login-form-box p {
                margin-bottom: 28px;
                text-align: center;
                color: #666;
            }
            .login-form-box .form-label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
            }
            .login-form-box .form-control {
                width: 100%;
                box-sizing: border-box;
                border-radius: 10px;
                min-height: 46px;
                font-size: 1.08rem;
                border: 1.5px solid #e0e3ea;
                margin-bottom: 18px;
                padding: 10px 16px;
                background: #fff;
                transition: border-color 0.2s;
            }
            .login-form-box .form-control:focus {
                border-color: #705FBC;
                box-shadow: 0 0 0 2px rgba(112,95,188,0.08);
            }
            .login-form-box .btn-warning {
                width: 100%;
                min-height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 1.13rem;
                margin: 20px 0 12px 0;
                border-radius: 8px;
                background: #ffc107;
                border: none;
                color: #222;
                box-shadow: none;
                padding: 0;
                transition: background 0.2s, color 0.2s;
            }
            .login-form-box .btn-warning:hover {
                background: #e0a800;
                color: #fff;
            }
            .login-form-box .btn-facebook,
            .login-form-box .btn-google {
                width: 48%;
                min-height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 1.1rem;
                border: none;
                border-radius: 8px;
                box-shadow: none;
                margin: 0;
                padding: 0;
                transition: background 0.2s, color 0.2s;
            }
            .login-form-box .btn-facebook {
                background: #3b5998;
                color: #fff;
            }
            .login-form-box .btn-facebook:hover {
                background: #2d4373;
                color: #fff;
            }
            .login-form-box .btn-google {
                background: #ea4335;
                color: #fff;
            }
            .login-form-box .btn-google:hover {
                background: #c23321;
                color: #fff;
            }
            .login-form-box .social-login {
                display: flex;
                gap: 16px;
                margin-top: 12px;
            }
            .login-form-box .form-check-label,
            .login-form-box .form-check-input {
                cursor: pointer;
            }
            .login-form-box .alert {
                width: 100%;
                text-align: center;
                margin-bottom: 1rem;
                border-radius: 8px;
            }
            .login-form-box a {
                color: #705FBC;
                text-decoration: none;
                font-weight: 500;
            }
            .login-form-box a:hover {
                text-decoration: underline;
            }
            @media (max-width: 900px) {
                .login-main-row {
                    flex-direction: column;
                }
                .login-left, .login-right {
                    min-width: 100vw;
                }
            }
            .login-left section.hero-section {
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
            }
            .login-left .hero-section .container {
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .login-left .hero-section .row {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .login-left .hero-section .col-md-12, .login-left .hero-section .col-md-6 {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                text-align: center;
            }
            .login-left .hero-section h1,
            .login-left .hero-section p,
            .login-left .hero-section a {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="login-main-row">
            <style>
                .login-left {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh; /* căn giữa theo chiều dọc */
                    background-color: #222; /* màu nền tối để dễ nhìn text trắng */
                }

                .login-left-content {
                    text-align: center;
                    color: #fff;
                    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                    max-width: 600px;
                    padding: 20px;
                }

                .login-left-content h1 {
                    font-size: 3rem;
                    font-weight: bold;
                    margin-bottom: 1.5rem;
                }

                .login-left-content p {
                    font-size: 1.25rem;
                    margin-bottom: 1.5rem;
                    text-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
                }

                .login-left-content a {
                    font-size: 1.25rem;
                }
            </style>

            <div class="login-left">
                <div class="login-left-content">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet" style="color: white;">
                        <i class="fas fa-microchip me-2"></i>
                        <span class="fw-bold">CES</span>
                    </a>
                    <h1>Build Your Dream PC</h1>
                    <p>
                        Customize your perfect PC with our easy-to-use PC Builder tool.<br>
                        Select from our wide range of high-quality components.
                    </p>
                    <a href="PCBuilderServlet" class="btn btn-primary btn-lg" style="color: white">Build PC</a>
                </div>
            </div>

            <div class="login-right">
                <div class="login-form-box">
                    <h2><span>Login to your</span> Account</h2>
                    <p>Don't have an account? <a href="Register.jsp">Create one here</a></p>
                    
                    <!-- Hiển thị thông báo thành công từ session -->
                    <% String successMessage = (String) session.getAttribute("successMessage"); %>
                    <% if (successMessage != null) { %>
                        <div class="alert alert-success" role="alert">
                            <i class="fa fa-check-circle me-2"></i><%= successMessage %>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    <% } %>
                    
                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert"><%= error %></div>
                    <% } %>
                    <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>
                    <form action="login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label class="form-label" for="email">Email</label>
                            <input type="text" class="form-control" id="email" name="email"
                                   value="<c:out value='${param.email != null ? param.email : (not empty email ? email : "")}'/>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="password">Your Password</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   value="<c:out value='${param.password != null ? param.password : (not empty password ? password : "")}'/>" required>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember" name="remember" value="ON"
                                       <c:if test="${param.remember == 'ON' || remember == 'ON'}">checked</c:if>>
                                <label class="form-check-label" for="remember">Remember me</label>
                            </div>
                            <a href="forget_password.jsp">Forgot Password?</a>
                        </div>
                        <button type="submit" class="btn btn-warning">Login</button>
                        <div class="text-center mt-2 mb-2 fw-bold">Login with Social media</div>
                        <div class="social-login">
                            <a class="btn btn-facebook" href="#"><i class="fa fa-facebook"></i> Facebook</a>
                            <a class="btn btn-google" href="#"><i class="fa fa-google-plus"></i> Google Plus</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            const loginForm = document.getElementById('loginForm');
            if (loginForm) {
                loginForm.addEventListener('submit', function (event) {
                    const email = document.getElementById('email').value;
                    const password = document.getElementById('password').value;
                    const errorDiv = document.getElementById('clientError');
                    let errors = [];

                    if (email.trim() === '') {
                        errors.push("Username is required.");
                    }

                    if (password.trim() === '') {
                        errors.push("Password is required.");
                    }

                    if (errors.length > 0) {
                        event.preventDefault();
                        errorDiv.innerHTML = errors.join('<br>');
                        errorDiv.style.display = 'block';
                    } else {
                        errorDiv.style.display = 'none';
                    }
                });
            }
        </script>
    </body>
</html>
