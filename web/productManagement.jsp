<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Select Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .main-container {
                padding: 20px;
                max-width: 1400px;
                margin: 0 auto;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 20px;
            }
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .btn-primary:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                transform: translateY(-1px);
            }
            .table-container {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .dataTables_wrapper .dataTables_filter {
                margin-bottom: 20px;
            }
            .dataTables_wrapper .dataTables_filter input {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 8px 12px;
                width: 300px;
            }
            .dataTables_wrapper .dataTables_length select {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 5px 10px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                border-radius: 8px;
                margin: 0 2px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                color: white !important;
            }
            .product-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e9ecef;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
            }
            .btn-sm {
                padding: 5px 10px;
                border-radius: 6px;
                font-size: 12px;
            }
            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 500;
            }
            .status-active {
                background-color: #d4edda;
                color: #155724;
            }
            .status-inactive {
                background-color: #f8d7da;
                color: #721c24;
            }

        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- Header Card -->
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="mb-0">
                            <i class="fas fa-boxes me-2"></i>Select Product
                        </h3>
                        <div>
                            <span class="text-light">
                                <c:if test="${not empty componentType}">
                                    <i class="fas fa-microchip me-1"></i>${componentType}
                                </c:if>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products DataTable -->
            <div class="table-container">
                <div class="mb-3">
                    <c:if test="${not empty componentType}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Selecting products for <strong>${componentType}</strong>. Click the <i class="fas fa-check text-success"></i> button to choose a product for your PC build.
                        </div>
                    </c:if>
                </div>
                <table id="productsTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
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
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img src="${product.imageUrl}" class="product-image" alt="Product">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                <i class="fas fa-image text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${product.name}</td>
                                <td>${product.brandName}</td>
                                <td>${product.componentTypeName}</td>
                                <td>$${product.price}</td>
                                <td>${product.stock}</td>
                                <td>
                                    <span class="status-badge ${product.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                        ${product.status != null ? product.status : 'Active'}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-success btn-sm select-product" data-product-id="${product.productId}" data-product-name="${product.name}" data-product-price="${product.price}" title="Select">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            $(document).ready(function() {
                // Initialize DataTable
                const table = $('#productsTable').DataTable({
                    pageLength: 15,
                    lengthMenu: [[10, 15, 25, 50], [10, 15, 25, 50]],
                    order: [[5, 'asc']], // Sort by price ascending
                    responsive: true,
                    language: {
                        search: "Search products:",
                        lengthMenu: "Show _MENU_ products per page",
                        info: "Showing _START_ to _END_ of _TOTAL_ products",
                        paginate: {
                            first: "First",
                            last: "Last",
                            next: "Next",
                            previous: "Previous"
                        }
                    },
                    columnDefs: [
                        { orderable: false, targets: [1, 8] }, // Image and Actions columns
                        { className: "text-center", targets: [1, 6, 7, 8] }
                    ]
                });





                // Select product for PC Builder
                $('#productsTable').on('click', '.select-product', function() {
                    const productId = $(this).data('product-id');
                    const productName = $(this).data('product-name');
                    const productPrice = $(this).data('product-price');
                    
                    // Lấy componentType từ URL parameter
                    const urlParams = new URLSearchParams(window.location.search);
                    const componentType = urlParams.get('componentType');
                    
                    if (componentType) {
                        // Gọi hàm từ parent window
                        if (window.parent && window.parent.selectComponentFromIframe) {
                            window.parent.selectComponentFromIframe(productId, productName, productPrice, componentType);
                        } else {
                            // Fallback: hiển thị thông báo
                            alert(`Đã chọn: ${productName} - $${productPrice}`);
                        }
                    } else {
                        alert('Không xác định được loại linh kiện');
                    }
                });
            });


        </script>
    </body>
</html> 