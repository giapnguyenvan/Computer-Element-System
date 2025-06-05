/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.util.Vector;
import model.Products;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author nghia
 */
@WebServlet(name = "HomePageServlet", urlPatterns = {"/homepageservlet"})
public class HomePageServlet extends HttpServlet {

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
        try {
            ProductDAO dao = new ProductDAO();
            
            // Xử lý phân trang
            int page = 1;
            int productsPerPage = 10;
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
            
            // Lấy tổng số sản phẩm và tính số trang
            int totalProducts = dao.getTotalProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
            
            // Lấy danh sách sản phẩm theo trang
            Vector<Products> plist = dao.getProductsByPage(page, productsPerPage);
            
            // Add debug information
            System.out.println("Page: " + page);
            System.out.println("Total products: " + totalProducts);
            System.out.println("Total pages: " + totalPages);
            System.out.println("Products on current page: " + (plist != null ? plist.size() : 0));
            
            // Set attributes for JSP
            request.setAttribute("product", plist);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            request.getRequestDispatcher("homePage.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            System.err.println("Error in HomePageServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message for the JSP
            request.setAttribute("errorMessage", "An error occurred while loading products. Please try again later.");
            request.getRequestDispatcher("homePage.jsp").forward(request, response);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        return "Homepage Servlet";
    }// </editor-fold>

}
