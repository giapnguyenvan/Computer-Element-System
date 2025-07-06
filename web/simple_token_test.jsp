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
    <title>Simple Token Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-search me-2"></i>Simple Token API Debug
                        </h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Generate a test token
                            String testToken = JwtUtil.generateAccessToken(456, "debug@test.com", "staff", "user");
                            
                            out.println("<div class='alert alert-info'>");
                            out.println("<h6>Generated Test Token:</h6>");
                            out.println("<p>" + testToken.substring(0, 50) + "...</p>");
                            out.println("</div>");
                            
                            // Test local validation
                            try {
                                Map<String, Object> userInfo = JwtUtil.validateToken(testToken);
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6>Local Token Validation:</h6>");
                                out.println("<p>User ID: " + userInfo.get("userId") + "</p>");
                                out.println("<p>Email: " + userInfo.get("email") + "</p>");
                                out.println("<p>Role: " + userInfo.get("role") + "</p>");
                                out.println("<p>User Type: " + userInfo.get("userType") + "</p>");
                                out.println("</div>");
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>");
                                out.println("<h6>Local Validation Failed:</h6>");
                                out.println("<p>" + e.getMessage() + "</p>");
                                out.println("</div>");
                            }
                        %>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>API Test</h5>
                                <button class="btn btn-primary" onclick="testAPI()">
                                    <i class="fas fa-play me-2"></i>Test API với Generated Token
                                </button>
                                
                                <div id="apiResult" class="mt-3"></div>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>Debug Information</h5>
                                <div class="alert alert-secondary">
                                    <h6>Token được sử dụng:</h6>
                                    <p><code><%= testToken %></code></p>
                                    
                                    <h6>API Endpoint:</h6>
                                    <p><code>${pageContext.request.contextPath}/api/auth/check-token</code></p>
                                    
                                    <h6>Headers:</h6>
                                    <p><code>Content-Type: application/json</code></p>
                                    <p><code>Authorization: Bearer [token]</code></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testAPI() {
            const resultDiv = document.getElementById('apiResult');
            const testToken = '<%= testToken %>';
            
            resultDiv.innerHTML = '<div class="alert alert-info">Testing API...</div>';
            
            console.log('Using token:', testToken);
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + testToken
                }
            })
            .then(response => {
                console.log('Response status:', response.status);
                console.log('Response ok:', response.ok);
                console.log('Response headers:', response.headers);
                
                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
                
                return response.json();
            })
            .then(data => {
                console.log('Response data:', data);
                console.log('Data type:', typeof data);
                console.log('Data keys:', Object.keys(data));
                
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>API Test Successful</h6>
                        <p><strong>Success:</strong> ${data.success}</p>
                        <p><strong>Valid:</strong> ${data.valid}</p>
                        <p><strong>User ID:</strong> ${data.userId || 'NULL/UNDEFINED'}</p>
                        <p><strong>Email:</strong> ${data.email || 'NULL/UNDEFINED'}</p>
                        <p><strong>Role:</strong> ${data.role || 'NULL/UNDEFINED'}</p>
                        <p><strong>User Type:</strong> ${data.userType || 'NULL/UNDEFINED'}</p>
                        <p><strong>Raw Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('API Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>API Test Failed</h6>
                        <p><strong>Error:</strong> ${error.message}</p>
                        <p>Check browser console for more details</p>
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 