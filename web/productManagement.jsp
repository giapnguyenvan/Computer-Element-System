<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    .table-container {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
                            <button class="btn btn-warning btn-sm btn-add-cart" data-product-id="${product.productId}" data-product-name="${product.name}" data-product-price="${product.price}" title="Thêm vào giỏ hàng">
                                <i class="fas fa-cart-plus"></i>
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
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
    // Gắn sự kiện cho nút thêm vào giỏ hàng
    $('.btn-add-cart').off('click').on('click', function() {
        const productId = $(this).data('product-id');
        const productName = $(this).data('product-name');
        const productPrice = $(this).data('product-price');
        // Lấy componentType từ URL parameter
        const urlParams = new URLSearchParams(window.location.search);
        const componentType = urlParams.get('componentType');
        if (window.addToCart) {
            window.addToCart(componentType, productId, productName, productPrice);
        } else {
            alert(`Đã thêm: ${productName} - $${productPrice}`);
        }
    });
});
</script> 