<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Category cat = (Category) request.getAttribute("category");
    boolean isEdit = (cat != null);
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit Category" : "Add New Category" %></title>
    <link rel="stylesheet" type="text/css" href="<%= ctx %>/css/category.css">
</head>
<body>
    <h2><%= isEdit ? "Edit Category" : "Add New Category" %></h2>

    <form method="post" action="<%= ctx %>/category">
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>" />
        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= cat.getId() %>" />
        <% } %>

        <label>Name:</label><br/>
        <input type="text" name="name" value="<%= isEdit ? cat.getName() : "" %>" required /><br/><br/>

        <label>Description:</label><br/>
        <textarea name="description" rows="4" cols="50"><%= isEdit ? cat.getDescription() : "" %></textarea><br/><br/>

        <input type="submit" value="<%= isEdit ? "Update" : "Add" %>" />
        <a href="<%= ctx %>/category">Cancel</a>
    </form>
</body>
</html>
