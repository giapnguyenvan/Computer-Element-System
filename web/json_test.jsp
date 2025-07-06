<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSON Handling Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-code me-2"></i>JSON Handling Test
                        </h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Test JWT token generation and JSON handling
                            try {
                                // Test 1: Generate tokens
                                String accessToken = JwtUtil.generateAccessToken(1, "test@example.com", "staff", "user");
                                String refreshToken = JwtUtil.generateRefreshToken(1, "test@example.com", "staff", "user");
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>Token Generation Test</h6>");
                                out.println("<p>Access Token: " + accessToken.substring(0, 50) + "...</p>");
                                out.println("<p>Refresh Token: " + refreshToken.substring(0, 50) + "...</p>");
                                out.println("</div>");
                                
                                // Test 2: Validate token and extract info
                                Map<String, Object> userInfo = JwtUtil.validateToken(accessToken);
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>Token Validation Test</h6>");
                                out.println("<p>User ID: " + userInfo.get("userId") + " (Type: " + userInfo.get("userId").getClass().getSimpleName() + ")</p>");
                                out.println("<p>Email: " + userInfo.get("email") + "</p>");
                                out.println("<p>Role: " + userInfo.get("role") + "</p>");
                                out.println("<p>User Type: " + userInfo.get("userType") + "</p>");
                                out.println("</div>");
                                
                                // Test 3: JSON Object creation with safe handling
                                Gson gson = new Gson();
                                JsonObject jsonResponse = new JsonObject();
                                jsonResponse.addProperty("success", true);
                                jsonResponse.addProperty("valid", true);
                                
                                // Safely handle userId (convert Number to int if needed)
                                Object userIdObj = userInfo.get("userId");
                                if (userIdObj != null) {
                                    if (userIdObj instanceof Number) {
                                        jsonResponse.addProperty("userId", ((Number) userIdObj).intValue());
                                    } else {
                                        jsonResponse.addProperty("userId", userIdObj.toString());
                                    }
                                } else {
                                    jsonResponse.addProperty("userId", 0);
                                }
                                
                                // Safely handle other fields
                                Object emailObj = userInfo.get("email");
                                jsonResponse.addProperty("email", emailObj != null ? emailObj.toString() : "");
                                
                                Object roleObj = userInfo.get("role");
                                jsonResponse.addProperty("role", roleObj != null ? roleObj.toString() : "");
                                
                                Object userTypeObj = userInfo.get("userType");
                                jsonResponse.addProperty("userType", userTypeObj != null ? userTypeObj.toString() : "");
                                
                                String jsonString = gson.toJson(jsonResponse);
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>JSON Object Creation Test</h6>");
                                out.println("<p><strong>Generated JSON:</strong></p>");
                                out.println("<pre class='bg-light p-2 rounded'>" + jsonString + "</pre>");
                                out.println("</div>");
                                
                                // Test 4: Parse JSON back
                                JsonObject parsedJson = gson.fromJson(jsonString, JsonObject.class);
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>JSON Parsing Test</h6>");
                                out.println("<p>Parsed User ID: " + parsedJson.get("userId") + "</p>");
                                out.println("<p>Parsed Email: " + parsedJson.get("email") + "</p>");
                                out.println("<p>Parsed Role: " + parsedJson.get("role") + "</p>");
                                out.println("<p>Parsed User Type: " + parsedJson.get("userType") + "</p>");
                                out.println("</div>");
                                
                                // Test 5: API endpoint simulation
                                out.println("<div class='alert alert-info'>");
                                out.println("<h6><i class='fas fa-info-circle me-2'></i>API Endpoint Test</h6>");
                                out.println("<p>Testing API endpoint simulation...</p>");
                                out.println("</div>");
                                
                                // Simulate the API response
                                JsonObject apiResponse = new JsonObject();
                                apiResponse.addProperty("success", true);
                                apiResponse.addProperty("valid", true);
                                
                                // Safe handling for API response
                                if (userIdObj != null) {
                                    if (userIdObj instanceof Number) {
                                        apiResponse.addProperty("userId", ((Number) userIdObj).intValue());
                                    } else {
                                        apiResponse.addProperty("userId", userIdObj.toString());
                                    }
                                } else {
                                    apiResponse.addProperty("userId", 0);
                                }
                                
                                apiResponse.addProperty("email", emailObj != null ? emailObj.toString() : "");
                                apiResponse.addProperty("role", roleObj != null ? roleObj.toString() : "");
                                apiResponse.addProperty("userType", userTypeObj != null ? userTypeObj.toString() : "");
                                
                                String apiJsonString = gson.toJson(apiResponse);
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>API Response Test</h6>");
                                out.println("<p><strong>API Response JSON:</strong></p>");
                                out.println("<pre class='bg-light p-2 rounded'>" + apiJsonString + "</pre>");
                                out.println("</div>");
                                
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>");
                                out.println("<h6><i class='fas fa-exclamation-triangle me-2'></i>JSON Test Failed</h6>");
                                out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
                                out.println("<p><strong>Stack Trace:</strong></p>");
                                out.println("<pre class='bg-light p-2 rounded'>");
                                e.printStackTrace(new java.io.PrintWriter(out));
                                out.println("</pre>");
                                out.println("</div>");
                            }
                        %>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>Manual API Tests</h5>
                                <div class="d-grid gap-2 d-md-flex">
                                    <button class="btn btn-primary" onclick="testCheckTokenAPI()">
                                        <i class="fas fa-shield-alt me-2"></i>Test Check Token API
                                    </button>
                                    <button class="btn btn-success" onclick="testRefreshTokenAPI()">
                                        <i class="fas fa-sync-alt me-2"></i>Test Refresh Token API
                                    </button>
                                    <button class="btn btn-warning" onclick="testLoginAPI()">
                                        <i class="fas fa-sign-in-alt me-2"></i>Test Login API
                                    </button>
                                </div>
                                
                                <div id="apiTestResults" class="mt-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testCheckTokenAPI() {
            const resultDiv = document.getElementById('apiTestResults');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing Check Token API...</div>';
            
            // First, generate a real token for testing
            const testToken = '<%= JwtUtil.generateAccessToken(123, "test@example.com", "staff", "user") %>';
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + testToken
                }
            })
            .then(response => {
                console.log('Response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Response data:', data);
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>Check Token API Test</h6>
                        <p><strong>User ID:</strong> ${data.userId || 'N/A'}</p>
                        <p><strong>Email:</strong> ${data.email || 'N/A'}</p>
                        <p><strong>Role:</strong> ${data.role || 'N/A'}</p>
                        <p><strong>User Type:</strong> ${data.userType || 'N/A'}</p>
                        <p><strong>Success:</strong> ${data.success}</p>
                        <p><strong>Valid:</strong> ${data.valid}</p>
                        <p><strong>Full Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('API Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Check Token API Error</h6>
                        <p>${error.message}</p>
                        <p>Check browser console for more details</p>
                    </div>
                `;
            });
        }
        
        function testRefreshTokenAPI() {
            const resultDiv = document.getElementById('apiTestResults');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing Refresh Token API...</div>';
            
            const formData = new URLSearchParams();
            formData.append('refreshToken', 'invalid.refresh.token');
            
            fetch('${pageContext.request.contextPath}/api/auth/refresh', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>Refresh Token API Test</h6>
                        <p><strong>Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Refresh Token API Error</h6>
                        <p>${error.message}</p>
                    </div>
                `;
            });
        }
        
        function testLoginAPI() {
            const resultDiv = document.getElementById('apiTestResults');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing Login API...</div>';
            
            const formData = new URLSearchParams();
            formData.append('email', 'test@example.com');
            formData.append('password', 'testpassword');
            
            fetch('${pageContext.request.contextPath}/api/auth/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>Login API Test</h6>
                        <p><strong>Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Login API Error</h6>
                        <p>${error.message}</p>
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 