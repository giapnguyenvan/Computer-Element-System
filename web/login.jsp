<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #705FBC;
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 300px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .login-container label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        .form-field {
            position: relative;
            margin-bottom: 20px;
        }
        .login-container input[type="email"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            box-sizing: border-box;
            outline: none;
            background-color: #fff;
        }
        .login-container input[type="email"]:focus,
        .login-container input[type="password"]:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }
        .login-container input[type="email"]::placeholder,
        .login-container input[type="password"]::placeholder {
            color: #aaa;
            font-size: 13px;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #0D6CF8;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .login-container input[type="submit"]:hover {
            background-color: #0b5ad3;
        }
        .remember-me {
            margin: 15px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .remember-me input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }
        .remember-me label {
            margin: 0;
            font-size: 14px;
            color: #666;
            cursor: pointer;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .forgot-link {
            text-align: center;
            margin-top: 15px;
        }
        .forgot-link a {
            color: #333;
            text-decoration: none;
        }
        .forgot-link a:hover {
            text-decoration: underline;
        }
        .register-link {
            text-align: center;
            margin-top: 10px;
        }
        .register-link a {
            color: #0D6CF8;
            text-decoration: none;
            font-weight: bold;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="login" method="post">
            <div class="form-field">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" required 
                       placeholder="Nhập địa chỉ email của bạn"
                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                       title="Vui lòng nhập một địa chỉ email hợp lệ">
            </div>

            <div class="form-field">
                <label for="password">Mật khẩu:</label>
                <input type="password" name="password" id="password" required
                       placeholder="Nhập mật khẩu của bạn">
            </div>
            
            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember" value="ON">
                <label for="remember">Ghi nhớ đăng nhập</label>
            </div>
            
            <input type="submit" value="Đăng nhập">
        </form>

        <div class="forgot-link">
            <a href="forget_password.jsp">Quên mật khẩu?</a>
        </div>
        <div class="register-link">
            <a href="Register.jsp">Chưa có tài khoản? Đăng ký ngay!</a>
        </div>
    </div>
</body>
</html>
