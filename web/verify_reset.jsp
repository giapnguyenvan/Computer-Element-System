<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password Verification</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
            margin-top: 100px;
        }
        .card {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            padding: 30px;
        }
        .card-header {
            background-color: #6c5ce7;
            color: white;
            text-align: center;
            font-size: 1.5rem;
            padding: 10px 0;
            border-radius: 8px 8px 0 0;
        }
        .form-control {
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .btn-primary {
            background-color: #6c5ce7;
            border: none;
            padding: 10px 20px;
            width: 100%;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #5a4bcf;
        }
        .alert {
            margin-top: 20px;
            padding: 15px;
            font-size: 1rem;
            border-radius: 8px;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h4>Reset Your Password</h4>
        </div>
        <div class="card-body">
            <form action="forget-password" method="post">
                <input type="hidden" name="action" value="verify" />
                <div class="mb-3">
                    <input type="text" class="form-control" name="code" maxlength="6" pattern="\d{6}" required placeholder="Verification code" />
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="newPassword" minlength="8" required placeholder="New password (min 8 characters)" />
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="confirmPassword" minlength="8" required placeholder="Confirm new password" />
                </div>
                <button type="submit" class="btn btn-primary">Reset Password</button>
            </form>
            <!-- Display error message if exists -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
            <!-- Display success message if exists -->
            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3">${message}</div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 