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
    <title>Staff Test Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-user-tie me-2"></i>Staff System Test
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
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>User</th>
                                            <td>
                                                <% if (user != null) { %>
                                                    <%= user.getFullname() %> (<%= user.getRole() %>)
                                                <% } else { %>
                                                    <span class="text-danger">Not logged in</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Access Token</th>
                                            <td>
                                                <% if (accessToken != null) { %>
                                                    <span class="text-success">Present</span>
                                                <% } else { %>
                                                    <span class="text-danger">Missing</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Refresh Token</th>
                                            <td>
                                                <% if (refreshToken != null) { %>
                                                    <span class="text-success">Present</span>
                                                <% } else { %>
                                                    <span class="text-danger">Missing</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
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
                                <h5>Navigation</h5>
                                <div class="d-grid gap-2 d-md-flex">
                                    <a href="${pageContext.request.contextPath}/staffDashboard.jsp" class="btn btn-success">
                                        <i class="fas fa-tachometer-alt me-2"></i>Staff Dashboard
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
                                <h5>Test Results</h5>
                                <div id="testResults">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>Click the buttons below to test functionality
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex">
                                    <button class="btn btn-info" onclick="testTokenAPI()">
                                        <i class="fas fa-shield-alt me-2"></i>Test Token API
                                    </button>
                                    <button class="btn btn-warning" onclick="testRefreshToken()">
                                        <i class="fas fa-sync-alt me-2"></i>Test Refresh Token
                                    </button>
                                    <button class="btn btn-dark" onclick="testStaffAccess()">
                                        <i class="fas fa-user-check me-2"></i>Test Staff Access
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testTokenAPI() {
            const token = '<%= accessToken %>';
            const resultDiv = document.getElementById('testResults');
            
            if (!token) {
                resultDiv.innerHTML = '<div class="alert alert-warning">No token available for testing</div>';
                return;
            }
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(response => {
                console.log('API Response Status:', response.status);
                console.log('API Response Headers:', response.headers);
                return response.json();
            })
            .then(data => {
                console.log('API Response Data:', data);
                console.log('User ID:', data.userId);
                console.log('Email:', data.email);
                console.log('Role:', data.role);
                console.log('User Type:', data.userType);
                if (data.success) {
                    resultDiv.innerHTML = `
                        <div class="alert alert-success">
                            <h6><i class="fas fa-check-circle me-2"></i>Token API Test Successful</h6>
                            <ul class="mb-0">
                                <li><strong>User ID:</strong> ${data.userId || 'N/A'}</li>
                                <li><strong>Email:</strong> ${data.email || 'N/A'}</li>
                                <li><strong>Role:</strong> ${data.role || 'N/A'}</li>
                                <li><strong>User Type:</strong> ${data.userType || 'N/A'}</li>
                            </ul>
                            <p class="mt-2"><strong>Raw Response:</strong></p>
                            <pre class="bg-light p-2 rounded small">${JSON.stringify(data, null, 2)}</pre>
                        </div>
                    `;
                } else {
                    resultDiv.innerHTML = `
                        <div class="alert alert-danger">
                            <h6><i class="fas fa-exclamation-triangle me-2"></i>Token API Test Failed</h6>
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
        
        function testRefreshToken() {
            const refreshToken = '<%= refreshToken %>';
            const resultDiv = document.getElementById('testResults');
            
            if (!refreshToken) {
                resultDiv.innerHTML = '<div class="alert alert-warning">No refresh token available</div>';
                return;
            }
            
            const formData = new URLSearchParams();
            formData.append('refreshToken', refreshToken);
            
            fetch('${pageContext.request.contextPath}/api/auth/refresh', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultDiv.innerHTML = `
                        <div class="alert alert-success">
                            <h6><i class="fas fa-check-circle me-2"></i>Refresh Token Test Successful</h6>
                            <p class="mb-0">New access token generated successfully</p>
                        </div>
                    `;
                } else {
                    resultDiv.innerHTML = `
                        <div class="alert alert-danger">
                            <h6><i class="fas fa-exclamation-triangle me-2"></i>Refresh Token Test Failed</h6>
                            <p class="mb-0">${data.error}</p>
                        </div>
                    `;
                }
            })
            .catch(error => {
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Refresh Error</h6>
                        <p class="mb-0">${error.message}</p>
                    </div>
                `;
            });
        }
        
        function testStaffAccess() {
            const userRole = '<%= user != null ? user.getRole() : "" %>';
            const resultDiv = document.getElementById('testResults');
            
            if (userRole.toLowerCase() === 'staff') {
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>Staff Access Test Successful</h6>
                        <p class="mb-0">User has staff role and can access staff dashboard</p>
                    </div>
                `;
            } else {
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Staff Access Test Failed</h6>
                        <p class="mb-0">User role is "${userRole}" but staff role is required</p>
                    </div>
                `;
            }
        }
    </script>
</body>
</html> 