package controller;

import com.google.gson.Gson;
import dal.ProductDAO;
import model.Products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ComponentApiServlet", urlPatterns = {"/api/components"})
public class ComponentApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        if (type == null || type.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Missing type parameter\"}");
            return;
        }
        // Lấy component_type_id từ tên type
        int componentTypeId = ProductDAO.getComponentTypeIdByName(type);
        if (componentTypeId == -1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\":\"Component type not found\"}");
            return;
        }
        List<Products> products = new ProductDAO().getProductsByComponentType(componentTypeId);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        new Gson().toJson(products, resp.getWriter());
    }
} 