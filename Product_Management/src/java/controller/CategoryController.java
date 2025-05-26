package controller;

import dal.CategoryDAO;
import model.Category;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryController", urlPatterns = {"/category"})
public class CategoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        // Xóa category
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.deleteCategory(id);
            response.sendRedirect("category");
            return;
        }

        // Hiển thị form thêm/sửa
        if ("edit".equals(action)) {
            String idStr = request.getParameter("id");
            Category category = null;

            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    category = CategoryDAO.getCategoryById(id);
                } catch (NumberFormatException e) {
                    // giữ category = null
                }
            }

            request.setAttribute("category", category);
            request.getRequestDispatcher("categoryForm.jsp").forward(request, response);
            return;
        }

        // Hiển thị danh sách hoặc tìm kiếm
        List<Category> categories;
        if (search != null && !search.isEmpty()) {
            categories = CategoryDAO.searchCategory(search);
        } else {
            categories = CategoryDAO.getAllCategories();
        }

        request.setAttribute("categories", categories);
        request.getRequestDispatcher("categoryList.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        if ("add".equals(action)) {
            CategoryDAO.addCategory(new Category(0, name, desc));
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.updateCategory(new Category(id, name, desc));
        }

        response.sendRedirect("category");
    }

    @Override
    public String getServletInfo() {
        return "Category Controller Servlet";
    }
}
