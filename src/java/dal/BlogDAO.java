package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Blog;
import model.BlogImage;

public class BlogDAO {
    private BlogImageDAO blogImageDAO;

    public BlogDAO() {
        this.blogImageDAO = new BlogImageDAO();
    }

    // Get all blogs with pagination and images
    public Vector<Blog> getAllBlogs(int page, int pageSize) {
        DBContext db = DBContext.getInstance();
        Vector<Blog> listBlogs = new Vector<>();
        String sql = "SELECT * FROM blog ORDER BY created_at DESC LIMIT ? OFFSET ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, pageSize);
            ptm.setInt(2, (page - 1) * pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog(
                    rs.getInt("blog_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("created_at")
                );
                // Load images for this blog
                Vector<BlogImage> images = blogImageDAO.getImagesByBlogId(b.getBlog_id());
                b.setImages(images);
                listBlogs.add(b);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listBlogs;
    }

    // Get blog by ID with images
    public Blog getBlogById(int blogId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM blog WHERE blog_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Blog b = new Blog(
                    rs.getInt("blog_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("created_at")
                );
                // Load images for this blog
                Vector<BlogImage> images = blogImageDAO.getImagesByBlogId(b.getBlog_id());
                b.setImages(images);
                return b;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Get blogs by user ID with images
    public Vector<Blog> getBlogsByUser(int userId) {
        DBContext db = DBContext.getInstance();
        Vector<Blog> listBlogs = new Vector<>();
        String sql = "SELECT * FROM blog WHERE user_id = ? ORDER BY created_at DESC";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, userId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog(
                    rs.getInt("blog_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("created_at")
                );
                // Load images for this blog
                Vector<BlogImage> images = blogImageDAO.getImagesByBlogId(b.getBlog_id());
                b.setImages(images);
                listBlogs.add(b);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listBlogs;
    }

    // Insert new blog with images
    public int insertBlog(Blog b) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO blog (title, content, user_id) VALUES (?, ?, ?)";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ptm.setString(1, b.getTitle());
            ptm.setString(2, b.getContent());
            ptm.setInt(3, b.getUser_id());
            ptm.executeUpdate();
            
            // Get the generated blog ID
            ResultSet rs = ptm.getGeneratedKeys();
            if (rs.next()) {
                int blogId = rs.getInt(1);
                
                // Insert images if any
                if (b.getImages() != null && !b.getImages().isEmpty()) {
                    for (BlogImage image : b.getImages()) {
                        image.setBlog_id(blogId);
                        if (image.getDisplay_order() == 0) {
                            image.setDisplay_order(blogImageDAO.getNextDisplayOrder(blogId));
                        }
                        blogImageDAO.insertBlogImage(image);
                    }
                }
                
                return blogId;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    // Update existing blog with images
    public void updateBlog(Blog b) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE blog SET title = ?, content = ? WHERE blog_id = ? AND user_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, b.getTitle());
            ptm.setString(2, b.getContent());
            ptm.setInt(3, b.getBlog_id());
            ptm.setInt(4, b.getUser_id());
            ptm.executeUpdate();
            
            // Update images if provided
            if (b.getImages() != null) {
                // Delete existing images
                blogImageDAO.deleteAllImagesByBlogId(b.getBlog_id());
                
                // Insert new images
                for (BlogImage image : b.getImages()) {
                    image.setBlog_id(b.getBlog_id());
                    if (image.getDisplay_order() == 0) {
                        image.setDisplay_order(blogImageDAO.getNextDisplayOrder(b.getBlog_id()));
                    }
                    blogImageDAO.insertBlogImage(image);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Delete blog and its images
    public void deleteBlog(int blogId, int userId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM blog WHERE blog_id = ? AND user_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ptm.setInt(2, userId);
            ptm.executeUpdate();
            
            // Delete associated images (CASCADE should handle this, but we'll do it explicitly)
            blogImageDAO.deleteAllImagesByBlogId(blogId);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Get total count of blogs
    public int getTotalBlogCount() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) as total FROM blog";
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

    // Search blogs by title with images
    public Vector<Blog> searchBlogsByTitle(String searchTerm, int page, int pageSize) {
        DBContext db = DBContext.getInstance();
        Vector<Blog> listBlogs = new Vector<>();
        String sql = "SELECT * FROM blog WHERE title LIKE ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, "%" + searchTerm + "%");
            ptm.setInt(2, pageSize);
            ptm.setInt(3, (page - 1) * pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog(
                    rs.getInt("blog_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("created_at")
                );
                // Load images for this blog
                Vector<BlogImage> images = blogImageDAO.getImagesByBlogId(b.getBlog_id());
                b.setImages(images);
                listBlogs.add(b);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listBlogs;
    }

    // Delete blog by blogId and userId
    public boolean deleteBlogById(int blogId, int userId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM blog WHERE blog_id = ? AND user_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, blogId);
            ptm.setInt(2, userId);
            int affected = ptm.executeUpdate();
            
            if (affected > 0) {
                // Delete associated images
                blogImageDAO.deleteAllImagesByBlogId(blogId);
            }
            
            return affected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Add image to blog
    public void addImageToBlog(int blogId, String imageUrl, String imageAlt) {
        BlogImage image = new BlogImage(0, blogId, imageUrl, imageAlt, 
                                      blogImageDAO.getNextDisplayOrder(blogId), null);
        blogImageDAO.insertBlogImage(image);
    }

    // Remove image from blog
    public void removeImageFromBlog(int imageId) {
        blogImageDAO.deleteBlogImage(imageId);
    }

    // Reorder images for a blog
    public void reorderBlogImages(int blogId, Vector<Integer> imageIds) {
        blogImageDAO.reorderImages(blogId, imageIds);
    }

    public static void main(String[] args) {
        BlogDAO dao = new BlogDAO();
        
        System.out.println("=== Blog DAO Test Cases ===\n");
        
        // Test 1: Insert a new blog with images
        System.out.println("Test 1: Inserting a new blog with images");
        Blog newBlog = new Blog(0, "Test Blog with Images", "This is a test blog content with images", 1, null);
        
        // Add some test images
        newBlog.addImage(new BlogImage(0, 0, "/assets/assets/images/blog/test1.jpg", "Test Image 1", 1, null));
        newBlog.addImage(new BlogImage(0, 0, "/assets/assets/images/blog/test2.jpg", "Test Image 2", 2, null));
        
        int blogId = dao.insertBlog(newBlog);
        System.out.println("Blog inserted with ID: " + blogId);
        System.out.println();
        
        // Test 2: Get all blogs and count
        System.out.println("Test 2: Getting all blogs (page 1, 5 items per page)");
        Vector<Blog> blogs = dao.getAllBlogs(1, 5);
        System.out.println("Total blogs in database: " + dao.getTotalBlogCount());
        System.out.println("Blogs on first page:");
        for (Blog b : blogs) {
            System.out.println("- " + b.getTitle() + " (ID: " + b.getBlog_id() + ", Images: " + b.getImages().size() + ")");
        }
        System.out.println();
        
        // Test 3: Get blog by ID (using first blog from previous test)
        if (!blogs.isEmpty()) {
            System.out.println("Test 3: Getting blog by ID");
            int testBlogId = blogs.get(0).getBlog_id();
            Blog foundBlog = dao.getBlogById(testBlogId);
            if (foundBlog != null) {
                System.out.println("Found blog: " + foundBlog.getTitle());
                System.out.println("Number of images: " + foundBlog.getImages().size());
                
                // Test 4: Update blog
                System.out.println("\nTest 4: Updating blog");
                foundBlog.setTitle("Updated Blog Title with Images");
                foundBlog.setContent("This content has been updated with images");
                dao.updateBlog(foundBlog);
                
                // Verify update
                Blog updatedBlog = dao.getBlogById(testBlogId);
                System.out.println("Updated blog title: " + updatedBlog.getTitle());
            }
            System.out.println();
        }
        
        // Test 5: Get blogs by user
        System.out.println("Test 5: Getting blogs by user ID 1");
        Vector<Blog> userBlogs = dao.getBlogsByUser(1);
        System.out.println("User has " + userBlogs.size() + " blogs");
        for (Blog b : userBlogs) {
            System.out.println("- " + b.getTitle() + " (Images: " + b.getImages().size() + ")");
        }
        System.out.println();
        
        // Test 6: Search blogs
        System.out.println("Test 6: Searching blogs by title");
        Vector<Blog> searchResults = dao.searchBlogsByTitle("Test", 1, 10);
        System.out.println("Found " + searchResults.size() + " blogs matching 'Test'");
        for (Blog b : searchResults) {
            System.out.println("- " + b.getTitle() + " (Images: " + b.getImages().size() + ")");
        }
        System.out.println();
    }
} 