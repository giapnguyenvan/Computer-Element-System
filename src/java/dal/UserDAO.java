package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO {
    private static UserDAO instance;
    private final DBContext dbContext;
    
    private UserDAO() {
        dbContext = DBContext.getInstance();
    }
    
    public static synchronized UserDAO getInstance() {
        if (instance == null) {
            instance = new UserDAO();
        }
        return instance;
    }
    
    public User login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getString("name"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address")
                    );
                }
            }
        }
        return null;
    }
    
    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, password, phone_number, address, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
                    
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFullname());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getRole());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM users WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
    
    public boolean updatePassword(String email, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getString("name"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address")
                    );
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
                "Peter Jones",  // fullname
                "peterj_admin@example.com", // email
                "0987654321",  // phone
                "100 Admin Road, District 5, HCMC" // address
            );
            register(adminUser);
        }
    }
}