<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<%
    // Check if user is logged in and is a shipper
    User user = (User) session.getAttribute("userAuth");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    // Check if user is shipper (không phân biệt hoa thường)
    if (!"shipper".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/homepageservlet");
        return;
    }
    // Token management - check if we have a valid token in session
    String accessToken = (String) session.getAttribute("accessToken");
    String refreshToken = (String) session.getAttribute("refreshToken");
    boolean validToken = false;
    if (accessToken != null) {
        try {
            Map<String, Object> tokenInfo = JwtUtil.validateToken(accessToken);
            String tokenRole = (String) tokenInfo.get("role");
            if ("shipper".equalsIgnoreCase(tokenRole)) {
                validToken = true;
            }
        } catch (Exception e) {
            // Token is invalid or expired, try to refresh
            if (refreshToken != null) {
                try {
                    String newAccessToken = JwtUtil.refreshAccessToken(refreshToken);
                    session.setAttribute("accessToken", newAccessToken);
                    validToken = true;
                } catch (Exception refreshException) {
                    // Both tokens are invalid, redirect to login
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
            } else {
                // No refresh token, redirect to login
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }
    } else {
        // No token in session, redirect to login
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipper Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
            padding-top: 20px;
        }
        .sidebar .logo-container {
            padding: 15px 20px;
        }
        .sidebar .logo-container h3 {
            margin: 0;
        }
        .shipper-profile {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 15px;
        }
        .shipper-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .shipper-profile .shipper-info {
            color: #fff;
        }
        .shipper-profile .shipper-info h6 {
            margin: 0;
            font-weight: 600;
        }
        .shipper-profile .shipper-info small {
            color: rgba(255,255,255,0.7);
        }
        .sidebar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .sidebar a.active {
            background-color: #495057;
        }
        .main-content {
            padding: 20px;
            flex: 1;
        }
        .card {
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .stat-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        #mainFrame {
            width: 100%;
            height: 100vh;
            border: none;
        }
        .container-fluid {
            padding-left: 0;
            padding-right: 0;
        }
        .row {
            margin-left: 0;
            margin-right: 0;
        }
        .shipper-header {
            background: linear-gradient(135deg, #007bff 0%, #00c6ff 100%);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        .token-status {
            position: fixed;
            top: 10px;
            right: 10px;
            background: rgba(0, 123, 255, 0.9);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <!-- Token Status Indicator -->
    <div class="token-status">
        <i class="fas fa-shield-alt me-1"></i>Token Valid
    </div>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    <div class="container-fluid">
        <div class="row">
            <!-- Shipper Sidebar -->
            <jsp:include page="shipperSidebar.jsp" />
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <div class="shipper-header">
                    <h2>Chào mừng, Shipper!</h2>
                    <p>Quản lý các đơn hàng giao hàng của bạn tại đây.</p>
                </div>
                <iframe id="mainFrame" name="mainFrame" src="${pageContext.request.contextPath}/shipperHome.jsp"></iframe>
            </div>
        </div>
    </div>
</body>
</html> 