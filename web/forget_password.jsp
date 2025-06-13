<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quên mật khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .forget-password-bg {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
        }
        .forget-password-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 320px;
        }
        .forget-password-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group input:focus {
            outline: none;
            border-color: #74ebd5;
            box-shadow: 0 0 5px rgba(116, 235, 213, 0.3);
        }
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button[type="submit"]:hover { background-color: #388e3c; }
        .error { color: red; text-align: center; margin-top: 10px; }
        .success { color: green; text-align: center; margin-top: 10px; }
        .login-link { text-align: center; margin-top: 15px; }
        .login-link a { color: #333; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="forget-password-bg">
        <div class="forget-password-container">
            <h2>Quên mật khẩu</h2>
            
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success">${success}</div>
            </c:if>

            <form action="forget-password" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required
                           value="${param.username != null ? param.username : (not empty username ? username : '')}">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required
                           value="${param.email != null ? param.email : (not empty email ? email : '')}">
                </div>
                <button type="submit">Lấy lại mật khẩu</button>
            </form>

            <div class="login-link">
                <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>