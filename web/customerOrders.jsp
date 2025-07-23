<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    body {
        background-color: #f8f9fa;
    }
    .order-card {
        margin-bottom: 1.5rem;
        border: none;
        box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .order-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
        padding: 1rem;
    }
    .status-badge {
        font-size: 0.875rem;
        padding: 0.375rem 0.75rem;
    }
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
    }
    .status-shipping {
        background-color: #d4edda;
        color: #155724;
    }
    .status-completed {
        background-color: #d1ecf1;
        color: #0c5460;
    }
    .status-cancel {
        background-color: #f8d7da;
        color: #721c24;
    }
    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
    }
    .btn-cancel:hover {
        background-color: #dc3545;
        border-color: #dc3545;
    }
    .order-summary {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 1rem;
    }
</style>
<div class="container my-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col">
                            <h2><i class="fas fa-shopping-bag me-2"></i>Order History</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/homepageservlet">Home</a></li>
                    <li class="breadcrumb-item active">Order History</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${empty orders}">
            <div class="text-center py-5">
                <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">No orders yet</h4>
                <p class="text-muted">Start shopping and place your first order!</p>
                <a href="${pageContext.request.contextPath}/homepageservlet" class="btn btn-primary">
                    <i class="fas fa-shopping-cart me-2"></i>Shop Now
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <div class="card order-card">
                    <!-- Order Header -->
                    <div class="order-header">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h5 class="mb-1">Order #${order.id}</h5>
                                <small class="text-muted">
                                    <i class="fas fa-calendar me-1"></i>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </small>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <c:choose>
                                    <c:when test="${order.status == 'Pending'}">
                                        <span class="badge status-pending status-badge">Pending</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Shipping'}">
                                        <span class="badge status-shipping status-badge">Shipping</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Completed'}">
                                        <span class="badge status-completed status-badge">Completed</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Cancel'}">
                                        <span class="badge status-cancel status-badge">Cancelled</span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Order Body -->
                    <div class="card-body">
                        <!-- Order Details -->
                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                            <div class="row mb-3 pb-3 border-bottom">
                                <div class="col-md-2">
                                    <c:choose>
                                        <c:when test="${not empty orderDetail.product.productImages and not empty orderDetail.product.productImages[0].imageUrl}">
                                            <img src="${orderDetail.product.productImages[0].imageUrl}" class="product-image" alt="${orderDetail.product.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image d-flex align-items-center justify-content-center bg-light">
                                                <i class="fas fa-microchip fa-2x text-primary"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="mb-1">${orderDetail.product.name}</h6>
                                    <c:if test="${not empty orderDetail.product.description}">
                                        <p class="text-muted mb-1 small">${orderDetail.product.description}</p>
                                    </c:if>
                                    <small class="text-muted">
                                        <span class="badge bg-secondary">Quantity: ${orderDetail.quantity}</span>
                                        <c:if test="${not empty orderDetail.product.status}">
                                            <span class="badge bg-info ms-1">${orderDetail.product.status}</span>
                                        </c:if>
                                    </small>
                                </div>
                                <div class="col-md-4 text-md-end">
                                    <div class="price">
                                        <span class="fw-bold text-primary">
                                            <fmt:formatNumber value="${orderDetail.price}" type="currency" 
                                                              currencySymbol="₫" groupingUsed="true" />
                                        </span>
                                    </div>
                                    <c:if test="${orderDetail.quantity > 1}">
                                        <small class="text-muted">
                                            <fmt:formatNumber value="${orderDetail.price / orderDetail.quantity}" 
                                                              type="currency" currencySymbol="₫" groupingUsed="true" /> / sản phẩm
                                        </small>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Order Summary -->
                        <div class="row">
                            <div class="col-md-8">
                                <div class="order-info">
                                    <p class="mb-1"><i class="fas fa-map-marker-alt me-2"></i><strong>Shipping Address:</strong></p>
                                    <p class="text-muted mb-2">${order.shippingAddress}</p>

                                    <c:if test="${not empty order.paymentMethod}">
                                        <p class="mb-1"><i class="fas fa-credit-card me-2"></i><strong>Payment Method:</strong></p>
                                        <p class="text-muted">${order.paymentMethod.name}</p>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="order-summary">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Shipping Fee:</span>
                                        <span>
                                            <fmt:formatNumber value="${order.shippingFee}" type="currency" 
                                                              currencySymbol="₫" groupingUsed="true" />
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <strong>Total:</strong>
                                        <strong class="text-primary">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" 
                                                              currencySymbol="₫" groupingUsed="true" />
                                        </strong>
                                    </div>

                                    <!-- Action Buttons -->
                                    <c:if test="${order.status == 'Pending'}">
                                        <form method="post" action="customer-orders" class="d-inline" onsubmit="return confirmCancel()">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                                                <i class="fas fa-times me-2"></i>Cancel Order
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
                                            function confirmCancel() {
                                                return confirm('Are you sure you want to cancel this order? This action cannot be undone.');
                                            }
    // Robust collapse toggle - checks state explicitly
    document.addEventListener('DOMContentLoaded', function(){
        document.querySelectorAll('.order-header').forEach(function(header){
            header.addEventListener('click', function(e){
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if(!target) return;

                const collapse = bootstrap.Collapse.getOrCreateInstance(target);
                
                // Check if body is currently shown
                if(target.classList.contains('show')){
                    collapse.hide();           // Close
                    this.classList.add('collapsed');
                } else {
                    collapse.show();           // Open  
                    this.classList.remove('collapsed');
                }
            });
        });
    });
</script>