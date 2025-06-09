<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Account Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-dark: #4f46e5;
            --secondary-color: #64748b;
            --success-color: #22c55e;
            --info-color: #0ea5e9;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --background-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
        }

        body {
            background-color: var(--background-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-primary);
        }

        .container {
            max-width: 1400px;
            padding: 2rem;
        }

        .page-header {
            background: var(--card-bg);
            border-radius: 24px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            opacity: 0.1;
            z-index: 0;
        }

        .page-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
        }

        .stats-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 1.5rem;
            flex: 1;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .filter-section {
            background: var(--card-bg);
            border-radius: 24px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        .search-input {
            border-radius: 12px 0 0 12px;
            border-right: none;
        }

        .search-button {
            border-radius: 0 12px 12px 0;
            background: var(--primary-color);
            border: none;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
        }

        .search-button:hover {
            background: var(--primary-dark);
        }

        .account-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .account-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .account-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary-color);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .account-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .account-name {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0;
        }

        .role-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .role-customer {
            background: linear-gradient(135deg, var(--success-color), #16a34a);
            color: white;
        }

        .role-staff {
            background: linear-gradient(135deg, var(--info-color), #0284c7);
            color: white;
        }

        .account-meta {
            margin-bottom: 1.5rem;
        }

        .account-meta p {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        .account-meta i {
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .action-buttons .btn {
            flex: 1;
            padding: 0.75rem;
            border-radius: 12px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: var(--warning-color);
            border: none;
            color: white;
        }

        .btn-warning:hover {
            background: #d97706;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }

        .modal-content {
            border-radius: 24px;
            border: none;
            box-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border-radius: 24px 24px 0 0;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            padding: 1.5rem;
            border-top: 2px solid #e2e8f0;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .page-link {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            color: var(--text-primary);
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .page-link:hover {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .page-item.active .page-link {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .add-account-btn {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
        }

        .add-account-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        @media (max-width: 768px) {
            .account-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-container {
                flex-direction: column;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1>Account Management</h1>
            <div class="d-flex justify-content-between align-items-center">
                <div class="stats-container">
                    <div class="stat-card">
                        <h3 class="mb-2">${totalAccounts}</h3>
                        <p class="text-muted mb-0">Total Accounts</p>
                    </div>
                    <div class="stat-card">
                        <h3 class="mb-2">${currentPage}</h3>
                        <p class="text-muted mb-0">Current Page</p>
                    </div>
                    <div class="stat-card">
                        <h3 class="mb-2">${totalPages}</h3>
                        <p class="text-muted mb-0">Total Pages</p>
                    </div>
                </div>
                <button type="button" class="add-account-btn" data-bs-toggle="modal" data-bs-target="#addAccountModal">
                    <i class="bi bi-person-plus"></i> Add New Account
                </button>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form action="viewaccounts" method="GET" class="row g-3">
                <input type="hidden" name="page" value="${currentPage}">
                <div class="col-md-3">
                    <label class="form-label fw-bold">Sort By</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="id" ${param.sortBy == 'id' ? 'selected' : ''}>ID</option>
                        <option value="name" ${param.sortBy == 'name' ? 'selected' : ''}>Name</option>
                        <option value="email" ${param.sortBy == 'email' ? 'selected' : ''}>Email</option>
                        <option value="role" ${param.sortBy == 'role' ? 'selected' : ''}>Role</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold">Filter by Role</label>
                    <select name="role" class="form-select" onchange="this.form.submit()">
                        <option value="">All Roles</option>
                        <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="staff" ${param.role == 'staff' ? 'selected' : ''}>Staff</option>
                        <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Search</label>
                    <div class="input-group">
                        <input type="text" name="search" class="form-control search-input" 
                               placeholder="Search by name, email, or phone..." 
                               value="${param.search}">
                        <button class="btn search-button" type="submit">
                            <i class="bi bi-search"></i> Search
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Accounts Display -->
        <div class="account-grid">
            <c:forEach items="${accountList}" var="account">
                <div class="account-card">
                    <div class="account-header">
                        <h5 class="account-name">${account.name}</h5>
                        <span class="role-badge role-${account.role.toLowerCase()}">${account.role}</span>
                    </div>
                    <div class="account-meta">
                        <p>
                            <i class="bi bi-envelope"></i>
                            ${account.email}
                        </p>
                        <p>
                            <i class="bi bi-telephone"></i>
                            ${account.phone_number}
                        </p>
                        <p>
                            <i class="bi bi-geo-alt"></i>
                            ${account.address}
                        </p>
                    </div>
                    <div class="action-buttons">
                        <button type="button" class="btn btn-primary" 
                                onclick="editAccount(${account.id}, '${account.name}', '${account.email}', 
                                                   '${account.phone_number}', '${account.address}', '${account.role}')"
                                data-bs-toggle="modal" data-bs-target="#editAccountModal">
                            <i class="bi bi-pencil"></i> Edit
                        </button>
                        <button type="button" class="btn btn-warning" 
                                onclick="resetPassword(${account.id})"
                                data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                            <i class="bi bi-key"></i> Reset
                        </button>
                        <button type="button" class="btn btn-danger" 
                                onclick="deleteAccount(${account.id}, '${account.name}')"
                                data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                            <i class="bi bi-trash"></i> Delete
                        </button>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty accountList}">
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <i class="bi bi-info-circle"></i> No accounts found.
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Account pagination">
                <ul class="pagination">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="viewaccounts?page=${currentPage - 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="viewaccounts?page=${i}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="viewaccounts?page=${currentPage + 1}&sortBy=${param.sortBy}&role=${param.role}&search=${param.search}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Add Account Modal -->
    <div class="modal fade" id="addAccountModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="mb-3">
                            <label class="form-label">Name:</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Password:</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Phone Number:</label>
                            <input type="tel" class="form-control" name="phone_number" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Address:</label>
                            <textarea class="form-control" name="address" rows="2" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Role:</label>
                            <select class="form-select" name="role" required>
                                <option value="customer">Customer</option>
                                <option value="staff">Staff</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="account_id" id="edit_account_id">
                        
                        <div class="mb-3">
                            <label class="form-label">Name:</label>
                            <input type="text" class="form-control" name="name" id="edit_name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" class="form-control" name="email" id="edit_email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Phone Number:</label>
                            <input type="tel" class="form-control" name="phone_number" id="edit_phone" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Address:</label>
                            <textarea class="form-control" name="address" id="edit_address" rows="2" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Role:</label>
                            <select class="form-select" name="role" id="edit_role" required>
                                <option value="customer">Customer</option>
                                <option value="staff">Staff</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updatePassword">
                        <input type="hidden" name="account_id" id="reset_account_id">
                        
                        <div class="mb-3">
                            <label class="form-label">New Password:</label>
                            <input type="password" class="form-control" name="new_password" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Confirm Password:</label>
                            <input type="password" class="form-control" name="confirm_password" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="Account_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="account_id" id="delete_account_id">
                        <p>Are you sure you want to delete account <span id="delete_account_name" class="fw-bold"></span>? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
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