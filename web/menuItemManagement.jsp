<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>
<%@ page import="com.google.gson.Gson" %>
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
    String defaultUrl = ctx + "/menuItemManagement?sort=default" + searchParam;
    String ascUrl = ctx + "/menuItemManagement?sort=asc" + searchParam;
    String descUrl = ctx + "/menuItemManagement?sort=desc" + searchParam;
    // Khai báo icon phổ biến dùng cho cả Add/Edit
    String[] iconClasses = {"fa-solid fa-house","fa-solid fa-user","fa-solid fa-gear","fa-solid fa-list","fa-solid fa-cart-shopping","fa-solid fa-star","fa-solid fa-book","fa-solid fa-envelope","fa-solid fa-bell","fa-solid fa-chart-bar"};
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management</title>
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
    </style>
</head>
<body class="bg-light">
<div class="container my-5">
    <div class="table-wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="mb-0">Menu Items</h4>
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
                    <th>Status <a href="<%= ctx %>/menuItemManagement?sort=<%= "status".equals(currentSort) ? "status_desc" : "status" %><%= searchParam %>" class="ms-1" title="Sort by Status">
                        <i class="fas fa-sort<%= "status".equals(currentSort) ? "-up" : ("status_desc".equals(currentSort) ? "-down" : "") %>"></i>
                    </a></th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (list != null) { 
                    for (MenuItem item : list) {
                %>
                <tr>
                    <td><%= item.getMenuItemId() %></td>
                    <td><%= item.getName() %></td>
                    <td><i class="<%= item.getIcon() %>"></i></td>
                    <td><%= item.getUrl() %></td>
                    <td><%= item.getParentId() != null ? item.getParentId() : "N/A" %></td>
                    <td><%= item.getStatus() %></td>
                    <td class="text-center">
                        <button class="btn-action" 
                                onclick="editMenuItem(this)"
                                data-bs-toggle="modal"
                                data-bs-target="#editMenuItemModal"
                                title="Edit"
                                data-id="<%= item.getMenuItemId() %>">
                            <i class="fas fa-edit"></i>
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
            <a href="<%= currentPage > 1 ? prevLink : "#" %>" class="btn btn-outline-primary <%= currentPage <= 1 ? "disabled" : "" %>">Previous</a>
            <span class="page-info"><%= currentPage %> / <%= totalPages %></span>
            <% String nextLink = ctx + "/menuItemManagement?page=" + (currentPage + 1) + searchParam + sortParam; %>
            <a href="<%= currentPage < totalPages ? nextLink : "#" %>" class="btn btn-outline-primary <%= currentPage >= totalPages ? "disabled" : "" %>">Next</a>
        </nav>
        <% } %>
    </div>
</div>
<!-- Add Menu Item Modal -->
<div class="modal fade" id="addMenuItemModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Menu Item</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/menuItemManagement" method="post" novalidate>
                    <input type="hidden" name="action" value="add" />
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                        <div class="invalid-feedback">Tên không được để trống và không quá 100 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chọn Icon</label>
                        <div class="d-flex flex-wrap gap-2" id="iconListAdd">
                            <% for(String icon : iconClasses) { %>
                                <label class="btn btn-outline-secondary mb-1">
                                    <input type="radio" name="iconRadioAdd" value="<%= icon %>" autocomplete="off" style="display:none;">
                                    <i class="<%= icon %> fa-2x"></i>
                                </label>
                            <% } %>
                        </div>
                        <input type="text" class="form-control mt-2" id="iconAdd" name="icon" required placeholder="Go to fontawesome.com to take icon">
                        <div class="invalid-feedback">Icon không được để trống và không quá 255 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label for="url" class="form-label">URL</label>
                        <input type="text" class="form-control" id="url" name="url">
                        <div class="invalid-feedback">URL không được quá 255 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label for="parentId" class="form-label">Parent ID</label>
                        <input type="number" class="form-control" id="parentId" name="parentId">
                        <!-- Không có invalid-feedback vì không required -->
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
<!-- Edit Menu Item Modal -->
<div class="modal fade" id="editMenuItemModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Menu Item</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/menuItemManagement" method="post" novalidate>
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" id="editId">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                        <div class="invalid-feedback">Tên không được để trống và không quá 100 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chọn Icon</label>
                        <div class="d-flex flex-wrap gap-2" id="iconListEdit">
                            <% for(String icon : iconClasses) { %>
                                <label class="btn btn-outline-secondary mb-1">
                                    <input type="radio" name="iconRadioEdit" value="<%= icon %>" autocomplete="off" style="display:none;">
                                    <i class="<%= icon %> fa-2x"></i>
                                </label>
                            <% } %>
                        </div>
                        <input type="text" class="form-control mt-2" id="iconEdit" name="icon" required placeholder="Go to fontawesome.com to take icon">
                        <div class="invalid-feedback">Icon không được để trống và không quá 255 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label for="editUrl" class="form-label">URL</label>
                        <input type="text" class="form-control" id="editUrl" name="url">
                        <div class="invalid-feedback">URL không được quá 255 ký tự.</div>
                    </div>
                    <div class="mb-3">
                        <label for="editParentId" class="form-label">Parent ID</label>
                        <input type="number" class="form-control" id="editParentId" name="parentId">
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
<div id="menuItemsJsonContainer" data-json="<%= new Gson().toJson(list).replace("\"", "&quot;").replace("'", "&#39;") %>" style="display:none;"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Lấy dữ liệu MenuItem từ data-attribute của HTML và phân tích cú pháp JSON
    var menuItemsData = JSON.parse(document.getElementById('menuItemsJsonContainer').dataset.json);

    console.log("menuItemsData:", menuItemsData);

    // Chọn icon cho modal Add
    document.querySelectorAll('#iconListAdd input[type=radio]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.getElementById('iconAdd').value = this.value;
        });
    });
    // Chọn icon cho modal Edit
    document.querySelectorAll('#iconListEdit input[type=radio]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.getElementById('iconEdit').value = this.value;
        });
    });
    // Khi mở modal Edit, tự động tick vào icon hiện tại nếu có
    function editMenuItem(element) {
        const id = parseInt(element.dataset.id);
        const item = menuItemsData.find(i => i.menuItemId === id);

        if (item) {
            document.getElementById('editId').value = item.menuItemId;
            document.getElementById('editName').value = item.name;
            document.getElementById('editUrl').value = item.url;
            document.getElementById('editParentId').value = item.parentId === null ? '' : item.parentId;
            document.getElementById('editStatus').value = item.status;
            document.getElementById('iconEdit').value = item.icon;

            // Chọn radio button icon tương ứng
            document.querySelectorAll('#iconListEdit input[type=radio]').forEach(function(radio) {
                if (radio.value === item.icon) {
                    radio.checked = true;
                } else {
                    radio.checked = false;
                }
            });

            // Reset validation states when modal opens
            document.querySelector('#editMenuItemModal form').classList.remove('was-validated');
            document.querySelectorAll('#editMenuItemModal .form-control, #editMenuItemModal .form-select').forEach(function(input) {
                input.classList.remove('is-invalid');
            });

            // Hiển thị modal
            var editModal = new bootstrap.Modal(document.getElementById('editMenuItemModal'));
            editModal.show();
        } else {
            console.error("Menu item not found for ID:", id);
            alert("Không tìm thấy mục menu này để chỉnh sửa.");
        }
    }
    
    function deleteMenuItem(id) {
        if (confirm('Are you sure you want to delete this menu item?')) {
            // Implement delete functionality
            // Ví dụ: window.location.href = '${pageContext.request.contextPath}/menuItemManagement?action=delete&id=' + id;
            alert('Chức năng xóa sẽ được xử lý ở backend cho ID: ' + id);
        }
    }

    // Custom validation for Add Menu Item form
    (function() {
        'use strict';
        var form = document.querySelector('#addMenuItemModal form');

        form.addEventListener('submit', function(event) {
            let isValid = true;

            // Kiểm tra trường tên không chỉ là khoảng trắng và giới hạn ký tự
            var nameInput = form.querySelector('#name');
            if (nameInput.value.trim() === '') {
                nameInput.setCustomValidity('Tên không được để trống.');
                isValid = false;
            } else if (nameInput.value.length > 100) {
                nameInput.setCustomValidity('Tên không được quá 100 ký tự.');
                isValid = false;
            } else {
                nameInput.setCustomValidity('');
            }

            // Kiểm tra trường icon không chỉ là khoảng trắng và giới hạn ký tự
            var iconInput = form.querySelector('#iconAdd');
            if (iconInput.value.trim() === '') {
                iconInput.setCustomValidity('Icon không được để trống.');
                isValid = false;
            } else if (iconInput.value.length > 255) {
                iconInput.setCustomValidity('Icon không được quá 255 ký tự.');
                isValid = false;
            } else {
                iconInput.setCustomValidity('');
            }

            // Kiểm tra trường URL và giới hạn ký tự (không required)
            var urlInput = form.querySelector('#url');
            if (urlInput.value.length > 255) {
                urlInput.setCustomValidity('URL không được quá 255 ký tự.');
                isValid = false;
            } else {
                urlInput.setCustomValidity('');
            }

            if (!isValid || !form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    })();

    // Custom validation for Edit Menu Item form
    (function() {
        'use strict';
        var form = document.querySelector('#editMenuItemModal form');

        form.addEventListener('submit', function(event) {
            let isValid = true;

            // Kiểm tra trường tên không chỉ là khoảng trắng và giới hạn ký tự
            var editNameInput = form.querySelector('#editName');
            if (editNameInput.value.trim() === '') {
                editNameInput.setCustomValidity('Tên không được để trống.');
                isValid = false;
            } else if (editNameInput.value.length > 100) {
                editNameInput.setCustomValidity('Tên không được quá 100 ký tự.');
                isValid = false;
            } else {
                editNameInput.setCustomValidity('');
            }

            // Kiểm tra trường icon không chỉ là khoảng trắng và giới hạn ký tự
            var editIconInput = form.querySelector('#iconEdit');
            if (editIconInput.value.trim() === '') {
                editIconInput.setCustomValidity('Icon không được để trống.');
                isValid = false;
            } else if (editIconInput.value.length > 255) {
                editIconInput.setCustomValidity('Icon không được quá 255 ký tự.');
                isValid = false;
            } else {
                editIconInput.setCustomValidity('');
            }

            // Kiểm tra trường URL và giới hạn ký tự (không required)
            var editUrlInput = form.querySelector('#editUrl');
            if (editUrlInput.value.length > 255) {
                editUrlInput.setCustomValidity('URL không được quá 255 ký tự.');
                isValid = false;
            } else {
                editUrlInput.setCustomValidity('');
            }

            if (!isValid || !form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    })();
</script>
</body>
</html> 