<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Category> list = (List<Category>) request.getAttribute("categories");
    String ctx = request.getContextPath();
    String sortOrder = (String) request.getAttribute("sortOrder");
    String currentSort = sortOrder != null ? sortOrder : "asc";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">Category List</h2>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                        <i class="fas fa-plus"></i> Add New Category
                    </button>
                </div>
                <div class="card-body">
                    <!-- Form tìm kiếm và sắp xếp -->
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <form action="<%= ctx %>/category" method="get" class="d-flex">
                                <div class="input-group">
                                    <input type="text" name="search" class="form-control" placeholder="Search by name..." 
                                           value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>"/>
                                    <button type="submit" class="btn btn-outline-secondary">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="btn-group">
                                <a href="<%= ctx %>/category?sort=default" class="btn btn-outline-primary <%= currentSort.equals("default") ? "active" : "" %>">
                                    <i class="fas fa-sort"></i> Default
                                </a>
                                <a href="<%= ctx %>/category?sort=asc" class="btn btn-outline-primary <%= currentSort.equals("asc") ? "active" : "" %>">
                                    <i class="fas fa-sort-alpha-down"></i> A-Z
                                </a>
                                <a href="<%= ctx %>/category?sort=desc" class="btn btn-outline-primary <%= currentSort.equals("desc") ? "active" : "" %>">
                                    <i class="fas fa-sort-alpha-up"></i> Z-A
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách category -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name <i class="fas fa-sort"></i></th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) {
                                for (Category c : list) { %>
                                <tr>
                                    <td><%= c.getId() %></td>
                                    <td><%= c.getName() %></td>
                                    <td><%= c.getDescription() %></td>
                                    <td>
                                        <button class="btn btn-warning btn-sm" 
                                                onclick="editCategory(<%= c.getId() %>, '<%= c.getName() %>', '<%= c.getDescription() %>')"
                                                data-bs-toggle="modal" data-bs-target="#editCategoryModal">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="<%= ctx %>/category?action=delete&id=<%= c.getId() %>"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%  }
                            } else { %>
                                <tr><td colspan="4" class="text-center">No categories found.</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Phân trang -->
                    <% if (request.getAttribute("totalPages") != null && (Integer)request.getAttribute("totalPages") > 1) { %>
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <% for (int i = 1; i <= (Integer)request.getAttribute("totalPages"); i++) {
                                String link = ctx + "/category?page=" + i;
                                if (request.getAttribute("search") != null) {
                                    link += "&search=" + request.getAttribute("search");
                                }
                                if (currentSort != null) {
                                    link += "&sort=" + currentSort;
                                }
                            %>
                            <li class="page-item <%= (i == (Integer)request.getAttribute("currentPage")) ? "active" : "" %>">
                                <a class="page-link" href="<%= link %>"><%= i %></a>
                            </li>
                            <% } %>
                        </ul>
                    </nav>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1">
            <div class="modal-dialog">
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
            <div class="modal-dialog">
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
