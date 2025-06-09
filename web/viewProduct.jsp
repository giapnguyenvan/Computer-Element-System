<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, model.Products" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%
    String sortBy = request.getParameter("sortBy");
    if (sortBy == null) sortBy = "id";
    String order = request.getParameter("order");
    if (order == null) order = "asc";
    String baseUrl = request.getContextPath() + "/productservlet?service=viewProduct";
%>

<%! 
    public String getNextOrder(String col, String sortBy, String order) {
        if (sortBy == null || !sortBy.equals(col)) return "asc";
        if ("asc".equalsIgnoreCase(order)) return "desc";
        if ("desc".equalsIgnoreCase(order)) return "none";
        return "asc";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .search-section,
            .filter-section,
            .insert-btn {
                margin: 5px;
            }

            .insert-btn {
                padding: 8px 15px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
                vertical-align: middle;
            }

            thead {
                background-color: #f2f2f2;
            }

            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tbody tr:hover {
                background-color: #e9f5ff;
            }

            .sort-link {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            form {
                display: inline-block;
            }

            input[type="text"] {
                padding: 5px;
                width: 250px;
            }

            button {
                padding: 6px 10px;
                margin-left: 5px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <div class="top-bar">
            <!-- Left: Insert Button -->
            <!--
            <a href="${pageContext.request.contextPath}/productservlet?service=insertProduct" class="insert-btn">Insert Product</a>
            -->          
            <button class="insert-btn" data-bs-toggle="modal" data-bs-target="#addProductModal">Insert Product</button>

            <!-- Middle: Filters -->
            <form action="productservlet" method="get" style="display: inline;">
                <input type="hidden" name="service" value="filterProducts"/>
                <select name="brand" onchange="this.form.submit()">
                    <option value="">-- Select Brand --</option>
                    <c:forEach var="b" items="${brand}">
                        <option value="${b}" ${param.brand == b ? 'selected' : ''}>${b}</option>
                    </c:forEach>
                </select>
                <select name="category_id" onchange="this.form.submit()">
                    <option value="">-- Select Category --</option>
                    <c:forEach var="c" items="${category}">
                        <option value="${c.id}" ${param.category_id == c.id ? 'selected' : ''}>${c.name}</option>
                    </c:forEach>
                </select>
            </form>

            <!-- Right: Search -->
            <div class="search-section">
                <form action="${pageContext.request.contextPath}/productservlet" method="get">
                    <input type="hidden" name="service" value="searchProduct" />
                    <input type="text" name="keyword" placeholder="Search by name, brand, description..." value="${keyword != null ? keyword : ''}" />
                    <button type="submit">Search & Sort</button>
                </form>
            </div>
        </div>

        <div class="col-sm-12">
            <div class="bg-light rounded p-4">
                <table class="table table-striped table-hover align-middle">
                    <thead class="table-light">
                        <tr class="text-center">
                            <th>
                                <a class="sort-link" href="<%= 
                                    "none".equals(getNextOrder("product_id", sortBy, order)) 
                                    ? baseUrl 
                                    : baseUrl + "&sortBy=id&order=" + getNextOrder("product_id", sortBy, order)
                                   %>">
                                    Product ID
                                    <c:choose>
                                        <c:when test="${param.sortBy eq 'id'}">
                                            <c:choose>
                                                <c:when test="${param.order eq 'asc'}"> ↑</c:when>
                                                <c:when test="${param.order eq 'desc'}"> ↓</c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Two-way arrow when NOT sorted -->
                                            ⇅
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th>Name</th>
                            <th>Brand</th>
                            <th><a class="sort-link text-decoration-none text-primary fw-bold" 
                                   href="<%= 
                                       "none".equals(getNextOrder("category_id", sortBy, order)) 
                                       ? baseUrl 
                                       : baseUrl + "&sortBy=category_id&order=" + getNextOrder("category_id", sortBy, order) 
                                   %>">Category
                                    <c:choose>
                                        <c:when test="${param.sortBy eq 'category_id'}">
                                            <c:choose>
                                                <c:when test="${param.order eq 'asc'}"> ↑</c:when>
                                                <c:when test="${param.order eq 'desc'}"> ↓</c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Two-way arrow when NOT sorted -->
                                            ⇅
                                        </c:otherwise>
                                    </c:choose></a>
                            </th>
                            <th><a class="sort-link text-decoration-none text-primary fw-bold" 
                                   href="<%= 
                                       "none".equals(getNextOrder("price", sortBy, order)) 
                                       ? baseUrl 
                                       : baseUrl + "&sortBy=price&order=" + getNextOrder("price", sortBy, order) 
                                   %>">Price
                                    <c:choose>
                                        <c:when test="${param.sortBy eq 'price'}">
                                            <c:choose>
                                                <c:when test="${param.order eq 'asc'}"> ↑</c:when>
                                                <c:when test="${param.order eq 'desc'}"> ↓</c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Two-way arrow when NOT sorted -->
                                            ⇅
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th><a class="sort-link text-decoration-none text-primary fw-bold" 
                                   href="<%= 
                                       "none".equals(getNextOrder("stock", sortBy, order)) 
                                       ? baseUrl 
                                       : baseUrl + "&sortBy=stock&order=" + getNextOrder("stock", sortBy, order) 
                                   %>">Stock
                                    <c:choose>
                                        <c:when test="${param.sortBy eq 'stock'}">
                                            <c:choose>
                                                <c:when test="${param.order eq 'asc'}"> ↑</c:when>
                                                <c:when test="${param.order eq 'desc'}"> ↓</c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Two-way arrow when NOT sorted -->
                                            ⇅
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th>Image</th>
                            <th>Description</th>
                            <th>Spec</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${product}" var="product">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.brand}</td>
                                <td>${product.categoryName}</td>
                                <td>${product.price}</td>
                                <td>${product.stock}</td>
                                <td><img src="${product.image_url}" alt="${product.name}" class="img-thumbnail" style="max-width: 100px;"></td>
                                <td>${product.description}</td>
                                <td>${product.spec_description}</td>
                                <td>${product.status}</td>
                                <td>
                                    <button 
                                        type="button" 
                                        class="btn btn-sm btn-info" 
                                        onclick="editProduct(this)" 
                                        data-id="${product.id}" 
                                        data-name="${product.name}" 
                                        data-brand="${product.brand}" 
                                        data-category_id="${product.category_id}" 
                                        data-price="${product.price}" 
                                        data-stock="${product.stock}" 
                                        data-description="${product.description}" 
                                        data-spec_description="${product.spec_description}" 
                                        data-image_url="${fn:escapeXml(product.image_url)}"
                                        data-status="${product.status}"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#editProductModal">
                                        Edit
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ADD PRODUCT MODAL -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="productservlet?service=insertProduct" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name:</label>
                                <input id="name" type="text" name="name" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="brand" class="form-label">Brand:</label>
                                <input id="brand" type="text" name="brand" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="category_id" class="form-label">Category:</label>
                                <select id="category_id" name="category_id" class="form-select" required>
                                    <option value="">-- Select Category --</option>
                                    <c:forEach var="c" items="${category}">
                                        <option value="${c.id}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label">Price:</label>
                                <input id="price" type="number" name="price" step="0.01" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="stock" class="form-label">Stock:</label>
                                <input id="stock" type="number" name="stock" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="image_url" class="form-label">Image URL:</label>
                                <input id="image_url" type="text" name="image_url" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description:</label>
                                <textarea id="description" name="description" class="form-control w-100" rows="3" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="spec_description" class="form-label">Specification:</label>
                                <textarea id="spec_description" name="spec_description" class="form-control w-100" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="status" class="form-label">Status:</label>
                                <select id="status" name="status" class="form-select" required>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Add Product</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- EDIT PRODUCT MODAL -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="productservlet?service=updateProduct" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" id="edit-id" name="id" />

                            <div class="mb-3">
                                <label for="edit-name" class="form-label">Name:</label>
                                <input id="edit-name" type="text" name="name" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="edit-brand" class="form-label">Brand:</label>
                                <input id="edit-brand" type="text" name="brand" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="edit-category_id" class="form-label">Category:</label>
                                <select id="edit-category_id" name="category_id" class="form-select" required>
                                    <option value="">-- Select Category --</option>
                                    <c:forEach var="c" items="${category}">
                                        <option value="${c.id}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="edit-price" class="form-label">Price:</label>
                                <input id="edit-price" type="number" name="price" step="0.01" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="edit-stock" class="form-label">Stock:</label>
                                <input id="edit-stock" type="number" name="stock" class="form-control w-100" required />
                            </div>

                            <div class="mb-3">
                                <label for="edit-image_url" class="form-label">Image URL:</label>
                                <input id="edit-image_url" type="text" name="image_url" class="form-control w-100" required />
                                <img id="edit-image-preview" src="" alt="Product Image" class="img-fluid mt-2" style="max-height: 200px;" />
                            </div>

                            <div class="mb-3">
                                <label for="edit-description" class="form-label">Description:</label>
                                <textarea id="edit-description" name="description" class="form-control w-100" rows="3" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="edit-spec_description" class="form-label">Specification:</label>
                                <textarea id="edit-spec_description" name="spec_description" class="form-control w-100" rows="3"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="edit-status" class="form-label">Status:</label>
                                <select id="edit-status" name="status" class="form-select" required>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Update Product</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function editProduct(element) {
                                                const id = element.getAttribute('data-id');
                                                const name = element.getAttribute('data-name');
                                                const brand = element.getAttribute('data-brand');
                                                const category_id = element.getAttribute('data-category_id');
                                                const price = element.getAttribute('data-price');
                                                const stock = element.getAttribute('data-stock');
                                                const description = element.getAttribute('data-description');
                                                const spec_description = element.getAttribute('data-spec_description');
                                                const image_url = element.getAttribute('data-image_url');
                                                const status = element.getAttribute('data-status');

                                                document.getElementById('edit-id').value = id;
                                                document.getElementById('edit-name').value = name;
                                                document.getElementById('edit-brand').value = brand;
                                                document.getElementById('edit-category_id').value = category_id;
                                                document.getElementById('edit-price').value = price;
                                                document.getElementById('edit-stock').value = stock;
                                                document.getElementById('edit-description').value = description;
                                                document.getElementById('edit-spec_description').value = spec_description;
                                                document.getElementById('edit-image_url').value = image_url;
                                                document.getElementById('edit-image-preview').src = image_url;
                                                document.getElementById('edit-status').value = status;
                                            }

        </script>
    </body>
</html>
