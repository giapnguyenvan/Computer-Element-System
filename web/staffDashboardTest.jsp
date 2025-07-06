<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-user-tie me-2"></i>Staff Dashboard Test
                        </h4>
                    </div>
                    <div class="card-body">
                        <%
                            User user = (User) session.getAttribute("userAuth");
                            String accessToken = (String) session.getAttribute("accessToken");
                            String refreshToken = (String) session.getAttribute("refreshToken");
                        %>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Session Information</h5>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">
                                        <strong>User:</strong> 
                                        <% if (user != null) { %>
                                            <%= user.getFullname() %> (<%= user.getRole() %>)
                                        <% } else { %>
                                            <span class="text-danger">Not logged in</span>
                                        <% } %>
                                    </li>
                                    <li class="list-group-item">
                                        <strong>Access Token:</strong> 
                                        <% if (accessToken != null) { %>
                                            <span class="text-success">Present</span>
                                        <% } else { %>
                                            <span class="text-danger">Missing</span>
                                        <% } %>
                                    </li>
                                    <li class="list-group-item">
                                        <strong>Refresh Token:</strong> 
                                        <% if (refreshToken != null) { %>
                                            <span class="text-success">Present</span>
                                        <% } else { %>
                                            <span class="text-danger">Missing</span>
                                        <% } %>
                                    </li>
                                </ul>
                            </div>
                            
                            <div class="col-md-6">
                                <h5>Token Validation</h5>
                                <%
                                    if (accessToken != null) {
                                        try {
                                            Map<String, Object> tokenInfo = JwtUtil.validateToken(accessToken);
                                            String tokenRole = (String) tokenInfo.get("role");
                                            String tokenType = (String) tokenInfo.get("tokenType");
                                %>
                                    <div class="alert alert-success">
                                        <h6><i class="fas fa-check-circle me-2"></i>Token Valid</h6>
                                        <ul class="mb-0">
                                            <li><strong>Role:</strong> <%= tokenRole %></li>
                                            <li><strong>Type:</strong> <%= tokenType %></li>
                                            <li><strong>User ID:</strong> <%= tokenInfo.get("userId") %></li>
                                            <li><strong>Email:</strong> <%= tokenInfo.get("email") %></li>
                                        </ul>
                                    </div>
                                <%
                                        } catch (Exception e) {
                                %>
                                    <div class="alert alert-danger">
                                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Token Invalid</h6>
                                        <p class="mb-0"><%= e.getMessage() %></p>
                                    </div>
                                <%
                                        }
                                    } else {
                                %>
                                    <div class="alert alert-warning">
                                        <h6><i class="fas fa-exclamation-triangle me-2"></i>No Token</h6>
                                        <p class="mb-0">No access token found in session.</p>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>Actions</h5>
                                <div class="d-grid gap-2 d-md-flex">
                                    <a href="${pageContext.request.contextPath}/staffDashboard.jsp" class="btn btn-success">
                                        <i class="fas fa-tachometer-alt me-2"></i>Go to Staff Dashboard
                                    </a>
                                    <a href="${pageContext.request.contextPath}/staffHome.jsp" class="btn btn-primary">
                                        <i class="fas fa-home me-2"></i>Staff Home
                                    </a>
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                                        <i class="fas fa-sign-in-alt me-2"></i>Login
                                    </a>
                                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>Token Management Test</h5>
                                <button class="btn btn-info" onclick="checkToken()">
                                    <i class="fas fa-shield-alt me-2"></i>Check Token API
                                </button>
                                <div id="tokenResult" class="mt-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function checkToken() {
            const token = '<%= accessToken %>';
            const resultDiv = document.getElementById('tokenResult');
            
            if (!token) {
                resultDiv.innerHTML = '<div class="alert alert-warning">No token available</div>';
                return;
            }
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultDiv.innerHTML = `
                        <div class="alert alert-success">
                            <h6><i class="fas fa-check-circle me-2"></i>Token API Check Successful</h6>
                            <ul class="mb-0">
                                <li><strong>User ID:</strong> ${data.userId}</li>
                                <li><strong>Email:</strong> ${data.email}</li>
                                <li><strong>Role:</strong> ${data.role}</li>
                                <li><strong>User Type:</strong> ${data.userType}</li>
                            </ul>
                        </div>
                    `;
                } else {
                    resultDiv.innerHTML = `
                        <div class="alert alert-danger">
                            <h6><i class="fas fa-exclamation-triangle me-2"></i>Token API Check Failed</h6>
                            <p class="mb-0">${data.error}</p>
                        </div>
                    `;
                }
            })
            .catch(error => {
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>API Error</h6>
                        <p class="mb-0">${error.message}</p>
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 