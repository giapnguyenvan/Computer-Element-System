<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Account Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary: #64748b;
            --success: #059669;
            --warning: #d97706;
            --danger: #dc2626;
            --background: #f8fafc;
            --card: #ffffff;
            --text: #1e293b;
            --text-light: #64748b;
            --border: #e2e8f0;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .main-content {
            height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .container-fluid {
            flex: 1 1 auto;
            overflow: auto;
        }

        .header {
            background: var(--card);
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 1.875rem;
            font-weight: 600;
            margin: 0;
            color: var(--text);
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .stat-box {
            background: var(--card);
            border-radius: 0.75rem;
            padding: 1.25rem;
            border: 1px solid var(--border);
            transition: transform 0.2s;
        }

        .stat-box:hover {
            transform: translateY(-2px);
        }

        .stat-box h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
            color: var(--primary);
        }

        .stat-box p {
            margin: 0.5rem 0 0;
            color: var(--text-light);
            font-size: 0.875rem;
        }

        .search-bar {
            background: var(--card);
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .search-bar .form-control {
            border-radius: 0.5rem;
            border: 1px solid var(--border);
            padding: 0.75rem 1rem;
        }

        .search-bar .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .search-bar .btn {
            border-radius: 0.5rem;
            padding: 0.75rem 1.5rem;
        }

        .accounts-table {
            background: var(--card);
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .accounts-table table {
            margin: 0;
        }

        .accounts-table th {
            background: var(--background);
            font-weight: 600;
            padding: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .accounts-table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--border);
        }

        .accounts-table tr:last-child td {
            border-bottom: none;
        }

        .role-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .role-admin {
            background: #fee2e2;
            color: var(--danger);
        }

        .role-staff {
            background: #fef3c7;
            color: var(--warning);
        }

        .role-customer {
            background: #dcfce7;
            color: var(--success);
        }

        .action-btn {
            padding: 0.5rem;
            border-radius: 0.5rem;
            border: none;
            background: transparent;
            color: var(--text-light);
            transition: all 0.2s;
        }

        .action-btn:hover {
            background: var(--background);
            color: var(--text);
        }

        .action-btn.edit:hover {
            color: var(--primary);
        }

        .action-btn.reset:hover {
            color: var(--warning);
        }

        .action-btn.delete:hover {
            color: var(--danger);
        }

        .modal-content {
            border-radius: 1rem;
            border: none;
        }

        .modal-header {
            background: var(--primary);
            color: white;
            border-radius: 1rem 1rem 0 0;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-footer {
            padding: 1.5rem;
            border-top: 1px solid var(--border);
        }

        .pagination {
            margin-top: 2rem;
            justify-content: center;
        }

        .page-link {
            border-radius: 0.5rem;
            margin: 0 0.25rem;
            border: 1px solid var(--border);
            color: var(--text);
        }

        .page-link:hover {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }

        .page-item.active .page-link {
            background: var(--primary);
            border-color: var(--primary);
        }

        .add-account-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .add-account-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #fff;
        }
        .login-bg {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #705FBC;
        }
        .login-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 300px;
        }
    </style>
