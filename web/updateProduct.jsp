<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-img {
            max-width: 150px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h2 class="mb-4">Edit Product</h2>

    <form action="productservlet?service=updateProduct" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="${product.id}" />

        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input id="name" type="text" name="name" value="${product.name}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="brand" class="form-label">Brand:</label>
            <input id="brand" type="text" name="brand" value="${product.brand}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="category_id" class="form-label">Category ID:</label>
            <input id="category_id" type="number" name="category_id" value="${product.category_id}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input id="price" type="text" name="price" value="${product.price}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="stock" class="form-label">Stock:</label>
            <input id="stock" type="number" name="stock" value="${product.stock}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" rows="4" class="form-control">${product.description}</textarea>
        </div>

        <div class="mb-3">
            <label for="spec_description" class="form-label">Spec Description:</label>
            <textarea id="spec_description" name="spec_description" rows="4" class="form-control">${product.spec_description}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Image URL:</label><br />
            <img src="${product.image_url}" alt="${product.name}" class="product-img img-thumbnail" />
            <input type="text" name="image_url" value="${product.image_url}" class="form-control mt-2" required />
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="Active" ${product.status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${product.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="productservlet?service=viewProduct" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>
</body>
</html>
