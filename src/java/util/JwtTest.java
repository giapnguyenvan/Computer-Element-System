package util;

import java.util.Map;

public class JwtTest {
    
    public static void main(String[] args) {
        try {
            System.out.println("=== JWT Test ===");
            
            // Test customer token generation
            System.out.println("\n1. Testing Customer Token Generation:");
            String customerAccessToken = JwtUtil.generateAccessToken(1, "customer@test.com", "customer", "customer");
            String customerRefreshToken = JwtUtil.generateRefreshToken(1, "customer@test.com", "customer", "customer");
            
            System.out.println("Customer Access Token: " + customerAccessToken);
            System.out.println("Customer Refresh Token: " + customerRefreshToken);
            
            // Test user token generation
            System.out.println("\n2. Testing User Token Generation:");
            String userAccessToken = JwtUtil.generateAccessToken(2, "admin@test.com", "Admin", "user");
            String userRefreshToken = JwtUtil.generateRefreshToken(2, "admin@test.com", "Admin", "user");
            
            System.out.println("User Access Token: " + userAccessToken);
            System.out.println("User Refresh Token: " + userRefreshToken);
            
            // Test token validation
            System.out.println("\n3. Testing Token Validation:");
            Map<String, Object> customerInfo = JwtUtil.validateToken(customerAccessToken);
            System.out.println("Customer Token Valid: " + (customerInfo != null));
            System.out.println("Customer Info: " + customerInfo);
            
            Map<String, Object> userInfo = JwtUtil.validateToken(userAccessToken);
            System.out.println("User Token Valid: " + (userInfo != null));
            System.out.println("User Info: " + userInfo);
            
            // Test token expiration check
            System.out.println("\n4. Testing Token Expiration:");
            boolean customerExpired = JwtUtil.isTokenExpired(customerAccessToken);
            boolean userExpired = JwtUtil.isTokenExpired(userAccessToken);
            System.out.println("Customer Token Expired: " + customerExpired);
            System.out.println("User Token Expired: " + userExpired);
            
            // Test refresh token
            System.out.println("\n5. Testing Refresh Token:");
            String newAccessToken = JwtUtil.refreshAccessToken(customerRefreshToken);
            System.out.println("New Access Token: " + newAccessToken);
            
            Map<String, Object> newTokenInfo = JwtUtil.validateToken(newAccessToken);
            System.out.println("New Token Valid: " + (newTokenInfo != null));
            System.out.println("New Token Info: " + newTokenInfo);
            
            // Test invalid token
            System.out.println("\n6. Testing Invalid Token:");
            try {
                JwtUtil.validateToken("invalid.token.here");
                System.out.println("ERROR: Invalid token should have failed validation");
            } catch (Exception e) {
                System.out.println("Invalid token correctly rejected: " + e.getMessage());
            }
            
            System.out.println("\n=== JWT Test Completed Successfully ===");
            
        } catch (Exception e) {
            System.err.println("JWT Test Failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 