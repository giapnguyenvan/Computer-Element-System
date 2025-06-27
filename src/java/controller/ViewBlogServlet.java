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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import java.util.List;
import model.Blog;
import model.Customer;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ViewBlogServlet", urlPatterns={"/viewblogs"})
public class ViewBlogServlet extends HttpServlet {
   
    private static final int PAGE_SIZE = 10; // Number of blogs per page
    private final BlogDAO blogDAO;
    private final CustomerDAO customerDAO;

    public ViewBlogServlet() {
        blogDAO = new BlogDAO();
        customerDAO = new CustomerDAO();
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
            
            // Create a map to store customer information
            Map<Integer, String> customerNames = new HashMap<>();
            
            // Get all customers for lookup
            List<Customer> customerList = customerDAO.getAllCustomers();
            
            // Fetch customer information for each blog
            for (Blog blog : allBlogs) {
                try {
                    int customerId = blog.getCustomer_id();
                    // Get customer by ID and store their name
                    Customer customer = customerList.stream()
                        .filter(c -> c.getCustomer_id() == customerId)
                        .findFirst()
                        .orElse(null);
                    if (customer != null) {
                        customerNames.put(customerId, customer.getName());
                    } else {
                        customerNames.put(customerId, "Unknown Customer");
                    }
                } catch (Exception e) {
                    customerNames.put(blog.getCustomer_id(), "Unknown Customer");
                }
            }
            
            // Store the customer names map in request
            request.setAttribute("customerNames", customerNames);
            
            // Store the full customer list for the add blog form
            request.setAttribute("customerList", customerList);
            
            // Apply search filter if specified
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                Vector<Blog> searchedList = new Vector<>();
                search = search.toLowerCase();
                for (Blog b : allBlogs) {
                    String customerName = customerNames.get(b.getCustomer_id());
                    if (b.getTitle().toLowerCase().contains(search) || 
                        b.getContent().toLowerCase().contains(search) ||
                        (customerName != null && customerName.toLowerCase().contains(search))) {
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
                            String name1 = customerNames.get(b1.getCustomer_id());
                            String name2 = customerNames.get(b2.getCustomer_id());
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
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addBlog(request, response);
            } else if ("delete".equals(action)) {
                // Xử lý xóa blog
                Object authObj = request.getSession().getAttribute("customerAuth");
                if (authObj == null) {
                    request.getSession().setAttribute("error", "You must be logged in to delete a blog.");
                    response.sendRedirect("viewblogs");
                    return;
                }
                int blogId = Integer.parseInt(request.getParameter("blog_id"));
                int customerId = ((model.Customer)authObj).getCustomer_id();
                boolean deleted = blogDAO.deleteBlogById(blogId, customerId);
                if (deleted) {
                    request.getSession().setAttribute("success", "Blog deleted successfully!");
                } else {
                    request.getSession().setAttribute("error", "Failed to delete blog. You can only delete your own blogs.");
                }
                response.sendRedirect("viewblogs");
            } else if ("update".equals(action)) {
                // Xử lý cập nhật blog
                Object authObj = request.getSession().getAttribute("customerAuth");
                if (authObj == null) {
                    request.getSession().setAttribute("error", "You must be logged in to update a blog.");
                    response.sendRedirect("viewblogs");
                    return;
                }
                int blogId = Integer.parseInt(request.getParameter("blog_id"));
                int customerId = ((model.Customer)authObj).getCustomer_id();
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                // Kiểm tra quyền sở hữu
                model.Blog blog = blogDAO.getBlogById(blogId);
                if (blog == null || blog.getCustomer_id() != customerId) {
                    request.getSession().setAttribute("error", "You can only update your own blogs.");
                    response.sendRedirect("viewblogs");
                    return;
                }
                blog.setTitle(title);
                blog.setContent(content);
                blogDAO.updateBlog(blog);
                request.getSession().setAttribute("success", "Blog updated successfully!");
                response.sendRedirect("viewblogs");
            } else {
                processRequest(request, response);
            }
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error: " + ex.getMessage());
            response.sendRedirect("viewblogs");
        }
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
                // Get customer information
                List<Customer> customers = customerDAO.getAllCustomers();
                Customer customer = customers.stream()
                    .filter(c -> c.getCustomer_id() == blog.getCustomer_id())
                    .findFirst()
                    .orElse(null);
                request.setAttribute("blog", blog);
                request.setAttribute("author", customer != null ? customer.getName() : "Unknown Customer");
                
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

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String customerIdStr = request.getParameter("customer_id");
        
        // Validate input
        StringBuilder errors = new StringBuilder();
        if (title == null || title.trim().isEmpty()) errors.append("Title is required. ");
        if (content == null || content.trim().isEmpty()) errors.append("Content is required. ");
        if (customerIdStr == null || customerIdStr.trim().isEmpty()) errors.append("Customer ID is required. ");
        
        if (errors.length() > 0) {
            request.getSession().setAttribute("error", errors.toString());
            response.sendRedirect("viewblogs");
            return;
        }
        
        try {
            int customerId = Integer.parseInt(customerIdStr);
            Blog blog = new Blog(0, title.trim(), content.trim(), customerId, null);
            blogDAO.insertBlog(blog);
            
            request.getSession().setAttribute("success", "Blog created successfully!");
            response.sendRedirect("viewblogs");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid customer ID format.");
            response.sendRedirect("viewblogs");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error creating blog: " + e.getMessage());
            response.sendRedirect("viewblogs");
        }
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // This method is not used in view mode
        response.sendRedirect("viewblogs");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // This method is not used in view mode
        response.sendRedirect("viewblogs");
    }
}
