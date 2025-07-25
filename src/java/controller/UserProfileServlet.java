package controller;

import dal.CustomerDAO;
import dal.MenuItemDAO;
import dal.VoucherDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.Customer;
import model.MenuItem;
import model.Voucher;
import java.util.List;
import shop.DAO.OrderDAO;
import shop.entities.Order;
import shop.entities.OrderDetail;

/**
 *
 * @author nghia
 */
@WebServlet(name = "UserProfileServlet", urlPatterns = {"/userprofile"})
public class UserProfileServlet extends HttpServlet {
    
    private OrderDAO orderDAO = new OrderDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action"); // Changed from "tab" to "action" to match sidebar links
        if (action == null) {
            action = "profile";
        }
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");
        String email = (String) session.getAttribute("session_login");
        CustomerDAO customerDAO = new CustomerDAO();

        try {
            String content = "profile.jsp"; // Default content
            String activePage = "profile";  // Default active page

            // Lấy menu động
            List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
            request.setAttribute("menuItems", menuItems);

            switch (action) {
                case "profile": {
                    Customer customer = customerDAO.getCustomerByEmail(email);
                    request.setAttribute("data", customer);
                    content = "profile.jsp";
                    activePage = "profile";
                    break;
                }
                case "orders": {
                    // Placeholder - No data set yet
                    content = "customerOrders.jsp";
                    activePage = "customer-orders";
                    shop.entities.Customer customer = (shop.entities.Customer) session.getAttribute("customer");

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

                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng. Vui lòng thử lại.");
                    }
                    break;
                }
                case "voucher": {
                    List<Voucher> vouchers = new VoucherDAO().getCustomerVoucher(customerId);
                    request.setAttribute("vouchers", vouchers);
                    content = "voucher.jsp";
                    activePage = "voucher";
                    break;
                }
                default: {
                    // Fallback if action is invalid
                    Customer customer = customerDAO.getCustomerByEmail(email);
                    request.setAttribute("data", customer);
                    content = "profile.jsp";
                    activePage = "profile";
                    break;
                }
            }

            // Set attributes for content and active page
            request.setAttribute("content", content);
            request.setAttribute("activePage", activePage);
            request.getRequestDispatcher("userProfileLayout.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
        return "Handles user profile actions";
    }
}
