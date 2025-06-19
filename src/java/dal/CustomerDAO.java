package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Customer;

public class CustomerDAO {
    private final DBContext dbContext;

    public CustomerDAO() {
        dbContext = DBContext.getInstance();
    }

    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customer (user_id, name, phone, shipping_address) VALUES (?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customer.getUser_id());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getShipping_address());
            stmt.executeUpdate();
        }
    }

    public Customer login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM Customer WHERE email = ? AND password = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                        rs.getInt("customer_id"),
                        0, // user_id không còn dùng
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("shipping_address")
                    );
                }
            }
        }
        return null;
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM Customer WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // You might want to add more methods here, e.g., getCustomerByUserId, updateCustomer, etc.
} 