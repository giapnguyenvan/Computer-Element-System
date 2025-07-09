package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import model.Customer;
import model.User;
import dal.CustomerDAO;
import dal.UserDAO;
import util.JwtUtil;

@WebServlet("/api/auth/*")
public class AuthApiServlet extends HttpServlet {
    
    private final Gson gson = new Gson();
    
    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/login".equals(pathInfo)) {
                handleLogin(request, response, out);
            } else if ("/refresh".equals(pathInfo)) {
                handleRefresh(request, response, out);
            } else if ("/logout".equals(pathInfo)) {
                handleLogout(request, response, out);
            } else if ("/check-token".equals(pathInfo)) {
                handleCheckToken(request, response, out);
            } else {
                sendErrorResponse(out, 404, "Endpoint not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(out, 500, "Internal server error: " + e.getMessage());
        }
    }
    
    private void handleLogin(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response, PrintWriter out) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null) {
            sendErrorResponse(out, 400, "Email and password are required");
            return;
        }
        
        try {
            // Try customer login first
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.login(email, password);
            if (customer != null && customer.isVerified()) {
                // Generate JWT tokens for customer
                String accessToken = JwtUtil.generateAccessToken(
                    customer.getCustomer_id(), 
                    customer.getEmail(), 
                    "customer", 
                    "customer"
                );
                String refreshToken = JwtUtil.generateRefreshToken(
                    customer.getCustomer_id(), 
                    customer.getEmail(), 
                    "customer", 
                    "customer"
                );
                
                JsonObject tokenResponse = JwtUtil.createTokenResponse(accessToken, refreshToken);
                tokenResponse.addProperty("success", true);
                tokenResponse.addProperty("userType", "customer");
                tokenResponse.addProperty("userId", customer.getCustomer_id());
                tokenResponse.addProperty("userName", customer.getName() != null ? customer.getName() : "");
                
                out.print(gson.toJson(tokenResponse));
                return;
            }
            
            // Try user (staff/admin) login
            UserDAO userDAO = UserDAO.getInstance();
            User user = userDAO.login(email, password);
            if (user != null && user.isVerified()) {
                // Generate JWT tokens for user
                String accessToken = JwtUtil.generateAccessToken(
                    user.getId(), 
                    user.getEmail(), 
                    user.getRole(), 
                    "user"
                );
                String refreshToken = JwtUtil.generateRefreshToken(
                    user.getId(), 
                    user.getEmail(), 
                    user.getRole(), 
                    "user"
                );
                
                JsonObject tokenResponse = JwtUtil.createTokenResponse(accessToken, refreshToken);
                tokenResponse.addProperty("success", true);
                tokenResponse.addProperty("userType", "user");
                tokenResponse.addProperty("userId", user.getId());
                tokenResponse.addProperty("userName", user.getUsername() != null ? user.getUsername() : "");
                tokenResponse.addProperty("role", user.getRole() != null ? user.getRole() : "");
                
                out.print(gson.toJson(tokenResponse));
                return;
            }
            
            // Login failed
            sendErrorResponse(out, 401, "Invalid email or password");
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(out, 500, "Login error: " + e.getMessage());
        }
    }
    
    private void handleRefresh(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response, PrintWriter out) {
        String refreshToken = request.getParameter("refreshToken");
        
        if (refreshToken == null) {
            sendErrorResponse(out, 400, "Refresh token is required");
            return;
        }
        
        try {
            // Validate refresh token and generate new access token
            String newAccessToken = JwtUtil.refreshAccessToken(refreshToken);
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("accessToken", newAccessToken);
            jsonResponse.addProperty("tokenType", "Bearer");
            jsonResponse.addProperty("expiresIn", 15 * 60); // 15 minutes in seconds
            
            out.print(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            sendErrorResponse(out, 401, "Invalid refresh token: " + e.getMessage());
        }
    }
    
    private void handleLogout(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response, PrintWriter out) {
        // For JWT, logout is typically handled client-side by removing tokens
        // But we can invalidate refresh tokens if needed
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", true);
        jsonResponse.addProperty("message", "Logged out successfully");
        
        out.print(gson.toJson(jsonResponse));
    }
    
    private void handleCheckToken(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response, PrintWriter out) {
        String authHeader = request.getHeader("Authorization");
        
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendErrorResponse(out, 401, "Missing or invalid Authorization header");
            return;
        }
        
        String token = authHeader.substring(7); // Remove "Bearer " prefix
        
        try {
            // Validate token
            Map<String, Object> userInfo = JwtUtil.validateToken(token);
            
            // Check if it's an access token
            if (!"access".equals(userInfo.get("tokenType"))) {
                sendErrorResponse(out, 401, "Invalid token type");
                return;
            }
            
            // Token is valid, return success
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("valid", true);
            
            // Debug logging
            System.out.println("=== DEBUG: Token Validation ===");
            System.out.println("UserInfo Map: " + userInfo);
            System.out.println("UserInfo Keys: " + userInfo.keySet());
            
            // Safely handle userId (convert Number to String if needed)
            Object userIdObj = userInfo.get("userId");
            System.out.println("userIdObj: " + userIdObj + " (Type: " + (userIdObj != null ? userIdObj.getClass().getSimpleName() : "null") + ")");
            
            if (userIdObj != null) {
                if (userIdObj instanceof Number) {
                    int userId = ((Number) userIdObj).intValue();
                    jsonResponse.addProperty("userId", userId);
                    System.out.println("Added userId as int: " + userId);
                } else {
                    String userId = userIdObj.toString();
                    jsonResponse.addProperty("userId", userId);
                    System.out.println("Added userId as string: " + userId);
                }
            } else {
                jsonResponse.addProperty("userId", 0);
                System.out.println("Added userId as default: 0");
            }
            
            // Safely handle email
            Object emailObj = userInfo.get("email");
            System.out.println("emailObj: " + emailObj + " (Type: " + (emailObj != null ? emailObj.getClass().getSimpleName() : "null") + ")");
            String email = emailObj != null ? emailObj.toString() : "";
            jsonResponse.addProperty("email", email);
            System.out.println("Added email: " + email);
            
            // Safely handle role
            Object roleObj = userInfo.get("role");
            System.out.println("roleObj: " + roleObj + " (Type: " + (roleObj != null ? roleObj.getClass().getSimpleName() : "null") + ")");
            String role = roleObj != null ? roleObj.toString() : "";
            jsonResponse.addProperty("role", role);
            System.out.println("Added role: " + role);
            
            // Safely handle userType
            Object userTypeObj = userInfo.get("userType");
            System.out.println("userTypeObj: " + userTypeObj + " (Type: " + (userTypeObj != null ? userTypeObj.getClass().getSimpleName() : "null") + ")");
            String userType = userTypeObj != null ? userTypeObj.toString() : "";
            jsonResponse.addProperty("userType", userType);
            System.out.println("Added userType: " + userType);
            
            System.out.println("Final JSON Response: " + gson.toJson(jsonResponse));
            System.out.println("=== END DEBUG ===");
            
            out.print(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            sendErrorResponse(out, 401, "Invalid token: " + e.getMessage());
        }
    }
    
    private void sendErrorResponse(PrintWriter out, int status, String message) {
        JsonObject error = new JsonObject();
        error.addProperty("success", false);
        error.addProperty("error", message);
        error.addProperty("status", status);
        
        out.print(gson.toJson(error));
    }
    
    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        response.sendError(jakarta.servlet.http.HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
} 