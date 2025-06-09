<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--text);
        }

        .container-fluid {
            padding: 2rem;
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
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="header">
            <div class="d-flex justify-content-between align-items-center">
                <h1>Account Management</h1>
                <button type="button" class="add-account-btn" data-bs-toggle="modal" data-bs-target="#addAccountModal">
                    <i class="bi bi-person-plus"></i> Add Account
                </button>
            </div>
            <div class="stats-row">
                <div class="stat-box">
                    <h3>${totalAccounts}</h3>
                    <p>Total Accounts</p>
                </div>
            </div>
        </div>

        <div class="search-bar">
            <form action="Account" method="GET" class="row g-3">
                <input type="hidden" name="page" value="${currentPage}">
                <div class="col-md-3">
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="id" ${param.sortBy == 'id' ? 'selected' : ''}>Sort by ID</option>
                        <option value="name" ${param.sortBy == 'name' ? 'selected' : ''}>Sort by Name</option>
                        <option value="email" ${param.sortBy == 'email' ? 'selected' : ''}>Sort by Email</option>
                        <option value="role" ${param.sortBy == 'role' ? 'selected' : ''}>Sort by Role</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="role" class="form-select" onchange="this.form.submit()">
                        <option value="">All Roles</option>
                        <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="staff" ${param.role == 'staff' ? 'selected' : ''}>Staff</option>
                        <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" 
                               placeholder="Search by name, email, or phone..." 
                               value="${param.search}">
                        <button class="btn btn-primary" type="submit">
                            <i class="bi bi-search"></i> Search
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <div class="accounts-table">
            <table class="table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${accountList}" var="account">
                        <tr>
                            <td>${account.name}</td>
                            <td>${account.email}</td>
                            <td>${account.phone_number}</td>
                            <td>
                                <span class="role-badge role-${account.role.toLowerCase()}">
                                    ${account.role}
                                </span>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button type="button" class="action-btn edit" 
                                            onclick="editAccount(${account.id}, '${account.name}', '${account.email}', 
                                                       '${account.phone_number}', '${account.address}', '${account.role}')"
                                            data-bs-toggle="modal" data-bs-target="#editAccountModal">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="action-btn reset" 
                                            onclick="resetPassword(${account.id})"
                                            data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                        <i class="bi bi-key"></i>
                                    </button>
                                    <button type="button" class="action-btn delete" 
                                            onclick="deleteAccount(${account.id}, '${account.name}')"
                                            data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${empty accountList}">
                <div class="text-center py-5">
                    <i class="bi bi-info-circle text-primary" style="font-size: 2rem;"></i>
                    <p class="mt-3 text-muted">No accounts found</p>
                </div>
            </c:if>
        </div>

        <c:if test="${totalPages > 1}">
            <div class="d-flex justify-content-between align-items-center mt-4">
                <div class="d-flex gap-3">
                    <div class="stat-box">
                        <h3>${currentPage}</h3>
                        <p>Current Page</p>
                    </div>
                    <div class="stat-box">
                        <h3>${totalPages}</h3>
                        <p>Total Pages</p>
                    </div>
                </div>
                <nav aria-label="Account pagination">
                    <ul class="pagination mb-0">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="Account?page=${currentPage - 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="Account?page=${i}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>
                        
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="Account?page=${currentPage + 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
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
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" required>
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
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" name="phone_number" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address" rows="2" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" required>
                                <option value="customer">Customer</option>
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
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" id="edit_name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" id="edit_email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" name="phone_number" id="edit_phone" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address" id="edit_address" rows="2" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" id="edit_role" required>
                                <option value="customer">Customer</option>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editAccount(id, name, email, phone, address, role) {
            document.getElementById('edit_account_id').value = id;
            document.getElementById('edit_name').value = name;
            document.getElementById('edit_email').value = email;
            document.getElementById('edit_phone').value = phone;
            document.getElementById('edit_address').value = address;
            document.getElementById('edit_role').value = role.toLowerCase();
        }
        
        function resetPassword(id) {
            document.getElementById('reset_account_id').value = id;
        }
        
        function deleteAccount(id, name) {
            document.getElementById('delete_account_id').value = id;
            document.getElementById('delete_account_name').textContent = name;
        }
    </script>
</body>
</html> 