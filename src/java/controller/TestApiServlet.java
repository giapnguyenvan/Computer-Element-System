package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import util.JwtUtil;

@WebServlet("/api/test/*")
public class TestApiServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/info".equals(pathInfo)) {
                // Get user info from JWT filter
                Integer userId = (Integer) request.getAttribute("userId");
                String userEmail = (String) request.getAttribute("userEmail");
                String userRole = (String) request.getAttribute("userRole");
                String userType = (String) request.getAttribute("userType");
                
                if (userId != null) {
                    String jsonResponse = String.format(
                        "{\"success\":true,\"message\":\"Protected endpoint accessed successfully\",\"data\":{\"userId\":%d,\"email\":\"%s\",\"role\":\"%s\",\"userType\":\"%s\"}}",
                        userId, userEmail, userRole, userType
                    );
                    out.print(jsonResponse);
                } else {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    out.print("{\"success\":false,\"error\":\"User not authenticated\"}");
                }
            } else if ("/public".equals(pathInfo)) {
                // Public endpoint - no authentication required
                out.print("{\"success\":true,\"message\":\"Public endpoint accessed successfully\",\"data\":{\"timestamp\":\"" + System.currentTimeMillis() + "\"}}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"success\":false,\"error\":\"Endpoint not found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"error\":\"Internal server error: " + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
} 