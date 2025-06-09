<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <h2 class="mb-4">Account Management</h2>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${accountList}" var="account">
                            <tr>
                                <td>${account.id}</td>
                                <td>${account.name}</td>
                                <td>${account.email}</td>
                                <td>${account.phone_number}</td>
                                <td>
                                    <span class="badge bg-${account.role == 'admin' ? 'danger' : account.role == 'staff' ? 'primary' : 'success'}">
                                        ${account.role}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-primary" 
                                                onclick="editAccount(${account.id}, '${account.name}', '${account.email}', 
                                                                   '${account.phone_number}', '${account.address}', '${account.role}')"
                                                data-bs-toggle="modal" data-bs-target="#editAccountModal">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button type="button" class="btn btn-sm btn-warning" 
                                                onclick="resetPassword(${account.id})"
                                                data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                            <i class="bi bi-key"></i>
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger" 
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
            </div>
        </div>
    </div>
</div>

<script>
function viewCustomerDetails(id) {
    window.location.href = '${pageContext.request.contextPath}/customerservlet?service=view&id=' + id;
}

function editCustomer(id) {
    window.location.href = '${pageContext.request.contextPath}/customerservlet?service=edit&id=' + id;
}

function deleteCustomer(id) {
    if (confirm('Are you sure you want to delete this customer?')) {
        window.location.href = '${pageContext.request.contextPath}/customerservlet?service=delete&id=' + id;
    }
}
</script> 