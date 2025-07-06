<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
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
    
    // Token management - check if we have a valid token in session
    String accessToken = (String) session.getAttribute("accessToken");
    String refreshToken = (String) session.getAttribute("refreshToken");
    
    boolean validToken = false;
    if (accessToken != null) {
        try {
            Map<String, Object> tokenInfo = JwtUtil.validateToken(accessToken);
            String tokenRole = (String) tokenInfo.get("role");
            if ("staff".equalsIgnoreCase(tokenRole)) {
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
            background-color: #343a40;
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
        
        /* Staff-specific styling */
        .staff-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        
        .token-status {
            position: fixed;
            top: 10px;
            right: 10px;
            background: rgba(40, 167, 69, 0.9);
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
            <!-- Staff Sidebar -->
            <jsp:include page="staffSidebar.jsp" />
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Staff Header -->
                <div class="staff-header">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="mb-1">
                                <i class="fas fa-user-tie me-2"></i>Staff Dashboard
                            </h4>
                            <p class="mb-0">Welcome back, ${user.fullname}! Manage products, blogs, and customer feedback.</p>
                        </div>
                        <div class="col-md-4 text-end">
                            <small>Last login: <%= new java.util.Date() %></small>
                        </div>
                    </div>
                </div>
                
                <iframe id="mainFrame" name="mainFrame" src="${pageContext.request.contextPath}/staffHome.jsp"></iframe>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <!-- Đã được load trong header.jsp -->
    
    <!-- Token Management Script -->
    <script>
        // Token refresh functionality
        function checkTokenExpiry() {
            const token = '<%= accessToken %>';
            if (token) {
                // Check if token is about to expire (within 5 minutes)
                fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + token
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        // Token is expired or invalid, redirect to login
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }
                })
                .catch(error => {
                    console.error('Token check failed:', error);
                });
            }
        }
        
        // Check token every 5 minutes
        setInterval(checkTokenExpiry, 5 * 60 * 1000);
        
        // Initial check
        checkTokenExpiry();
        
        // Update token status indicator
        function updateTokenStatus(isValid) {
            const statusElement = document.querySelector('.token-status');
            if (isValid) {
                statusElement.innerHTML = '<i class="fas fa-shield-alt me-1"></i>Token Valid';
                statusElement.style.background = 'rgba(40, 167, 69, 0.9)';
            } else {
                statusElement.innerHTML = '<i class="fas fa-exclamation-triangle me-1"></i>Token Invalid';
                statusElement.style.background = 'rgba(220, 53, 69, 0.9)';
            }
        }
    </script>
</body>
</html> 