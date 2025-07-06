<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Token Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Simple Token Test</h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Generate a test token
                            String testToken = JwtUtil.generateAccessToken(123, "test@example.com", "staff", "user");
                            
                            out.println("<h5>Generated Token:</h5>");
                            out.println("<p><code>" + testToken.substring(0, 50) + "...</code></p>");
                            
                            // Validate token locally
                            try {
                                Map<String, Object> userInfo = JwtUtil.validateToken(testToken);
                                
                                out.println("<h5>Local Validation Results:</h5>");
                                out.println("<ul>");
                                out.println("<li><strong>User ID:</strong> " + userInfo.get("userId") + "</li>");
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
                        <button class="btn btn-success" onclick="testAPI()">Test API</button>
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
            
            resultDiv.innerHTML = '<div class="alert alert-info">Testing API...</div>';
            
            fetch('${pageContext.request.contextPath}/api/auth/check-token', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + testToken
                }
            })
            .then(response => response.json())
            .then(data => {
                console.log('API Response:', data);
                
                // Simple display without template literals
                let html = '<div class="alert alert-success">';
                html += '<h6>API Response:</h6>';
                html += '<ul>';
                html += '<li><strong>Success:</strong> ' + data.success + '</li>';
                html += '<li><strong>Valid:</strong> ' + data.valid + '</li>';
                html += '<li><strong>User ID:</strong> ' + data.userId + '</li>';
                html += '<li><strong>Email:</strong> ' + data.email + '</li>';
                html += '<li><strong>Role:</strong> ' + data.role + '</li>';
                html += '<li><strong>User Type:</strong> ' + data.userType + '</li>';
                html += '</ul>';
                html += '<h6>Raw JSON:</h6>';
                html += '<pre class="bg-light p-2">' + JSON.stringify(data, null, 2) + '</pre>';
                html += '</div>';
                
                resultDiv.innerHTML = html;
            })
            .catch(error => {
                console.error('Error:', error);
                resultDiv.innerHTML = '<div class="alert alert-danger"><h6>Error:</h6><p>' + error.message + '</p></div>';
            });
        }
    </script>
</body>
</html> 