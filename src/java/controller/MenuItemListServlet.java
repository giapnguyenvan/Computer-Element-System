package controller;

import dal.MenuItemDAO;
import model.MenuItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MenuItemListServlet", urlPatterns = {"/menuItemList", "/menuItemManagement"})
public class MenuItemListServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        // Lấy tham số phân trang, tìm kiếm, sắp xếp
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        int page = 1;
        if (pageStr != null) {
            try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        }
        int totalMenuItems = MenuItemDAO.countMenuItems(search);
        int totalPages = (int) Math.ceil((double) totalMenuItems / PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;
        List<MenuItem> menuItems = MenuItemDAO.getMenuItems(search, sort, offset, PAGE_SIZE);
        request.setAttribute("menuItems", menuItems);
        request.setAttribute("totalMenuItems", totalMenuItems);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("search", search);
        request.setAttribute("sortOrder", sort);
        request.getRequestDispatcher("menuItemManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String icon = request.getParameter("icon");
            String url = request.getParameter("url");
            String parentIdStr = request.getParameter("parentId");
            String status = request.getParameter("status");
            Integer parentId = null;
            if (parentIdStr != null && !parentIdStr.isEmpty()) {
                try { parentId = Integer.parseInt(parentIdStr); } catch (Exception ignored) {}
            }
            MenuItem item = new MenuItem(name, icon, url, parentId, status);
            MenuItemDAO.addMenuItem(item);
        } else if ("update".equals(action)) {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String icon = request.getParameter("icon");
            String url = request.getParameter("url");
            String parentIdStr = request.getParameter("parentId");
            String status = request.getParameter("status");
            Integer parentId = null;
            int id = 0;
            if (idStr != null && !idStr.isEmpty()) {
                try { id = Integer.parseInt(idStr); } catch (Exception ignored) {}
            }
            if (parentIdStr != null && !parentIdStr.isEmpty()) {
                try { parentId = Integer.parseInt(parentIdStr); } catch (Exception ignored) {}
            }
            MenuItem item = new MenuItem(id, name, icon, url, parentId, status);
            MenuItemDAO.updateMenuItem(item);
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.isEmpty()) {
                try { id = Integer.parseInt(idStr); } catch (Exception ignored) {}
            }
            MenuItemDAO.setMenuItemStatus(id, "Deactivate");
        }
        response.sendRedirect(request.getContextPath() + "/menuItemManagement");
    }
} 