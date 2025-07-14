package controller;

import dal.ProductDAO;
import dal.CategoryDAO;
import dal.BrandDAO;
import dal.SeriesDAO;
import dal.ProductSpecificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Products;
import model.Category;
import model.Brand;
import model.Series;
import model.ProductSpecification;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;

@WebServlet(name = "ProductEditServlet", urlPatterns = {"/producteditservlet"})
public class ProductEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("id");
        
        if (action == null || productIdStr == null) {
            response.sendRedirect("productservlet?service=viewProduct");
            return;
        }
        
        int productId = Integer.parseInt(productIdStr);
        ProductDAO productDAO = new ProductDAO();
        
        if ("edit".equals(action)) {
            // Handle Edit action
            CategoryDAO categoryDAO = new CategoryDAO();
            BrandDAO brandDAO = new BrandDAO();
            SeriesDAO seriesDAO = new SeriesDAO();
            ProductSpecificationDAO specDAO = new ProductSpecificationDAO();
            
            // Get product details
            Products product = productDAO.getProductById(productId);
            if (product == null) {
                request.setAttribute("errorMsg", "Product not found!");
                request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                return;
            }
            
            // Get all categories, brands, and series for dropdowns
            List<Category> categories = CategoryDAO.getAllCategories();
            List<Brand> brands = brandDAO.getAllBrands();
            List<Series> series = seriesDAO.getAllSeries();
            
            // Get product specifications
            List<ProductSpecification> specifications = specDAO.getSpecificationsByProductId(productId);
            
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("brands", brands);
            request.setAttribute("series", series);
            request.setAttribute("specifications", specifications);
            request.getRequestDispatcher("productDetailAdmin.jsp").forward(request, response);
            
        } else if ("delete".equals(action)) {
            // Handle Delete action
            if (productDAO.deactivateProduct(productId)) {
                request.setAttribute("successMsg", "Product deactivated successfully!");
            } else {
                request.setAttribute("errorMsg", "Failed to deactivate product!");
            }
            response.sendRedirect("productservlet?service=viewProduct");
            
        } else {
            response.sendRedirect("productservlet?service=viewProduct");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            // Handle product update
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            int componentTypeId = Integer.parseInt(request.getParameter("componentTypeId"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            
            String seriesIdStr = request.getParameter("seriesId");
            Integer seriesId = null;
            if (seriesIdStr != null && !seriesIdStr.trim().isEmpty()) {
                seriesId = Integer.parseInt(seriesIdStr);
            }
            
            String model = request.getParameter("model");
            double price = Double.parseDouble(request.getParameter("price"));
            
            String importPriceStr = request.getParameter("importPrice");
            Double importPrice = null;
            if (importPriceStr != null && !importPriceStr.trim().isEmpty()) {
                importPrice = Double.parseDouble(importPriceStr);
            }
            
            int stock = Integer.parseInt(request.getParameter("stock"));
            String sku = request.getParameter("sku");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");
            
            Products product = new Products();
            product.setProductId(productId);
            product.setName(name);
            product.setComponentTypeId(componentTypeId);
            product.setBrandId(brandId);
            product.setSeriesId(seriesId);
            product.setModel(model);
            product.setPrice(price);
            product.setImportPrice(importPrice);
            product.setStock(stock);
            product.setSku(sku);
            product.setDescription(description);
            product.setStatus(status);
            product.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            ProductDAO productDAO = new ProductDAO();
            ProductSpecificationDAO specDAO = new ProductSpecificationDAO();
            
            // Update product
            boolean productUpdated = productDAO.updateProduct(product);
            
            // Update product image
            boolean imageUpdated = true; // Default to true in case no image is provided
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                imageUpdated = productDAO.updateProductImage(productId, imageUrl.trim());
            }
            
            // Handle specifications
            String[] specKeys = request.getParameterValues("specKeys");
            String[] specValues = request.getParameterValues("specValues");
            
            if (specKeys != null && specValues != null) {
                // Delete existing specifications
                specDAO.deleteSpecificationsByProductId(productId);
                
                // Add new specifications
                for (int i = 0; i < specKeys.length; i++) {
                    if (specKeys[i] != null && !specKeys[i].trim().isEmpty() && 
                        specValues[i] != null && !specValues[i].trim().isEmpty()) {
                        ProductSpecification spec = new ProductSpecification();
                        spec.setProductId(productId);
                        spec.setSpecKey(specKeys[i].trim());
                        spec.setSpecValue(specValues[i].trim());
                        specDAO.addSpecification(spec);
                    }
                }
            }
            
            if (productUpdated && imageUpdated) {
                request.setAttribute("successMsg", "Product updated successfully!");
            } else if (!productUpdated) {
                request.setAttribute("errorMsg", "Failed to update product!");
            } else if (!imageUpdated) {
                request.setAttribute("errorMsg", "Product updated but failed to update image!");
            }
            
            // Redirect back to the edit page to show updated data
            response.sendRedirect("producteditservlet?action=edit&id=" + productId);
        } else {
            response.sendRedirect("productservlet?service=viewProduct");
        }
    }
} 