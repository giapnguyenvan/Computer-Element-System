<%-- 
    Document   : categoryForm
    Created on : May 26, 2025, 1:02:00 PM
    Author     : fpt shop
--%>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Category cat = (Category) request.getAttribute("category");
    boolean isEdit = (cat != null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit Category" : "Add New Category" %></title>
    <link rel="stylesheet" type="text/css" href="css/category.css">
</head>
<body>
    <h2><%= isEdit ? "Edit Category" : "Add New Category" %></h2>

    <form method="post" action="category">
        <!-- Hidden field để xác định action -->
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>" />
        
        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= cat.getId() %>" />
        <% } %>

        <label for="name">Name:</label><br/>
        <input type="text" name="name" id="name" value="<%= isEdit ? cat.getName() : "" %>" required/><br/><br/>

        <label for="description">Description:</label><br/>
        <textarea name="description" id="description" rows="4" cols="50"><%= isEdit ? cat.getDescription() : "" %></textarea><br/><br/>

        <input type="submit" value="<%= isEdit ? "Update" : "Add" %>" />
        <a href="category">Cancel</a>
    </form>
</body>
</html>

