<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng xuất</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #FFDEE9, #B5FFFC);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .message-box {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            text-align: center;
        }
        .message-box h2 {
            margin-bottom: 15px;
        }
        .message-box a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            margin-top: 10px;
        }
        .message-box a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h2>Đăng xuất thành công!</h2>
        <p>Hẹn gặp lại bạn lần sau.</p>
        <a href="login.jsp">Đăng nhập lại</a>
    </div>
</body>
</html>
