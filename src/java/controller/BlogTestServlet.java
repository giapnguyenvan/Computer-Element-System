package controller;

import dal.BlogDAO;
import dal.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import java.util.List;
import model.Blog;
import model.Customer;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name="BlogTestServlet", urlPatterns={"/blog-test"})
public class BlogTestServlet extends HttpServlet {
   
    private final BlogDAO blogDAO;
    private final CustomerDAO customerDAO;

    public BlogTestServlet() {
        blogDAO = new BlogDAO();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Get all blogs with images
            Vector<Blog> allBlogs = blogDAO.getAllBlogs(1, Integer.MAX_VALUE);
            
            // Create a map to store customer information
            Map<Integer, String> customerNames = new HashMap<>();
            
            // Get all customers for lookup
            List<Customer> customerList = customerDAO.getAllCustomers();
            
            // Fetch customer information for each blog
            for (Blog blog : allBlogs) {
                try {
                    int customerId = blog.getCustomer_id();
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
            
            // Set attributes for the JSP
            request.setAttribute("blogList", allBlogs);
            request.setAttribute("customerNames", customerNames);
            
            // Forward to test JSP
            request.getRequestDispatcher("blog-test.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching blogs: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
} 