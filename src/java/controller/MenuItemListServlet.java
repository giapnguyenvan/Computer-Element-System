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

@WebServlet(name = "MenuItemListServlet", urlPatterns = {"/menuItemList"})
public class MenuItemListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
        request.setAttribute("menuItems", menuItems);
        request.getRequestDispatcher("menuItem.jsp").forward(request, response);
    }
} 