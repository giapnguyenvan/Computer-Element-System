package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.BlogImage;

public class BlogImageDAO {

    // Get all images for a specific blog
    public Vector<BlogImage> getImagesByBlogId(int blogId) {
        DBContext db = DBContext.getInstance();
        Vector<BlogImage> listImages = new Vector<>();
        String sql = "SELECT * FROM blog_image WHERE blog_id = ? ORDER BY display_order ASC";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                BlogImage img = new BlogImage(
                    rs.getInt("image_id"),
                    rs.getInt("blog_id"),
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
    public BlogImage getImageById(int imageId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM blog_image WHERE image_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, imageId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new BlogImage(
                    rs.getInt("image_id"),
                    rs.getInt("blog_id"),
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

    // Insert new blog image
    public void insertBlogImage(BlogImage image) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO blog_image (blog_id, image_url, image_alt, display_order) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, image.getBlog_id());
            ptm.setString(2, image.getImage_url());
            ptm.setString(3, image.getImage_alt());
            ptm.setInt(4, image.getDisplay_order());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Update existing blog image
    public void updateBlogImage(BlogImage image) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE blog_image SET image_url = ?, image_alt = ?, display_order = ? WHERE image_id = ?";
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

    // Delete blog image
    public void deleteBlogImage(int imageId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM blog_image WHERE image_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, imageId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete all images for a blog
    public void deleteAllImagesByBlogId(int blogId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM blog_image WHERE blog_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get next display order for a blog
    public int getNextDisplayOrder(int blogId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT MAX(display_order) as max_order FROM blog_image WHERE blog_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("max_order") + 1;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 1; // Default to 1 if no images exist
    }

    // Reorder images for a blog
    public void reorderImages(int blogId, Vector<Integer> imageIds) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE blog_image SET display_order = ? WHERE image_id = ? AND blog_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            for (int i = 0; i < imageIds.size(); i++) {
                ptm.setInt(1, i + 1);
                ptm.setInt(2, imageIds.get(i));
                ptm.setInt(3, blogId);
                ptm.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get image count for a blog
    public int getImageCountByBlogId(int blogId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as count FROM blog_image WHERE blog_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
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
        BlogImageDAO dao = new BlogImageDAO();
        
        System.out.println("=== Blog Image DAO Test Cases ===\n");
        
        // Test 1: Get images for blog ID 1
        System.out.println("Test 1: Getting images for blog ID 1");
        Vector<BlogImage> images = dao.getImagesByBlogId(1);
        System.out.println("Found " + images.size() + " images for blog 1");
        for (BlogImage img : images) {
            System.out.println("- " + img.getImage_url() + " (Order: " + img.getDisplay_order() + ")");
        }
        System.out.println();
        
        // Test 2: Get next display order for blog 1
        System.out.println("Test 2: Getting next display order for blog 1");
        int nextOrder = dao.getNextDisplayOrder(1);
        System.out.println("Next display order: " + nextOrder);
        System.out.println();
        
        // Test 3: Get image count for blog 1
        System.out.println("Test 3: Getting image count for blog 1");
        int count = dao.getImageCountByBlogId(1);
        System.out.println("Image count: " + count);
        System.out.println();
        
        // Test 4: Get image by ID (if any images exist)
        if (!images.isEmpty()) {
            System.out.println("Test 4: Getting image by ID");
            BlogImage firstImage = images.get(0);
            BlogImage foundImage = dao.getImageById(firstImage.getImage_id());
            if (foundImage != null) {
                System.out.println("Found image: " + foundImage.getImage_url());
            }
            System.out.println();
        }
    }
} 