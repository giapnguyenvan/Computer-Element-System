<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Category> list = (List<Category>) request.getAttribute("categories");
    String ctx = request.getContextPath();
    String sortOrder = (String) request.getAttribute("sortOrder");
    String currentSort = sortOrder != null ? sortOrder : "default";

    // Pagination variables
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    String search = (String) request.getAttribute("search");
    String searchParam = search != null ? "&search=" + java.net.URLEncoder.encode(search, "UTF-8") : "";
    String sortParam = "&sort=" + currentSort;

    String defaultUrl = ctx + "/category?sort=default" + searchParam;
    String ascUrl = ctx + "/category?sort=asc" + searchParam;
    String descUrl = ctx + "/category?sort=desc" + searchParam;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f0f2f5;
            }
            .management-header {
                background-color: white;
                padding: 1.5rem;
                border-radius: .5rem;
                box-shadow: 0 2px 4px rgba(0,0,0,.1);
                margin-bottom: 2rem;
            }
            .table-wrapper {
                background-color: white;
                padding: 1.5rem;
                border-radius: .5rem;
                box-shadow: 0 2px 4px rgba(0,0,0,.1);
            }
            .btn-action {
                background: none;
                border: none;
                padding: 0;
                margin: 0 8px;
                color: #6c757d;
                font-size: 1.1rem;
            }
            .btn-action:hover {
                color: #0d6efd;
            }
            .text-danger:hover {
                color: #dc3545 !important;
            }
            .page-info {
                display: inline-block;
                padding: 0.375rem 0.75rem;
                background-color: #0d6efd;
                color: white;
                border-radius: 0.25rem;
                margin: 0 5px;
                font-weight: 500;
            }
            .table thead th {
                font-weight: 600;
                color: #343a40;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container my-5">
            <!-- Management Header -->
            <div class="management-header">
                <h4 class="mb-4">Category Management</h4>
                <div class="row g-3 align-items-center">
                    <div class="col-md-3">
                        <select class="form-select" id="sortControl" onchange="window.location.href = this.value;">
                            <option value="<%= defaultUrl %>" <%= "default".equals(currentSort) ? "selected" : "" %>>Sort by ID</option>
                            <option value="<%= ascUrl %>" <%= "asc".equals(currentSort) ? "selected" : "" %>>Name A-Z</option>
                            <option value="<%= descUrl %>" <%= "desc".equals(currentSort) ? "selected" : "" %>>Name Z-A</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <form action="<%= ctx %>/category" method="get">
                            <div class="input-group">
                                <input type="text" name="search" class="form-control" placeholder="Search by name or description..." 
                                       value="<%= search != null ? search : "" %>"/>
                                <% if (sortOrder != null) { %>
                                <input type="hidden" name="sort" value="<%= sortOrder %>"/>
                                <% } %>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3 text-end">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="fas fa-plus"></i> Add Category
                        </button>
                    </div>
                </div>
            </div>

            <!-- Category List Table -->
            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">User Accounts</h4>
                    <span class="text-muted">Total Categories: <%= request.getAttribute("totalCategories") != null ? request.getAttribute("totalCategories") : "N/A" %></span>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (list != null && !list.isEmpty()) {
                            for (Category c : list) { %>
                            <tr>
                                <td><strong><%= c.getId() %></strong></td>
                                <td><%= c.getName() %></td>
                                <td><%= c.getDescription() %></td>
                                <td class="text-center">
                                    <button class="btn-action" 
                                            onclick="editCategory(<%= c.getId() %>, '<%= c.getName().replace("'", "\\'") %>', '<%= c.getDescription().replace("'", "\\'") %>')"
                                            data-bs-toggle="modal" data-bs-target="#editCategoryModal" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <a href="<%= ctx %>/category?action=delete&id=<%= c.getId() %>"
                                       class="btn-action text-danger"
                                       onclick="return confirm('Are you sure you want to delete this category?');" title="Delete">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                            <%  }
                        } else { %>
                            <tr><td colspan="4" class="text-center py-5">No categories found.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <% if (totalPages != null && totalPages > 1) { %>
                <nav aria-label="Page navigation" class="mt-4 d-flex justify-content-end align-items-center">
                    <% String prevLink = ctx + "/category?page=" + (currentPage - 1) + searchParam + sortParam; %>
                    <a href="<%= currentPage > 1 ? prevLink : "#" %>" class="btn btn-outline-primary <%= currentPage <= 1 ? "disabled" : "" %>">Previous</a>

                    <span class="page-info"><%= currentPage %> / <%= totalPages %></span>

                    <% String nextLink = ctx + "/category?page=" + (currentPage + 1) + searchParam + sortParam; %>
                    <a href="<%= currentPage < totalPages ? nextLink : "#" %>" class="btn btn-outline-primary <%= currentPage >= totalPages ? "disabled" : "" %>">Next</a>
                </nav>
                <% } %>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="<%= ctx %>/category" method="post">
                            <input type="hidden" name="action" value="add" />
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
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

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="<%= ctx %>/category" method="post">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" id="editId">
                            <div class="mb-3">
                                <label for="editName" class="form-label">Name</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="editDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
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

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        
        <script>
            function editCategory(id, name, description) {
                document.getElementById('editId').value = id;
                document.getElementById('editName').value = name;
                document.getElementById('editDescription').value = description;
            }
        </script>
    </body>
</html>
