/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.util.Vector;
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
        ProductDAO dao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();
        Vector<Products> plist;
        ArrayList<Category> clist = cdao.getAllCategories();
        Vector<String> brands = dao.getAllBrands();

        if (service != null) {
            switch (service) {
                case "viewProduct":
                    String sortBy = request.getParameter("sortBy");
                    String order = request.getParameter("order");

                    if (sortBy == null || order == null || order.equals("none")) {
                        plist = dao.getAllProductWithCategoryName();
                    } else {
                        plist = dao.getSortedProduct(sortBy, order);
                    }

                    request.setAttribute("product", plist);
                    request.setAttribute("brand", brands);
                    request.setAttribute("category", clist);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;
                case "insertProduct":
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String name = request.getParameter("name");
                        String brand = request.getParameter("brand");
                        int categoryID = Integer.parseInt(request.getParameter("category_id"));
                        double price = Double.parseDouble(request.getParameter("price"));
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        String imageUrl = request.getParameter("image_url");
                        String description = request.getParameter("description");
                        String specDescription = request.getParameter("spec_description");
                        String status = request.getParameter("status");

                        // Assuming your constructor matches the order and types of your new fields
                        Products newProduct = new Products(
                                0, // id (auto-increment or generated elsewhere)
                                name,
                                brand,
                                categoryID,
                                price,
                                stock,
                                imageUrl,
                                description,
                                specDescription,
                                status
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
                case "searchProduct":
                    String keyword = request.getParameter("keyword");
                    Vector<Products> result;
                    Vector<Products> productList;
                    if (keyword == null || keyword.trim().isEmpty()) {
                        // Return all products if keyword is empty
                        result = dao.getAllProduct();
                    } else {
                        // Otherwise, perform search
                        result = dao.searchProduct(keyword.trim());
                    }
                    request.setAttribute("brand", brands);
                    request.setAttribute("category", clist);
                    request.setAttribute("product", result);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;
                /*case "filterByBrand":
                    String brand = request.getParameter("brand");
                    Vector<Products> blist = dao.getProductByBrand(brand);

                    request.setAttribute("product", blist);            // Đặt danh sách sản phẩm
                    request.setAttribute("brand", brands);             // Danh sách brand để đổ dropdown
                    request.setAttribute("category", clist);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;

                case "filterByCategory":
                    String categoryIdRaw = request.getParameter("category_id");
                    int categoryId = Integer.parseInt(categoryIdRaw);
                    Vector<Products> categoryList = dao.getProductByCategory(categoryId);

                    request.setAttribute("product", categoryList);      // Đặt danh sách sản phẩm
                    request.setAttribute("brand", brands);              // Danh sách brand để đổ dropdown
                    request.setAttribute("category", clist);            // Danh sách category để đổ dropdown
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                    break;*/
                case "filterProducts":
                    String brand = request.getParameter("brand"); // can be null or empty
                    String categoryIdRaw = request.getParameter("category_id");

                    CategoryDAO categoryDAO = new CategoryDAO();
                    ProductDAO productDAO = new ProductDAO();

                    Vector<Products> productl = null; // final product list
                    Category category = null;

                    if (categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
                        int categoryId = Integer.parseInt(categoryIdRaw);
                        category = categoryDAO.getCategoryById(categoryId); // get category details
                        productl = productDAO.getProductByCategory(categoryId);
                    } else {
                        // No category filter, get all products initially
                        productl = productDAO.getAllProduct();
                    }

                    // Apply brand filter if specified and productList is not null
                    if (brand != null && !brand.isEmpty() && productl != null) {
                        Vector<Products> filteredByBrand = new Vector<>();
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
                        if (page < 1) page = 1;
                    } catch (NumberFormatException e) {
                        // Keep page as 1 if not specified or invalid
                    }

                    ProductDAO ppdao = new ProductDAO();
                    Products product = ppdao.getProductById(productID);
                    Vector<Products> relatedProducts = ppdao.getProductByCategory(product.getCategory_id());

                    // Get feedback data
                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    Vector<Feedback> allFeedback = feedbackDAO.getFeedbackWithUsersByProduct(productID);
                    
                    // Calculate total pages
                    int totalFeedback = allFeedback.size();
                    int totalPages = (int) Math.ceil((double) totalFeedback / ITEMS_PER_PAGE);
                    
                    // Get paginated feedback
                    int startIdx = (page - 1) * ITEMS_PER_PAGE;
                    int endIdx = Math.min(startIdx + ITEMS_PER_PAGE, totalFeedback);
                    Vector<Feedback> paginatedFeedback = new Vector<>();
                    
                    for (int i = startIdx; i < endIdx; i++) {
                        paginatedFeedback.add(allFeedback.get(i));
                    }
                    
                    // Calculate average rating
                    double averageRating = 0;
                    if (!allFeedback.isEmpty()) {
                        double totalRating = 0;
                        for (Feedback f : allFeedback) {
                            totalRating += f.getRating();
                        }
                        averageRating = totalRating / allFeedback.size();
                    }

                    // Set attributes for JSP
                    request.setAttribute("product", product);
                    request.setAttribute("relatedProducts", relatedProducts);
                    request.setAttribute("feedbackList", paginatedFeedback);
                    request.setAttribute("totalFeedback", totalFeedback);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("averageRating", averageRating);
                    
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
