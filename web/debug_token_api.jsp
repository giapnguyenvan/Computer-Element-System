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
    <title>Debug Token API</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h4 class="mb-0">
                            <i class="fas fa-bug me-2"></i>Debug Token API - Tại sao giá trị rỗng?
                        </h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Step 1: Generate a real token
                            String testToken = null;
                            try {
                                testToken = JwtUtil.generateAccessToken(123, "staff@test.com", "staff", "user");
                                
                                out.println("<div class='alert alert-info'>");
                                out.println("<h6><i class='fas fa-info-circle me-2'></i>Step 1: Token Generation</h6>");
                                out.println("<p><strong>Generated Token:</strong> " + testToken.substring(0, 50) + "...</p>");
                                out.println("</div>");
                                
                                // Step 2: Validate token locally
                                Map<String, Object> userInfo = JwtUtil.validateToken(testToken);
                                
                                out.println("<div class='alert alert-success'>");
                                out.println("<h6><i class='fas fa-check-circle me-2'></i>Step 2: Local Token Validation</h6>");
                                out.println("<p><strong>User ID:</strong> " + userInfo.get("userId") + " (Type: " + userInfo.get("userId").getClass().getSimpleName() + ")</p>");
                                out.println("<p><strong>Email:</strong> " + userInfo.get("email") + "</p>");
                                out.println("<p><strong>Role:</strong> " + userInfo.get("role") + "</p>");
                                out.println("<p><strong>User Type:</strong> " + userInfo.get("userType") + "</p>");
                                out.println("<p><strong>Token Type:</strong> " + userInfo.get("tokenType") + "</p>");
                                out.println("</div>");
                                
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>");
                                out.println("<h6><i class='fas fa-exclamation-triangle me-2'></i>Token Generation Failed</h6>");
                                out.println("<p>" + e.getMessage() + "</p>");
                                out.println("</div>");
                            }
                        %>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>API Test với Real Token</h5>
                                <div class="mb-3">
                                    <label for="tokenInput" class="form-label">Token để test:</label>
                                    <input type="text" class="form-control" id="tokenInput" 
                                           value="<%= testToken != null ? testToken : "" %>" 
                                           placeholder="Enter token here">
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex">
                                    <button class="btn btn-primary" onclick="testWithRealToken()">
                                        <i class="fas fa-shield-alt me-2"></i>Test với Real Token
                                    </button>
                                    <button class="btn btn-danger" onclick="testWithInvalidToken()">
                                        <i class="fas fa-times-circle me-2"></i>Test với Invalid Token
                                    </button>
                                    <button class="btn btn-info" onclick="testWithNoToken()">
                                        <i class="fas fa-question-circle me-2"></i>Test với No Token
                                    </button>
                                </div>
                                
                                <div id="apiTestResults" class="mt-3"></div>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-12">
                                <h5>Debug Information</h5>
                                <div class="alert alert-secondary">
                                    <h6>Vấn đề có thể xảy ra:</h6>
                                    <ul>
                                        <li><strong>Token không hợp lệ:</strong> API trả về lỗi 401</li>
                                        <li><strong>Token hết hạn:</strong> Token đã quá 15 phút</li>
                                        <li><strong>Wrong token type:</strong> Token không phải access token</li>
                                        <li><strong>API endpoint lỗi:</strong> Servlet không xử lý đúng</li>
                                        <li><strong>JSON parsing lỗi:</strong> Response format không đúng</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testWithRealToken() {
            const token = document.getElementById('tokenInput').value;
            const resultDiv = document.getElementById('apiTestResults');
            
            if (!token) {
                resultDiv.innerHTML = '<div class="alert alert-warning">Vui lòng nhập token để test</div>';
                return;
            }
            
            resultDiv.innerHTML = '<div class="alert alert-info">Testing với real token...</div>';
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(response => {
                console.log('Response status:', response.status);
                console.log('Response headers:', response.headers);
                return response.json();
            })
            .then(data => {
                console.log('Response data:', data);
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6><i class="fas fa-check-circle me-2"></i>API Test với Real Token</h6>
                        <p><strong>Status:</strong> Success</p>
                        <p><strong>User ID:</strong> ${data.userId || 'N/A'}</p>
                        <p><strong>Email:</strong> ${data.email || 'N/A'}</p>
                        <p><strong>Role:</strong> ${data.role || 'N/A'}</p>
                        <p><strong>User Type:</strong> ${data.userType || 'N/A'}</p>
                        <p><strong>Success:</strong> ${data.success}</p>
                        <p><strong>Valid:</strong> ${data.valid}</p>
                        <p><strong>Raw Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('API Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>API Error</h6>
                        <p><strong>Error:</strong> ${error.message}</p>
                        <p>Check browser console for more details</p>
                    </div>
                `;
            });
        }
        
        function testWithInvalidToken() {
            const resultDiv = document.getElementById('apiTestResults');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing với invalid token...</div>';
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer invalid.token.here'
                }
            })
            .then(response => {
                console.log('Invalid token response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Invalid token response data:', data);
                resultDiv.innerHTML = `
                    <div class="alert alert-warning">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>API Test với Invalid Token</h6>
                        <p><strong>Status:</strong> Error (Expected)</p>
                        <p><strong>Success:</strong> ${data.success}</p>
                        <p><strong>Error:</strong> ${data.error || 'N/A'}</p>
                        <p><strong>Status Code:</strong> ${data.status}</p>
                        <p><strong>Raw Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('Invalid token API Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>Invalid Token API Error</h6>
                        <p><strong>Error:</strong> ${error.message}</p>
                    </div>
                `;
            });
        }
        
        function testWithNoToken() {
            const resultDiv = document.getElementById('apiTestResults');
            resultDiv.innerHTML = '<div class="alert alert-info">Testing với no token...</div>';
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                console.log('No token response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('No token response data:', data);
                resultDiv.innerHTML = `
                    <div class="alert alert-warning">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>API Test với No Token</h6>
                        <p><strong>Status:</strong> Error (Expected)</p>
                        <p><strong>Success:</strong> ${data.success}</p>
                        <p><strong>Error:</strong> ${data.error || 'N/A'}</p>
                        <p><strong>Status Code:</strong> ${data.status}</p>
                        <p><strong>Raw Response:</strong></p>
                        <pre class="bg-light p-2 rounded">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('No token API Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>No Token API Error</h6>
                        <p><strong>Error:</strong> ${error.message}</p>
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 