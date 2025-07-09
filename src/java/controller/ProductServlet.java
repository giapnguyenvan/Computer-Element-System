/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.util.List;
import model.Products;
import dal.ProductDAO;
import model.Category;
import dal.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import dal.FeedbackDAO;
import model.Feedback;

@WebServlet(name = "ProductServlet", urlPatterns = {"/productservlet"})
public class ProductServlet extends HttpServlet {

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String service = request.getParameter("service");
        ProductDAO dao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();
        List<Products> plist;
        List<Category> clist = cdao.getAllCategories();
        List<String> brands = dao.getAllBrands();

        if (service != null) {
            switch (service) {
                case "viewProduct":
                    plist = dao.getAllProduct();
                    request.setAttribute("product", plist);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;

                case "productDetail":
                    int productID = Integer.parseInt(request.getParameter("id"));
                    int page = 1;
                    final int ITEMS_PER_PAGE = 3;

                    try {
                        page = Integer.parseInt(request.getParameter("page"));
                        if (page < 1) {
                            page = 1;
                        }
                    } catch (NumberFormatException e) {
                        // Keep page as 1 if not specified or invalid
                    }

                    Products product = dao.getProductById(productID);
                    if (product == null) {
                        request.setAttribute("errorMsg", "Không tìm thấy sản phẩm hoặc sản phẩm đã bị xóa!");
                        request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                        break;
                    }
                    List<Products> relatedProducts = dao.getProductsWithPagingByComponentType(product.getComponentTypeId(), 1, 5);

                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    List<Feedback> allFeedback = feedbackDAO.getFeedbackWithCustomersByProduct(productID);
                    if (allFeedback == null) {
                        allFeedback = new ArrayList<>();
                    }

                    int totalFeedback = allFeedback.size();
                    int totalPages = (int) Math.ceil((double) totalFeedback / ITEMS_PER_PAGE);

                    int startIdx = (page - 1) * ITEMS_PER_PAGE;
                    int endIdx = Math.min(startIdx + ITEMS_PER_PAGE, totalFeedback);
                    List<Feedback> paginatedFeedback = new ArrayList<>();
                    if (!allFeedback.isEmpty()) {
                        for (int i = startIdx; i < endIdx; i++) {
                            paginatedFeedback.add(allFeedback.get(i));
                        }
                    }

                    double averageRating = 0;
                    if (totalFeedback > 0) {
                        double sum = 0;
                        for (Feedback f : allFeedback) {
                            sum += f.getRating();
                        }
                        averageRating = sum / totalFeedback;
                    }

                    request.setAttribute("product", product);
                    request.setAttribute("relatedProducts", relatedProducts);
                    request.setAttribute("feedbackList", paginatedFeedback);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("averageRating", averageRating);
                    request.setAttribute("totalFeedback", totalFeedback);
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                    break;

                case "productDetailAdmin":
                    int productIDAdmin = Integer.parseInt(request.getParameter("id"));
                    Products productAdmin = dao.getProductById(productIDAdmin);
                    if (productAdmin == null) {
                        request.setAttribute("errorMsg", "Product not found!");
                        request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                        break;
                    }
                    request.setAttribute("product", productAdmin);
                    request.getRequestDispatcher("productDetailAdmin.jsp").forward(request, response);
                    break;

                default:
                    response.sendRedirect("productservlet?service=viewProduct");
                    break;
            }
        } else {
            response.sendRedirect("productservlet?service=viewProduct");
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}