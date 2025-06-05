<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Blog Management</h2>
        <a href="${pageContext.request.contextPath}/blogservlet?service=add" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Add New Blog
        </a>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${blogs}" var="blog">
                            <tr>
                                <td>${blog.id}</td>
                                <td>${blog.title}</td>
                                <td>${blog.author}</td>
                                <td>${blog.date}</td>
                                <td>
                                    <span class="badge bg-${blog.status ? 'success' : 'warning'}">
                                        ${blog.status ? 'Published' : 'Draft'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info me-2" onclick="viewBlog(${blog.id})">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-warning me-2" onclick="editBlog(${blog.id})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteBlog(${blog.id})">
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
function viewBlog(id) {
    window.location.href = '${pageContext.request.contextPath}/blogservlet?service=view&id=' + id;
}

function editBlog(id) {
    window.location.href = '${pageContext.request.contextPath}/blogservlet?service=edit&id=' + id;
}

function deleteBlog(id) {
    if (confirm('Are you sure you want to delete this blog post?')) {
        window.location.href = '${pageContext.request.contextPath}/blogservlet?service=delete&id=' + id;
    }
}
</script> 