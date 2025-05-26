<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Category> list = (List<Category>) request.getAttribute("categories");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category List</title>
    <link rel="stylesheet" type="text/css" href="<%= ctx %>/css/category.css">
</head>
<body>
    <h2>Category List</h2>

    <!-- Form tìm kiếm -->
    <form action="<%= ctx %>/category" method="get">
        <input type="text" name="search" placeholder="Search by name..." />
        <button type="submit">Search</button>
    </form>

    <!-- Nút thêm mới -->
    <p><a href="<%= ctx %>/category?action=edit">Add New Category</a></p>

    <!-- Danh sách category -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <% if (list != null && !list.isEmpty()) {
            for (Category c : list) { %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getDescription() %></td>
                    <td>
                        <a href="<%= ctx %>/category?action=edit&id=<%= c.getId() %>">Edit</a> |
                        <a href="<%= ctx %>/category?action=delete&id=<%= c.getId() %>"
                           onclick="return confirm('Are you sure to delete this category?');">Delete</a>
                    </td>
                </tr>
        <%  }
        } else { %>
            <tr><td colspan="4">No categories found.</td></tr>
        <% } %>
    </table>

    <!-- Phân trang -->
    <%
        Integer currentPage = (Integer) request.getAttribute("currentPage");
        Integer totalPages = (Integer) request.getAttribute("totalPages");
        String search = (String) request.getAttribute("search");
    %>

    <% if (totalPages != null && totalPages > 1) { %>
        <div style="margin-top: 20px;">
            <strong>Page:</strong>
            <% for (int i = 1; i <= totalPages; i++) {
                String link = ctx + "/category?page=" + i;
                if (search != null && !search.isEmpty()) {
                    link += "&search=" + search;
                }
            %>
                <% if (i == currentPage) { %>
                    <strong>[<%= i %>]</strong>
                <% } else { %>
                    <a href="<%= link %>"><%= i %></a>
                <% } %>
            <% } %>
        </div>
    <% } %>
</body>
</html>
