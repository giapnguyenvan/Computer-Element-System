<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f0f2f5;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #1a73e8;
                text-align: center;
                margin-bottom: 20px;
            }
            .welcome-text {
                text-align: center;
                font-size: 18px;
                color: #333;
                line-height: 1.6;
            }
            .logout-button {
                display: block;
                width: 200px;
                margin: 30px auto 0;
                padding: 10px 20px;
                background-color: #dc3545;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 8px;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .logout-button:hover {
                background-color: #c82333;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to Our Website! ${sessionScope.session_login} </h1>
            <div class="welcome-text">
                <p>Thank you for visiting our website. We're glad to have you here!</p>
                <p>This is your personalized welcome page.</p>
            </div>
            <a href="logout.jsp" class="logout-button">Đăng xuất</a>
        </div>
    </body>
</html> 