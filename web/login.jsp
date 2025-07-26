<%--
Trang đăng nhập cho người dùng (Customer, Admin, Staff)
Hiển thị form đăng nhập, xử lý hiển thị thông báo lỗi/thành công, và các liên kết hỗ trợ như quên mật khẩu, đăng ký tài khoản mới.
--%>
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
            body, .auth-form-box, .auth-form-box * {
                font-family: 'Times New Roman', Times, serif !important;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: none;
            }
            .auth-main-row {
                min-height: 100vh;
                display: flex;
            }
            .auth-left {
                position: relative;
                background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
                color: #fff;
                flex: 1;
                display: flex;
                align-items: stretch;
                min-width: 400px;
                overflow: hidden;
            }
            .auth-left::before {
                content: '';
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                background: rgba(93,46,188,0.85);
                z-index: 1;
            }
            .auth-left > * {
                position: relative;
                z-index: 2;
            }
            .auth-left-content {
                text-align: center;
                color: #fff;
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                max-width: 600px;
                padding: 20px;
                margin: auto;
            }
            .auth-left-content .navbar-brand {
                color: white;
                display: flex;
                align-items: center;
                gap: 8px;
                justify-content: center;
                margin-bottom: 30px;
                font-size: 2rem;
                text-decoration: none;
            }
            .auth-left-content .fw-bold {
                font-size: 2rem;
                text-decoration: underline;
            }
            .auth-left-content h1 {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 1.5rem;
            }
            .auth-left-content p {
                font-size: 1.25rem;
                margin-bottom: 1.5rem;
                text-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
            }
            .auth-left-content a.btn {
                font-size: 1.25rem;
                color: white;
                background: #0d6efd;
                border-radius: 8px;
                border: none;
                padding: 0.75rem 2rem;
                display: inline-block;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(44, 62, 80, 0.13);
                transition: background 0.2s, color 0.2s;
            }
            .auth-left-content a.btn:hover {
                background: #0056b3;
                color: #fff;
            }
            .auth-right {
                flex: 1.2;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f4f6fb;
                min-height: 100vh;
            }
            .auth-form-box {
                width: 100%;
                max-width: 440px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 8px 32px rgba(44, 62, 80, 0.12);
                padding: 32px 24px 24px 24px;
                margin: 24px 0;
                display: flex;
                flex-direction: column;
                align-items: stretch;
                transition: box-shadow 0.2s;
            }
            .auth-form-box:hover {
                box-shadow: 0 12px 40px rgba(44, 62, 80, 0.18);
            }
            .auth-form-box h2 {
                font-family: 'Times New Roman', Times, serif;
                font-size: 2rem;
                font-weight: 800;
                margin-bottom: 10px;
                text-align: center;
                color: #222;
                letter-spacing: -1px;
            }
            .auth-form-box p {
                margin-bottom: 28px;
                text-align: center;
                color: #666;
            }
            .auth-form-box .form-label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
                font-size: 1rem;
            }
            .auth-form-box .form-control {
                width: 100%;
                box-sizing: border-box;
                border-radius: 10px;
                min-height: 40px;
                font-size: 1rem;
                border: 1.5px solid #e0e3ea;
                margin-bottom: 14px;
                padding: 8px 12px;
                background: #fff;
                transition: border-color 0.2s;
            }
            .auth-form-box .form-control:focus {
                border-color: #705FBC;
                box-shadow: 0 0 0 2px rgba(112,95,188,0.08);
            }
            .auth-form-box .btn-primary, .auth-form-box .btn-register, .auth-form-box button[type="submit"] {
                width: 100%;
                min-height: 44px;
                border-radius: 8px;
                background: #0d6efd;
                color: #fff;
                font-weight: 700;
                font-size: 1.13rem;
                border: none;
                box-shadow: none;
                margin: 12px 0 8px 0;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s, color 0.2s;
            }
            .auth-form-box .btn-primary:hover, .auth-form-box .btn-register:hover, .auth-form-box button[type="submit"]:hover {
                background: #0056b3;
                color: #fff;
            }
            .auth-form-box .alert {
                width: 100%;
                text-align: center;
                margin-bottom: 1rem;
                border-radius: 8px;
                font-size: 1rem;
                padding: 12px 8px;
            }
            .auth-form-box a {
                color: #705FBC;
                text-decoration: none;
                font-weight: 500;
            }
            .auth-form-box a:hover {
                text-decoration: underline;
            }
            .auth-form-box .login-link {
                text-align: center;
                margin-top: 8px;
                font-size: 0.98rem;
            }
            .auth-form-box .login-link a {
                color: #333;
                text-decoration: none;
            }
            .auth-form-box .login-link a:hover {
                text-decoration: underline;
            }
            @media (max-width: 900px) {
                .auth-main-row {
                    flex-direction: column;
                }
                .auth-left, .auth-right {
                    min-width: 100vw;
                }
            }
        </style>
    </head>
    <body>
        <div class="auth-main-row">
            <%--
                Khối bên trái: Hiển thị thông tin chào mừng, giới thiệu, nút chuyển sang PC Builder
            --%>
            <div class="auth-left">
                <div class="auth-left-content">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet" style="color: white;">
                        <span class="fw-bold">CES</span>
                    </a>
                    <h1>Welcome to CES</h1>
                    <p>
                        Join us to build your dream PC and enjoy exclusive member benefits.<br>
                        Sign up now and start your journey!
                    </p>
                    <a href="pcBuilder.jsp" class="btn btn-primary btn-lg" style="color: white">Build PC</a>
                </div>
            </div>

            <%--
                Khối bên phải: Form đăng nhập và các thông báo
            --%>
            <div class="auth-right">
                <div class="auth-form-box">
                    <h2><span>Login to your</span> Account</h2>
                    <p>Don't have an account? <a href="Register.jsp">Create one here</a></p>
                    
                    <%-- Hiển thị thông báo thành công khi đăng ký hoặc xác thực email thành công --%>
                    <% 
                    String successParam = request.getParameter("success");
                    String emailParam = request.getParameter("email");
                    String verificationParam = request.getParameter("verification");
                    String loginEmail = (String) session.getAttribute("login_email");
                    String loginPassword = (String) session.getAttribute("login_password");
                    Boolean registrationSuccess = (Boolean) session.getAttribute("registration_success");
                    
                    if ("registration".equals(successParam) && emailParam != null) {
                        // Xóa session attributes sau khi sử dụng
                        session.removeAttribute("login_email");
                        session.removeAttribute("login_password");
                        session.removeAttribute("registration_success");
                    %>
                        <div class="alert alert-success" role="alert">
                            <i class="fa fa-check-circle me-2"></i>Registration successful! Please check your email to verify your account.
                        </div>
                    <% } else { %>
                        <% String successMessage = (String) session.getAttribute("successMessage"); %>
                        <% if (successMessage != null) { %>
                            <div class="alert alert-success" role="alert">
                                <i class="fa fa-check-circle me-2"></i><%= successMessage %>
                            </div>
                            <% session.removeAttribute("successMessage"); %>
                        <% } %>
                    <% } %>
                    
                    <%-- Hiển thị thông báo lỗi nếu có --%>
                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert"><%= error %></div>
                    <% } %>
                    <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>

                    <%-- Form đăng nhập --%>
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
                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>
                </div>
            </div>
            
        </div>
        
        <%--
            Script kiểm tra dữ liệu form phía client, tự động điền email nếu vừa đăng ký thành công, popup xác thực thành công
        --%>
        <script>
            const loginForm = document.getElementById('loginForm');
            
            // Auto-fill email and password if coming from registration
            document.addEventListener('DOMContentLoaded', function() {
                const urlParams = new URLSearchParams(window.location.search);
                const success = urlParams.get('success');
                const verification = urlParams.get('verification');
                const email = urlParams.get('email');
                
                if (success === 'registration' && email) {
                    // Email đã được điền từ URL parameter
                    document.getElementById('email').value = email;
                    
                    // Hiển thị thông báo thành công
                    const successAlert = document.createElement('div');
                    successAlert.className = 'alert alert-success';
                    successAlert.innerHTML = '<i class="fa fa-check-circle me-2"></i>Registration successful! Please check your email to verify your account.';
                    
                    const form = document.getElementById('loginForm');
                    form.parentNode.insertBefore(successAlert, form);
                }
                
                // Hiển thị popup thành công khi verification thành công
                if (verification === 'success' && email) {
                    // Email đã được điền từ URL parameter
                    document.getElementById('email').value = email;
                    
                    // Hiển thị popup thành công
                    const successModal = new bootstrap.Modal(document.getElementById('successModal'));
                    successModal.show();
                }
            });
            
            // Kiểm tra dữ liệu form trước khi submit
            if (loginForm) {
                loginForm.addEventListener('submit', function (event) {
                    const email = document.getElementById('email').value;
                    const password = document.getElementById('password').value;
                    const errorDiv = document.getElementById('clientError');
                    let errors = [];

                    if (email.trim() === '') {
                        errors.push("Email is required.");
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
