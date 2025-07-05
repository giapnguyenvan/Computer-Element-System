package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Products;

@WebServlet(name = "RAMCategoryServlet", urlPatterns = {"/RAMCategoryServlet"})
public class RAMCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();

        int productsPerPage = 4;
        int componentTypeId = 3; // RAM

        int currentPage = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }

        int totalProducts = productDAO.getTotalProductsByComponentType(componentTypeId);
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        List<Products> ramProducts = productDAO.getProductsWithPagingByComponentType(componentTypeId, currentPage, productsPerPage);

        request.setAttribute("ramProducts", ramProducts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("RAMCategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}