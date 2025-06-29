<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    // Check if user is logged in and is a staff
    User user = (User) session.getAttribute("userAuth");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Check if user is staff (không phân biệt hoa thường)
    if (!"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/homepageservlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard - Management</title>
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
            background-color: #2c3e50;
            padding-top: 20px;
        }

        .sidebar .logo-container {
            padding: 15px 20px;
        }

        .sidebar .logo-container h3 {
            margin: 0;
        }

        .staff-profile {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 15px;
        }

        .staff-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .staff-profile .staff-info {
            color: #fff;
        }

        .staff-profile .staff-info h6 {
            margin: 0;
            font-weight: 600;
        }

        .staff-profile .staff-info small {
            color: rgba(255,255,255,0.7);
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        .sidebar a.active {
            background-color: #34495e;
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
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="staffSidebar.jsp" />
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <iframe id="mainFrame" name="mainFrame" src="${pageContext.request.contextPath}/staffHome.jsp"></iframe>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <!-- Đã được load trong header.jsp -->
</body>
</html> 