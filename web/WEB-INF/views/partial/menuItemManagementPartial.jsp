<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<MenuItem> list = (List<MenuItem>) request.getAttribute("menuItems");
    String ctx = request.getContextPath();
    String sortOrder = (String) request.getAttribute("sortOrder");
    String currentSort = sortOrder != null ? sortOrder : "default";
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    String search = (String) request.getAttribute("search");
    String searchParam = search != null ? "&search=" + java.net.URLEncoder.encode(search, "UTF-8") : "";
    String sortParam = "&sort=" + currentSort;
    
    // Thêm các URL cho sorting
    String defaultUrl = ctx + "/menuItemManagement?sort=default" + searchParam;
    String ascUrl = ctx + "/menuItemManagement?sort=asc" + searchParam;
    String descUrl = ctx + "/menuItemManagement?sort=desc" + searchParam;
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0">Menu (Level 1)</h4>
    <span class="text-muted">Total Items: <%= request.getAttribute("totalMenuItems") != null ? request.getAttribute("totalMenuItems") : "N/A" %></span>
</div>

<div class="row g-3 align-items-center mb-4">
    <div class="col-md-3">
        <select class="form-select" id="sortControl" onchange="window.location.href=this.value">
            <option value="<%= defaultUrl %>" <%= "default".equals(currentSort) ? "selected" : "" %>>Sort by ID</option>
            <option value="<%= ascUrl %>" <%= "asc".equals(currentSort) ? "selected" : "" %>>Name A-Z</option>
            <option value="<%= descUrl %>" <%= "desc".equals(currentSort) ? "selected" : "" %>>Name Z-A</option>
        </select>
    </div>
    <div class="col-md-6">
        <form action="<%= ctx %>/menuItemManagement" method="get">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Search by name or url..." value="<%= search != null ? search : "" %>">
                <% if (sortOrder != null) { %>
                <input type="hidden" name="sort" value="<%= sortOrder %>">
                <% } %>
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
            </div>
        </form>
    </div>
    <div class="col-md-3 text-end">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addMenuItemModal">
            <i class="fas fa-plus"></i> Add Menu Item
        </button>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-hover align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Icon</th>
            <th>URL</th>
            <th>Parent ID</th>
            <th>Status</th>
            <th class="text-center">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (list != null) { 
            for (MenuItem item : list) { %>
        <tr>
            <td><%= item.getId() %></td>
            <td><%= item.getName() %></td>
            <td><i class="<%= item.getIcon() %>"></i></td>
            <td><%= item.getUrl() %></td>
            <td><%= item.getParentId() != null ? item.getParentId() : "N/A" %></td>
            <td><%= item.getStatus() %></td>
            <td class="text-center">
                <button class="btn-action" onclick="editMenuItem(<%= item.getId() %>)" title="Edit">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-action text-danger" onclick="deleteMenuItem(<%= item.getId() %>)" title="Delete">
                    <i class="fas fa-trash"></i>
                </button>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>

<% if (totalPages != null && totalPages > 1) { %>
<nav aria-label="Page navigation" class="mt-4 d-flex justify-content-end align-items-center">
    <% String prevLink = ctx + "/menuItemManagement?page=" + (currentPage - 1) + searchParam + sortParam; %>
    <a href="<%= currentPage > 1 ? prevLink : "#" %>" class="btn btn-outline-primary pagination-link <%= currentPage <= 1 ? "disabled" : "" %>">Previous</a>
    <span class="page-info"><%= currentPage %> / <%= totalPages %></span>
    <% String nextLink = ctx + "/menuItemManagement?page=" + (currentPage + 1) + searchParam + sortParam; %>
    <a href="<%= currentPage < totalPages ? nextLink : "#" %>" class="btn btn-outline-primary pagination-link <%= currentPage >= totalPages ? "disabled" : "" %>">Next</a>
</nav>
<% } %> 