</head>
<body>
    
    <div class="main-content">
        <div class="d-flex justify-content-center my-4">
            <a href="Account?view=user" class="btn btn-outline-primary mx-2 ${param.view != 'customer' ? 'active' : ''}">User</a>
            <a href="Account?view=customer" class="btn btn-outline-primary mx-2 ${param.view == 'customer' ? 'active' : ''}">Customer</a>
        </div>
        <div class="container-fluid">
            <div class="header">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center gap-3">
                        <h1>Account Management</h1>
                        <div class="stat-box" style="padding: 0.5rem 1rem; margin: 0;">
                            <p style="font-size: 0.75rem; margin: 0;">Total Accounts</p>
                            <h3 style="font-size: 1.25rem; margin: 0;">${totalAccounts}</h3>
                        </div>
                    </div>
                    <button type="button" class="add-account-btn" data-bs-toggle="modal" data-bs-target="#addAccountModal">
                        <i class="bi bi-person-plus"></i> Add Account
                    </button>
                </div>
            </div>

            <div class="search-bar">
                <form action="Account" method="GET" class="row g-3 align-items-stretch">
                    <input type="hidden" name="page" value="${currentPage}">
                    <div class="col-3">
                        <select name="sortBy" class="form-select h-100" style="min-height:48px;" onchange="this.form.submit()">
                            <option value="id" ${param.sortBy == 'id' ? 'selected' : ''}>Sort by ID</option>
                            <option value="name" ${param.sortBy == 'name' ? 'selected' : ''}>Sort by Name</option>
                            <option value="email" ${param.sortBy == 'email' ? 'selected' : ''}>Sort by Email</option>
                            <option value="role" ${param.sortBy == 'role' ? 'selected' : ''}>Sort by Role</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <select name="role" class="form-select h-100" style="min-height:48px;" onchange="this.form.submit()">
                            <option value="">All Roles</option>
                            <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                            <option value="staff" ${param.role == 'staff' ? 'selected' : ''}>Staff</option>
                            <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <input type="text" name="search" class="form-control h-100" style="min-height:48px;" placeholder="Search by name, email, or phone..." value="${param.search}">
                    </div>
                    <div class="col-2 d-flex">
                        <button class="btn btn-primary h-100 d-flex align-items-center justify-content-center px-3" style="min-height:48px; white-space:nowrap;" type="submit">
                            <i class="bi bi-search me-2"></i> Search
                        </button>
                    </div>
                </form>
            </div>

            <div class="accounts-table">
                                    <tbody>
                        <c:forEach items="${accountList}" var="account">
                            <tr>
                                <td>${account.username}</td>
                                <td>${account.email}</td>
                                <td>
                                    <span class="role-badge role-${account.role.toLowerCase()}">
                                        ${account.role}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="action-btn edit" 
                                                onclick="editAccount(${account.id}, '${fn:escapeXml(fn:replace(account.username, "'", "\\'") )}', '${fn:escapeXml(fn:replace(account.email, "'", "\\'") )}', '${fn:escapeXml(fn:replace(account.role, "'", "\\'") )}')"
                                                data-bs-toggle="modal" data-bs-target="#editAccountModal">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button type="button" class="action-btn reset" 
                                                onclick="resetPassword(${account.id})"
                                                data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                            <i class="bi bi-key"></i>
                                        </button>
                                        <c:if test="${account.role != 'admin'}">
                                            <button type="button" class="action-btn delete" 
                                                    onclick="deleteAccount(${account.id}, '${fn:escapeXml(fn:replace(account.username, "'", "\\'") )}')"
                                                    data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                
            </div>

            <c:if test="${totalPages > 1}">
                <nav aria-label="Account pagination">
                    <ul class="pagination justify-content-center mt-4">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="Account?page=${currentPage - 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">Previous</a>
                        </li>
                        <li class="page-item active">
                            <span class="page-link">${currentPage}</span>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="Account?page=${currentPage + 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">Next</a>
                        </li>
                    </ul>
                </nav>
            </c:if>

            <c:if test="${param.view != 'customer'}">
                <!-- Bảng User Accounts -->
                <h2>User Accounts</h2>
                <div class="accounts-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${userList}" var="account">
                                <tr>
                                    <td>${account.username}</td>
                                    <td>${account.email}</td>
                                    <td>
                                        <span class="role-badge role-${account.role.toLowerCase()}">
                                            ${account.role}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button type="button" class="action-btn edit" 
                                                    onclick="editAccount(${account.id}, '${fn:escapeXml(fn:replace(account.username, "'", "\\'") )}', '${fn:escapeXml(fn:replace(account.email, "'", "\\'") )}', '${fn:escapeXml(fn:replace(account.role, "'", "\\'") )}')"
                                                    data-bs-toggle="modal" data-bs-target="#editAccountModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button type="button" class="action-btn reset" 
                                                    onclick="resetPassword(${account.id})"
                                                    data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key"></i>
                                            </button>
                                            <c:if test="${account.role != 'admin'}">
                                                <button type="button" class="action-btn delete" 
                                                        onclick="deleteAccount(${account.id}, '${fn:escapeXml(fn:replace(account.username, "'", "\\'") )}')"
                                                        data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty userList}">
                        <div class="text-center py-5">
                            <i class="bi bi-info-circle text-primary" style="font-size: 2rem;"></i>
                            <p class="mt-3 text-muted">No accounts found</p>
                        </div>
                    </c:if>
                    <!-- Phân trang user -->
                    <nav aria-label="User pagination">
                        <ul class="pagination justify-content-center mt-4">
                            <li class="page-item ${userCurrentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="Account?view=user&userPage=${userCurrentPage - 1}&customerPage=${customerCurrentPage}">Previous</a>
                            </li>
                            <li class="page-item active">
                                <span class="page-link">${userCurrentPage} / ${userTotalPages}</span>
                            </li>
                            <li class="page-item ${userCurrentPage == userTotalPages ? 'disabled' : ''}">
                                <a class="page-link" href="Account?view=user&userPage=${userCurrentPage + 1}&customerPage=${customerCurrentPage}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>

            <c:if test="${param.view == 'customer'}">
                <!-- Bảng Customer Accounts -->
                <h2 class="mt-5">Customer Accounts</h2>
                <div class="accounts-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Shipping Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customerList}" var="customer">
                                <tr>
                                    <td>${customer.name}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.phone}</td>
                                    <td>${customer.shipping_address}</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button type="button" class="action-btn edit"
                                                onclick="editCustomer(${customer.customer_id}, '${fn:escapeXml(fn:replace(customer.name, "'", "\\'") )}', '${fn:escapeXml(fn:replace(customer.email, "'", "\\'") )}', '${fn:escapeXml(fn:replace(customer.phone, "'", "\\'") )}', '${fn:escapeXml(fn:replace(customer.shipping_address, "'", "\\'") )}')"
                                                data-bs-toggle="modal" data-bs-target="#editCustomerModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button type="button" class="action-btn reset"
                                                onclick="resetCustomerPassword(${customer.customer_id})"
                                                data-bs-toggle="modal" data-bs-target="#resetCustomerPasswordModal">
                                                <i class="bi bi-key"></i>
                                            </button>
                                            <button type="button" class="action-btn delete"
                                                onclick="deleteCustomer(${customer.customer_id}, '${fn:escapeXml(fn:replace(customer.name, "'", "\\'") )}')"
                                                data-bs-toggle="modal" data-bs-target="#deleteCustomerModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty customerList}">
                        <div class="text-center py-5">
                            <i class="bi bi-info-circle text-primary" style="font-size: 2rem;"></i>
                            <p class="mt-3 text-muted">No customers found</p>
                        </div>
                    </c:if>
                    <!-- Phân trang customer -->
                    <nav aria-label="Customer pagination">
                        <ul class="pagination justify-content-center mt-4">
                            <li class="page-item ${customerCurrentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="Account?view=customer&userPage=${userCurrentPage}&customerPage=${customerCurrentPage - 1}">Previous</a>
                            </li>
                            <li class="page-item active">
                                <span class="page-link">${customerCurrentPage} / ${customerTotalPages}</span>
                            </li>
                            <li class="page-item ${customerCurrentPage == customerTotalPages ? 'disabled' : ''}">
                                <a class="page-link" href="Account?view=customer&userPage=${userCurrentPage}&customerPage=${customerCurrentPage + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Add Account Modal -->
    <div class="modal fade" id="addAccountModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Account</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" required>
                                <option value="staff">Staff</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Account</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Account Modal -->
    <div class="modal fade" id="editAccountModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Account</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="account_id" id="edit_account_id">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" id="edit_username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" id="edit_email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" id="edit_role" required>
                                <option value="staff">Staff</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Account</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reset Password Modal -->
    <div class="modal fade" id="resetPasswordModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Reset Password</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updatePassword">
                        <input type="hidden" name="account_id" id="reset_account_id">
                        
                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <input type="password" class="form-control" name="new_password" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" name="confirm_password" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Reset Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Account Modal -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Account</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="account_id" id="delete_account_id">
                        <input type="hidden" name="account_email" id="delete_account_email">
                        <input type="hidden" name="account_role" id="delete_account_role">
                        <p>Are you sure you want to delete account <span id="delete_account_name" class="fw-bold"></span>? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Customer Modal -->
    <div class="modal fade" id="editCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Customer</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Customer_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="customer_id" id="edit_customer_id">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" id="edit_customer_name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" id="edit_customer_email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="text" class="form-control" name="phone" id="edit_customer_phone" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Shipping Address</label>
                            <input type="text" class="form-control" name="shipping_address" id="edit_customer_shipping_address" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Customer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reset Customer Password Modal -->
    <div class="modal fade" id="resetCustomerPasswordModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Reset Customer Password</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Customer_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updatePassword">
                        <input type="hidden" name="customer_id" id="reset_customer_id">
                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <input type="password" class="form-control" name="new_password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" name="confirm_password" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Reset Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Customer Modal -->
    <div class="modal fade" id="deleteCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Customer</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="Customer_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="customer_id" id="delete_customer_id">
                        <p>Are you sure you want to delete customer <span id="delete_customer_name" class="fw-bold"></span>? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editAccount(id, username, email, role) {
            document.getElementById('edit_account_id').value = id;
            document.getElementById('edit_username').value = username;
            document.getElementById('edit_email').value = email;
            document.getElementById('edit_role').value = role.toLowerCase();
        }
        
        function resetPassword(id) {
            document.getElementById('reset_account_id').value = id;
        }
        
        function deleteAccount(id, username) {
            document.getElementById('delete_account_id').value = id;
            document.getElementById('delete_account_name').textContent = username;
        }

        function editCustomer(id, name, email, phone, shipping_address) {
            document.getElementById('edit_customer_id').value = id;
            document.getElementById('edit_customer_name').value = name;
            document.getElementById('edit_customer_email').value = email;
            document.getElementById('edit_customer_phone').value = phone;
            document.getElementById('edit_customer_shipping_address').value = shipping_address;
        }
        
        function resetCustomerPassword(id) {
            document.getElementById('reset_customer_id').value = id;
        }
        
        function deleteCustomer(id, name) {
            document.getElementById('delete_customer_id').value = id;
            document.getElementById('delete_customer_name').textContent = name;
        }
    </script>
</body>
</html>