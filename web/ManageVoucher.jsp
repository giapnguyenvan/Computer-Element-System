<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Voucher Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .voucher-card { margin-bottom: 20px; transition: transform 0.2s; cursor: pointer; }
        .voucher-card:hover { transform: translateY(-5px); }
        .voucher-meta { font-size: 0.9em; color: #666; }
        .filter-section { background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-bottom: 30px; }
        .pagination { margin-top: 30px; }
        .action-buttons { margin-top: 10px; display: flex; gap: 10px; }
        .modal-content { max-height: 90vh; overflow-y: auto; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Voucher Management</h1>
        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <% session.removeAttribute("success"); %>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <% session.removeAttribute("error"); %>
            </div>
        </c:if>
        <!-- Add New Voucher Button -->
        <div class="text-end mb-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVoucherModal">
                Add New Voucher
            </button>
        </div>
        <!-- Stats Section -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body text-center">
                        <h5>Total Vouchers: ${totalVouchers}</h5>
                        <p class="mb-0">Page ${currentPage} of ${totalPages}</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="managevouchers" method="GET" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Sort By:</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="newest" ${param.sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="oldest" ${param.sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                        <option value="code" ${param.sortBy == 'code' ? 'selected' : ''}>Code</option>
                        <option value="status" ${param.sortBy == 'status' ? 'selected' : ''}>Status</option>
                    </select>
                </div>
                <div class="col-md-8">
                    <label class="form-label">Search:</label>
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search in vouchers..." value="${param.search}">
                        <button class="btn btn-outline-secondary" type="submit">Search</button>
                    </div>
                </div>
            </form>
        </div>
        <!-- Voucher Display -->
        <div class="row">
            <c:forEach items="${voucherList}" var="voucher">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card voucher-card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${voucher.code}</h5>
                            <div class="voucher-meta mb-2">
                                <small>
                                    Start: ${voucher.start_date} <br>
                                    End: ${voucher.end_date}
                                </small>
                            </div>
                            <div class="voucher-meta mb-2">
                                <small>Status: ${voucher.status}</small>
                            </div>
                            <div class="voucher-meta mb-2">
                                <small>Type: ${voucher.discount_type} | Value: ${voucher.discount_value}</small>
                            </div>
                            <div class="voucher-meta mb-2">
                                <small>Min Order: ${voucher.min_order_amount}</small>
                            </div>
                            <div class="voucher-meta mb-2">
                                <small>Max Uses: ${voucher.max_uses} | Per User: ${voucher.max_uses_per_user}</small>
                            </div>
                            <div class="voucher-meta mb-2">
                                <small>Description: ${voucher.description}</small>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-primary" onclick="editVoucher(this)"
                                        data-code="${voucher.code}"
                                        data-description="${voucher.description}"
                                        data-discount_type="${voucher.discount_type}"
                                        data-discount_value="${voucher.discount_value}"
                                        data-min_order_amount="${voucher.min_order_amount}"
                                        data-max_uses="${voucher.max_uses}"
                                        data-max_uses_per_user="${voucher.max_uses_per_user}"
                                        data-start_date="${voucher.start_date}"
                                        data-end_date="${voucher.end_date}"
                                        data-status="${voucher.status}"
                                        data-bs-toggle="modal" data-bs-target="#editVoucherModal">
                                    Edit
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete('${voucher.code}')">
                                    Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty voucherList}">
                <div class="col-12">
                    <div class="alert alert-info text-center">No vouchers found.</div>
                </div>
            </c:if>
        </div>
        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Voucher pagination">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="managevouchers?page=${currentPage - 1}&sortBy=${param.sortBy}&search=${param.search}">Previous</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="managevouchers?page=${i}&sortBy=${param.sortBy}&search=${param.search}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="managevouchers?page=${currentPage + 1}&sortBy=${param.sortBy}&search=${param.search}">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
    <!-- Add Voucher Modal -->
    <div class="modal fade" id="addVoucherModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Voucher</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="managevouchers" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Code:</label>
                            <input type="text" class="form-control" name="code" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description:</label>
                            <input type="text" class="form-control" name="description">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Discount Type:</label>
                            <select class="form-select" name="discount_type" required>
                                <option value="percent">Percent</option>
                                <option value="fixed">Fixed</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Discount Value:</label>
                            <input type="number" step="0.01" class="form-control" name="discount_value" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Min Order Amount:</label>
                            <input type="number" step="0.01" class="form-control" name="min_order_amount" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Max Uses:</label>
                            <input type="number" class="form-control" name="max_uses">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Max Uses Per User:</label>
                            <input type="number" class="form-control" name="max_uses_per_user">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Start Date (yyyy-mm-dd hh:mm):</label>
                            <input type="text" class="form-control" name="start_date" required placeholder="2024-06-01 00:00">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">End Date (yyyy-mm-dd hh:mm):</label>
                            <input type="text" class="form-control" name="end_date" required placeholder="2024-12-31 23:59">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status:</label>
                            <select class="form-select" name="status" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                                <option value="Expired">Expired</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Voucher</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Edit Voucher Modal -->
    <div class="modal fade" id="editVoucherModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Voucher</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="managevouchers" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="code" id="edit_code">
                        <div class="mb-3">
                            <label class="form-label">Description:</label>
                            <input type="text" class="form-control" name="description" id="edit_description">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Discount Type:</label>
                            <select class="form-select" name="discount_type" id="edit_discount_type">
                                <option value="percent">Percent</option>
                                <option value="fixed">Fixed</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Discount Value:</label>
                            <input type="number" step="0.01" class="form-control" name="discount_value" id="edit_discount_value">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Min Order Amount:</label>
                            <input type="number" step="0.01" class="form-control" name="min_order_amount" id="edit_min_order_amount">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Max Uses:</label>
                            <input type="number" class="form-control" name="max_uses" id="edit_max_uses">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Max Uses Per User:</label>
                            <input type="number" class="form-control" name="max_uses_per_user" id="edit_max_uses_per_user">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Start Date (yyyy-mm-dd hh:mm):</label>
                            <input type="text" class="form-control" name="start_date" id="edit_start_date">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">End Date (yyyy-mm-dd hh:mm):</label>
                            <input type="text" class="form-control" name="end_date" id="edit_end_date">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status:</label>
                            <select class="form-select" name="status" id="edit_status">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                                <option value="Expired">Expired</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Voucher</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editVoucher(element) {
            document.getElementById('edit_code').value = element.getAttribute('data-code');
            document.getElementById('edit_description').value = element.getAttribute('data-description');
            document.getElementById('edit_discount_type').value = element.getAttribute('data-discount_type');
            document.getElementById('edit_discount_value').value = element.getAttribute('data-discount_value');
            document.getElementById('edit_min_order_amount').value = element.getAttribute('data-min_order_amount');
            document.getElementById('edit_max_uses').value = element.getAttribute('data-max_uses');
            document.getElementById('edit_max_uses_per_user').value = element.getAttribute('data-max_uses_per_user');
            document.getElementById('edit_start_date').value = element.getAttribute('data-start_date').replace('T', ' ').substring(0, 16);
            document.getElementById('edit_end_date').value = element.getAttribute('data-end_date').replace('T', ' ').substring(0, 16);
            document.getElementById('edit_status').value = element.getAttribute('data-status');
        }
        function confirmDelete(code) {
            if (confirm('Are you sure you want to delete this voucher?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'managevouchers';
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                const codeInput = document.createElement('input');
                codeInput.type = 'hidden';
                codeInput.name = 'code';
                codeInput.value = code;
                form.appendChild(actionInput);
                form.appendChild(codeInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html> 