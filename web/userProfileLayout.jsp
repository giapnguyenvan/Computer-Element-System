<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("customerAuth");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .admin-profile {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 15px;
        }

        .admin-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .admin-profile .admin-info {
            color: #fff;
        }

        .admin-profile .admin-info h6 {
            margin: 0;
            font-weight: 600;
        }

        .admin-profile .admin-info small {
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

        .content-wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="content-wrapper">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <jsp:include page="userProfileSideBar.jsp" />
                
                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 main-content">
                    <jsp:include page="${content}" />
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS -->
    <!-- Already loaded in header.jsp -->
</body>
</html>