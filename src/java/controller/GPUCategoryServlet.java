package controller;

import dal.ProductDAO;
import java.io.IOException;
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
            int componentTypeId = 4; // GPU

            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }

            int totalProducts = productDAO.getTotalProductsByComponentType(componentTypeId);
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            List<Products> gpuProducts = productDAO.getProductsWithPagingByComponentType(componentTypeId, currentPage, productsPerPage);

            request.setAttribute("gpuProducts", gpuProducts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/GPUCategory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}