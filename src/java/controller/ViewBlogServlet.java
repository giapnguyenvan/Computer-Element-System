/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Vector;
import java.util.List;
import model.Blog;
import model.BlogImage;
import model.Customer;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import dal.MenuItemDAO;
import model.MenuItem;
import dal.UserDAO;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ViewBlogServlet", urlPatterns={"/viewblogs"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ViewBlogServlet extends HttpServlet {
   
    private static final int PAGE_SIZE = 10; // Number of blogs per page
    private final BlogDAO blogDAO;
    private final UserDAO userDAO;

    public ViewBlogServlet() {
        blogDAO = new BlogDAO();
        userDAO = UserDAO.getInstance();
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
            // Get all blogs first (we'll filter and sort them in memory)
            Vector<Blog> allBlogs = blogDAO.getAllBlogs(1, Integer.MAX_VALUE);
            
            // Create a map to store user information
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
            
            // Lấy menu động
            List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
            request.setAttribute("menuItems", menuItems);
            
            // Forward to JSP
            request.getRequestDispatcher("viewblogs.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching blogs: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
                listBlogs(request, response);
            } else if (action.equals("view")) {
                viewBlog(request, response);
            } else {
                response.sendRedirect("viewblogs");
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("viewblogs.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "ViewBlog Servlet";
    }// </editor-fold>

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    private void viewBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.getBlogById(blogId);
            
            if (blog != null) {
                User user = userDAO.getUserById(blog.getUser_id());
                String fullName = user != null ? userDAO.getFullname(blog.getUser_id(), user.getRole()) : null;
                String author = (fullName != null && !fullName.isEmpty()) ? fullName : (user != null ? user.getUsername() : "Unknown User");
                request.setAttribute("blog", blog);
                request.setAttribute("author", author);
                
                // Forward to the view blog page
                request.getRequestDispatcher("viewblogs.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Blog not found");
                response.sendRedirect(request.getContextPath() + "/viewblogs");
            }
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error viewing blog: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/viewblogs");
        }
    }


}
