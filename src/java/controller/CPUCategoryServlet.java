package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Products;

public class CPUCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            ProductDAO productDAO = new ProductDAO();
            int productsPerPage = 4;
            int componentTypeId = 1; // CPU

            // Get current page from parameter
            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            // Get total products and calculate total pages
            int totalProducts = productDAO.getTotalProductsByComponentType(componentTypeId);
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

            // Validate current page
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // Get products for current page
            List<Products> cpuProducts = productDAO.getProductsWithPagingByComponentType(componentTypeId, currentPage, productsPerPage);

            // Set attributes
            request.setAttribute("cpuProducts", cpuProducts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Forward to JSP
            request.getRequestDispatcher("/CPUCategory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}