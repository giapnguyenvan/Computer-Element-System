/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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

/**
 *
 * @author admin
 */
public class LoginServlet extends HttpServlet {
    private final String USERNAME_SYSTEM = "John Doe";
    private final String PASSWORD_SYSTEM = "abc123123";
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        if (username.equals(USERNAME_SYSTEM)&password.equals(PASSWORD_SYSTEM)){
            HttpSession session = request.getSession();
            session.setAttribute("session_login", username);
            
            // Handle remember me cookie
            if (remember != null){
                String encodedUsername = URLEncoder.encode(username, StandardCharsets.UTF_8);
                String encodedPassword = URLEncoder.encode(password, StandardCharsets.UTF_8);
                
                Cookie usernameCookie = new Cookie("COOKIE_USERNAME", encodedUsername);
                Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", encodedPassword);
                
                usernameCookie.setMaxAge(60*60*24); // 24 hours
                passwordCookie.setMaxAge(60*60*24);
                
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            } else {
                // If remember is not checked, delete existing cookies
                Cookie usernameCookie = new Cookie("COOKIE_USERNAME", "");
                Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", "");
                
                usernameCookie.setMaxAge(0); // Delete cookie
                passwordCookie.setMaxAge(0);
                
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            }
            
            response.sendRedirect("welcome.jsp");
        }else{
            request.setAttribute("error", "Please enter valid account");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
            
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
