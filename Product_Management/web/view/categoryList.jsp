<%-- 
    Document   : categoryList
    Created on : May 26, 2025, 12:57:12 PM
    Author     : fpt shop
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Category> list = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category List</title>
    <!-- Link tới file CSS -->
    <link rel="stylesheet" type="text/css" href="css/category.css">
</head>
<body>
    <h2>Category List</h2>

    <!-- Form tìm kiếm -->
    <form method="get" action="category">
        <input type="text" name="search" placeholder="Search by name..." />
        <button type="submit">Search</button>
    </form>

    <!-- Nút thêm mới -->
    <p><a href="category?action=edit">Add New Category</a></p>

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
                        <a href="category?action=edit&id=<%= c.getId() %>">Edit</a> |
                        <a href="category?action=delete&id=<%= c.getId() %>"
                           onclick="return confirm('Are you sure to delete this category?');">Delete</a>
                    </td>
                </tr>
        <%  }
        } else { %>
            <tr><td colspan="4">No categories found.</td></tr>
        <% } %>
    </table>
</body>
</html>
