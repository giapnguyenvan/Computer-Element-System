<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
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
    <h2 class="mb-4">Add New Product</h2>

    <!-- ADD PRODUCT FORM -->
    <form action="productservlet?service=insertProduct" method="post" novalidate>
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input id="name" type="text" name="name" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="brand" class="form-label">Brand:</label>
            <input id="brand" type="text" name="brand" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="category_id" class="form-label">Category ID:</label>
            <input id="category_id" type="number" name="category_id" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input id="price" type="number" step="0.01" name="price" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="stock" class="form-label">Stock:</label>
            <input id="stock" type="number" name="stock" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" rows="4" class="form-control"></textarea>
        </div>

        <div class="mb-3">
            <label for="spec_description" class="form-label">Spec Description:</label>
            <textarea id="spec_description" name="spec_description" rows="4" class="form-control"></textarea>
        </div>

        <div class="mb-3">
            <label for="image_url" class="form-label">Image URL:</label>
            <input id="image_url" type="text" name="image_url" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Add Product</button>
        <a href="productservlet?service=viewProduct" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>
</body>
</html>
