package controller;

import dal.CategoryDAO;
import model.Category;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            request.getRequestDispatcher("/view/categoryForm.jsp").forward(request, response);
            return;
        }

        // Hiển thị danh sách có phân trang
        int pageSize = 5; // 5 bản ghi/trang
        int currentPage = 1;
        String pageParam = request.getParameter("page");

        try {
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        List<Category> categories;
        int totalRecords = CategoryDAO.getTotalCategories();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (search != null && !search.isEmpty()) {
            // Nếu đang tìm kiếm thì không phân trang
            categories = CategoryDAO.searchCategory(search);
            request.setAttribute("search", search);
            totalPages = 1;
        } else {
            categories = CategoryDAO.getCategoriesByPage(currentPage, pageSize);
        }

        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/view/categoryList.jsp").forward(request, response);

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
