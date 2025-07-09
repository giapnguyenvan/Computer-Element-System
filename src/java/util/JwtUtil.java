package util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;

public class JwtUtil {
    
    private static final String SECRET_KEY = "your-secret-key-must-be-at-least-256-bits-long-for-hs256-algorithm";
    private static final long ACCESS_TOKEN_EXPIRATION = 15 * 60 * 1000; // 15 minutes
    private static final long REFRESH_TOKEN_EXPIRATION = 7 * 24 * 60 * 60 * 1000; // 7 days
    private static final String ISSUER = "Project_G2";
    
    private static final Gson gson = new Gson();
    
    // Generate access token
    public static String generateAccessToken(int userId, String email, String role, String userType) {
        return generateToken(userId, email, role, userType, ACCESS_TOKEN_EXPIRATION, "access");
    }
    
    // Generate refresh token
    public static String generateRefreshToken(int userId, String email, String role, String userType) {
        return generateToken(userId, email, role, userType, REFRESH_TOKEN_EXPIRATION, "refresh");
    }
    
    private static String generateToken(int userId, String email, String role, String userType, 
                                      long expiration, String tokenType) {
        try {
            // Create header
            Map<String, String> header = new HashMap<>();
            header.put("alg", "HS256");
            header.put("typ", "JWT");
            String headerJson = gson.toJson(header);
            String headerEncoded = Base64.getUrlEncoder().withoutPadding().encodeToString(headerJson.getBytes(StandardCharsets.UTF_8));
            
            // Create payload
            Map<String, Object> payload = new HashMap<>();
            payload.put("userId", userId);
            payload.put("email", email);
            payload.put("role", role);
            payload.put("userType", userType);
            payload.put("tokenType", tokenType);
            payload.put("iat", new Date().getTime());
            payload.put("exp", new Date().getTime() + expiration);
            payload.put("iss", ISSUER);
            
            String payloadJson = gson.toJson(payload);
            String payloadEncoded = Base64.getUrlEncoder().withoutPadding().encodeToString(payloadJson.getBytes(StandardCharsets.UTF_8));
            
            // Create signature
            String data = headerEncoded + "." + payloadEncoded;
            String signature = createHmacSha256(data, SECRET_KEY);
            String signatureEncoded = Base64.getUrlEncoder().withoutPadding().encodeToString(signature.getBytes(StandardCharsets.UTF_8));
            
            return data + "." + signatureEncoded;
            
        } catch (Exception e) {
            throw new RuntimeException("Error generating token", e);
        }
    }
    
    // Validate token
    public static Map<String, Object> validateToken(String token) {
        try {
            String[] parts = token.split("\\.");
            if (parts.length != 3) {
                throw new RuntimeException("Invalid token format");
            }
            
            String headerEncoded = parts[0];
            String payloadEncoded = parts[1];
            String signatureEncoded = parts[2];
            
            // Verify signature
            String data = headerEncoded + "." + payloadEncoded;
            String expectedSignature = createHmacSha256(data, SECRET_KEY);
            String expectedSignatureEncoded = Base64.getUrlEncoder().withoutPadding().encodeToString(expectedSignature.getBytes(StandardCharsets.UTF_8));
            
            if (!signatureEncoded.equals(expectedSignatureEncoded)) {
                throw new RuntimeException("Invalid signature");
            }
            
            // Decode payload
            String payloadJson = new String(Base64.getUrlDecoder().decode(payloadEncoded), StandardCharsets.UTF_8);
            Map<String, Object> payload = gson.fromJson(payloadJson, Map.class);
            
            // Check expiration
            long exp = ((Number) payload.get("exp")).longValue();
            if (exp < new Date().getTime()) {
                throw new RuntimeException("Token has expired");
            }
            
            return payload;
            
        } catch (Exception e) {
            throw new RuntimeException("Invalid token: " + e.getMessage());
        }
    }
    
    // Extract user info from token
    public static Map<String, Object> extractUserInfo(String token) {
        return validateToken(token);
    }
    
    // Check if token is expired
    public static boolean isTokenExpired(String token) {
        try {
            Map<String, Object> payload = validateToken(token);
            long exp = ((Number) payload.get("exp")).longValue();
            return exp < new Date().getTime();
        } catch (Exception e) {
            return true;
        }
    }
    
    // Get token expiration time
    public static Date getTokenExpiration(String token) {
        Map<String, Object> payload = validateToken(token);
        long exp = ((Number) payload.get("exp")).longValue();
        return new Date(exp);
    }
    
    // Refresh access token using refresh token
    public static String refreshAccessToken(String refreshToken) {
        Map<String, Object> claims = validateToken(refreshToken);
        
        // Check if it's actually a refresh token
        if (!"refresh".equals(claims.get("tokenType"))) {
            throw new RuntimeException("Invalid refresh token");
        }
        
        // Generate new access token
        return generateAccessToken(
            ((Number) claims.get("userId")).intValue(),
            (String) claims.get("email"),
            (String) claims.get("role"),
            (String) claims.get("userType")
        );
    }
    
    private static String createHmacSha256(String data, String key) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKeySpec);
            byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException("Error creating HMAC", e);
        }
    }
    
    // Create response with tokens
    public static JsonObject createTokenResponse(String accessToken, String refreshToken) {
        JsonObject response = new JsonObject();
        response.addProperty("accessToken", accessToken);
        response.addProperty("refreshToken", refreshToken);
        response.addProperty("tokenType", "Bearer");
        response.addProperty("expiresIn", ACCESS_TOKEN_EXPIRATION / 1000); // seconds
        return response;
    }
} 