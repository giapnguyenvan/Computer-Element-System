<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <h2 class="mb-4">Add New Product</h2>
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/productservlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="service" value="insertProduct">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="productName" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="name" required>
                    </div>
                    <div class="col-md-6">
                        <label for="brand" class="form-label">Brand</label>
                        <input type="text" class="form-control" id="brand" name="brand" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="category" class="form-label">Category</label>
                        <select class="form-select" id="category" name="category_id" required>
                            <option value="">Select Category</option>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" required>
                    </div>
                    <div class="col-md-6">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="specDescription" class="form-label">Specification Description</label>
                    <textarea class="form-control" id="specDescription" name="spec_description" rows="4" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="image" class="form-label">Product Image</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
                </div>
                <div class="d-flex justify-content-end">
                    <a href="${pageContext.request.contextPath}/adminLayout.jsp?content=productContent.jsp&title=Product Management" class="btn btn-secondary me-2">Cancel</a>
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.getElementById('addProductForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    
    fetch('${pageContext.request.contextPath}/productservlet', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            window.location.href = '${pageContext.request.contextPath}/adminLayout.jsp?content=productContent.jsp&title=Manage Products';
        } else {
            alert('Error adding product');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error adding product');
    });
});
</script> 