/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.Blog;
import java.util.Collections;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ViewBlogServlet", urlPatterns={"/viewblogs"})
public class ViewBlogServlet extends HttpServlet {
   
    private static final int PAGE_SIZE = 10; // Number of blogs per page
    private final BlogDAO blogDAO;

    public ViewBlogServlet() {
        blogDAO = new BlogDAO();
    }

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
        
        try {
            // Get all blogs first (we'll filter and sort them in memory)
            Vector<Blog> allBlogs = blogDAO.getAllBlogs(1, Integer.MAX_VALUE);
            
            // Apply search filter if specified
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                Vector<Blog> searchedList = new Vector<>();
                search = search.toLowerCase();
                for (Blog b : allBlogs) {
                    if (b.getTitle().toLowerCase().contains(search) || 
                        b.getContent().toLowerCase().contains(search)) {
                        searchedList.add(b);
                    }
                }
                allBlogs = searchedList;
            }
            
            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "newest":
                        Collections.sort(allBlogs, (b1, b2) -> {
                            if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                            return b2.getCreated_at().compareTo(b1.getCreated_at());
                        });
                        break;
                    case "oldest":
                        Collections.sort(allBlogs, (b1, b2) -> {
                            if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                            return b1.getCreated_at().compareTo(b2.getCreated_at());
                        });
                        break;
                    case "title":
                        Collections.sort(allBlogs, (b1, b2) -> 
                            b1.getTitle().compareToIgnoreCase(b2.getTitle()));
                        break;
                }
            } else {
                // Default sort by newest
                Collections.sort(allBlogs, (b1, b2) -> {
                    if (b1.getCreated_at() == null || b2.getCreated_at() == null) return 0;
                    return b2.getCreated_at().compareTo(b1.getCreated_at());
                });
            }
            
            // Calculate pagination
            int totalBlogs = allBlogs.size();
            int totalPages = (int) Math.ceil((double) totalBlogs / PAGE_SIZE);
            
            // Get page number from request
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
            } catch (NumberFormatException e) {
                // Keep page as 1 if not specified or invalid
            }
            
            // Apply pagination to filtered and sorted results
            Vector<Blog> pagedBlogs = new Vector<>();
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalBlogs);
            
            for (int i = startIndex; i < endIndex; i++) {
                pagedBlogs.add(allBlogs.get(i));
            }
            
            // Set attributes for the JSP
            request.setAttribute("blogList", pagedBlogs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBlogs", totalBlogs);
            
            // Forward to JSP
            request.getRequestDispatcher("viewblogs.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching blogs: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "ViewBlog Servlet handles displaying and filtering blogs";
    }// </editor-fold>

}
