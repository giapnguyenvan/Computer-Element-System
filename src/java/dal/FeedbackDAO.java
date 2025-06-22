package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Feedback;

public class FeedbackDAO {

    // Get all feedback for a specific product
    public Vector<Feedback> getFeedbackByProduct(int productId) {
        DBContext db = DBContext.getInstance();
        Vector<Feedback> listFeedback = new Vector<>();
        String sql = "SELECT * FROM feedback WHERE product_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Get all feedback by a specific customer
    public Vector<Feedback> getFeedbackByCustomer(int customerId) {
         DBContext db = DBContext.getInstance();
        Vector<Feedback> listFeedback = new Vector<>();
        String sql = "SELECT * FROM feedback WHERE customer_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, customerId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Add new feedback
    public void insertFeedback(Feedback f) {
         DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO feedback (customer_id, product_id, rating, content) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, f.getCustomer_id());
            ptm.setInt(2, f.getProduct_id());
            ptm.setInt(3, f.getRating());
            ptm.setString(4, f.getContent());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Update existing feedback
    public void updateFeedback(Feedback f) {
         DBContext db = DBContext.getInstance();
        String sql = "UPDATE feedback SET rating = ?, content = ? WHERE feedback_id = ? AND customer_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, f.getRating());
            ptm.setString(2, f.getContent());
            ptm.setInt(3, f.getFeedback_id());
            ptm.setInt(4, f.getCustomer_id());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete feedback
    public void deleteFeedback(int feedbackId, int customerId) {
         DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM feedback WHERE feedback_id = ? AND customer_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ptm.setInt(2, customerId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get average rating for a product
    public double getAverageRating(int productId) {
         DBContext db = DBContext.getInstance();
        String sql = "SELECT AVG(rating) as avg_rating FROM feedback WHERE product_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0.0;
    }

    // Get feedback by ID
    public Feedback getFeedbackById(int feedbackId) {
         DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM feedback WHERE feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Get all feedback with optional pagination
    public Vector<Feedback> getAllFeedback(int page, int pageSize) {
        DBContext db = DBContext.getInstance();
        Vector<Feedback> listFeedback = new Vector<>();
        String sql = "SELECT f.*, c.name as customer_name, c.email as customer_email, p.name as product_name " +
                    "FROM feedback f " +
                    "LEFT JOIN customer c ON f.customer_id = c.customer_id " +
                    "LEFT JOIN product p ON f.product_id = p.product_id " +
                    "ORDER BY f.created_at DESC LIMIT ? OFFSET ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, pageSize);
            ptm.setInt(2, (page - 1) * pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
                f.setCustomerName(rs.getString("customer_name"));
                f.setProductName(rs.getString("product_name"));
                f.setCustomerEmail(rs.getString("customer_email"));
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Get total count of feedback
    public int getTotalFeedbackCount() {
         DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as total FROM feedback";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }


    // Get all feedback with customer information for a specific product
    public Vector<Feedback> getFeedbackWithCustomersByProduct(int productId) {

        DBContext db = DBContext.getInstance();
        Vector<Feedback> listFeedback = new Vector<>();
        String sql = "SELECT f.*, c.name as customer_name FROM feedback f " +
                    "LEFT JOIN customer c ON f.customer_id = c.customer_id " +
                    "WHERE f.product_id = ? " +
                    "ORDER BY f.created_at DESC";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
                f.setCustomerName(rs.getString("customer_name"));
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Check if customer has already given feedback for a product
    public boolean hasCustomerFeedbackForProduct(int customerId, int productId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as count FROM feedback WHERE customer_id = ? AND product_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, customerId);
            ptm.setInt(2, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Get feedback count for a product
    public int getFeedbackCountForProduct(int productId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as count FROM feedback WHERE product_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        FeedbackDAO dao = new FeedbackDAO();
        // Test with product ID 1
        Vector<Feedback> feedbacks = dao.getFeedbackByProduct(1);
        
        System.out.println("Feedbacks for product ID 1:");
        if (feedbacks.isEmpty()) {
            System.out.println("No feedback found for this product.");
        } else {
            for (Feedback f : feedbacks) {
                System.out.println(f.toString());
            }
        }
        
        // Also print the average rating
        double avgRating = dao.getAverageRating(1);
        System.out.println("\nAverage rating for product ID 1: " + avgRating);
    }
} 