<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="util.JwtUtil" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>JWT Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { border: 1px solid #ddd; margin: 10px 0; padding: 15px; }
        .result { background: #f5f5f5; padding: 10px; margin: 10px 0; font-family: monospace; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
        button { padding: 10px 20px; margin: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>JWT Test Page</h1>
    
    <div class="test-section">
        <h2>1. JWT Token Generation Test</h2>
        <%
            try {
                // Test JWT token generation
                String accessToken = JwtUtil.generateAccessToken(1, "test@example.com", "customer", "customer");
                String refreshToken = JwtUtil.generateRefreshToken(1, "test@example.com", "customer", "customer");
                
                out.println("<div class='result success'>");
                out.println("<strong>✅ JWT Token Generation Successful!</strong><br>");
                out.println("Access Token: " + accessToken.substring(0, 50) + "...<br>");
                out.println("Refresh Token: " + refreshToken.substring(0, 50) + "...<br>");
                out.println("</div>");
                
                // Test token validation
                Map<String, Object> userInfo = JwtUtil.validateToken(accessToken);
                out.println("<div class='result success'>");
                out.println("<strong>✅ Token Validation Successful!</strong><br>");
                out.println("User ID: " + userInfo.get("userId") + "<br>");
                out.println("Email: " + userInfo.get("email") + "<br>");
                out.println("Role: " + userInfo.get("role") + "<br>");
                out.println("User Type: " + userInfo.get("userType") + "<br>");
                out.println("</div>");
                
                // Test token expiration
                boolean expired = JwtUtil.isTokenExpired(accessToken);
                out.println("<div class='result success'>");
                out.println("<strong>✅ Token Expiration Check:</strong> " + (expired ? "Expired" : "Valid") + "<br>");
                out.println("</div>");
                
                // Test refresh token
                String newAccessToken = JwtUtil.refreshAccessToken(refreshToken);
                out.println("<div class='result success'>");
                out.println("<strong>✅ Token Refresh Successful!</strong><br>");
                out.println("New Access Token: " + newAccessToken.substring(0, 50) + "...<br>");
                out.println("</div>");
                
            } catch (Exception e) {
                out.println("<div class='result error'>");
                out.println("<strong>❌ JWT Test Failed:</strong> " + e.getMessage() + "<br>");
                out.println("Stack trace: " + e.toString());
                out.println("</div>");
            }
        %>
    </div>
    
    <div class="test-section">
        <h2>2. API Test Links</h2>
        <p>Test these endpoints after deploying:</p>
        <ul>
            <li><a href="api/auth/login" target="_blank">POST /api/auth/login</a></li>
            <li><a href="api/test/public" target="_blank">GET /api/test/public (Public)</a></li>
            <li><a href="api/test/info" target="_blank">GET /api/test/info (Protected)</a></li>
            <li><a href="session-test" target="_blank">Session Test</a></li>
        </ul>
    </div>
    
    <div class="test-section">
        <h2>3. JavaScript Test</h2>
        <button onclick="testJwtApi()">Test JWT API (JavaScript)</button>
        <div id="jsResult" class="result" style="display: none;"></div>
    </div>
    
    <script>
        async function testJwtApi() {
            const resultDiv = document.getElementById('jsResult');
            resultDiv.style.display = 'block';
            resultDiv.className = 'result';
            resultDiv.innerHTML = 'Testing...';
            
            try {
                // Test public endpoint
                const response = await fetch('api/test/public');
                const data = await response.json();
                
                resultDiv.className = 'result success';
                resultDiv.innerHTML = '<strong>✅ API Test Successful!</strong><br>' + 
                                    'Response: ' + JSON.stringify(data, null, 2);
            } catch (error) {
                resultDiv.className = 'result error';
                resultDiv.innerHTML = '<strong>❌ API Test Failed:</strong><br>' + error.message;
            }
        }
    </script>
</body>
</html> 