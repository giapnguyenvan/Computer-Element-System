package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.FeedbackImage;

public class FeedbackImageDAO {

    // Get all images for a specific feedback
    public Vector<FeedbackImage> getImagesByFeedbackId(int feedbackId) {
        DBContext db = DBContext.getInstance();
        Vector<FeedbackImage> listImages = new Vector<>();
        String sql = "SELECT * FROM feedback_image WHERE feedback_id = ? ORDER BY display_order ASC";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                FeedbackImage img = new FeedbackImage(
                    rs.getInt("image_id"),
                    rs.getInt("feedback_id"),
                    rs.getString("image_url"),
                    rs.getString("image_alt"),
                    rs.getInt("display_order"),
                    rs.getTimestamp("created_at")
                );
                listImages.add(img);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listImages;
    }

    // Get image by ID
    public FeedbackImage getImageById(int imageId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM feedback_image WHERE image_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, imageId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new FeedbackImage(
                    rs.getInt("image_id"),
                    rs.getInt("feedback_id"),
                    rs.getString("image_url"),
                    rs.getString("image_alt"),
                    rs.getInt("display_order"),
                    rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Insert new feedback image
    public void insertFeedbackImage(FeedbackImage image) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO feedback_image (feedback_id, image_url, image_alt, display_order) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, image.getFeedback_id());
            ptm.setString(2, image.getImage_url());
            ptm.setString(3, image.getImage_alt());
            ptm.setInt(4, image.getDisplay_order());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Update existing feedback image
    public void updateFeedbackImage(FeedbackImage image) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE feedback_image SET image_url = ?, image_alt = ?, display_order = ? WHERE image_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, image.getImage_url());
            ptm.setString(2, image.getImage_alt());
            ptm.setInt(3, image.getDisplay_order());
            ptm.setInt(4, image.getImage_id());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete feedback image
    public void deleteFeedbackImage(int imageId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM feedback_image WHERE image_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, imageId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete all images for a feedback
    public void deleteAllImagesByFeedbackId(int feedbackId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM feedback_image WHERE feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get next display order for a feedback
    public int getNextDisplayOrder(int feedbackId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT MAX(display_order) as max_order FROM feedback_image WHERE feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("max_order") + 1;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 1; // Default to 1 if no images exist
    }

    // Reorder images for a feedback
    public void reorderImages(int feedbackId, Vector<Integer> imageIds) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE feedback_image SET display_order = ? WHERE image_id = ? AND feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            for (int i = 0; i < imageIds.size(); i++) {
                ptm.setInt(1, i + 1);
                ptm.setInt(2, imageIds.get(i));
                ptm.setInt(3, feedbackId);
                ptm.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get image count for a feedback
    public int getImageCountByFeedbackId(int feedbackId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as count FROM feedback_image WHERE feedback_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, feedbackId);
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
        FeedbackImageDAO dao = new FeedbackImageDAO();
        
        System.out.println("=== Feedback Image DAO Test Cases ===\n");
        
        // Test 1: Get images for feedback ID 1
        System.out.println("Test 1: Getting images for feedback ID 1");
        Vector<FeedbackImage> images = dao.getImagesByFeedbackId(1);
        System.out.println("Found " + images.size() + " images for feedback 1");
        for (FeedbackImage img : images) {
            System.out.println("- " + img.getImage_url() + " (Order: " + img.getDisplay_order() + ")");
        }
        System.out.println();
        
        // Test 2: Get next display order for feedback 1
        System.out.println("Test 2: Getting next display order for feedback 1");
        int nextOrder = dao.getNextDisplayOrder(1);
        System.out.println("Next display order: " + nextOrder);
        System.out.println();
        
        // Test 3: Get image count for feedback 1
        System.out.println("Test 3: Getting image count for feedback 1");
        int count = dao.getImageCountByFeedbackId(1);
        System.out.println("Image count: " + count);
        System.out.println();
        
        // Test 4: Get image by ID (if any images exist)
        if (!images.isEmpty()) {
            System.out.println("Test 4: Getting image by ID");
            FeedbackImage firstImage = images.get(0);
            FeedbackImage foundImage = dao.getImageById(firstImage.getImage_id());
            if (foundImage != null) {
                System.out.println("Found image: " + foundImage.getImage_url());
            }
            System.out.println();
        }
    }
} 