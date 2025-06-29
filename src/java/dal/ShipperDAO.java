package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.util.Date;
import model.Shipper;

public class ShipperDAO {
    private final DBContext dbContext;

    public ShipperDAO() {
        dbContext = DBContext.getInstance();
    }

    public void addShipper(Shipper shipper) throws SQLException {
        String sql = "INSERT INTO shipper (name, phone, email, vehicle_number, vehicle_type, status, current_location, join_date, rating, total_deliveries) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, shipper.getName());
            stmt.setString(2, shipper.getPhone());
            stmt.setString(3, shipper.getEmail());
            stmt.setString(4, shipper.getVehicle_number());
            stmt.setString(5, shipper.getVehicle_type());
            stmt.setString(6, shipper.getStatus());
            stmt.setString(7, shipper.getCurrent_location());
            stmt.setDate(8, new java.sql.Date(shipper.getJoin_date().getTime()));
            stmt.setBigDecimal(9, shipper.getRating());
            stmt.setInt(10, shipper.getTotal_deliveries());
            stmt.executeUpdate();
        }
    }

    public Shipper getShipperById(int shipperId) throws SQLException {
        String sql = "SELECT * FROM shipper WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, shipperId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShipper(rs);
                }
            }
        }
        return null;
    }

    public Shipper getShipperByPhone(String phone) throws SQLException {
        String sql = "SELECT * FROM shipper WHERE phone = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phone);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShipper(rs);
                }
            }
        }
        return null;
    }

    public Shipper getShipperByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM shipper WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShipper(rs);
                }
            }
        }
        return null;
    }

    public List<Shipper> getAllShippers() throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper ORDER BY shipper_id";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                shippers.add(mapResultSetToShipper(rs));
            }
        }
        return shippers;
    }

    public List<Shipper> getActiveShippers() throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper WHERE status = 'Active' ORDER BY rating DESC, total_deliveries DESC";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                shippers.add(mapResultSetToShipper(rs));
            }
        }
        return shippers;
    }

    public List<Shipper> getAvailableShippers() throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper WHERE status = 'Active' ORDER BY rating DESC, total_deliveries DESC";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                shippers.add(mapResultSetToShipper(rs));
            }
        }
        return shippers;
    }

    public List<Shipper> getShippersByVehicleType(String vehicleType) throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper WHERE vehicle_type = ? AND status = 'Active' ORDER BY rating DESC";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, vehicleType);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    shippers.add(mapResultSetToShipper(rs));
                }
            }
        }
        return shippers;
    }

    public boolean updateShipper(Shipper shipper) throws SQLException {
        String sql = "UPDATE shipper SET name = ?, phone = ?, email = ?, vehicle_number = ?, vehicle_type = ?, status = ?, current_location = ?, rating = ?, total_deliveries = ? WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, shipper.getName());
            stmt.setString(2, shipper.getPhone());
            stmt.setString(3, shipper.getEmail());
            stmt.setString(4, shipper.getVehicle_number());
            stmt.setString(5, shipper.getVehicle_type());
            stmt.setString(6, shipper.getStatus());
            stmt.setString(7, shipper.getCurrent_location());
            stmt.setBigDecimal(8, shipper.getRating());
            stmt.setInt(9, shipper.getTotal_deliveries());
            stmt.setInt(10, shipper.getShipper_id());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateShipperStatus(int shipperId, String status) throws SQLException {
        String sql = "UPDATE shipper SET status = ? WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, shipperId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateShipperLocation(int shipperId, String location) throws SQLException {
        String sql = "UPDATE shipper SET current_location = ? WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, location);
            stmt.setInt(2, shipperId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateShipperRating(int shipperId, BigDecimal rating) throws SQLException {
        String sql = "UPDATE shipper SET rating = ? WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBigDecimal(1, rating);
            stmt.setInt(2, shipperId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean incrementDeliveryCount(int shipperId) throws SQLException {
        String sql = "UPDATE shipper SET total_deliveries = total_deliveries + 1 WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, shipperId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteShipper(int shipperId) throws SQLException {
        String sql = "DELETE FROM shipper WHERE shipper_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, shipperId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean isPhoneExists(String phone) throws SQLException {
        String sql = "SELECT phone FROM shipper WHERE phone = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phone);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM shipper WHERE email = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public List<Shipper> searchShippersByName(String name) throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper WHERE name LIKE ? ORDER BY name";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + name + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    shippers.add(mapResultSetToShipper(rs));
                }
            }
        }
        return shippers;
    }

    public List<Shipper> getTopRatedShippers(int limit) throws SQLException {
        List<Shipper> shippers = new ArrayList<>();
        String sql = "SELECT * FROM shipper WHERE status = 'Active' ORDER BY rating DESC, total_deliveries DESC LIMIT ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    shippers.add(mapResultSetToShipper(rs));
                }
            }
        }
        return shippers;
    }

    private Shipper mapResultSetToShipper(ResultSet rs) throws SQLException {
        Shipper shipper = new Shipper();
        shipper.setShipper_id(rs.getInt("shipper_id"));
        shipper.setName(rs.getString("name"));
        shipper.setPhone(rs.getString("phone"));
        shipper.setEmail(rs.getString("email"));
        shipper.setVehicle_number(rs.getString("vehicle_number"));
        shipper.setVehicle_type(rs.getString("vehicle_type"));
        shipper.setStatus(rs.getString("status"));
        shipper.setCurrent_location(rs.getString("current_location"));
        shipper.setJoin_date(rs.getDate("join_date"));
        shipper.setRating(rs.getBigDecimal("rating"));
        shipper.setTotal_deliveries(rs.getInt("total_deliveries"));
        return shipper;
    }
} 