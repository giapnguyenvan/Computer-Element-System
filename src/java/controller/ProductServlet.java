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
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import dal.FeedbackDAO;
import model.Feedback;

/**
 *
 * @author nghia
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/productservlet"})
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");
        ProductDAO dao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();
        List<Products> plist;
        List<Category> clist = cdao.getAllCategories();
        List<String> brands = dao.getAllBrands();

        if (service != null) {
            switch (service) {
                case "viewProduct":
                    if (sortBy == null || sortBy.equals("none")) {
                        sortBy = "id"; // default sorting by product ID
                    }

                    if (order == null || order.equals("none")) {
                        order = "asc"; // default order is ascending
                    }
                    plist = dao.getSortedProducts(sortBy, order);

                    request.setAttribute("product", plist);
                    request.setAttribute("brand", brands);
                    request.setAttribute("category", clist);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;
                case "insertProduct":
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String name = request.getParameter("name");
                        String brand = request.getParameter("brand");
                        String categoryIdRaw = request.getParameter("category_id");
                        String priceRaw = request.getParameter("price");
                        String stockRaw = request.getParameter("stock");
                        String imageUrl = request.getParameter("image_url");
                        String description = request.getParameter("description");
                        String specDescription = request.getParameter("spec_description");
                        String status = request.getParameter("status");

                        String errorMsg = "";

                        // Validation
                        if (name == null || name.trim().isEmpty() || name.length() > 255) {
                            errorMsg += "Tên sản phẩm không hợp lệ.<br/>";
                        }
                        if (brand == null || brand.trim().isEmpty() || brand.length() > 255) {
                            errorMsg += "Thương hiệu không hợp lệ.<br/>";
                        }

                        int categoryID = -1;
                        try {
                            categoryID = Integer.parseInt(categoryIdRaw);
                        } catch (NumberFormatException e) {
                            errorMsg += "Danh mục không hợp lệ.<br/>";
                        }

                        double price = -1;
                        try {
                            price = Double.parseDouble(priceRaw);
                            if (price < 0) {
                                throw new NumberFormatException();
                            }
                        } catch (NumberFormatException e) {
                            errorMsg += "Giá không hợp lệ.<br/>";
                        }

                        int stock = -1;
                        try {
                            stock = Integer.parseInt(stockRaw);
                            if (stock < 0) {
                                throw new NumberFormatException();
                            }
                        } catch (NumberFormatException e) {
                            errorMsg += "Số lượng tồn kho không hợp lệ.<br/>";
                        }

                        if (imageUrl == null || imageUrl.trim().isEmpty() || imageUrl.length() > 1000) {
                            errorMsg += "URL ảnh không hợp lệ.<br/>";
                        }

                        if (description == null || description.trim().isEmpty() || description.length() > 1000) {
                            errorMsg += "Mô tả không hợp lệ.<br/>";
                        }

                        if (status == null || (!status.equals("Active") && !status.equals("Inactive"))) {
                            errorMsg += "Trạng thái sản phẩm không hợp lệ.<br/>";
                        }

                        if (!errorMsg.isEmpty()) {
                            request.setAttribute("errorMsg", errorMsg);
                            request.setAttribute("brand", brands);
                            request.setAttribute("category", clist);
                            request.setAttribute("product", dao.getAllProduct());
                            request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                            return;
                        }

                        // Insert nếu hợp lệ
                        Products newProduct = new Products(
                                0, name.trim(), brand.trim(), categoryID, price, stock,
                                imageUrl.trim(), description.trim(),
                                specDescription != null ? specDescription.trim() : "", status
                        );
                        dao.insertProduct(newProduct);
                        response.sendRedirect("productservlet?service=viewProduct");
                    } else {
                        request.getRequestDispatcher("insertProduct.jsp").forward(request, response);
                    }
                    break;
                case "updateProduct":
                    if (request.getParameter("id") != null && request.getParameter("name") == null) {
                        int productID = Integer.parseInt(request.getParameter("id"));

                        ProductDAO pdao = new ProductDAO();
                        Products product = pdao.getProductById(productID);

                        request.setAttribute("product", product);
                        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
                    } else {
                        // Update product data from form submission
                        int id = Integer.parseInt(request.getParameter("id"));
                        String name = request.getParameter("name");
                        String brand = request.getParameter("brand");
                        int category_id = Integer.parseInt(request.getParameter("category_id"));
                        double price = Double.parseDouble(request.getParameter("price"));
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        String image_url = request.getParameter("image_url");
                        String description = request.getParameter("description");
                        String spec_description = request.getParameter("spec_description");
                        String status = request.getParameter("status");

                        Products updatedProduct = new Products(id, name, brand, category_id, price, stock, image_url, description, spec_description, status);
                        dao.updateProduct(updatedProduct);

                        response.sendRedirect("productservlet?service=viewProduct");
                    }
                    break;
                case "filterProducts":
                    String brand = request.getParameter("brand"); // can be null or empty
                    String categoryIdRaw = request.getParameter("category_id");

                    CategoryDAO categoryDAO = new CategoryDAO();
                    ProductDAO productDAO = new ProductDAO();

                    List<Products> productl = null; // final product list
                    Category category = null;

                    if (categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
                        int categoryId = Integer.parseInt(categoryIdRaw);
                        category = categoryDAO.getCategoryById(categoryId); // get category details
                        productl = productDAO.getProductByCategory(categoryId);
                    } else {
                        // No category filter, get all products initially
                        productl = productDAO.getSortedProducts(sortBy, order);
                    }

                    // Apply brand filter if specified and productList is not null
                    if (brand != null && !brand.isEmpty() && productl != null) {
                        List<Products> filteredByBrand = new ArrayList<>();
                        for (Products p : productl) {
                            if (brand.equals(p.getBrand())) {
                                filteredByBrand.add(p);
                            }
                        }
                        productl = filteredByBrand;
                    }

                    // Set attributes for display
                    request.setAttribute("product", productl);
                    request.setAttribute("brand", brands);
                    request.setAttribute("category", clist);
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

                    ProductDAO ppdao = new ProductDAO();
                    Products product = ppdao.getProductById(productID);
                    List<Products> relatedProducts = ppdao.getProductByCategory(product.getCategory_id());

                    // Get feedback data
                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    List<Feedback> allFeedback = feedbackDAO.getFeedbackWithUsersByProduct(productID);

                    // Calculate total pages
                    int totalFeedback = allFeedback.size();
                    int totalPages = (int) Math.ceil((double) totalFeedback / ITEMS_PER_PAGE);

                    // Get paginated feedback
                    int startIdx = (page - 1) * ITEMS_PER_PAGE;
                    int endIdx = Math.min(startIdx + ITEMS_PER_PAGE, totalFeedback);
                    List<Feedback> paginatedFeedback = new ArrayList<>();

                    for (int i = startIdx; i < endIdx; i++) {
                        paginatedFeedback.add(allFeedback.get(i));
                    }

                    // Calculate average rating
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
                    request.setAttribute("averageRating", String.format("%.1f", averageRating));
                    request.setAttribute("totalFeedback", totalFeedback);
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                    break;
                default:
                    service = "viewProduct";
                    break;
            }
        } else {
            response.sendRedirect("productservlet?service=viewProduct");
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
