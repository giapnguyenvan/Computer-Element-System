<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - Product Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 30px; }
        .admin-content { margin-left: 250px; /* adjust if your sidebar is a different width */ }
        .product-image { max-width: 100%; border-radius: 8px; }
    </style>
</head>
<body>
    <!-- Admin Sidebar Include -->
    <jsp:include page="adminSidebar.jsp"/>

    <div class="container admin-content mt-4">
        <h2>Product Detail (Admin View)</h2>
        <div class="row">
            <!-- Product Image -->
            <div class="col-md-5">
                <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
            </div>
            <!-- Product Info -->
            <div class="col-md-7">
                <h3>${product.name}</h3>
                <h5 class="text-muted">${product.brandName}</h5>
                <h4 class="text-danger mb-3">$${product.price}</h4>
                <p><strong>Category:</strong> ${product.componentTypeName}</p>
                <p><strong>Stock:</strong> ${product.stock}</p>
                <p><strong>Status:</strong> ${product.status}</p>
                <p><strong>Model:</strong> ${product.model}</p>
                <p><strong>Series:</strong> ${product.seriesName}</p>
                <p><strong>SKU:</strong> ${product.sku}</p>
                <p><strong>Created At:</strong> ${product.createdAt}</p>
                <hr>
                <h5>Description</h5>
                <p>${product.description}</p>
            </div>
        </div>
        <hr>
        <!-- You can add admin-only actions here, like Edit/Delete buttons -->
        <a href="productservlet?service=viewProduct" class="btn btn-secondary mt-3">Back to Product List</a>
    </div>
</body>
</html>
