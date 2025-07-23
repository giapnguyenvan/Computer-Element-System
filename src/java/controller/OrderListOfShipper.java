/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import shop.DAO.OrderDAO;
import shop.DAO.ShipperDAO;
import shop.entities.Order;
import shop.entities.OrderDetail;
import shop.entities.Shipper;

/**
 *
 * @author -PC-
 */
@WebServlet(name = "OrderListOfShipper", urlPatterns = {"/order-list-of-shipper"})
public class OrderListOfShipper extends HttpServlet {
    

    private ShipperDAO shipperDAO = new ShipperDAO();
    private OrderDAO orderDAO = new OrderDAO();

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userAuth");

        if (user == null || !"Shipper".equals(user.getRole())) {
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            response.sendRedirect("error");
            return;
        }
        try {
            Shipper shipper = shipperDAO.getByEmail(user.getEmail(), "Active");
            request.setAttribute("shipper", shipper);
            List<Order> ordersOfShipper = orderDAO.getByShipperId(shipper.getShipperId());
            // Lọc chỉ lấy đơn hàng có trạng thái 'Shipping'
            String status = request.getParameter("status");
            request.setAttribute("status", status); // Đảm bảo truyền status cho JSP
            List<Order> filteredOrders = new java.util.ArrayList<>();
            if (status == null || status.equals("all")) {
                // Chỉ lấy Shipping và Completed khi chọn All
                for (Order order : ordersOfShipper) {
                    if ("Shipping".equalsIgnoreCase(order.getStatus()) || "Completed".equalsIgnoreCase(order.getStatus())) {
                        order.setPaidFunc();
                        order.setCustomerFunc();
                        order.setorderDetailsFunc();
                        for (OrderDetail orderDetail : order.getOrderDetails()) {
                            orderDetail.setProductFunc();
                        }
                        filteredOrders.add(order);
                    }
                }
            } else {
                for (Order order : ordersOfShipper) {
                    if (status.equalsIgnoreCase(order.getStatus())) {
                        order.setPaidFunc();
                        order.setCustomerFunc();
                        order.setorderDetailsFunc();
                        for (OrderDetail orderDetail : order.getOrderDetails()) {
                            orderDetail.setProductFunc();
                        }
                        filteredOrders.add(order);
                    }
                }
            }
            request.setAttribute("orders", filteredOrders);
            // Đếm số lượng đơn theo trạng thái trong filteredOrders
            int pendingCount = 0, shippingCount = 0, completedCount = 0, cancelledCount = 0;
            for (Order order : filteredOrders) {
                if ("Pending".equalsIgnoreCase(order.getStatus())) pendingCount++;
                else if ("Shipping".equalsIgnoreCase(order.getStatus())) shippingCount++;
                else if ("Completed".equalsIgnoreCase(order.getStatus())) completedCount++;
                else if ("Cancel".equalsIgnoreCase(order.getStatus()) || "Cancelled".equalsIgnoreCase(order.getStatus())) cancelledCount++;
            }
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("shippingCount", shippingCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.getRequestDispatcher("order-list-of-shipper.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
