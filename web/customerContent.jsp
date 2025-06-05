<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <h2 class="mb-4">Customer Management</h2>

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
                        <c:forEach items="${customers}" var="customer">
                            <tr>
                                <td>${customer.id}</td>
                                <td>${customer.fullname}</td>
                                <td>${customer.email}</td>
                                <td>${customer.phone}</td>
                                <td>
                                    <span class="badge bg-${customer.status ? 'success' : 'danger'}">
                                        ${customer.status ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info me-2" onclick="viewCustomerDetails(${customer.id})">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-warning me-2" onclick="editCustomer(${customer.id})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteCustomer(${customer.id})">
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