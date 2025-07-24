<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
                --info-gradient: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
                --shadow-sm: 0 2px 4px rgba(0,0,0,.1);
                --shadow-md: 0 4px 12px rgba(0,0,0,.15);
                --shadow-lg: 0 8px 25px rgba(0,0,0,.2);
                --border-radius: 12px;
                --transition: all 0.3s ease;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                min-height: 100vh;
            }

            .page-header {
                background: white;
                padding: 2rem;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-md);
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
            }

            .page-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--primary-gradient);
            }

            .page-title {
                font-size: 2rem;
                font-weight: 700;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.5rem;
            }

            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin: 2rem 0;
            }

            .stat-card {
                background: white;
                padding: 1.5rem;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                border: none;
                transition: var(--transition);
                position: relative;
                overflow: hidden;
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-lg);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: var(--primary-gradient);
            }

            .stat-card.pending::before { background: var(--warning-gradient); }
            .stat-card.shipping::before { background: var(--info-gradient); }
            .stat-card.completed::before { background: var(--success-gradient); }
            .stat-card.cancelled::before { background: var(--danger-gradient); }

            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                color: white;
                margin-bottom: 1rem;
            }

            .stat-icon.pending { background: var(--warning-gradient); }
            .stat-icon.shipping { background: var(--info-gradient); }
            .stat-icon.completed { background: var(--success-gradient); }
            .stat-icon.cancelled { background: var(--danger-gradient); }

            .filter-section {
                background: white;
                padding: 2rem;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                margin-bottom: 2rem;
            }

            .filter-form {
                display: grid;
                grid-template-columns: 1fr auto auto auto auto;
                gap: 1rem;
                align-items: end;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-label {
                font-weight: 600;
                color: #374151;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-control {
                border: 2px solid #e5e7eb;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                transition: var(--transition);
                font-size: 0.875rem;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                outline: none;
            }

            .btn-filter {
                background: var(--primary-gradient);
                border: none;
                color: white;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 600;
                transition: var(--transition);
                height: fit-content;
            }

            .btn-filter:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
                color: white;
            }

            .table-wrapper {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                overflow: hidden;
            }

            .table-header {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                padding: 1.5rem 2rem;
                border-bottom: 1px solid #e5e7eb;
            }

            .table-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #1f2937;
                margin: 0;
            }

            .table {
                margin: 0;
                font-size: 0.875rem;
            }

            .table thead th {
                background-color: #f8fafc;
                border-bottom: 2px solid #e5e7eb;
                font-weight: 600;
                color: #374151;
                padding: 1rem;
                text-transform: uppercase;
                font-size: 0.75rem;
                letter-spacing: 0.05em;
            }

            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #f3f4f6;
            }

            .table tbody tr {
                transition: var(--transition);
            }

            .table tbody tr:hover {
                background-color: #f8fafc;
            }

            .status-badge {
                padding: 0.375rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                border: none;
                cursor: pointer;
                transition: var(--transition);
                min-width: 100px;
                text-align: center;
            }

            .status-badge.pending {
                background: linear-gradient(135deg, #fef3c7, #f59e0b);
                color: #92400e;
            }

            .status-badge.shipping {
                background: linear-gradient(135deg, #dbeafe, #3b82f6);
                color: #1e40af;
            }

            .status-badge.completed {
                background: linear-gradient(135deg, #d1fae5, #10b981);
                color: #065f46;
            }

            .status-badge.cancel {
                background: linear-gradient(135deg, #fee2e2, #ef4444);
                color: #991b1b;
            }

            .status-badge:hover {
                transform: translateY(-1px);
                box-shadow: var(--shadow-sm);
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #6b7280;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.3;
            }

            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 9999;
            }

            .loading-spinner {
                background: white;
                padding: 2rem;
                border-radius: var(--border-radius);
                text-align: center;
            }

            .spinner-border-custom {
                width: 3rem;
                height: 3rem;
                border: 0.3em solid transparent;
                border-top: 0.3em solid #667eea;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            @media (max-width: 768px) {
                .filter-form {
                    grid-template-columns: 1fr;
                    gap: 1rem;
                }
                
                .stats-cards {
                    grid-template-columns: 1fr 1fr;
                }
                
                .table-responsive {
                    font-size: 0.75rem;
                }
            }

            /* Custom Scrollbar */
            .table-responsive::-webkit-scrollbar {
                height: 8px;
            }

            .table-responsive::-webkit-scrollbar-track {
                background: #f1f5f9;
                border-radius: 4px;
            }

            .table-responsive::-webkit-scrollbar-thumb {
                background: var(--primary-gradient);
                border-radius: 4px;
            }

            .table-responsive::-webkit-scrollbar-thumb:hover {
                background: #5a67d8;
            }

            /* Pagination Styles */
            .pagination-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem 2rem;
                background: #f8fafc;
                border-top: 1px solid #e5e7eb;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .pagination-info {
                font-size: 0.875rem;
                color: #6b7280;
            }

            .pagination {
                margin: 0;
                gap: 0.25rem;
            }

            .page-link {
                border: none;
                color: #6b7280;
                padding: 0.5rem 0.75rem;
                border-radius: 8px;
                transition: var(--transition);
                font-weight: 500;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 40px;
                height: 40px;
            }

            .page-link:hover {
                background: var(--primary-gradient);
                color: white;
                transform: translateY(-2px);
                box-shadow: var(--shadow-sm);
            }

            .page-item.active .page-link {
                background: var(--primary-gradient);
                color: white;
                box-shadow: var(--shadow-sm);
            }

            .page-item:first-child .page-link,
            .page-item:last-child .page-link {
                font-size: 0.875rem;
            }

            .page-size-selector {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.875rem;
            }

            .page-size-selector .form-select {
                padding: 0.375rem 2rem 0.375rem 0.75rem;
                border: 2px solid #e5e7eb;
                border-radius: 6px;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 0.5rem center;
                background-repeat: no-repeat;
                background-size: 16px 12px;
                min-width: 80px;
            }

            .page-size-selector .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                outline: none;
            }

            /* Pagination responsive */
            @media (max-width: 768px) {
                .pagination-wrapper {
                    flex-direction: column;
                    text-align: center;
                    gap: 1rem;
                }
                
                .pagination {
                    order: 2;
                }
                
                .pagination-info {
                    order: 1;
                }
                
                .page-size-selector {
                    order: 3;
                    justify-content: center;
                }
                
                .page-link {
                    padding: 0.375rem 0.5rem;
                    min-width: 36px;
                    height: 36px;
                    font-size: 0.875rem;
                }
            }

            /* Animation for pagination */
            .page-item {
                transition: var(--transition);
            }

            .pagination-wrapper {
                animation: slideUp 0.3s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .shipper-select {
                min-width: 90px;
                max-width: 140px;
                width: 100%;
                border: 2px solid #667eea;
                border-radius: 8px;
                padding: 5px 28px 5px 10px;
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                font-size: 0.92rem;
                font-weight: 500;
                color: #374151;
                background-image: url('data:image/svg+xml;utf8,<svg fill="%23667eea" height="20" viewBox="0 0 20 20" width="20" xmlns="http://www.w3.org/2000/svg"><path d="M7.293 7.293a1 1 0 011.414 0L10 8.586l1.293-1.293a1 1 0 111.414 1.414l-2 2a1 1 0 01-1.414 0l-2-2a1 1 0 010-1.414z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 0.6rem center;
                background-size: 1em;
                transition: border-color 0.2s, box-shadow 0.2s;
            }
            .shipper-select:focus {
                border-color: #4facfe;
                box-shadow: 0 0 0 2px #a5b4fc44;
                outline: none;
            }
            .shipper-select:hover {
                border-color: #764ba2;
                background: linear-gradient(135deg, #e2e8f0 0%, #f8fafc 100%);
            }
        </style>
    </head>
    <body>
        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-spinner">
                <div class="spinner-border-custom"></div>
                <p class="mt-3 mb-0">Updating order status...</p>
            </div>
        </div>

        <div class="container my-5">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-bag me-3"></i>Order Management
                </h1>
                <p class="text-muted mb-0">Manage and track all customer orders efficiently</p>
                
                <!-- Quick Stats -->
                <div class="stats-cards">
                    <div class="stat-card pending">
                        <div class="stat-icon pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="mb-1">${pendingCount}</h3>
                        <p class="text-muted mb-0">Pending Orders</p>
                    </div>
                    <div class="stat-card shipping">
                        <div class="stat-icon shipping">
                            <i class="fas fa-truck"></i>
                        </div>
                        <h3 class="mb-1">${shippingCount}</h3>
                        <p class="text-muted mb-0">Shipping</p>
                    </div>
                    <div class="stat-card completed">
                        <div class="stat-icon completed">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h3 class="mb-1">${completedCount}</h3>
                        <p class="text-muted mb-0">Completed</p>
                    </div>
                    <div class="stat-card cancelled">
                        <div class="stat-icon cancelled">
                            <i class="fas fa-times-circle"></i>
                            </div>
                        <h3 class="mb-1">${cancelledCount}</h3>
                        <p class="text-muted mb-0">Cancelled</p>
                    </div>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <form action="order-list-of-shipper" method="get" class="filter-form">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-filter me-2"></i>Status Filter
                        </label>
                        <select class="form-control" id="status" name="status">
                            <option value="all" ${status == "all"?"selected":""}>All Orders</option>
                            <option value="Pending" ${status == "Pending"?"selected":""}>Pending</option>
                            <option value="Shipping" ${status == "Shipping"?"selected":""}>Shipping</option>
                            <option value="Completed" ${status == "Completed"?"selected":""}>Completed</option>
                            <option value="Cancel" ${status == "Cancel"?"selected":""}>Cancelled</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-calendar-alt me-2"></i>From Date
                        </label>
                        <input value="${fromDate}" type="date" class="form-control" name="fromDate">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-calendar-alt me-2"></i>To Date
                        </label>
                        <input value="${toDate}" type="date" class="form-control" name="toDate">
                    </div>
                    
                    <button type="submit" class="btn-filter">
                        <i class="fas fa-search me-2"></i>Filter Orders
                    </button>
                </form>
            </div>

            <!-- Orders Table -->
            <div class="table-wrapper">
                <div class="table-header">
                    <h2 class="table-title">
                        <i class="fas fa-list me-3"></i>Orders List
                    </h2>
                </div>
                
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>Order ID</th>
                                <th><i class="fas fa-user me-2"></i>Customer</th>
                                <th><i class="fas fa-shipping-fast me-2"></i>Shipping Fee</th>
                                <th><i class="fas fa-dollar-sign me-2"></i>Total Amount</th>
                                <th><i class="fas fa-credit-card me-2"></i>Payment</th>
                                <th><i class="fas fa-map-marker-alt me-2"></i>Address</th>
                                <th><i class="fas fa-flag me-2"></i>Status</th>
                                <th><i class="fas fa-credit-card me-2"></i>Paid</th>
                                <th><i class="fas fa-eye me-2"></i>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr>
                                        <td colspan="9" class="empty-state">
                                            <i class="fas fa-inbox"></i>
                                            <h4>No Orders Found</h4>
                                            <p>There are no orders matching your current filters.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${orders}" var="order" varStatus="status">
                                <tr>
                                            <td>
                                                <span class="fw-bold text-primary">#${order.id}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div>
                                                        <div class="fw-semibold">${order.customer.name}</div>
                                                        <small class="text-muted">${order.customer.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.shippingFee == null || order.shippingFee == 0}">
                                                        <span class="fw-semibold text-success">Free</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="fw-semibold">$${order.shippingFee}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="fw-bold text-success">$${order.totalAmount}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-credit-card me-2 text-muted"></i>
                                                    ${order.paymentMethod.name}
                                                </div>
                                            </td>
                                            <td>
                                                <small class="text-muted" title="${order.shippingAddress}">
                                                    ${fn:length(order.shippingAddress) > 30 ? fn:substring(order.shippingAddress, 0, 30).concat('...') : order.shippingAddress}
                                                </small>
                                            </td>
                                    <td>
                                                <input type="hidden" id='old_order_status_${order.id}' value="${order.status}">
                                                <span class="status-badge ${fn:toLowerCase(order.status)}">
                                                    ${order.status}
                                                </span>
                                                
                                        </select>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.paid}">
                                                        <span class="badge bg-success">Paid</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">Not yet</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'Shipping'}">
                                                        <button class="btn btn-primary btn-sm" onclick="updateOrderStatus(${order.id}, 'Completed')">Xác nhận đã giao</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Không hiển thị nút cho trạng thái khác -->
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                </tr>
                            </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination Section -->
                <c:if test="${totalOrders > 0}">
                    <div class="pagination-wrapper">
                        <div class="pagination-info">
                            <span class="text-muted">
                                Showing <strong>${startIndex}</strong> to <strong>${endIndex}</strong> of <strong>${totalOrders}</strong> orders
                            </span>
        </div>

                        <!-- Only show navigation if more than 1 page -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Order pagination">
                                <ul class="pagination justify-content-center">
                                    <!-- First Page -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=1&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}" title="First Page">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <!-- Previous Page -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}" title="Previous Page">
                                                <i class="fas fa-angle-left"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <!-- Page Numbers -->
                                    <c:forEach var="pageNum" begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" 
                                              end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}">
                                        <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${pageNum}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}">
                                                ${pageNum}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    
                                    <!-- Next Page -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}" title="Next Page">
                                                <i class="fas fa-angle-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <!-- Last Page -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${totalPages}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}" title="Last Page">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                        
                        <!-- Always show Page Size Selector -->
                        <div class="page-size-selector">
                            <label class="form-label">Orders per page:</label>
                            <select class="form-select" onchange="changePageSize(this.value)" style="width: auto; display: inline-block;">
                                <option value="5" ${empty pageSize or pageSize == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
                                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                            </select>
                            </div>
                    </div>
                </c:if>
        </div>

        <!-- Order Detail Modal -->
        <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                <h5 class="modal-title">Order Details #<span id="modalOrderId"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                <div id="orderDetailContent" class="p-2 text-center text-muted">
                  <i class="fas fa-spinner fa-spin"></i> Loading...
                            </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Timeline CSS -->
        <style>
            .timeline { list-style: none; padding-left: 0; }
            .timeline li { position: relative; padding-left: 20px; margin-bottom: 10px; }
            .timeline li::before { content: ''; position: absolute; left: 5px; top: 6px; width: 8px; height: 8px; border-radius: 50%; background: #667eea; }
        </style>

        <form id="update_status_form" action="order-list-manage" method="post" hidden="">
            <input type="text" name="from_page" value="shipper">
            <input type="text" name="shipper_id" value="${shipper.shipperId}">
            <input type="text" name="order_id" id="order_id">
            <input type="text" name="order_status" id="order_status">
        </form>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <script>
            const contextPath = '${pageContext.request.contextPath}';

            // Initialize stats on page load
            document.addEventListener('DOMContentLoaded', function() {
                updateStats();
                
                // Add smooth scrolling
                document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                    anchor.addEventListener('click', function (e) {
                        e.preventDefault();
                        document.querySelector(this.getAttribute('href')).scrollIntoView({
                            behavior: 'smooth'
                        });
                    });
                });
            });

            function updateStats() {
                const rows = document.querySelectorAll('tbody tr');
                let pending = 0, shipping = 0, completed = 0, cancelled = 0;
                
                rows.forEach(row => {
                    const statusSelect = row.querySelector('select[id^="status_order_"]');
                    if (statusSelect) {
                        const status = statusSelect.value.toLowerCase();
                        switch(status) {
                            case 'pending': pending++; break;
                            case 'shipping': shipping++; break;
                            case 'completed': completed++; break;
                            case 'cancel': cancelled++; break;
                        }
                    }
                });
                
                document.getElementById('pendingCount').textContent = pending;
                document.getElementById('shippingCount').textContent = shipping;
                document.getElementById('completedCount').textContent = completed;
                document.getElementById('cancelledCount').textContent = cancelled;
            }

                                            function changeStatus(order_id) {
                const selectElement = document.getElementById("status_order_" + order_id);
                const newStatus = selectElement.value;
                const oldStatus = document.getElementById("old_order_status_" + order_id).value;
                
                // Show custom confirmation dialog
                if (confirm('Are you sure you want to change order #' + order_id + ' status from "' + oldStatus + '" to "' + newStatus + '"?')) {
                    // Show loading overlay
                    document.getElementById('loadingOverlay').style.display = 'flex';
                    
                    // Update the select appearance
                    selectElement.className = `status-badge ${newStatus.toLowerCase()}`;
                    
                    // Submit the form
                    document.getElementById("order_id").value = order_id;
                    document.getElementById("order_status").value = newStatus;
                    document.getElementById("update_status_form").submit();
                } else {
                    // Reset to original value
                    selectElement.value = oldStatus;
                }
            }

            function showOrderDetail(orderId) {
                document.getElementById('modalOrderId').textContent = orderId;
                const contentEl = document.getElementById('orderDetailContent');
                contentEl.innerHTML = '<div class="text-center text-muted py-4"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';
                const modal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
                modal.show();

                fetch(contextPath + '/OrderApiServlet?id=' + orderId)
                    .then(res => res.json())
                    .then(data => {
                        if (!data.success) {
                            contentEl.innerHTML = '<div class="text-danger">Failed to load order details.</div>';
                                                    return;
                                                }

                        let html = '';
                        // Products table
                        html += '<h6 class="mb-3">Products</h6>';
                        html += '<div class="table-responsive"><table class="table table-sm align-middle"><thead><tr><th>Image</th><th>Name</th><th>Qty</th><th>Price</th></tr></thead><tbody>';
                        data.items.forEach(function(it) {
                            html += '<tr>' +
                                '<td><img src="' + (it.imageUrl || (contextPath + '/IMG/product/default.jpg')) + '" style="width:48px;height:48px;object-fit:cover"></td>' +
                                '<td>' + it.name + '</td>' +
                                '<td>' + it.quantity + '</td>' +
                                '<td>' + Number(it.price).toLocaleString() + '</td>' +
                            '</tr>';
                        });
                        html += '</tbody></table></div>';

                        // Note
                        html += '<h6 class="mt-4">Note</h6>';
                        html += '<p>' + (data.note ? data.note : '<span class="text-muted">None</span>') + '</p>';

                        // Status history
                        if (data.statusHistory && data.statusHistory.length > 0) {
                            html += '<h6 class="mt-4">Status History</h6><ul class="timeline">';
                            data.statusHistory.forEach(function(h) {
                                html += '<li><span class="badge bg-secondary">' + h.status + '</span> <span class="ms-2">' + h.time + '</span> <span class="text-muted ms-2">' + (h.changedBy || '') + '</span></li>';
                            });
                            html += '</ul>';
                        }

                        contentEl.innerHTML = html;
                    })
                    .catch(err => {
                        console.error(err);
                        contentEl.innerHTML = '<div class="text-danger">Error loading order details.</div>';
                    });
            }

            function updateOrderStatus(orderId, newStatus) {
                if (confirm('Bạn có chắc muốn cập nhật trạng thái đơn hàng #' + orderId + ' thành ' + newStatus + '?')) {
                    document.getElementById('order_id').value = orderId;
                    document.getElementById('order_status').value = newStatus;
                    document.getElementById('update_status_form').submit();
                }
            }

            // Add hover effects to table rows
            document.addEventListener('DOMContentLoaded', function() {
                const tableRows = document.querySelectorAll('tbody tr');
                tableRows.forEach(row => {
                    row.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateX(4px)';
                    });
                    
                    row.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateX(0)';
                    });
                });
            });

            // Auto-hide loading overlay after 3 seconds as fallback
            setTimeout(function() {
                const overlay = document.getElementById('loadingOverlay');
                if (overlay.style.display === 'flex') {
                    overlay.style.display = 'none';
                }
            }, 3000);

            // Function to change page size
            function changePageSize(pageSize) {
                const urlParams = new URLSearchParams(window.location.search);
                urlParams.set('pageSize', pageSize);
                urlParams.set('page', '1'); // Reset to first page when changing page size
                window.location.search = urlParams.toString();
            }

            // Smooth pagination navigation
            document.addEventListener('DOMContentLoaded', function() {
                const paginationLinks = document.querySelectorAll('.pagination .page-link');
                paginationLinks.forEach(link => {
                    link.addEventListener('click', function(e) {
                        // Add loading effect
                        const overlay = document.getElementById('loadingOverlay');
                        if (overlay) {
                            overlay.style.display = 'flex';
                            overlay.querySelector('p').textContent = 'Loading orders...';
                        }
                    });
                });
            });

            // Add keyboard navigation for pagination
            document.addEventListener('keydown', function(e) {
                const currentPage = parseInt('${currentPage}' || '1');
                const totalPages = parseInt('${totalPages}' || '1');
                
                if (e.ctrlKey || e.metaKey) {
                    switch(e.key) {
                        case 'ArrowLeft':
                            if (currentPage > 1) {
                                e.preventDefault();
                                const prevLink = document.querySelector('.pagination .page-link[href*="page=' + (currentPage - 1) + '"]');
                                if (prevLink) prevLink.click();
                            }
                            break;
                        case 'ArrowRight':
                            if (currentPage < totalPages) {
                                e.preventDefault();
                                const nextLink = document.querySelector('.pagination .page-link[href*="page=' + (currentPage + 1) + '"]');
                                if (nextLink) nextLink.click();
                                            }
                            break;
                    }
                }
            });
        </script>
    </body>
</html>
