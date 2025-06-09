package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Products;

public class GPUCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            ProductDAO productDAO = new ProductDAO();
            int productsPerPage = 4;

            // Get current page from parameter
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            // Get total products and calculate total pages
            int totalProducts = productDAO.getTotalGPUProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

            // Validate current page
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // Get products for current page
            List<Products> gpuProducts = productDAO.getGPUProductsWithPaging(currentPage, productsPerPage);

            // Set attributes
            request.setAttribute("gpuProducts", gpuProducts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Forward to JSP
            request.getRequestDispatcher("/GPUCategory.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
} 