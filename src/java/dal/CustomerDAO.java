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

    // You might want to add more methods here, e.g., getCustomerByUserId, updateCustomer, etc.
} 