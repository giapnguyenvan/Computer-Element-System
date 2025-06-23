/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package shop.controller;

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
import shop.entities.Order;
import shop.entities.OrderDetail;
import shop.entities.Transaction;

/**
 *
 * @author admin
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment-servlet"})
public class PaymentServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        config.getServletContext().setAttribute("/payment-servlet", this);
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
            Transaction transaction = Transaction.builder()
                    .transactionCode("TS" + now.getTime())
                    .orderId(orderId)
                    .paymentMethodId(order.getPaymentMethodId())
                    .totalAmount(order.getTotalAmount())
                    .createdAt(now)
                    .paid(false)
                    .build();

            Integer key = transactionDAO.insertGetKey(transaction);

            transaction = transactionDAO.getById(key);
            
            order.setorderDetailsFunc();

            for (OrderDetail orderDetail : order.getOrderDetails()) {
                orderDetail.setProductFunc();
            }
            request.setAttribute("order", order);
            request.setAttribute("transaction", transaction);

            request.getRequestDispatcher("payment.jsp").forward(request, response);
            return;

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("homepageservlet");
            return;
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
        processRequest(request, response);
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
    
    private class CheckTrans {
        public String transactionCode;
        public BigDecimal amount; 
    }

}
