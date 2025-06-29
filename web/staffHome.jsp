<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("userAuth");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            border: none;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .action-btn {
            display: block;
            width: 100%;
            padding: 1rem;
            margin-bottom: 1rem;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            color: white;
        }
        
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .activity-item {
            padding: 0.75rem 0;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }
    </style>
</head>
<body style="background-color: #f8f9fa;">
    <div class="container-fluid p-4">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">Chào mừng, ${user.fullname}!</h1>
                    <p class="mb-0">Đây là bảng điều khiển quản lý dành cho Staff. Bạn có thể quản lý sản phẩm, blog và phản hồi từ đây.</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-user-tie" style="font-size: 4rem; opacity: 0.8;"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Statistics Cards -->
            <div class="col-lg-8">
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon text-primary">
                                <i class="fas fa-box"></i>
                            </div>
                            <div class="stat-number text-primary">150</div>
                            <div class="stat-label">Tổng sản phẩm</div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon text-success">
                                <i class="fas fa-blog"></i>
                            </div>
                            <div class="stat-number text-success">25</div>
                            <div class="stat-label">Blog đã đăng</div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon text-warning">
                                <i class="fas fa-comments"></i>
                            </div>
                            <div class="stat-number text-warning">89</div>
                            <div class="stat-label">Phản hồi mới</div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="recent-activity">
                    <h5 class="mb-3">
                        <i class="fas fa-clock me-2"></i>Hoạt động gần đây
                    </h5>
                    <div class="activity-item d-flex align-items-center">
                        <div class="activity-icon bg-primary text-white">
                            <i class="fas fa-plus"></i>
                        </div>
                        <div>
                            <div class="fw-bold">Thêm sản phẩm mới</div>
                            <small class="text-muted">AMD Ryzen 7 9800X3D - 2 giờ trước</small>
                        </div>
                    </div>
                    <div class="activity-item d-flex align-items-center">
                        <div class="activity-icon bg-success text-white">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div>
                            <div class="fw-bold">Cập nhật blog</div>
                            <small class="text-muted">"Hướng dẫn build PC gaming" - 4 giờ trước</small>
                        </div>
                    </div>
                    <div class="activity-item d-flex align-items-center">
                        <div class="activity-icon bg-warning text-white">
                            <i class="fas fa-reply"></i>
                        </div>
                        <div>
                            <div class="fw-bold">Phản hồi khách hàng</div>
                            <small class="text-muted">5 phản hồi mới - 6 giờ trước</small>
                        </div>
                    </div>
                    <div class="activity-item d-flex align-items-center">
                        <div class="activity-icon bg-info text-white">
                            <i class="fas fa-box"></i>
                        </div>
                        <div>
                            <div class="fw-bold">Cập nhật kho</div>
                            <small class="text-muted">NVIDIA RTX 5090 - 8 giờ trước</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="col-lg-4">
                <div class="quick-actions">
                    <h5 class="mb-3">
                        <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                    </h5>
                    <a href="${pageContext.request.contextPath}/productservlet" class="action-btn">
                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
                    </a>
                    <a href="${pageContext.request.contextPath}/manageblogs" class="action-btn">
                        <i class="fas fa-edit me-2"></i>Quản lý blog
                    </a>
                    <a href="${pageContext.request.contextPath}/managefeedback" class="action-btn">
                        <i class="fas fa-comments me-2"></i>Xem phản hồi
                    </a>
                    <a href="${pageContext.request.contextPath}/productservlet" class="action-btn">
                        <i class="fas fa-boxes me-2"></i>Kiểm tra kho
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 