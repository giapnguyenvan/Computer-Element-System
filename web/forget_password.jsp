<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Forgot Password | Computer Element System</title>
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
            background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
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
            background: rgba(93,46,188,0.85);
            z-index: 1;
        }
        .login-left > * {
            position: relative;
            z-index: 2;
        }
        .login-left-content {
            text-align: center;
            color: #fff;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            padding: 20px;
            margin: auto;
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
    </style>
</head>
<body>
<div class="login-main-row">
    <div class="login-left">
        <div class="login-left-content">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet" style="color: white;">
                <i class="fas fa-microchip me-2"></i>
                <span class="fw-bold">CES</span>
            </a>
            <h1>Forgot Your Password?</h1>
            <p>
                Enter your username and email to reset your password.<br>
                We'll send you instructions to recover your account.
            </p>
            <a href="login.jsp" class="btn btn-primary btn-lg" style="color: white">Back to Login</a>
        </div>
    </div>
    <div class="login-right">
        <div class="login-form-box">
            <h2>Forgot Password</h2>
            <p>Enter your details to reset your password</p>
            <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">${success}</div>
            </c:if>
            <form action="forget-password" method="post" id="forgetPasswordForm">
                <div class="mb-3">
                    <label class="form-label" for="username">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required
                           value="${param.username != null ? param.username : (not empty username ? username : '')}">
                </div>
                <div class="mb-3">
                    <label class="form-label" for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required
                           value="${param.email != null ? param.email : (not empty email ? email : '')}">
                </div>
                <button type="submit" class="btn btn-warning">Reset Password</button>
            </form>
            <div class="login-link" style="text-align:center; margin-top:15px;">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>
</div>
<script>
    function validateEmail(email) {
        const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return re.test(email);
    }

    const forgetPasswordForm = document.getElementById('forgetPasswordForm');
    if (forgetPasswordForm) {
        forgetPasswordForm.addEventListener('submit', function (event) {
            const email = document.getElementById('email').value;
            const username = document.getElementById('username').value;
            const errorDiv = document.getElementById('clientError');
            let errors = [];

            if (username.trim() === '') {
                errors.push("Username is required.");
            }

            if (!validateEmail(email)) {
                errors.push("Invalid email format.");
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