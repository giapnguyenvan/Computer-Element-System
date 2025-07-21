/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import shop.DAO.OrderDAO;
import shop.entities.Order;
import shop.entities.OrderDetail;

/**
 *
 * @author -PC-
 */
@WebServlet(name = "OrderManageStaff", urlPatterns = {"/order-manage-staff"})
public class OrderManageStaff extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

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
        try {
            // Get filter parameters
            String status = request.getParameter("status");
            if (status == null) {
                status = "all";
            }
            request.setAttribute("status", status);
            String fromDateStr = request.getParameter("fromDate");
            request.setAttribute("fromDate", fromDateStr);
            String toDateStr = request.getParameter("toDate");
            request.setAttribute("toDate", toDateStr);
            
            // Get pagination parameters
            int page = 1;
            int pageSize = 5; // Default orders per page
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeParam);
                    if (pageSize < 5) pageSize = 5;
                    if (pageSize > 100) pageSize = 100; // Max limit
                } catch (NumberFormatException e) {
                    pageSize = 5;
                }
            }

            String currentYear = (new Date().getYear() + 1900) + "";
            Date fromDate;
            Date toDate;

            if (fromDateStr == null || fromDateStr.isEmpty()) {
                fromDate = simpleDateFormat.parse(currentYear + "-01-01");
            } else {
                fromDate = simpleDateFormat.parse(fromDateStr);
            }

            if (toDateStr == null || toDateStr.isEmpty()) {
                toDate = simpleDateFormat.parse(currentYear + "-12-31");
            } else {
                toDate = simpleDateFormat.parse(toDateStr);
            }
            
            // Get all orders and filter them
            List<Order> ordersAll = orderDAO.getAll();
            List<Order> filteredOrders = new ArrayList<>();
            for (Order order : ordersAll) {
                boolean isGet = true;
                if (!status.equals("all")) {
                    if (!status.equals(order.getStatus())) {
                        isGet = false;
                    }
                }
                if (isGet) {
                    if (toDate.after(order.getOrderDate()) && fromDate.before(order.getOrderDate())) {
                        filteredOrders.add(order);
                    }
                }
            }
            
            // Calculate pagination
            int totalOrders = filteredOrders.size();
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }
            
            // Get orders for current page
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalOrders);
            List<Order> paginatedOrders = new ArrayList<>();
            
            if (startIndex < totalOrders) {
                for (int i = startIndex; i < endIndex; i++) {
                    Order order = filteredOrders.get(i);
                        order.setorderDetailsFunc();
                        order.setCustomerFunc();
                        order.setPaymentMethodFunc();
                        for (OrderDetail orderDetail : order.getOrderDetails()) {
                            orderDetail.setProductFunc();
                        }
                    paginatedOrders.add(order);
                    }
                }

            // Set attributes for JSP
            request.setAttribute("orders", paginatedOrders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("startIndex", startIndex + 1);
            request.setAttribute("endIndex", Math.min(endIndex, totalOrders));
            
            String message = (String) request.getAttribute("message");
            if (message == null) {
                message = "Order list loaded successfully!";
                request.setAttribute("message", message);
            }
            request.getRequestDispatcher("OrderManageStaff.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error loading orders: " + e.getMessage());
            request.getRequestDispatcher("OrderManageStaff.jsp").forward(request, response);
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
        try {
            String orderId = request.getParameter("order_id");
            String status = request.getParameter("order_status");

            Order order = orderDAO.getById(Integer.parseInt(orderId));
            order.setStatus(status);
            orderDAO.update(order);
            request.setAttribute("message", "Update successfully");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Update failure");
        }
        doGet(request, response);
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
