<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Product Management</h2>
        <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=addProduct.jsp&title=Add New Product" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Add New Product
        </a>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Brand</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Image</th>
                            <th>Description</th>
                            <th>Spec Description</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="product">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.brand}</td>
                                <td>${product.category_id}</td>
                                <td>${product.price}</td>
                                <td>${product.stock}</td>
                                <td><img src="${product.image_url}" alt="${product.name}" width="100" /></td>
                                <td>${product.description}</td>
                                <td>${product.spec_description}</td>
                                <td>
                                    <span class="badge bg-${product.status == 1 ? 'success' : 'danger'}">
                                        ${product.status == 1 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info me-2" onclick="viewProduct(${product.id})">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-warning me-2" onclick="editProduct(${product.id})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.id})">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function viewProduct(id) {
    window.location.href = '${pageContext.request.contextPath}/productservlet?service=view&id=' + id;
}

function editProduct(id) {
    window.location.href = '${pageContext.request.contextPath}/productservlet?service=edit&id=' + id;
}

function deleteProduct(id) {
    if (confirm('Are you sure you want to delete this product?')) {
        window.location.href = '${pageContext.request.contextPath}/productservlet?service=delete&id=' + id;
    }
}
</script> 