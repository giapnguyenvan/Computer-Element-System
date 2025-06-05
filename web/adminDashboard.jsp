<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    // Check if user is logged in and is an admin
    User user = (User) session.getAttribute("userAuth");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Check if user is admin
    if (!"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/homepageservlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
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
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="sidebar.jsp" />
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <h2 class="mb-4">Dashboard Overview</h2>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase mb-0">Total Products</h6>
                                        <h2 class="mb-0">${totalProducts}</h2>
                                    </div>
                                    <i class="fas fa-box fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase mb-0">Total Customers</h6>
                                        <h2 class="mb-0">${totalCustomers}</h2>
                                    </div>
                                    <i class="fas fa-users fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase mb-0">Total Orders</h6>
                                        <h2 class="mb-0">${totalOrders}</h2>
                                    </div>
                                    <i class="fas fa-shopping-cart fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase mb-0">Total Revenue</h6>
                                        <h2 class="mb-0">$${totalRevenue}</h2>
                                    </div>
                                    <i class="fas fa-dollar-sign fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=addProduct.jsp&title=Add New Product" class="btn btn-primary w-100">
                                            <i class="fas fa-plus me-2"></i> Add New Product
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=categoryContent.jsp&title=Manage Categories" class="btn btn-success w-100">
                                            <i class="fas fa-folder-plus me-2"></i> Manage Categories
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=customerContent.jsp&title=Customer Management" class="btn btn-info w-100">
                                            <i class="fas fa-user-plus me-2"></i> View Customers
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=blogContent.jsp&title=Blog Management" class="btn btn-warning w-100">
                                            <i class="fas fa-edit me-2"></i> Manage Blogs
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Recent Activities</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Activity</th>
                                                <th>User</th>
                                                <th>Time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentActivities}" var="activity">
                                                <tr>
                                                    <td>${activity.description}</td>
                                                    <td>${activity.user}</td>
                                                    <td>${activity.time}</td>
                                                    <td>
                                                        <span class="badge bg-${activity.status == 'Completed' ? 'success' : 'warning'}">
                                                            ${activity.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 