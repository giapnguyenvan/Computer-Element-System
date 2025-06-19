/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import model.User;
import dal.CustomerDAO;
import model.Customer;

/**
 *
 * @author admin
 */
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        try {
            // Thử đăng nhập với Customer
            Customer customer = new dal.CustomerDAO().login(email, password);
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customerAuth", customer);
                session.setAttribute("session_login", email);
                session.setAttribute("user_role", "customer");
                session.setAttribute("user_name", customer.getName());
                response.sendRedirect(request.getContextPath() + "/homepageservlet");
                return;
            }
            // Nếu không phải customer, thử với User (staff/admin)
            User user = dal.UserDAO.getInstance().login(email, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userAuth", user);
                session.setAttribute("session_login", email);
                session.setAttribute("user_role", user.getRole());
                session.setAttribute("user_name", user.getFullname());
                
                // Handle remember me cookie
                if (remember != null) {
                    String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8);
                    String encodedPassword = URLEncoder.encode(password, StandardCharsets.UTF_8);
                    
                    Cookie emailCookie = new Cookie("COOKIE_EMAIL", encodedEmail);
                    Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", encodedPassword);
                    
                    emailCookie.setMaxAge(60*60*24); // 24 hours
                    passwordCookie.setMaxAge(60*60*24);
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                } else {
                    // If remember is not checked, delete existing cookies
                    Cookie emailCookie = new Cookie("COOKIE_EMAIL", "");
                    Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", "");
                    
                    emailCookie.setMaxAge(0); // Delete cookie
                    passwordCookie.setMaxAge(0);
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }
                
                // Nếu là admin thì chuyển hướng đến adminDashboard.jsp
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/homepageservlet");
                }
                return;
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }// </editor-fold>

}
