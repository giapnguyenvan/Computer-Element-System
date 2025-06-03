<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            background: #343a40;
            color: white;
        }
        .nav-link {
            color: rgba(255,255,255,.8);
        }
        .nav-link:hover {
            color: white;
        }
        .card {
            transition: transform .2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .stats-card {
            border-left: 4px solid;
        }
        .main-content {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 px-0 position-fixed sidebar">
            <div class="p-3">
                <h3 class="text-center">Admin Panel</h3>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#dashboard">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="categoryList.jsp">
                            <i class="fas fa-list me-2"></i>Categories
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#users">
                            <i class="fas fa-users me-2"></i>Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#orders">
                            <i class="fas fa-shopping-cart me-2"></i>Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#settings">
                            <i class="fas fa-cog me-2"></i>Settings
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">
                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 ms-sm-auto main-content">
            <div class="px-4 py-5">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Dashboard Overview</h1>
                    <div class="btn-group">
                        <button class="btn btn-primary">
                            <i class="fas fa-download me-2"></i>Download Report
                        </button>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-5">
                    <div class="col-md-6 col-xl-3">
                        <div class="card stats-card border-primary">
                            <div class="card-body">
                                <h5 class="card-title text-primary">Total Users</h5>
                                <h2 class="mb-0">1,250</h2>
                                <small class="text-success">
                                    <i class="fas fa-arrow-up"></i> 12% increase
                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="card stats-card border-success">
                            <div class="card-body">
                                <h5 class="card-title text-success">Revenue</h5>
                                <h2 class="mb-0">$24,500</h2>
                                <small class="text-success">
                                    <i class="fas fa-arrow-up"></i> 8% increase
                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="card stats-card border-info">
                            <div class="card-body">
                                <h5 class="card-title text-info">Orders</h5>
                                <h2 class="mb-0">450</h2>
                                <small class="text-success">
                                    <i class="fas fa-arrow-up"></i> 5% increase
                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="card stats-card border-warning">
                            <div class="card-body">
                                <h5 class="card-title text-warning">Categories</h5>
                                <h2 class="mb-0">25</h2>
                                <small class="text-success">
                                    <i class="fas fa-arrow-up"></i> 3% increase
                                </small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities & Quick Actions -->
                <div class="row">
                    <!-- Recent Activities -->
                    <div class="col-md-8 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Recent Activities</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1">New user registered</h6>
                                            <small>3 minutes ago</small>
                                        </div>
                                        <p class="mb-1">John Doe created a new account.</p>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1">New order received</h6>
                                            <small>1 hour ago</small>
                                        </div>
                                        <p class="mb-1">Order #12345 needs processing.</p>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1">Category updated</h6>
                                            <small>2 hours ago</small>
                                        </div>
                                        <p class="mb-1">Electronics category was modified.</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="categoryForm.jsp" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Add New Category
                                    </a>
                                    <button class="btn btn-success">
                                        <i class="fas fa-user-plus me-2"></i>Add New User
                                    </button>
                                    <button class="btn btn-info text-white">
                                        <i class="fas fa-cog me-2"></i>System Settings
                                    </button>
                                    <button class="btn btn-warning">
                                        <i class="fas fa-file-export me-2"></i>Export Data
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</body>
</html> 