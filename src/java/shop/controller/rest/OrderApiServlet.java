package shop.controller.rest;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import shop.DAO.CartItemDAO;
import shop.DAO.OrderDAO;
import shop.DAO.OrderDetailDAO;
import shop.DAO.ProductDAO;
import shop.entities.Customer;
import shop.entities.Order;
import shop.entities.OrderDetail;
import shop.entities.Product;
import shop.entities.User;
import shop.utils.ResponseUtils;

/**
 *
 * @author admin
 */
@WebServlet(name = "OrderApiServlet", urlPatterns = {"/OrderApiServlet"})
public class OrderApiServlet extends HttpServlet {

    private final Gson gson = new Gson();
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final CartItemDAO cartItemDAO = new CartItemDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        config.getServletContext().setAttribute("/OrderApiServlet", this);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer genId = null;
        try {
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            int customerId = customer.getId();
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                String requestBody = ResponseUtils.getRequestBody(request);
                Order order = gson.fromJson(requestBody, Order.class);
                order.setCustomerId(customerId);
                order.setOrderDate(new Date());

                // Check stock for all items before processing
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    Product product = productDAO.getById(orderDetail.getProductId());
                    if (product == null) {
                        throw new Exception("Product not found: " + orderDetail.getProductId());
                    }
                    if (product.getStock() < orderDetail.getQuantity()) {
                        throw new Exception("Not enough stock for product: " + product.getName());
                    }
                }

                // Create order
                genId = orderDAO.insertGetKey(order);

                // Process order details and update stock
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    orderDetail.setOrderId(genId);
                    orderDetailDAO.insert(orderDetail);

                    // Update product stock
                    Product product = productDAO.getById(orderDetail.getProductId());
                    product.setStock(product.getStock() - orderDetail.getQuantity());
                    productDAO.update(product);
                }

                // Clear cart after successful order
                cartItemDAO.deleteByUserId(customerId);

                JsonObject responseObj = new JsonObject();
                responseObj.addProperty("success", true);
                responseObj.addProperty("orderId", genId);
                responseObj.addProperty("message", "Order placed successfully");
                responseObj.add("data", null);
                ResponseUtils.sendJsonResponse(response, responseObj);
            } else {
                ResponseUtils.sendErrorResponse(response, 404, "Endpoint not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtils.sendErrorResponse(response, 500, "Internal server error: " + e.getMessage());
        }
    }

}
