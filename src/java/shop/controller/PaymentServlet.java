/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Date;
import shop.DAO.OrderDAO;
import shop.DAO.TransactionDAO;
import shop.controller.rest.CartApiServlet;
import shop.entities.Order;
import shop.entities.OrderDetail;
import shop.entities.Transaction;
import shop.utils.ResponseUtils;
import dal.MenuItemDAO;
import model.MenuItem;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment-servlet"})
public class PaymentServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    private final TransactionDAO transactionDAO = new TransactionDAO();

    private final Gson gson = new Gson();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        config.getServletContext().setAttribute("/payment-servlet", this);
    }

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
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String orderIdStr = request.getParameter("orderId");
            Integer orderId = Integer.parseInt(orderIdStr);

            Order order = orderDAO.getById(orderId);

            if (order == null) {
                response.sendRedirect("hompageservlet");
                return;
            }
            Date now = new Date();
            Transaction transaction = transactionDAO.getByOrderId(orderId);

            if (transaction == null) {
                transaction = Transaction.builder()
                        .transactionCode("TS" + now.getTime())
                        .orderId(orderId)
                        .paymentMethodId(order.getPaymentMethodId())
                        .totalAmount(order.getTotalAmount())
                        .createdAt(now)
                        .paid(false)
                        .build();
                Integer key = transactionDAO.insertGetKey(transaction);

                transaction = transactionDAO.getById(key);
            } else {
                if (transaction.isPaid()) {
                    response.sendRedirect("homepageservlet");
                    return;
                }
                transaction.setCreatedAt(now);
                transaction.setTotalAmount(order.getTotalAmount());
            }

            order.setorderDetailsFunc();

            for (OrderDetail orderDetail : order.getOrderDetails()) {
                orderDetail.setProductFunc();
            }
            request.setAttribute("order", order);
            request.setAttribute("transaction", transaction);
            
            // Lấy menu động
            List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
            request.setAttribute("menuItems", menuItems);
            
            request.getRequestDispatcher("payment.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("homepageservlet");
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
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestBody = ResponseUtils.getRequestBody(request);

            CheckTrans checkTrans = gson.fromJson(requestBody, CheckTrans.class);

            Transaction transaction = transactionDAO.getByCode(checkTrans.transactionCode);
            if (transaction != null && checkTrans.amount.doubleValue() >= transaction.getTotalAmount().doubleValue() * 0.99) {
                transaction.setPaid(true);
                transactionDAO.update(transaction);
                JsonObject responseObj = new JsonObject();
                responseObj.addProperty("status", 200);
                responseObj.addProperty("message", "Trans updated successfully");
                ResponseUtils.sendJsonResponse(response, responseObj);
                return;
            }
            ResponseUtils.sendErrorResponse(response, 404, "Bad request: Transaction not found");
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtils.sendErrorResponse(response, 500, "Internal server error: " + e.getMessage());
        }

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

    private static class CheckTrans {

        String transactionCode;
        BigDecimal amount;
    }

}
