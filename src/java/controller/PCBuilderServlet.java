package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PCComponent;
import dal.PCComponentDAO;
import dal.ProductDAO;
import model.Products;
import com.google.gson.Gson;
import java.util.Vector;

@WebServlet(name = "PCBuilderServlet", urlPatterns = {"/PCBuilderServlet"})
public class PCBuilderServlet extends HttpServlet {

    private PCComponentDAO pcComponentDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        pcComponentDAO = new PCComponentDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Check if this is an API call for products
            String action = request.getParameter("action");
            if ("getProducts".equals(action)) {
                handleGetProducts(request, response);
                return;
            }
            
            // Load all component lists
            List<PCComponent> cpuList = pcComponentDAO.getComponentsByType("CPU");
            List<PCComponent> gpuList = pcComponentDAO.getComponentsByType("GPU");
            List<PCComponent> ramList = pcComponentDAO.getComponentsByType("RAM");
            List<PCComponent> motherboardList = pcComponentDAO.getComponentsByType("Motherboard");
            List<PCComponent> storageList = pcComponentDAO.getComponentsByType("Storage");
            List<PCComponent> psuList = pcComponentDAO.getComponentsByType("PSU");

            // Load products by component type from database
            Vector<Products> cpuProducts = productDAO.getProductsByComponentType(1); // CPU
            Vector<Products> mainboardProducts = productDAO.getProductsByComponentType(2); // Mainboard  
            Vector<Products> ramProducts = productDAO.getProductsByComponentType(3); // RAM
            Vector<Products> gpuProducts = productDAO.getProductsByComponentType(4); // GPU
            Vector<Products> storageProducts = productDAO.getProductsByComponentType(5); // Storage
            Vector<Products> psuProducts = productDAO.getProductsByComponentType(6); // PSU
            Vector<Products> caseProducts = productDAO.getProductsByComponentType(7); // Case
            Vector<Products> coolerProducts = productDAO.getProductsByComponentType(8); // Cooler

            // Sử dụng Map để truyền brands và series cho từng componenttype
            Map<String, Vector<String>> brandsMap = new HashMap<>();
            Map<String, Vector<String>> seriesMap = new HashMap<>();
            String[] types = {"CPU", "Mainboard", "RAM", "GPU", "Storage", "PSU", "Case", "Cooler"};
            int[] typeIds = {10, 11, 12, 13, 14, 15, 16, 17}; // Đúng với DB của bạn
            for (int i = 0; i < types.length; i++) {
                brandsMap.put(types[i], productDAO.getBrandsByComponentType(typeIds[i]));
                seriesMap.put(types[i], productDAO.getSeriesByComponentType(typeIds[i]));
            }

            // Set attributes for JSP
            request.setAttribute("cpuList", cpuList);
            request.setAttribute("gpuList", gpuList);
            request.setAttribute("ramList", ramList);
            request.setAttribute("motherboardList", motherboardList);
            request.setAttribute("storageList", storageList);
            request.setAttribute("psuList", psuList);

            // Set product attributes
            request.setAttribute("cpuProducts", cpuProducts);
            request.setAttribute("mainboardProducts", mainboardProducts);
            request.setAttribute("ramProducts", ramProducts);
            request.setAttribute("gpuProducts", gpuProducts);
            request.setAttribute("storageProducts", storageProducts);
            request.setAttribute("psuProducts", psuProducts);
            request.setAttribute("caseProducts", caseProducts);
            request.setAttribute("coolerProducts", coolerProducts);

            // Forward to PC Builder page
            request.getRequestDispatcher("pcBuilder.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in PCBuilderServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading the PC Builder page: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleGetProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String componentType = request.getParameter("componentType");
        String brandFilter = request.getParameter("brand");
        String seriesFilter = request.getParameter("series");
        
        Vector<Products> products = new Vector<>();
        
        // Get products based on component type
        switch (componentType.toLowerCase()) {
            case "cpu":
                products = productDAO.getProductsByComponentType(1);
                break;
            case "mainboard":
                products = productDAO.getProductsByComponentType(2);
                break;
            case "ram":
                products = productDAO.getProductsByComponentType(3);
                break;
            case "gpu":
                products = productDAO.getProductsByComponentType(4);
                break;
            case "storage":
                products = productDAO.getProductsByComponentType(5);
                break;
            case "psu":
                products = productDAO.getProductsByComponentType(6);
                break;
            case "case":
                products = productDAO.getProductsByComponentType(7);
                break;
            case "cooler":
                products = productDAO.getProductsByComponentType(8);
                break;
        }
        
        // Filter by brand if specified
        if (brandFilter != null && !brandFilter.isEmpty()) {
            products = filterProductsByBrand(products, brandFilter);
        }
        
        // Filter by series if specified
        if (seriesFilter != null && !seriesFilter.isEmpty()) {
            products = filterProductsBySeries(products, seriesFilter);
        }
        
        // Convert to JSON and send response
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(products);
        response.getWriter().write(jsonResponse);
    }
    
    private Vector<Products> filterProductsByBrand(Vector<Products> products, String brand) {
        Vector<Products> filtered = new Vector<>();
        for (Products product : products) {
            if (brand.equalsIgnoreCase(product.getBrandName())) {
                filtered.add(product);
            }
        }
        return filtered;
    }
    
    private Vector<Products> filterProductsBySeries(Vector<Products> products, String series) {
        Vector<Products> filtered = new Vector<>();
        for (Products product : products) {
            if (product.getName().toLowerCase().contains(series.toLowerCase())) {
                filtered.add(product);
            }
        }
        return filtered;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get selected components
        String cpuId = request.getParameter("cpu");
        String gpuId = request.getParameter("gpu");
        String ramId = request.getParameter("ram");
        String motherboardId = request.getParameter("motherboard");
        String storageId = request.getParameter("storage");
        String psuId = request.getParameter("psu");

        // Validate selections
        if (cpuId == null || gpuId == null || ramId == null || 
            motherboardId == null || storageId == null || psuId == null) {
            request.setAttribute("error", "Please select all components");
            doGet(request, response);
            return;
        }

        // Get component details
        PCComponent cpu = pcComponentDAO.getComponentById(Integer.parseInt(cpuId));
        PCComponent gpu = pcComponentDAO.getComponentById(Integer.parseInt(gpuId));
        PCComponent ram = pcComponentDAO.getComponentById(Integer.parseInt(ramId));
        PCComponent motherboard = pcComponentDAO.getComponentById(Integer.parseInt(motherboardId));
        PCComponent storage = pcComponentDAO.getComponentById(Integer.parseInt(storageId));
        PCComponent psu = pcComponentDAO.getComponentById(Integer.parseInt(psuId));

        // Calculate total price
        double totalPrice = cpu.getPrice() + gpu.getPrice() + ram.getPrice() + 
                          motherboard.getPrice() + storage.getPrice() + psu.getPrice();

        // Set attributes for the confirmation page
        request.setAttribute("cpu", cpu);
        request.setAttribute("gpu", gpu);
        request.setAttribute("ram", ram);
        request.setAttribute("motherboard", motherboard);
        request.setAttribute("storage", storage);
        request.setAttribute("psu", psu);
        request.setAttribute("totalPrice", totalPrice);

        // Forward to confirmation page
        request.getRequestDispatcher("pcBuilderConfirmation.jsp").forward(request, response);
    }
} 