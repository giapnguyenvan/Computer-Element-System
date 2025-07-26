package shop.controller.rest;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// No change needed, all imports are present. The error was likely a false positive or due to a stale build. If error persists, try cleaning and rebuilding the project.
import java.io.IOException;
import java.util.List;
import model.Products;
import dal.ProductDAO;

@WebServlet(name = "ProductApiServlet", urlPatterns = {"/ProductApiServlet"})
public class ProductApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        String componentType = request.getParameter("componentType");
        List<Products> products;
        ProductDAO dao = new ProductDAO();
        if (componentType != null && !componentType.isEmpty()) {
            int componentTypeId = ProductDAO.getComponentTypeIdByName(componentType);
            if (componentTypeId != -1) {
                products = dao.getProductsByComponentType(componentTypeId);
            } else {
                // Log lỗi componentType không hợp lệ
                System.err.println("[ProductApiServlet] Unknown componentType: " + componentType);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Unknown componentType: " + componentType + "\"}");
                return;
            }
        } else {
            products = dao.getAllProduct();
        }
        // Build JSON response
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(java.util.Collections.singletonMap("products", products)));
    }
}
