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
import dal.InventoryLogDAO;
import model.InventoryLog;

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
            if (customer == null) {
                ResponseUtils.sendErrorResponse(response, 401, "User not authenticated");
                return;
            }
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
                InventoryLogDAO logDAO = new InventoryLogDAO();
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    orderDetail.setOrderId(genId);
                    orderDetailDAO.insert(orderDetail);

                    // Update product stock
                    Product product = productDAO.getById(orderDetail.getProductId());
                    int oldStock = product.getStock();
                    product.setStock(product.getStock() - orderDetail.getQuantity());
                    productDAO.update(product);

                    // Log Adjust for purchase
                    InventoryLog log = new InventoryLog();
                    log.setProduct_id(product.getId());
                    log.setAction("Adjust");
                    log.setQuantity(-orderDetail.getQuantity());
                    log.setNote("Stock adjusted due to purchase. Old stock: " + oldStock + ", Purchased: " + orderDetail.getQuantity());
                    
                    logDAO.insertLog(log);
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Endpoint: /OrderApiServlet?id=<orderId>  -> return JSON details of the order
        try {
            String idParam = request.getParameter("id");
            if (idParam == null) {
                ResponseUtils.sendErrorResponse(response, 400, "Missing order id parameter");
                return;
            }

            int orderId;
            try {
                orderId = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                ResponseUtils.sendErrorResponse(response, 400, "Invalid order id");
                return;
            }

            Order order = orderDAO.getById(orderId);
            if (order == null) {
                ResponseUtils.sendErrorResponse(response, 404, "Order not found");
                return;
            }

            // Populate nested entities
            order.setCustomerFunc();
            order.setorderDetailsFunc();
            order.setPaymentMethodFunc();

            // Build JSON response
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.addProperty("orderId", order.getId());
            json.addProperty("status", order.getStatus());
            json.addProperty("totalAmount", order.getTotalAmount() != null ? order.getTotalAmount().toString() : "0");
            json.addProperty("shippingFee", order.getShippingFee() != null ? order.getShippingFee().toString() : "0");
            json.addProperty("note", order.getShippingAddress() != null ? order.getShippingAddress() : "");

            // Customer info
            if (order.getCustomer() != null) {
                JsonObject cust = new JsonObject();
                cust.addProperty("name", order.getCustomer().getName());
                cust.addProperty("email", order.getCustomer().getEmail());
                cust.addProperty("id", order.getCustomer().getId());
                json.add("customer", cust);
            }

            // Items array
            com.google.gson.JsonArray itemsArr = new com.google.gson.JsonArray();
            if (order.getOrderDetails() != null) {
                for (OrderDetail od : order.getOrderDetails()) {
                    od.setProductFunc();
                    JsonObject itemObj = new JsonObject();
                    itemObj.addProperty("productId", od.getProductId());
                    itemObj.addProperty("name", od.getProduct() != null ? od.getProduct().getName() : "");
                    itemObj.addProperty("quantity", od.getQuantity());
                    itemObj.addProperty("price", od.getPrice() != null ? od.getPrice().toString() : "0");

                    // Try to get product image
                    String imageUrl = "";
                    if (od.getProduct() != null) {
                        od.getProduct().setProductImagesFunc();
                        if (od.getProduct().getProductImages() != null && !od.getProduct().getProductImages().isEmpty()) {
                            imageUrl = od.getProduct().getProductImages().get(0).getImageUrl();
                        }
                    }
                    itemObj.addProperty("imageUrl", imageUrl);
                    itemsArr.add(itemObj);
                }
            }
            json.add("items", itemsArr);

            // Status history - hiện chưa có bảng lịch sử, nên trả về lịch sử đơn giản chỉ gồm trạng thái hiện tại
            com.google.gson.JsonArray historyArr = new com.google.gson.JsonArray();
            JsonObject hist = new JsonObject();
            hist.addProperty("status", order.getStatus());
            hist.addProperty("time", order.getOrderDate() != null ? order.getOrderDate().toString() : "");
            hist.addProperty("statusColor", "primary");
            hist.addProperty("changedBy", "System");
            historyArr.add(hist);
            json.add("statusHistory", historyArr);

            ResponseUtils.sendJsonResponse(response, json);
        } catch (Exception ex) {
            ex.printStackTrace();
            ResponseUtils.sendErrorResponse(response, 500, "Internal server error");
        }
    }

}
