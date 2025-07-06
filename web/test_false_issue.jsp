<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test False Issue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h4 class="mb-0">Test False Issue</h4>
                    </div>
                    <div class="card-body">
                        <h5>Test 1: Direct Values</h5>
                        <div id="test1"></div>
                        
                        <hr>
                        
                        <h5>Test 2: API Response</h5>
                        <button class="btn btn-primary" onclick="testAPI()">Test API</button>
                        <div id="test2"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Test 1: Direct values
        const testData = {
            userId: 123,
            email: "test@example.com",
            role: "staff",
            userType: "user",
            success: true,
            valid: true
        };
        
        document.getElementById('test1').innerHTML = `
            <table class="table table-sm">
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                    <th>Type</th>
                    <th>Boolean Test</th>
                    <th>String Test</th>
                </tr>
                <tr>
                    <td>userId</td>
                    <td>${testData.userId}</td>
                    <td>${typeof testData.userId}</td>
                                                    <td>${testData.userId !== null && testData.userId !== undefined ? testData.userId : 'N/A'}</td>
                    <td>${String(testData.userId)}</td>
                </tr>
                <tr>
                    <td>email</td>
                    <td>${testData.email}</td>
                    <td>${typeof testData.email}</td>
                    <td>${testData.email ? 'true' : 'false'}</td>
                    <td>${String(testData.email)}</td>
                </tr>
                <tr>
                    <td>role</td>
                    <td>${testData.role}</td>
                    <td>${typeof testData.role}</td>
                    <td>${testData.role ? 'true' : 'false'}</td>
                    <td>${String(testData.role)}</td>
                </tr>
                <tr>
                    <td>userType</td>
                    <td>${testData.userType}</td>
                    <td>${typeof testData.userType}</td>
                    <td>${testData.userType ? 'true' : 'false'}</td>
                    <td>${String(testData.userType)}</td>
                </tr>
            </table>
        `;
        
        // Test 2: API response
        function testAPI() {
            const resultDiv = document.getElementById('test2');
            
            // Use a simple test token
            const testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjc4OSwiZW1haWwiOiJ0ZXN0QGRlYnVnLmNvbSIsInJvbGUiOiJzdGFmZiIsInVzZXJUeXBlIjoidXNlciIsInRva2VuVHlwZSI6ImFjY2VzcyIsImlhdCI6MTczNDU2NzIwMCwiZXhwIjoxNzM0NTY4MTAwfQ.test";
            
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
                
                resultDiv.innerHTML = `
                    <div class="alert alert-success">
                        <h6>API Response Analysis:</h6>
                        <table class="table table-sm">
                            <tr>
                                <th>Field</th>
                                <th>Raw Value</th>
                                <th>Type</th>
                                <th>Boolean Test</th>
                                <th>String Test</th>
                                <th>Truthy Test</th>
                            </tr>
                            <tr>
                                <td>success</td>
                                <td>${data.success}</td>
                                <td>${typeof data.success}</td>
                                <td>${data.success ? 'true' : 'false'}</td>
                                <td>${String(data.success)}</td>
                                <td>${!!data.success}</td>
                            </tr>
                            <tr>
                                <td>valid</td>
                                <td>${data.valid}</td>
                                <td>${typeof data.valid}</td>
                                <td>${data.valid ? 'true' : 'false'}</td>
                                <td>${String(data.valid)}</td>
                                <td>${!!data.valid}</td>
                            </tr>
                            <tr>
                                <td>userId</td>
                                <td>${data.userId}</td>
                                <td>${typeof data.userId}</td>
                                <td>${data.userId !== null && data.userId !== undefined ? data.userId : 'N/A'}</td>
                                <td>${String(data.userId)}</td>
                                <td>${!!data.userId}</td>
                            </tr>
                            <tr>
                                <td>email</td>
                                <td>${data.email}</td>
                                <td>${typeof data.email}</td>
                                <td>${data.email ? 'true' : 'false'}</td>
                                <td>${String(data.email)}</td>
                                <td>${!!data.email}</td>
                            </tr>
                            <tr>
                                <td>role</td>
                                <td>${data.role}</td>
                                <td>${typeof data.role}</td>
                                <td>${data.role ? 'true' : 'false'}</td>
                                <td>${String(data.role)}</td>
                                <td>${!!data.role}</td>
                            </tr>
                            <tr>
                                <td>userType</td>
                                <td>${data.userType}</td>
                                <td>${typeof data.userType}</td>
                                <td>${data.userType ? 'true' : 'false'}</td>
                                <td>${String(data.userType)}</td>
                                <td>${!!data.userType}</td>
                            </tr>
                        </table>
                        
                        <h6>Raw JSON:</h6>
                        <pre class="bg-light p-2">${JSON.stringify(data, null, 2)}</pre>
                        
                        <h6>Console Log:</h6>
                        <p>Check browser console for detailed logs</p>
                    </div>
                `;
                
                // Additional console logging
                console.log('=== DETAILED ANALYSIS ===');
                console.log('userId:', data.userId, 'Type:', typeof data.userId, 'Truthy:', !!data.userId);
                console.log('email:', data.email, 'Type:', typeof data.email, 'Truthy:', !!data.email);
                console.log('role:', data.role, 'Type:', typeof data.role, 'Truthy:', !!data.role);
                console.log('userType:', data.userType, 'Type:', typeof data.userType, 'Truthy:', !!data.userType);
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