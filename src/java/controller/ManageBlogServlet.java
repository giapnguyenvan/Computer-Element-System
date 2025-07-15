/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.util.Vector;
import java.util.List;
import model.Blog;
import model.User;
import model.BlogImage;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Collection;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ManageBlogServlet", urlPatterns={"/manageblogs"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ManageBlogServlet extends HttpServlet {
   
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10; // Number of blogs per page
    private final BlogDAO blogDAO;
    private final UserDAO userDAO = UserDAO.getInstance();

    public ManageBlogServlet() {
        blogDAO = new BlogDAO();
    }

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Get all blogs
            Vector<Blog> allBlogs = blogDAO.getAllBlogs(1, Integer.MAX_VALUE);
            
            // Create a map to store user names
            Map<Integer, String> userNames = new HashMap<>();
            
            // Fetch user information for each blog
            for (Blog blog : allBlogs) {
                try {
                    int userId = blog.getUser_id();
                    User user = userDAO.getUserById(userId);
                    String fullName = user != null ? userDAO.getFullname(userId, user.getRole()) : null;
                    if (fullName != null && !fullName.isEmpty()) {
                        userNames.put(userId, fullName);
                    } else if (user != null) {
                        userNames.put(userId, user.getUsername());
                    } else {
                        userNames.put(userId, "Unknown User");
                    }
                } catch (Exception e) {
                    userNames.put(blog.getUser_id(), "Unknown User");
                }
            }
            
            // Store the user names map in request
            request.setAttribute("userNames", userNames);
            
            // Add this: get all users for author dropdown
            Vector<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            
            // Apply search filter if specified
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                Vector<Blog> searchedList = new Vector<>();
                search = search.toLowerCase();
                for (Blog b : allBlogs) {
                    String userName = userNames.get(b.getUser_id());
                    if (b.getTitle().toLowerCase().contains(search) || 
                        b.getContent().toLowerCase().contains(search) ||
                        (userName != null && userName.toLowerCase().contains(search))) {
                        searchedList.add(b);
                    }
                }
                allBlogs = searchedList;
            }
            
            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "newest":
                        Collections.sort(allBlogs, (b1, b2) -> {
                            if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                            return b2.getCreated_at().compareTo(b1.getCreated_at());
                        });
                        break;
                    case "oldest":
                        Collections.sort(allBlogs, (b1, b2) -> {
                            if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                            return b1.getCreated_at().compareTo(b2.getCreated_at());
                        });
                        break;
                    case "title":
                        Collections.sort(allBlogs, (b1, b2) -> 
                            b1.getTitle().compareToIgnoreCase(b2.getTitle()));
                        break;
                    case "author":
                        Collections.sort(allBlogs, (b1, b2) -> {
                            String name1 = userNames.get(b1.getUser_id());
                            String name2 = userNames.get(b2.getUser_id());
                            return name1.compareToIgnoreCase(name2);
                        });
                        break;
                }
            } else {
                // Default sort by newest
                Collections.sort(allBlogs, (b1, b2) -> {
                    if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                    return b2.getCreated_at().compareTo(b1.getCreated_at());
                });
            }
            
            // Calculate pagination
            int totalBlogs = allBlogs.size();
            int totalPages = (int) Math.ceil((double) totalBlogs / PAGE_SIZE);
            
            // Get page number from request
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
            } catch (NumberFormatException e) {
                // Keep page as 1 if not specified or invalid
            }
            
            // Apply pagination to filtered and sorted results
            Vector<Blog> pagedBlogs = new Vector<>();
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalBlogs);
            
            for (int i = startIndex; i < endIndex; i++) {
                pagedBlogs.add(allBlogs.get(i));
            }
            
            // Set attributes for the JSP
            request.setAttribute("blogList", pagedBlogs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBlogs", totalBlogs);
            
            // Forward to JSP
            request.getRequestDispatcher("ManageBlog.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching blogs: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                processRequest(request, response);
            } else if (action.equals("view")) {
                viewBlog(request, response);
            } else {
                processRequest(request, response);
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("ManageBlog.jsp").forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addBlog(request, response);
                    break;
                case "update":
                    updateBlog(request, response);
                    break;
                case "delete":
                    // Xử lý xóa blog
                    Object authObj = request.getSession().getAttribute("userAuth");
                    if (authObj == null) {
                        request.getSession().setAttribute("error", "You must be logged in to delete a blog.");
                        response.sendRedirect("manageblogs");
                        return;
                    }
                    int blogId = Integer.parseInt(request.getParameter("blog_id"));
                    deleteBlogWithImages(request, response, blogId);
                    break;
                default:
                    response.sendRedirect("manageblogs");
                    break;
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("ManageBlog.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "ManageBlog Servlet handles displaying and managing blogs";
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int page = 1;
        int pageSize = PAGE_SIZE;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            // Keep default page value
        }
        Vector<Blog> blogs = blogDAO.getAllBlogs(page, pageSize);
        int totalBlogs = blogDAO.getTotalBlogCount();
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);
        request.setAttribute("blogList", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        // Add this: get all users for author dropdown
        try {
            Vector<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
        } catch (java.sql.SQLException e) {
            request.setAttribute("error", "Error loading user list: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("ManageBlog.jsp").forward(request, response);
    }

    private void viewBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.getBlogById(blogId);
            
            if (blog != null) {
                // Get user information
                User user = userDAO.getUserById(blog.getUser_id());
                String fullName = user != null ? userDAO.getFullname(blog.getUser_id(), user.getRole()) : null;
                request.setAttribute("blog", blog);
                request.setAttribute("author", fullName != null ? fullName : "Unknown User");
                
                // Forward to the manage blog page with the modal open
                request.getRequestDispatcher("ManageBlog.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Blog not found");
                response.sendRedirect(request.getContextPath() + "/manageblogs");
            }
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error viewing blog: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        }
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Object authObj = request.getSession().getAttribute("userAuth");
        StringBuilder errors = new StringBuilder();
        if (title == null || title.trim().isEmpty()) errors.append("Title is required. ");
        if (content == null || content.trim().isEmpty()) errors.append("Content is required. ");
        if (authObj == null) errors.append("You must be logged in to add a blog. ");
        if (errors.length() > 0) {
            request.getSession().setAttribute("error", errors.toString());
            response.sendRedirect(request.getContextPath() + "/manageblogs");
            return;
        }
        try {
            int userId = ((model.User)authObj).getId();
            Blog blog = new Blog(0, title.trim(), content.trim(), userId, null);
            int blogId = blogDAO.insertBlog(blog);
            
            // Handle file uploads
            if (blogId > 0) {
                try {
                    dal.BlogImageDAO blogImageDAO = new dal.BlogImageDAO();
                    Collection<Part> fileParts = request.getParts();
                    
                    for (Part filePart : fileParts) {
                        if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                            String fileName = getSubmittedFileName(filePart);
                            if (fileName != null && !fileName.isEmpty()) {
                                // Generate unique filename
                                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                                String uniqueFileName = System.currentTimeMillis() + "_" + blogId + fileExtension;
                                String uploadPath = "IMG/blog/" + uniqueFileName;
                                
                                // Save file to server
                                String realPath = getServletContext().getRealPath(uploadPath);
                                java.io.File uploadDir = new java.io.File(realPath).getParentFile();
                                if (!uploadDir.exists()) {
                                    boolean created = uploadDir.mkdirs();
                                    if (!created) {
                                        System.err.println("Failed to create directory: " + uploadDir.getAbsolutePath());
                                    }
                                }
                                System.out.println("Saving image to: " + realPath);
                                try {
                                    filePart.write(realPath);
                                } catch (Exception ex) {
                                    System.err.println("Failed to save image file: " + realPath);
                                    ex.printStackTrace();
                                }
                                
                                // Save image info to database
                                BlogImage blogImage = new BlogImage(0, blogId, uploadPath, fileName, 0, null);
                                blogImageDAO.insertBlogImage(blogImage);
                            }
                        }
                    }
                } catch (Exception e) {
                    // Log error but don't fail the blog creation
                    System.err.println("Error uploading images: " + e.getMessage());
                }
            }
            
            request.getSession().setAttribute("success", "Blog added successfully!");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid user ID format.");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        }
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String userIdStr = request.getParameter("user_id");
        StringBuilder errors = new StringBuilder();
        if (idStr == null || idStr.trim().isEmpty()) errors.append("Blog ID is required. ");
        if (title == null || title.trim().isEmpty()) errors.append("Title is required. ");
        if (content == null || content.trim().isEmpty()) errors.append("Content is required. ");
        if (userIdStr == null || userIdStr.trim().isEmpty()) errors.append("User ID is required. ");
        if (errors.length() > 0) {
            request.getSession().setAttribute("error", errors.toString());
            response.sendRedirect(request.getContextPath() + "/manageblogs");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            int userId = Integer.parseInt(userIdStr);
            Blog blog = new Blog(id, title.trim(), content.trim(), userId, null);
            blogDAO.updateBlog(blog);
            
            // Handle file uploads for update
            try {
                dal.BlogImageDAO blogImageDAO = new dal.BlogImageDAO();
                Collection<Part> fileParts = request.getParts();
                
                for (Part filePart : fileParts) {
                    if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                        String fileName = getSubmittedFileName(filePart);
                        if (fileName != null && !fileName.isEmpty()) {
                            // Generate unique filename
                            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                            String uniqueFileName = System.currentTimeMillis() + "_" + id + fileExtension;
                            String uploadPath = "IMG/blog/" + uniqueFileName;
                            
                            // Save file to server
                            String realPath = getServletContext().getRealPath(uploadPath);
                            java.io.File uploadDir = new java.io.File(realPath).getParentFile();
                            if (!uploadDir.exists()) {
                                boolean created = uploadDir.mkdirs();
                                if (!created) {
                                    System.err.println("Failed to create directory: " + uploadDir.getAbsolutePath());
                                }
                            }
                            System.out.println("Saving image to: " + realPath);
                            try {
                                filePart.write(realPath);
                            } catch (Exception ex) {
                                System.err.println("Failed to save image file: " + realPath);
                                ex.printStackTrace();
                            }
                            
                            // Save image info to database
                            BlogImage blogImage = new BlogImage(0, id, uploadPath, fileName, 0, null);
                            blogImageDAO.insertBlogImage(blogImage);
                        }
                    }
                }
            } catch (Exception e) {
                // Log error but don't fail the blog update
                System.err.println("Error uploading images: " + e.getMessage());
            }
            
            request.getSession().setAttribute("success", "Blog updated successfully!");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid ID format.");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        }
    }

    private void deleteBlogWithImages(HttpServletRequest request, HttpServletResponse response, int blogId)
    throws ServletException, IOException {
        try {
            dal.BlogImageDAO blogImageDAO = new dal.BlogImageDAO();
            
            // Step 1: Get all images associated with the blog
            java.util.Vector<model.BlogImage> images = blogImageDAO.getImagesByBlogId(blogId);
            
            // Step 2: Delete image files from the server
            for (model.BlogImage img : images) {
                if (img.getImage_url() != null && (img.getImage_url().startsWith("/blog/") || img.getImage_url().startsWith("IMG/blog/"))) {
                    String realPath = getServletContext().getRealPath(img.getImage_url());
                    java.io.File file = new java.io.File(realPath);
                    if (file.exists()) {
                        boolean fileDeleted = file.delete();
                        if (!fileDeleted) {
                            System.err.println("Failed to delete image file: " + realPath);
                        }
                    }
                }
            }
            
            // Step 3: Delete image records from database
            blogImageDAO.deleteAllImagesByBlogId(blogId);
            
            // Step 4: Delete the blog itself
            boolean blogDeleted = blogDAO.deleteBlogById(blogId);
            
            if (blogDeleted) {
                request.getSession().setAttribute("success", "Blog and associated images deleted successfully!");
            } else {
                request.getSession().setAttribute("error", "Failed to delete blog.");
            }
            
            response.sendRedirect("manageblogs");
            
        } catch (Exception e) {
            System.err.println("Error deleting blog with images: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error deleting blog: " + e.getMessage());
            response.sendRedirect("manageblogs");
        }
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));
            dal.BlogImageDAO blogImageDAO = new dal.BlogImageDAO();
            java.util.Vector<model.BlogImage> images = blogImageDAO.getImagesByBlogId(id);
            blogDAO.deleteBlog(id, userId);
            for (model.BlogImage img : images) {
                if (img.getImage_url() != null && (img.getImage_url().startsWith("/blog/") || img.getImage_url().startsWith("IMG/blog/"))) {
                    String realPath = getServletContext().getRealPath(img.getImage_url());
                    java.io.File file = new java.io.File(realPath);
                    if (file.exists()) file.delete();
                }
            }
            request.getSession().setAttribute("success", "Blog deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid ID format.");
            response.sendRedirect(request.getContextPath() + "/manageblogs");
        }
    }
    
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
} 