<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Debug</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0">Simple Debug - Tại sao hiển thị FALSE?</h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Generate test token
                            String testToken = JwtUtil.generateAccessToken(789, "test@debug.com", "staff", "user");
                            
                            out.println("<h5>Test Token:</h5>");
                            out.println("<p><code>" + testToken.substring(0, 50) + "...</code></p>");
                            
                            // Test local validation
                            try {
                                Map<String, Object> userInfo = JwtUtil.validateToken(testToken);
                                
                                out.println("<h5>Local Validation Results:</h5>");
                                out.println("<ul>");
                                out.println("<li><strong>User ID:</strong> " + userInfo.get("userId") + " (Type: " + userInfo.get("userId").getClass().getSimpleName() + ")</li>");
                                out.println("<li><strong>Email:</strong> " + userInfo.get("email") + "</li>");
                                out.println("<li><strong>Role:</strong> " + userInfo.get("role") + "</li>");
                                out.println("<li><strong>User Type:</strong> " + userInfo.get("userType") + "</li>");
                                out.println("</ul>");
                                
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>Local validation failed: " + e.getMessage() + "</div>");
                            }
                        %>
                        
                        <hr>
                        
                        <h5>API Test</h5>
                        <button class="btn btn-primary" onclick="testAPI()">Test API</button>
                        
                        <div id="result" class="mt-3"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testAPI() {
            const resultDiv = document.getElementById('result');
            const testToken = '<%= testToken %>';
            
            resultDiv.innerHTML = '<div class="alert alert-info">Testing...</div>';
            
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
                console.log('Raw response data:', data);
                console.log('Data type:', typeof data);
                console.log('Data keys:', Object.keys(data));
                
                // Test individual fields
                console.log('userId:', data.userId, 'Type:', typeof data.userId);
                console.log('email:', data.email, 'Type:', typeof data.email);
                console.log('role:', data.role, 'Type:', typeof data.role);
                console.log('userType:', data.userType, 'Type:', typeof data.userType);
                
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6>API Response Analysis:</h6>
                        <table class="table table-sm">
                            <tr>
                                <th>Field</th>
                                <th>Value</th>
                                <th>Type</th>
                                <th>Boolean Test</th>
                            </tr>
                            <tr>
                                <td>success</td>
                                <td>${data.success}</td>
                                <td>${typeof data.success}</td>
                                <td>${data.success ? 'true' : 'false'}</td>
                            </tr>
                            <tr>
                                <td>valid</td>
                                <td>${data.valid}</td>
                                <td>${typeof data.valid}</td>
                                <td>${data.valid ? 'true' : 'false'}</td>
                            </tr>
                            <tr>
                                <td>userId</td>
                                <td>${data.userId}</td>
                                <td>${typeof data.userId}</td>
                                <td>${data.userId !== null && data.userId !== undefined ? data.userId : 'N/A'}</td>
                            </tr>
                            <tr>
                                <td>email</td>
                                <td>${data.email}</td>
                                <td>${typeof data.email}</td>
                                <td>${data.email ? 'true' : 'false'}</td>
                            </tr>
                            <tr>
                                <td>role</td>
                                <td>${data.role}</td>
                                <td>${typeof data.role}</td>
                                <td>${data.role ? 'true' : 'false'}</td>
                            </tr>
                            <tr>
                                <td>userType</td>
                                <td>${data.userType}</td>
                                <td>${typeof data.userType}</td>
                                <td>${data.userType ? 'true' : 'false'}</td>
                            </tr>
                        </table>
                        
                        <h6>Raw JSON:</h6>
                        <pre class="bg-light p-2">${JSON.stringify(data, null, 2)}</pre>
                    </div>
                `;
            })
            .catch(error => {
                console.error('Error:', error);
                resultDiv.innerHTML = `
                    <div class="alert alert-danger">
                        <h6>Error:</h6>
                        <p>${error.message}</p>
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 