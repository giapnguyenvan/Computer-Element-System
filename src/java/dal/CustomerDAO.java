package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import model.Customer;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class CustomerDAO {

    private final DBContext dbContext;

    public CustomerDAO() {
        dbContext = DBContext.getInstance();
    }

    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customer (user_id, name, phone, shipping_address) VALUES (?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customer.getUser_id());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getShipping_address());
            stmt.executeUpdate();
        }
    }

    public void addCustomerWithEmail(Customer customer, String hashedPassword) throws SQLException {
        if (isEmailExists(customer.getEmail())) {
            throw new SQLException("Email already exists: " + customer.getEmail());
        }

        String sql = "INSERT INTO Customer (name, email, password, phone, shipping_address, gender, date_of_birth) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, customer.getPhone());
            stmt.setString(5, customer.getShipping_address());
            stmt.setString(6, customer.getGender());
            if (customer.getDateOfBirth() != null) {
                stmt.setDate(7, new Date(customer.getDateOfBirth().getTime()));
            } else {
                stmt.setNull(7, java.sql.Types.DATE);
            }
            stmt.executeUpdate();
        }
    }

    /**
     * Đăng nhập customer (khách hàng) bằng email và password
     * @param email Email đăng nhập
     * @param password Mật khẩu (dạng plain text, sẽ kiểm tra với hash trong DB)
     * @return Customer nếu đăng nhập thành công, null nếu thất bại
     */
    public Customer login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM Customer WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    // So sánh mật khẩu nhập vào với mật khẩu đã mã hóa trong DB
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        // Tạo đối tượng Customer từ dữ liệu DB
                        Customer customer = new Customer(
                                rs.getInt("customer_id"),
                                0, // user_id không còn dùng
                                rs.getString("name"),
                                rs.getString("phone"),
                                rs.getString("shipping_address"),
                                rs.getBoolean("is_verified")
                        );
                        customer.setEmail(rs.getString("email"));
                        customer.setPassword(hashedPassword);
                        customer.setGender(rs.getString("gender"));
                        java.sql.Date dateOfBirth = rs.getDate("date_of_birth");
                        if (dateOfBirth != null) {
                            customer.setDateOfBirth(new java.util.Date(dateOfBirth.getTime()));
                        }
                        return customer;
                    } else {
                        // Sai mật khẩu
                        return null;
                    }
                }
            }
        }
        return null;
    }

    public Customer getCustomerByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM Customer WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer(
                            rs.getInt("customer_id"),
                            0, // user_id không còn dùng
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("shipping_address")
                    );
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setGender(rs.getString("gender"));
                    java.sql.Date dateOfBirth = rs.getDate("date_of_birth");
                    if (dateOfBirth != null) {
                        customer.setDateOfBirth(new java.util.Date(dateOfBirth.getTime()));
                    }
                    return customer;
                }
            }
        }
        return null;
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM Customer WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean isEmailExistsButNotVerified(String email) throws SQLException {
        String sql = "SELECT email FROM Customer WHERE email = ? AND is_verified = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public java.util.List<Customer> getAllCustomers() throws SQLException {
        java.util.List<Customer> customers = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Customer";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); java.sql.ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("customer_id"),
                        0, // user_id không còn dùng
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("shipping_address")
                );
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setGender(rs.getString("gender"));
                java.sql.Date dateOfBirth = rs.getDate("date_of_birth");
                if (dateOfBirth != null) {
                    customer.setDateOfBirth(new java.util.Date(dateOfBirth.getTime()));
                }
                customers.add(customer);
            }
        }
        return customers;
    }

    public boolean updateIsVerified(String email, boolean isVerified) throws SQLException {
        String sql = "UPDATE Customer SET is_verified = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isVerified);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteUnverifiedCustomer(String email) throws SQLException {
        String sql = "DELETE FROM Customer WHERE email = ? AND is_verified = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateCustomerInfo(String email, String name, String phone, String address, String hashedPassword) throws SQLException {
        String sql = "UPDATE Customer SET name = ?, phone = ?, shipping_address = ?, password = ? WHERE email = ? AND is_verified = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, address);
            stmt.setString(4, hashedPassword);
            stmt.setString(5, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateCustomerInfoWithGenderAndDOB(String email, String name, String phone, String address, String hashedPassword, String gender, java.util.Date dateOfBirth) throws SQLException {
        String sql = "UPDATE Customer SET name = ?, phone = ?, shipping_address = ?, password = ?, gender = ?, date_of_birth = ? WHERE email = ? AND is_verified = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, address);
            stmt.setString(4, hashedPassword);
            stmt.setString(5, gender);
            if (dateOfBirth != null) {
                stmt.setDate(6, new Date(dateOfBirth.getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE);
            }
            stmt.setString(7, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updatePassword(String email, String newPassword) throws SQLException {
        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateEmail(String oldEmail, String newEmail) throws SQLException {
        String sql = "UPDATE customer SET email=? WHERE email=?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newEmail);
            ps.setString(2, oldEmail);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updatePhone(String email, String newPhone) throws SQLException {
        String sql = "UPDATE customer SET phone=? WHERE email=?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPhone);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateName(String email, String newName) throws SQLException {
        String sql = "UPDATE customer SET name = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newName);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateGender(String email, String newGender) throws SQLException {
        String sql = "UPDATE customer SET gender = ? WHERE email = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newGender);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        }
    }

}
