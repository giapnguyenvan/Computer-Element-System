package util;

import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class SessionManager {
    
    private static final int SESSION_TIMEOUT_MINUTES = 30; // 30 minutes
    private static final ConcurrentHashMap<String, SessionInfo> activeSessions = new ConcurrentHashMap<>();
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    
    static {
        // Start session cleanup task
        scheduler.scheduleAtFixedRate(SessionManager::cleanupExpiredSessions, 1, 1, TimeUnit.MINUTES);
    }
    
    public static class SessionInfo {
        private final String sessionId;
        private final Date createdAt;
        private Date lastAccessed;
        private final String userType;
        private final int userId;
        
        public SessionInfo(String sessionId, String userType, int userId) {
            this.sessionId = sessionId;
            this.userType = userType;
            this.userId = userId;
            this.createdAt = new Date();
            this.lastAccessed = new Date();
        }
        
        public void updateLastAccessed() {
            this.lastAccessed = new Date();
        }
        
        public boolean isExpired() {
            long currentTime = System.currentTimeMillis();
            long lastAccessTime = lastAccessed.getTime();
            return (currentTime - lastAccessTime) > (SESSION_TIMEOUT_MINUTES * 60 * 1000);
        }
        
        // Getters
        public String getSessionId() { return sessionId; }
        public Date getCreatedAt() { return createdAt; }
        public Date getLastAccessed() { return lastAccessed; }
        public String getUserType() { return userType; }
        public int getUserId() { return userId; }
    }
    
    public static void createSession(HttpSession session, String userType, int userId) {
        String sessionId = session.getId();
        SessionInfo sessionInfo = new SessionInfo(sessionId, userType, userId);
        activeSessions.put(sessionId, sessionInfo);
        
        // Set session timeout
        session.setMaxInactiveInterval(SESSION_TIMEOUT_MINUTES * 60);
    }
    
    public static void updateSessionAccess(HttpSession session) {
        String sessionId = session.getId();
        SessionInfo sessionInfo = activeSessions.get(sessionId);
        if (sessionInfo != null) {
            sessionInfo.updateLastAccessed();
        }
    }
    
    public static void invalidateSession(HttpSession session) {
        String sessionId = session.getId();
        activeSessions.remove(sessionId);
        session.invalidate();
    }
    
    public static void invalidateUserSessions(int userId, String userType) {
        activeSessions.entrySet().removeIf(entry -> {
            SessionInfo info = entry.getValue();
            return info.getUserId() == userId && info.getUserType().equals(userType);
        });
    }
    
    public static boolean isSessionValid(HttpSession session) {
        if (session == null) return false;
        
        String sessionId = session.getId();
        SessionInfo sessionInfo = activeSessions.get(sessionId);
        
        if (sessionInfo == null) return false;
        
        if (sessionInfo.isExpired()) {
            activeSessions.remove(sessionId);
            return false;
        }
        
        // Update last accessed time
        sessionInfo.updateLastAccessed();
        return true;
    }
    
    public static SessionInfo getSessionInfo(HttpSession session) {
        if (session == null) return null;
        return activeSessions.get(session.getId());
    }
    
    public static int getActiveSessionCount() {
        return activeSessions.size();
    }
    
    private static void cleanupExpiredSessions() {
        activeSessions.entrySet().removeIf(entry -> {
            SessionInfo info = entry.getValue();
            return info.isExpired();
        });
    }
    
    public static void shutdown() {
        scheduler.shutdown();
        try {
            if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            scheduler.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
} 