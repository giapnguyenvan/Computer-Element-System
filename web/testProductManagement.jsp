<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Test Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                padding: 20px;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px 15px 0 0 !important;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <h3 class="mb-0">
                        <i class="fas fa-boxes me-2"></i>Product Management Test
                    </h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="productsTable" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Brand</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${product}">
                                    <tr>
                                        <td>${product.productId}</td>
                                        <td>${product.name}</td>
                                        <td>${product.brandName}</td>
                                        <td>${product.componentTypeName}</td>
                                        <td>$${product.price}</td>
                                        <td>${product.stock}</td>
                                        <td>
                                            <span class="badge ${product.status == 'Active' ? 'bg-success' : 'bg-danger'}">
                                                ${product.status != null ? product.status : 'Active'}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary edit-product" data-product-id="${product.productId}">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger delete-product" data-product-id="${product.productId}">
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

        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            $(document).ready(function() {
                // Initialize DataTable
                const table = $('#productsTable').DataTable({
                    pageLength: 10,
                    lengthMenu: [[5, 10, 25, 50], [5, 10, 25, 50]],
                    order: [[0, 'desc']],
                    responsive: true,
                    language: {
                        search: "Search products:",
                        lengthMenu: "Show _MENU_ products per page",
                        info: "Showing _START_ to _END_ of _TOTAL_ products"
                    }
                });

                // Edit product
                $('#productsTable').on('click', '.edit-product', function() {
                    const productId = $(this).data('product-id');
                    alert('Edit product ID: ' + productId);
                });

                // Delete product
                $('#productsTable').on('click', '.delete-product', function() {
                    const productId = $(this).data('product-id');
                    if (confirm('Are you sure you want to delete this product?')) {
                        alert('Delete product ID: ' + productId);
                    }
                });
            });
        </script>
    </body>
</html> 