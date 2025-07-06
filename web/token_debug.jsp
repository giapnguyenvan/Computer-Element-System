<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Token Debug</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h4 class="mb-0">Token Generation & Validation Debug</h4>
                    </div>
                    <div class="card-body">
                        <%
                            // Test token generation
                            int testUserId = 789;
                            String testEmail = "test@debug.com";
                            String testRole = "staff";
                            String testUserType = "user";
                            
                            out.println("<h5>1. Token Generation Test:</h5>");
                            out.println("<ul>");
                            out.println("<li><strong>User ID:</strong> " + testUserId + " (Type: " + Integer.class.getSimpleName() + ")</li>");
                            out.println("<li><strong>Email:</strong> " + testEmail + "</li>");
                            out.println("<li><strong>Role:</strong> " + testRole + "</li>");
                            out.println("<li><strong>User Type:</strong> " + testUserType + "</li>");
                            out.println("</ul>");
                            
                            try {
                                String accessToken = JwtUtil.generateAccessToken(testUserId, testEmail, testRole, testUserType);
                                out.println("<h6>Generated Access Token:</h6>");
                                out.println("<p><code>" + accessToken.substring(0, 100) + "...</code></p>");
                                
                                out.println("<h5>2. Token Validation Test:</h5>");
                                Map<String, Object> userInfo = JwtUtil.validateToken(accessToken);
                                
                                out.println("<h6>Validation Results:</h6>");
                                out.println("<table class='table table-sm'>");
                                out.println("<tr><th>Field</th><th>Value</th><th>Type</th></tr>");
                                
                                for (Map.Entry<String, Object> entry : userInfo.entrySet()) {
                                    String key = entry.getKey();
                                    Object value = entry.getValue();
                                    String type = value != null ? value.getClass().getSimpleName() : "null";
                                    out.println("<tr>");
                                    out.println("<td>" + key + "</td>");
                                    out.println("<td>" + value + "</td>");
                                    out.println("<td>" + type + "</td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                                
                                // Test specific fields
                                out.println("<h6>Specific Field Tests:</h6>");
                                out.println("<ul>");
                                
                                Object userIdObj = userInfo.get("userId");
                                out.println("<li><strong>userId:</strong> " + userIdObj + " (Type: " + (userIdObj != null ? userIdObj.getClass().getSimpleName() : "null") + ")</li>");
                                
                                Object emailObj = userInfo.get("email");
                                out.println("<li><strong>email:</strong> " + emailObj + " (Type: " + (emailObj != null ? emailObj.getClass().getSimpleName() : "null") + ")</li>");
                                
                                Object roleObj = userInfo.get("role");
                                out.println("<li><strong>role:</strong> " + roleObj + " (Type: " + (roleObj != null ? roleObj.getClass().getSimpleName() : "null") + ")</li>");
                                
                                Object userTypeObj = userInfo.get("userType");
                                out.println("<li><strong>userType:</strong> " + userTypeObj + " (Type: " + (userTypeObj != null ? userTypeObj.getClass().getSimpleName() : "null") + ")</li>");
                                
                                out.println("</ul>");
                                
                                // Test JSON conversion
                                out.println("<h5>3. JSON Conversion Test:</h5>");
                                Gson gson = new Gson();
                                String jsonString = gson.toJson(userInfo);
                                out.println("<p><strong>JSON String:</strong></p>");
                                out.println("<pre class='bg-light p-2'>" + jsonString + "</pre>");
                                
                                // Test API simulation
                                out.println("<h5>4. API Response Simulation:</h5>");
                                com.google.gson.JsonObject jsonResponse = new com.google.gson.JsonObject();
                                jsonResponse.addProperty("success", true);
                                jsonResponse.addProperty("valid", true);
                                
                                // Test different ways to add userId
                                if (userIdObj instanceof Number) {
                                    jsonResponse.addProperty("userId", ((Number) userIdObj).intValue());
                                    out.println("<p>✅ Added userId as int: " + ((Number) userIdObj).intValue() + "</p>");
                                } else if (userIdObj != null) {
                                    jsonResponse.addProperty("userId", userIdObj.toString());
                                    out.println("<p>✅ Added userId as string: " + userIdObj.toString() + "</p>");
                                } else {
                                    jsonResponse.addProperty("userId", 0);
                                    out.println("<p>❌ Added userId as default: 0</p>");
                                }
                                
                                jsonResponse.addProperty("email", emailObj != null ? emailObj.toString() : "");
                                jsonResponse.addProperty("role", roleObj != null ? roleObj.toString() : "");
                                jsonResponse.addProperty("userType", userTypeObj != null ? userTypeObj.toString() : "");
                                
                                String apiResponse = gson.toJson(jsonResponse);
                                out.println("<p><strong>API Response JSON:</strong></p>");
                                out.println("<pre class='bg-light p-2'>" + apiResponse + "</pre>");
                                
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                                e.printStackTrace();
                            }
                        %>
                        
                        <hr>
                        
                        <h5>5. Live API Test</h5>
                        <button class="btn btn-primary" onclick="testLiveAPI()">Test Live API</button>
                        <div id="liveResult" class="mt-3"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function testLiveAPI() {
            const resultDiv = document.getElementById('liveResult');
            
            // Get the token from server-side
            const testToken = '<%= JwtUtil.generateAccessToken(789, "test@debug.com", "staff", "user") %>';
            
            resultDiv.innerHTML = '<div class="alert alert-info">Testing live API...</div>';
            
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
                console.log('Live API Response:', data);
                
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6>Live API Response:</h6>
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