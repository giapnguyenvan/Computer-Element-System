<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body, .register-form-box, .register-form-box * {
            font-family: 'Times New Roman', Times, serif !important;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: none;
        }
        .register-main-row {
            min-height: 100vh;
            display: flex;
        }
        .register-left {
            position: relative;
            background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
            color: #fff;
            flex: 1;
            display: flex;
            align-items: stretch;
            min-width: 400px;
            overflow: hidden;
        }
        .register-left::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(93,46,188,0.85);
            z-index: 1;
        }
        .register-left > * {
            position: relative;
            z-index: 2;
        }
        .register-left-content {
            text-align: center;
            color: #fff;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            padding: 10px;
            margin: auto;
        }
        .register-left-content .navbar-brand {
            color: white;
            display: flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
            margin-bottom: 30px;
            font-size: 2rem;
            text-decoration: none;
        }
        .register-left-content .navbar-brand img {
            height: 38px;
            width: auto;
            display: inline-block;
            vertical-align: middle;
        }
        .register-left-content .fw-bold {
            font-size: 2rem;
            text-decoration: underline;
        }
        .register-left-content h1 {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 0.7rem;
        }
        .register-left-content p {
            font-size: 1rem;
            margin-bottom: 0.7rem;
            text-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
        }
        .register-left-content a.btn {
            font-size: 1.25rem;
            color: white;
        }
        .register-right {
            flex: 1.2;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f4f6fb;
            min-height: 100vh;
        }
        .register-form-box {
            max-width: 400px;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(44, 62, 80, 0.12);
            padding: 24px 18px 18px 18px;
            margin: 12px 0;
            display: flex;
            flex-direction: column;
            align-items: stretch;
            transition: box-shadow 0.2s;
        }
        .register-form-box:hover {
            box-shadow: 0 12px 40px rgba(44, 62, 80, 0.18);
        }
        .register-form-box h2 {
            font-family: 'Times New Roman', Times, serif;
            font-size: 1.5rem;
            font-weight: 800;
            margin-bottom: 8px;
            text-align: center;
            color: #222;
            letter-spacing: -1px;
        }
        .register-form-box p {
            margin-bottom: 28px;
            text-align: center;
            color: #666;
        }
        .register-form-box .form-label {
            display: block;
            margin-bottom: 3px;
            font-weight: 600;
            color: #333;
            font-size: 1rem;
        }
        .register-form-box .form-control {
            width: 100%;
            box-sizing: border-box;
            border-radius: 10px;
            min-height: 36px;
            font-size: 0.98rem;
            border: 1.5px solid #e0e3ea;
            margin-bottom: 10px;
            padding: 7px 10px;
            background: #fff;
            transition: border-color 0.2s;
        }
        .register-form-box .form-control:focus {
            border-color: #705FBC;
            box-shadow: 0 0 0 2px rgba(112,95,188,0.08);
        }
        .register-form-box .btn-register {
            width: 100%;
            min-height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
            margin: 12px 0 8px 0;
            border-radius: 8px;
            background: #0D6CF8;
            border: none;
            color: #fff;
            box-shadow: none;
            padding: 0;
            transition: background 0.2s, color 0.2s;
        }
        .register-form-box .btn-register:hover {
            background: #0b5ad3;
            color: #fff;
        }
        .register-form-box .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .register-form-box .login-link {
            text-align: center;
            margin-top: 8px;
            font-size: 0.98rem;
        }
        .register-form-box .login-link a {
            color: #333;
            text-decoration: none;
        }
        .register-form-box .login-link a:hover {
            text-decoration: underline;
        }
        .register-form-box form {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }
        .register-form-box .form-col {
            flex: 1 1 45%;
            min-width: 0;
            display: flex;
            flex-direction: column;
        }
        .register-form-box .form-col-full {
            flex: 1 1 100%;
        }
        @media (max-width: 700px) {
            .register-form-box form {
                flex-direction: column;
                gap: 0;
            }
            .register-form-box .form-col, .register-form-box .form-col-full {
                flex: 1 1 100%;
            }
        }
        @media (max-width: 900px) {
            .register-main-row {
                flex-direction: column;
            }
            .register-left, .register-right {
                min-width: 100vw;
            }
        }
    </style>
</head>
<body>
   
    <div class="register-main-row">
        <div class="register-left">
            <div class="register-left-content">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet">
                    
                    <span class="fw-bold">CES</span>
                </a>
                <h1>Welcome to CES</h1>
                <p>
                    Join us to build your dream PC and enjoy exclusive member benefits.<br>
                    Sign up now and start your journey!
                </p>
                <a href="PCBuilderServlet" class="btn btn-primary btn-lg" style="color: white">Build PC</a>
            </div>
        </div>
        <div class="register-right">
            <div class="register-form-box">
                <h2>Sign Up</h2>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="error"><%= error %></div>
                <% } %>
                <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>
                <form action="register" method="post" id="registerForm">
                    <div class="form-col">
                        <label class="form-label" for="fullname">Full Name:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" required
                               value="${param.fullname != null ? param.fullname : (not empty fullname ? fullname : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               value="${param.email != null ? param.email : (not empty email ? email : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required
                               value="${param.username != null ? param.username : (not empty username ? username : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="phone">Phone Number:</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required
                               value="${param.phone != null ? param.phone : (not empty phone ? phone : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="confirmPassword">Confirm Password:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div class="form-col-full">
                        <label class="form-label" for="address">Address:</label>
                        <input type="text" class="form-control" id="address" name="address" required
                               value="${param.address != null ? param.address : (not empty address ? address : '')}">
                    </div>
                    <button type="submit" class="btn-register">Sign Up</button>
                </form>
                <div class="login-link">
                    <p>Already have an account? <a href="login.jsp">Login now</a></p>
                </div>
            </div>
        </div>
    </div>
    <script>
        function validateEmail(email) {
            const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return re.test(email);
        }

        function validatePassword(password) {
            const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            return re.test(password);
        }

        const registerForm = document.getElementById('registerForm');
        if (registerForm) {
            registerForm.addEventListener('submit', function (event) {
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const errorDiv = document.getElementById('clientError');
                let errors = [];

                if (!validateEmail(email)) {
                    errors.push("Email không hợp lệ. Vui lòng nhập lại.");
                }

                if (!validatePassword(password)) {
                    errors.push("Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
                }

                if (password !== confirmPassword) {
                    errors.push("Mật khẩu xác nhận không khớp.");
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