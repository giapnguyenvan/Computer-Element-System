package controller;

import dal.MenuAttributeDAO;
import dal.MenuItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.MenuAttribute;
import model.MenuItem;

@WebServlet(name = "MenuAttributeManagementServlet", urlPatterns = {"/menuAttributeManagement"})
public class MenuAttributeManagementServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get search and sort parameters
            String search = request.getParameter("search");
            String sortOrder = request.getParameter("sort");
            String pageStr = request.getParameter("page");
            
            // Parse page number
            int page = 1;
            if (pageStr != null) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    // Keep page as 1 if invalid
                }
            }
            
            // Calculate pagination
            int totalMenuAttributes = MenuAttributeDAO.countMenuAttributes(search);
            int totalPages = (int) Math.ceil((double) totalMenuAttributes / PAGE_SIZE);
            if (page > totalPages && totalPages > 0) page = totalPages;
            int offset = (page - 1) * PAGE_SIZE;
            
            // Get menu attributes with search, sort and pagination
            ArrayList<MenuAttribute> menuAttributes = MenuAttributeDAO.getMenuAttributes(search, sortOrder, offset, PAGE_SIZE);
            
            // Get menu items for dropdown
            List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
            
            // Set attributes for JSP
            request.setAttribute("menuAttributes", menuAttributes);
            request.setAttribute("menuItems", menuItems);
            request.setAttribute("search", search);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalMenuAttributes", totalMenuAttributes);
            
            // Forward to JSP
            request.getRequestDispatcher("menuAttributeManagement.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if ("add".equals(action)) {
                MenuAttribute attr = new MenuAttribute();
                attr.setName(request.getParameter("name"));
                attr.setUrl(request.getParameter("url"));
                attr.setMenuItemId(Integer.parseInt(request.getParameter("menuItemId")));
                attr.setStatus(request.getParameter("status"));
                MenuAttributeDAO.addMenuAttribute(attr);
            } 
            else if ("update".equals(action)) {
                MenuAttribute attr = new MenuAttribute();
                attr.setAttributeId(Integer.parseInt(request.getParameter("id")));
                attr.setName(request.getParameter("name"));
                attr.setUrl(request.getParameter("url"));
                attr.setMenuItemId(Integer.parseInt(request.getParameter("menuItemId")));
                attr.setStatus(request.getParameter("status"));
                MenuAttributeDAO.updateMenuAttribute(attr);
            }
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                MenuAttributeDAO.deleteMenuAttribute(id);
            }
            
            response.sendRedirect("menuAttributeManagement");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
} 