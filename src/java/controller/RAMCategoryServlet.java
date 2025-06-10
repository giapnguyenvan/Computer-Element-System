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

        // Số sản phẩm trên mỗi trang
        int productsPerPage = 4;

        // Lấy trang hiện tại từ parameter, mặc định là trang 1
        int currentPage = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }

        // Lấy tổng số sản phẩm RAM
        int totalProducts = productDAO.getTotalRAMProducts();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        // Lấy danh sách sản phẩm cho trang hiện tại
        List<Products> ramProducts = productDAO.getRAMProductsWithPaging(currentPage, productsPerPage);

        // Set attributes để sử dụng trong JSP
        request.setAttribute("ramProducts", ramProducts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Forward to the JSP page
        request.getRequestDispatcher("RAMCategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 