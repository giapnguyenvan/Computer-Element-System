package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Feedback;
import model.FeedbackImage;

public class FeedbackDAO {
    private FeedbackImageDAO feedbackImageDAO;

    public FeedbackDAO() {
        this.feedbackImageDAO = new FeedbackImageDAO();
    }

    // Get all feedback for a specific product with images
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
                // Load images for this feedback
                Vector<FeedbackImage> images = feedbackImageDAO.getImagesByFeedbackId(f.getFeedback_id());
                f.setImages(images);
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Get all feedback by a specific customer with images
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
                // Load images for this feedback
                Vector<FeedbackImage> images = feedbackImageDAO.getImagesByFeedbackId(f.getFeedback_id());
                f.setImages(images);
                listFeedback.add(f);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listFeedback;
    }

    // Add new feedback with images
    public int insertFeedback(Feedback f) {
         DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO feedback (customer_id, product_id, rating, content) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ptm.setInt(1, f.getCustomer_id());
            ptm.setInt(2, f.getProduct_id());
            ptm.setInt(3, f.getRating());
            ptm.setString(4, f.getContent());
            ptm.executeUpdate();
            
            // Get the generated feedback ID
            ResultSet rs = ptm.getGeneratedKeys();
            if (rs.next()) {
                int feedbackId = rs.getInt(1);
                
                // Insert images if any
                if (f.getImages() != null && !f.getImages().isEmpty()) {
                    for (FeedbackImage image : f.getImages()) {
                        image.setFeedback_id(feedbackId);
                        if (image.getDisplay_order() == 0) {
                            image.setDisplay_order(feedbackImageDAO.getNextDisplayOrder(feedbackId));
                        }
                        feedbackImageDAO.insertFeedbackImage(image);
                    }
                }
                
                return feedbackId;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    // Update existing feedback with images
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
            
            // Update images if provided
            if (f.getImages() != null) {
                // Delete existing images
                feedbackImageDAO.deleteAllImagesByFeedbackId(f.getFeedback_id());
                
                // Insert new images
                for (FeedbackImage image : f.getImages()) {
                    image.setFeedback_id(f.getFeedback_id());
                    if (image.getDisplay_order() == 0) {
                        image.setDisplay_order(feedbackImageDAO.getNextDisplayOrder(f.getFeedback_id()));
                    }
                    feedbackImageDAO.insertFeedbackImage(image);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete feedback and its images
    public void deleteFeedback(int feedbackId, int customerId) {
         DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM feedback WHERE feedback_id = ? AND customer_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ptm.setInt(2, customerId);
            ptm.executeUpdate();
            
            // Delete associated images (CASCADE should handle this, but we'll do it explicitly)
            feedbackImageDAO.deleteAllImagesByFeedbackId(feedbackId);
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

    // Get feedback by ID with images
    public Feedback getFeedbackById(int feedbackId) {
         DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM feedback WHERE feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Feedback f = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("product_id"),
                    rs.getInt("rating"),
                    rs.getString("content"),
                    rs.getString("created_at")
                );
                // Load images for this feedback
                Vector<FeedbackImage> images = feedbackImageDAO.getImagesByFeedbackId(f.getFeedback_id());
                f.setImages(images);
                return f;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Get all feedback with optional pagination and images
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
                
                // Load images for this feedback
                Vector<FeedbackImage> images = feedbackImageDAO.getImagesByFeedbackId(f.getFeedback_id());
                f.setImages(images);
                
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

    // Get all feedback with customer information for a specific product with images
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
                
                // Load images for this feedback
                Vector<FeedbackImage> images = feedbackImageDAO.getImagesByFeedbackId(f.getFeedback_id());
                f.setImages(images);
                
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

    // Add image to feedback
    public void addImageToFeedback(int feedbackId, String imageUrl, String imageAlt) {
        FeedbackImage image = new FeedbackImage(0, feedbackId, imageUrl, imageAlt, 
                                              feedbackImageDAO.getNextDisplayOrder(feedbackId), null);
        feedbackImageDAO.insertFeedbackImage(image);
    }

    // Remove image from feedback
    public void removeImageFromFeedback(int imageId) {
        feedbackImageDAO.deleteFeedbackImage(imageId);
    }

    // Reorder images for a feedback
    public void reorderFeedbackImages(int feedbackId, Vector<Integer> imageIds) {
        feedbackImageDAO.reorderImages(feedbackId, imageIds);
    }

    public static void main(String[] args) {
        FeedbackDAO dao = new FeedbackDAO();
        
        System.out.println("=== Feedback DAO Test Cases ===\n");
        
        // Test 1: Insert a new feedback with images
        System.out.println("Test 1: Adding new feedback with images");
        Feedback newFeedback = new Feedback(
            0,  // ID will be auto-generated
            1,  // customer_id
            1,  // product_id
            5,  // rating
            "This is a test feedback for product 1 with images",
            java.time.LocalDateTime.now().toString()
        );
        
        // Add some test images
        newFeedback.addImage(new FeedbackImage(0, 0, "/assets/images/feedback/test1.jpg", "Test Image 1", 1, null));
        newFeedback.addImage(new FeedbackImage(0, 0, "/assets/images/feedback/test2.jpg", "Test Image 2", 2, null));
        
        int feedbackId = dao.insertFeedback(newFeedback);
        System.out.println("Added new feedback with ID: " + feedbackId);
        System.out.println();
        
        // Test 2: Get feedback by product
        System.out.println("Test 2: Getting feedback for product 1");
        Vector<Feedback> productFeedbacks = dao.getFeedbackByProduct(1);
        System.out.println("Feedback count for product 1: " + productFeedbacks.size());
        for (Feedback f : productFeedbacks) {
            System.out.println(f.toString() + " (Images: " + f.getImages().size() + ")");
        }
        System.out.println();
        
        // Test 3: Get feedback by customer
        System.out.println("Test 3: Getting feedback for customer 1");
        Vector<Feedback> customerFeedbacks = dao.getFeedbackByCustomer(1);
        System.out.println("Feedback count for customer 1: " + customerFeedbacks.size());
        for (Feedback f : customerFeedbacks) {
            System.out.println(f.toString() + " (Images: " + f.getImages().size() + ")");
        }
        System.out.println();
        
        // Test 4: Get feedback by ID
        if (!productFeedbacks.isEmpty()) {
            System.out.println("Test 4: Getting feedback by ID");
            Feedback firstFeedback = productFeedbacks.get(0);
            Feedback foundFeedback = dao.getFeedbackById(firstFeedback.getFeedback_id());
            if (foundFeedback != null) {
                System.out.println("Found feedback: " + foundFeedback.getContent());
                System.out.println("Number of images: " + foundFeedback.getImages().size());
            }
            System.out.println();
        }
        
        // Test 5: Get average rating
        double avgRating = dao.getAverageRating(1);
        System.out.println("Test 5: Average rating for product 1: " + avgRating);
        System.out.println();
        
        // Test 6: Get feedback count
        int feedbackCount = dao.getFeedbackCountForProduct(1);
        System.out.println("Test 6: Feedback count for product 1: " + feedbackCount);
        System.out.println();
        
        // Test 7: Check if customer has feedback
        boolean hasFeedback = dao.hasCustomerFeedbackForProduct(1, 1);
        System.out.println("Test 7: Customer 1 has feedback for product 1: " + hasFeedback);
        System.out.println();
    }
} 