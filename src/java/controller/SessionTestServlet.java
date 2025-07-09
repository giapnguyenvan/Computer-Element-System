package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import util.SessionManager;

@WebServlet("/session-test")
public class SessionTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Session Test</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Session Management Test</h1>");
        
        // Test session validity
        boolean isValid = SessionManager.isSessionValid(session);
        out.println("<h2>Session Status</h2>");
        out.println("<p>Session ID: " + session.getId() + "</p>");
        out.println("<p>Session Valid: " + isValid + "</p>");
        out.println("<p>Active Sessions: " + SessionManager.getActiveSessionCount() + "</p>");
        
        // Test session info
        SessionManager.SessionInfo sessionInfo = SessionManager.getSessionInfo(session);
        if (sessionInfo != null) {
            out.println("<h2>Session Info</h2>");
            out.println("<p>User Type: " + sessionInfo.getUserType() + "</p>");
            out.println("<p>User ID: " + sessionInfo.getUserId() + "</p>");
            out.println("<p>Created At: " + sessionInfo.getCreatedAt() + "</p>");
            out.println("<p>Last Accessed: " + sessionInfo.getLastAccessed() + "</p>");
        }
        
        // Test actions
        out.println("<h2>Session Actions</h2>");
        out.println("<form method='post'>");
        out.println("<button type='submit' name='action' value='create'>Create Test Session</button>");
        out.println("<button type='submit' name='action' value='update'>Update Session Access</button>");
        out.println("<button type='submit' name='action' value='invalidate'>Invalidate Session</button>");
        out.println("</form>");
        
        out.println("</body>");
        out.println("</html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        switch (action) {
            case "create":
                SessionManager.createSession(session, "test", 999);
                break;
            case "update":
                SessionManager.updateSessionAccess(session);
                break;
            case "invalidate":
                SessionManager.invalidateSession(session);
                break;
        }
        
        // Redirect back to GET
        response.sendRedirect("session-test");
    }
} 