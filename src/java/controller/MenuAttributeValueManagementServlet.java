package controller;

import dal.MenuAttributeDAO;
import dal.MenuAttributeValueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.MenuAttribute;
import model.MenuAttributeValue;

@WebServlet(name = "MenuAttributeValueManagementServlet", urlPatterns = {"/menuAttributeValueManagement"})
public class MenuAttributeValueManagementServlet extends HttpServlet {
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
            int totalMenuAttributeValues = MenuAttributeValueDAO.countMenuAttributeValues(search);
            int totalPages = (int) Math.ceil((double) totalMenuAttributeValues / PAGE_SIZE);
            if (page > totalPages && totalPages > 0) page = totalPages;
            int offset = (page - 1) * PAGE_SIZE;
            
            // Get menu attribute values with search, sort and pagination
            List<MenuAttributeValue> menuAttributeValues = MenuAttributeValueDAO.getMenuAttributeValues(search, sortOrder, offset, PAGE_SIZE);
            
            // Get all menu attributes for dropdown
            List<MenuAttribute> menuAttributes = MenuAttributeDAO.getAllMenuAttributes(null, null);
            
            // Set attributes for JSP
            request.setAttribute("menuAttributes", menuAttributes);
            request.setAttribute("menuAttributeValues", menuAttributeValues);
            request.setAttribute("search", search);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalMenuAttributeValues", totalMenuAttributeValues);
            
            // Forward to JSP
            request.getRequestDispatcher("menuAttributeValueManagement.jsp").forward(request, response);
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
                MenuAttributeValue value = new MenuAttributeValue();
                value.setValue(request.getParameter("name"));
                value.setUrl(request.getParameter("url"));
                value.setAttributeId(Integer.parseInt(request.getParameter("attributeId")));
                value.setStatus(request.getParameter("status"));
                MenuAttributeValueDAO.addMenuAttributeValue(value);
            } 
            else if ("update".equals(action)) {
                MenuAttributeValue value = new MenuAttributeValue();
                value.setValueId(Integer.parseInt(request.getParameter("id")));
                value.setValue(request.getParameter("name"));
                value.setUrl(request.getParameter("url"));
                value.setAttributeId(Integer.parseInt(request.getParameter("attributeId")));
                value.setStatus(request.getParameter("status"));
                MenuAttributeValueDAO.updateMenuAttributeValue(value);
            }
            
            response.sendRedirect("menuAttributeValueManagement");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
} 