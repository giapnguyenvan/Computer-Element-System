<%@ page import="java.util.List" %>
<%@ page import="model.MenuAttribute" %>
<%@ page import="model.MenuItem" %>
<%@ page import="dal.MenuAttributeDAO" %>
<%@ page import="dal.MenuItemDAO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<MenuAttribute> list = (List<MenuAttribute>) request.getAttribute("menuAttributes");
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    
    // Xử lý khi truy cập trực tiếp JSP
    if (list == null) {
        list = MenuAttributeDAO.getAllMenuAttributes(null, null);
    }
    if (menuItems == null) {
        menuItems = MenuItemDAO.getAllMenuItems();
    }
    
    String ctx = request.getContextPath();
    String sortOrder = (String) request.getAttribute("sortOrder");
    String currentSort = sortOrder != null ? sortOrder : "default";
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    String search = (String) request.getAttribute("search");
    String searchParam = search != null ? "&search=" + java.net.URLEncoder.encode(search, "UTF-8") : "";
    String sortParam = "&sort=" + currentSort;
    String defaultUrl = ctx + "/menuAttributeManagement?sort=default" + searchParam;
    String ascUrl = ctx + "/menuAttributeManagement?sort=asc" + searchParam;
    String descUrl = ctx + "/menuAttributeManagement?sort=desc" + searchParam;
    String statusAscUrl = ctx + "/menuAttributeManagement?sort=status_asc" + searchParam;
    String statusDescUrl = ctx + "/menuAttributeManagement?sort=status_desc" + searchParam;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu (level 2)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .table-wrapper {
            background-color: white;
            padding: 1.5rem;
            border-radius: .5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .btn-action { background: none; border: none; padding: 0; margin: 0 8px; color: #6c757d; font-size: 1.1rem; }
        .btn-action:hover { color: #0d6efd; }
        .text-danger:hover { color: #dc3545 !important; }
        .page-info { display: inline-block; padding: 0.375rem 0.75rem; background-color: #0d6efd; color: white; border-radius: 0.25rem; margin: 0 5px; font-weight: 500; }
        .table thead th { font-weight: 600; color: #343a40; }
        .sort-column {
            display: flex;
            align-items: center;
            gap: 3px;
        }
        .sort-icons {
            display: inline-flex;
            flex-direction: column;
            margin-left: 3px;
            height: 16px;
        }
        .sort-icon {
            cursor: pointer;
            color: #6c757d;
            line-height: 8px;
            font-size: 11px;
            margin: -2px 0;
        }
        .sort-icon:hover {
            color: #0d6efd;
        }
        .sort-active {
            color: #0d6efd;
        }
        .sort-icon i {
            display: block;
        }
    </style>
</head>
<body class="bg-light">
<div class="container my-5">
    <div class="table-wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="mb-0">Menu Attributes</h4>
            <span class="text-muted">Total Attributes: <%= request.getAttribute("totalMenuAttributes") != null ? request.getAttribute("totalMenuAttributes") : "N/A" %></span>
        </div>

        <div class="row g-3 align-items-center mb-4">
            <div class="col-md-3">
                <select class="form-select" id="sortControl" onchange="window.location.href = this.value;">
                    <option value="<%= defaultUrl %>" <%= "default".equals(currentSort) ? "selected" : "" %>>Sort by ID</option>
                    <option value="<%= ascUrl %>" <%= "asc".equals(currentSort) ? "selected" : "" %>>Name A-Z</option>
                    <option value="<%= descUrl %>" <%= "desc".equals(currentSort) ? "selected" : "" %>>Name Z-A</option>
                </select>
            </div>
            <div class="col-md-6">
                <form action="<%= ctx %>/menuAttributeManagement" method="get">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search by name, URL, or menu item..." value="<%= search != null ? search : "" %>"/>
                        <% if (sortOrder != null) { %>
                        <input type="hidden" name="sort" value="<%= sortOrder %>"/>
                        <% } %>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                    </div>
                </form>
            </div>
            <div class="col-md-3 text-end">
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addMenuAttributeModal">
                    <i class="fas fa-plus"></i> Add Attribute
                </button>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>URL</th>
                    <th>Menu Item</th>
                    <th>
                        <div class="sort-column">
                            Status
                            <div class="sort-icons">
                                <span class="sort-icon <%= "status_asc".equals(currentSort) ? "sort-active" : "" %>" onclick="window.location.href='<%= statusAscUrl %>'">
                                    <i class="fas fa-sort-up"></i>
                                </span>
                                <span class="sort-icon <%= "status_desc".equals(currentSort) ? "sort-active" : "" %>" onclick="window.location.href='<%= statusDescUrl %>'">
                                    <i class="fas fa-sort-down"></i>
                                </span>
                            </div>
                        </div>
                    </th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (list != null && !list.isEmpty()) {
                    for (MenuAttribute attr : list) { %>
                <tr>
                    <td><strong><%= attr.getAttributeId() %></strong></td>
                    <td><%= attr.getName() %></td>
                    <td><%= attr.getUrl() %></td>
                    <td>
                        <% for(MenuItem mi : menuItems) { if(mi.getMenuItemId() == attr.getMenuItemId()) { %>
                            <%= mi.getName() %>
                        <% }} %>
                    </td>
                    <td><%= attr.getStatus() %></td>
                    <td class="text-center">
                        <button class="btn-action" onclick="editMenuAttribute('<%= attr.getAttributeId() %>', '<%= attr.getName().replace("'", "\\'") %>', '<%= attr.getUrl() != null ? attr.getUrl().replace("'", "\\'") : "" %>', '<%= attr.getMenuItemId() %>', '<%= attr.getStatus() %>')" data-bs-toggle="modal" data-bs-target="#editMenuAttributeModal" title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                </tr>
                <%  }
                } else { %>
                <tr><td colspan="6" class="text-center py-5">No attributes found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% if (totalPages != null && totalPages > 1) { %>
        <nav aria-label="Page navigation" class="mt-4 d-flex justify-content-end align-items-center">
            <% String prevLink = ctx + "/menuAttributeManagement?page=" + (currentPage - 1) + searchParam + sortParam; %>
            <a href="<%= currentPage > 1 ? prevLink : "#" %>" class="btn btn-outline-primary <%= currentPage <= 1 ? "disabled" : "" %>">Previous</a>
            <span class="page-info"><%= currentPage %> / <%= totalPages %></span>
            <% String nextLink = ctx + "/menuAttributeManagement?page=" + (currentPage + 1) + searchParam + sortParam; %>
            <a href="<%= currentPage < totalPages ? nextLink : "#" %>" class="btn btn-outline-primary <%= currentPage >= totalPages ? "disabled" : "" %>">Next</a>
        </nav>
        <% } %>
    </div>
</div>

<!-- Add Attribute Modal -->
<div class="modal fade" id="addMenuAttributeModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Attribute</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="<%= ctx %>/menuAttributeManagement" method="post">
                    <input type="hidden" name="action" value="add" />
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="url" class="form-label">URL</label>
                        <input type="text" class="form-control" id="url" name="url" maxlength="255">
                    </div>
                    <div class="mb-3">
                        <label for="menuItemId" class="form-label">Menu Item</label>
                        <select class="form-select" id="menuItemId" name="menuItemId" required>
                            <option value="">-- Chọn menu cha --</option>
                            <% for(MenuItem mi : menuItems) { %>
                                <option value="<%= mi.getMenuItemId() %>"><%= mi.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="Activate">Activate</option>
                            <option value="Deactivate">Deactivate</option>
                        </select>
                    </div>
                    <div class="text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Attribute Modal -->
<div class="modal fade" id="editMenuAttributeModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Attribute</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="<%= ctx %>/menuAttributeManagement" method="post">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" id="editId">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editName" name="name" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="editUrl" class="form-label">URL</label>
                        <input type="text" class="form-control" id="editUrl" name="url" maxlength="255">
                    </div>
                    <div class="mb-3">
                        <label for="editMenuItemId" class="form-label">Menu Item</label>
                        <select class="form-select" id="editMenuItemId" name="menuItemId" required>
                            <option value="">-- Chọn menu cha --</option>
                            <% for(MenuItem mi : menuItems) { %>
                                <option value="<%= mi.getMenuItemId() %>"><%= mi.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editStatus" class="form-label">Status</label>
                        <select class="form-select" id="editStatus" name="status">
                            <option value="Activate">Activate</option>
                            <option value="Deactivate">Deactivate</option>
                        </select>
                    </div>
                    <div class="text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function editMenuAttribute(id, name, url, menuItemId, status) {
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editUrl').value = url;
        document.getElementById('editMenuItemId').value = menuItemId;
        document.getElementById('editStatus').value = status;
    }
</script>
</body>
</html> 