package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import util.JwtUtil;

@WebFilter("/api/*")
public class JwtAuthenticationFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Skip authentication for auth endpoints
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.contains("/api/auth/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Get Authorization header
        String authHeader = httpRequest.getHeader("Authorization");
        
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendUnauthorizedResponse(httpResponse, "Missing or invalid Authorization header");
            return;
        }
        
        // Extract token
        String token = authHeader.substring(7); // Remove "Bearer " prefix
        
        try {
            // Validate token
            Map<String, Object> userInfo = JwtUtil.validateToken(token);
            
            // Check if it's an access token
            if (!"access".equals(userInfo.get("tokenType"))) {
                sendUnauthorizedResponse(httpResponse, "Invalid token type");
                return;
            }
            
            // Add user info to request attributes
            request.setAttribute("userId", userInfo.get("userId"));
            request.setAttribute("userEmail", userInfo.get("email"));
            request.setAttribute("userRole", userInfo.get("role"));
            request.setAttribute("userType", userInfo.get("userType"));
            
            // Continue with the request
            chain.doFilter(request, response);
            
        } catch (Exception e) {
            sendUnauthorizedResponse(httpResponse, "Invalid token: " + e.getMessage());
        }
    }
    
    private void sendUnauthorizedResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json;charset=UTF-8");
        
        String jsonResponse = "{\"success\":false,\"error\":\"" + message + "\",\"status\":401}";
        response.getWriter().write(jsonResponse);
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
} 