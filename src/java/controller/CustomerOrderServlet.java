package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import shop.DAO.OrderDAO;
import shop.entities.Customer;
import shop.entities.Order;
import shop.entities.OrderDetail;

@WebServlet(name = "CustomerOrderServlet", urlPatterns = {"/customer-orders"})
public class CustomerOrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Order> orders = orderDAO.getByCustomerId(customer.getId());
            
            // Load order details, customer info, and payment method for each order
            for (Order order : orders) {
                order.setorderDetailsFunc();
                order.setCustomerFunc();
                order.setPaymentMethodFunc();
                
                // Load product info for each order detail
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    orderDetail.setProductFunc();
                }
            }
            
            request.setAttribute("orders", orders);
            request.setAttribute("customerId", customer.getId());
            request.getRequestDispatcher("customerOrders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng. Vui lòng thử lại.");
            request.getRequestDispatcher("customerOrders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String orderIdParam = request.getParameter("orderId");
        
        if ("cancel".equals(action) && orderIdParam != null) {
            try {
                Integer orderId = Integer.valueOf(orderIdParam);
                
                // Verify that this order belongs to the customer
                Order order = orderDAO.getById(orderId);
                if (order != null && order.getCustomerId().equals(customer.getId())) {
                    // Only allow cancellation for pending orders
                    if ("Pending".equals(order.getStatus())) {
                        boolean updated = orderDAO.updateOrderStatus("Cancel", orderId);
                        if (updated) {
                            request.setAttribute("success", "Đơn hàng đã được hủy thành công.");
                        } else {
                            request.setAttribute("error", "Không thể hủy đơn hàng. Vui lòng thử lại.");
                        }
                    } else {
                        request.setAttribute("error", "Chỉ có thể hủy đơn hàng có trạng thái 'Đang chờ xử lý'.");
                    }
                } else {
                    request.setAttribute("error", "Không tìm thấy đơn hàng hoặc bạn không có quyền thực hiện thao tác này.");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Mã đơn hàng không hợp lệ.");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.");
            }
        }
        
        // Redirect back to GET to show updated list
        response.sendRedirect("userprofile?action=orders");
    }
} 