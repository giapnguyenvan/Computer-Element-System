package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import java.util.Vector;

public class UserDAO {
    // Singleton pattern để dùng chung một instance UserDAO
    private static UserDAO instance;
    private final DBContext dbContext;
    
    public UserDAO() {
        dbContext = DBContext.getInstance();
    }
    
    public static synchronized UserDAO getInstance() {
        if (instance == null) {
            instance = new UserDAO();
        }
        return instance;
    }
    
    /**
     * Đăng nhập user (Staff/Admin) bằng email và password
     * @param email Email đăng nhập
     * @param password Mật khẩu (chưa mã hóa)
     * @return User nếu đăng nhập thành công, null nếu thất bại
     */
    public User login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM User WHERE email = ? AND password = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Tạo đối tượng User từ dữ liệu DB
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getBoolean("is_verified")
                    );
                }
            }
        }
        return null;
    }
    
    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO User (username, password, email, role, status, is_verified) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());
            stmt.setString(5, "Active");
            stmt.setBoolean(6, true);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM User WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
    
    public boolean updatePassword(String email, String newPassword) throws SQLException {
        String sql = "UPDATE User SET password = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM User WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getBoolean("is_verified")
                    );
                }
            }
        }
        return null;
    }

    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM User WHERE user_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getBoolean("is_verified")
                    );
                }
            }
        }
        return null;
    }

    public Vector<User> getAllUsers() throws SQLException {
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM User ORDER BY username";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("email"),
                    rs.getBoolean("is_verified")
                );
                users.add(user);
            }
        }
        return users;
    }

    public User getUserByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM User WHERE username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getBoolean("is_verified")
                    );
                    return user;
                }
            }
        }
        return null;
    }

    // Method to insert admin user Peter Jones
    public void insertAdminUser() throws SQLException {
        // Check if admin already exists
        if (!isEmailExists("peterj_admin@example.com")) {
            User adminUser = new User(
                "Peter Jones",  // username
                "abc123123",    // password
                "admin",        // role
                "peterj_admin@example.com"
            );
            adminUser.setVerified(true);
            register(adminUser);
        }
    }

    public String getFullname(int userId, String role) throws SQLException {
        String tableName = "";
        if ("Admin".equalsIgnoreCase(role)) {
            tableName = "admin";
        } else if ("Staff".equalsIgnoreCase(role)) {
            tableName = "staff";
        } else {
            return null; // Không phải vai trò có tên đầy đủ
        }

        String sql = String.format("SELECT name FROM %s WHERE user_id = ?", tableName);
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        }
        return null;
    }

    // Cập nhật trạng thái xác thực tài khoản
    public boolean updateIsVerified(String email, boolean isVerified) throws SQLException {
        String sql = "UPDATE User SET is_verified = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isVerified);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        }
    }

}