package dal;

import java.sql.*;
import java.util.*;
import model.Voucher;

public class VoucherDAO {

    private final DBContext dbContext;

    public VoucherDAO() {
        dbContext = DBContext.getInstance();
    }

    public Voucher getVoucherByCode(String code) {
        String sql = "SELECT * FROM voucher WHERE code = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractVoucher(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Voucher> getAllVouchers() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM voucher";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(extractVoucher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertVoucher(Voucher v) {
        String sql = "INSERT INTO voucher (code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, v.getCode());
            stmt.setString(2, v.getDescription());
            stmt.setString(3, v.getDiscount_type());
            stmt.setBigDecimal(4, v.getDiscount_value());
            stmt.setBigDecimal(5, v.getMin_order_amount());
            if (v.getMax_uses() != null) {
                stmt.setInt(6, v.getMax_uses());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }
            if (v.getMax_uses_per_user() != null) {
                stmt.setInt(7, v.getMax_uses_per_user());
            } else {
                stmt.setNull(7, Types.INTEGER);
            }
            stmt.setTimestamp(8, v.getStart_date());
            stmt.setTimestamp(9, v.getEnd_date());
            stmt.setString(10, v.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVoucher(Voucher v) {
        String sql = "UPDATE voucher SET description=?, discount_type=?, discount_value=?, min_order_amount=?, max_uses=?, max_uses_per_user=?, start_date=?, end_date=?, status=? WHERE code=?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, v.getDescription());
            stmt.setString(2, v.getDiscount_type());
            stmt.setBigDecimal(3, v.getDiscount_value());
            stmt.setBigDecimal(4, v.getMin_order_amount());
            if (v.getMax_uses() != null) {
                stmt.setInt(5, v.getMax_uses());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            if (v.getMax_uses_per_user() != null) {
                stmt.setInt(6, v.getMax_uses_per_user());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }
            stmt.setTimestamp(7, v.getStart_date());
            stmt.setTimestamp(8, v.getEnd_date());
            stmt.setString(9, v.getStatus());
            stmt.setString(10, v.getCode());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVoucher(String code) {
        String sql = "DELETE FROM voucher WHERE code = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Voucher extractVoucher(ResultSet rs) throws SQLException {
        return new Voucher(
                rs.getInt("voucher_id"),
                rs.getString("code"),
                rs.getString("description"),
                rs.getString("discount_type"),
                rs.getBigDecimal("discount_value"),
                rs.getBigDecimal("min_order_amount"),
                rs.getObject("max_uses") != null ? rs.getInt("max_uses") : null,
                rs.getObject("max_uses_per_user") != null ? rs.getInt("max_uses_per_user") : null,
                rs.getTimestamp("start_date"),
                rs.getTimestamp("end_date"),
                rs.getString("status")
        );
    }

    public List<Voucher> getCustomerVoucher(int customerId) throws SQLException {
        List<Voucher> list = new ArrayList<>();
        String sql =
            "SELECT v.* " +
            "FROM voucher v " +
            "JOIN voucher_usage vu ON v.voucher_id = vu.voucher_id " +
            "WHERE vu.customer_id = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucher_id(rs.getInt("voucher_id"));
                v.setCode(rs.getString("code"));
                v.setDescription(rs.getString("description"));
                v.setDiscount_type(rs.getString("discount_type"));
                v.setDiscount_value(rs.getBigDecimal("discount_value"));
                v.setMin_order_amount(rs.getBigDecimal("min_order_amount"));
                v.setMax_uses((Integer) rs.getObject("max_uses")); // nullable
                v.setMax_uses_per_user((Integer) rs.getObject("max_uses_per_user")); // nullable
                v.setStart_date(rs.getTimestamp("start_date"));
                v.setEnd_date(rs.getTimestamp("end_date"));
                v.setStatus(rs.getString("status"));
                list.add(v);
            }
        }

        return list;
    }

    /**
     * Auto-update voucher statuses based on current time and usage.
     * - Set to 'Expired' if end_date < now
     * - Set to 'Inactive' if max_uses is reached
     * - Otherwise, set to 'Active'
     */
    public void autoUpdateVoucherStatuses() {
        String selectSql = "SELECT voucher_id, start_date, end_date, max_uses, status FROM voucher";
        String usageSql = "SELECT COUNT(*) FROM voucher_usage WHERE voucher_id = ?";
        String updateSql = "UPDATE voucher SET status = ? WHERE voucher_id = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             ResultSet rs = selectStmt.executeQuery()) {
            while (rs.next()) {
                int voucherId = rs.getInt("voucher_id");
                Timestamp startDate = rs.getTimestamp("start_date");
                Timestamp endDate = rs.getTimestamp("end_date");
                Integer maxUses = rs.getObject("max_uses") != null ? rs.getInt("max_uses") : null;
                String currentStatus = rs.getString("status");
                String newStatus = currentStatus;
                Timestamp now = new Timestamp(System.currentTimeMillis());
                if (endDate != null && endDate.before(now)) {
                    newStatus = "Expired";
                } else if (startDate != null && startDate.after(now)) {
                    newStatus = "Inactive";
                } else if (maxUses != null) {
                    // Check usage count
                    try (PreparedStatement usageStmt = conn.prepareStatement(usageSql)) {
                        usageStmt.setInt(1, voucherId);
                        ResultSet usageRs = usageStmt.executeQuery();
                        if (usageRs.next()) {
                            int usageCount = usageRs.getInt(1);
                            if (usageCount >= maxUses) {
                                newStatus = "Inactive";
                            } else {
                                newStatus = "Active";
                            }
                        }
                    }
                } else {
                    // No max uses, not expired, not in the future
                    newStatus = "Active";
                }
                // Only update if status changed
                if (!newStatus.equals(currentStatus)) {
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setString(1, newStatus);
                        updateStmt.setInt(2, voucherId);
                        updateStmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
