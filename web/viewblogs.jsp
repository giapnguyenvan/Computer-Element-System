<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Blog Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .blog-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .blog-card:hover {
            transform: translateY(-5px);
        }
        .blog-meta {
            font-size: 0.9em;
            color: #666;
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .pagination {
            margin-top: 30px;
        }
        .action-buttons {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }
        .blog-content {
            max-height: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Blog Management</h1>
        
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
        
        <!-- Add New Blog Button -->
        <div class="text-end mb-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                Add New Blog
            </button>
        </div>

        <!-- Stats Section -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body text-center">
                        <h5>Total Blogs: ${totalBlogs}</h5>
                        <p class="mb-0">Page ${currentPage} of ${totalPages}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="viewblogs" method="GET" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Sort By:</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="newest" ${param.sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="oldest" ${param.sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                        <option value="title" ${param.sortBy == 'title' ? 'selected' : ''}>Title</option>
                    </select>
                </div>
                <div class="col-md-8">
                    <label class="form-label">Search:</label>
                    <div class="input-group">
                    <input type="text" name="search" class="form-control" placeholder="Search in blogs..." 
                               value="${param.search}">
                        <button class="btn btn-outline-secondary" type="submit">Search</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Blog Display -->
        <div class="row">
            <c:forEach items="${blogList}" var="blog">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card blog-card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${blog.title}</h5>
                            <div class="blog-meta mb-2">
                                <small>
                                    Created: ${blog.created_at}<br>
                                    Updated: ${blog.updated_at}
                                </small>
                            </div>
                            <div class="blog-content">
                                <p class="card-text">${blog.content}</p>
                            </div>
                            <div class="blog-meta">
                                <small>User ID: ${blog.user_id}</small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-sm btn-primary" 
                                        onclick="editBlog('${blog.id}', '${blog.title}', '${blog.content}', '${blog.user_id}')"
                                        data-bs-toggle="modal" data-bs-target="#editBlogModal">
                                    Edit
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" 
                                        onclick="confirmDelete('${blog.id}', '${blog.user_id}')">
                                    Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty blogList}">
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        No blogs found.
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Blog pagination">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="viewblogs?page=${currentPage - 1}&sortBy=${param.sortBy}&search=${param.search}">Previous</a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="viewblogs?page=${i}&sortBy=${param.sortBy}&search=${param.search}">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="viewblogs?page=${currentPage + 1}&sortBy=${param.sortBy}&search=${param.search}">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Add Blog Modal -->
    <div class="modal fade" id="addBlogModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Blog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/CES/Blog_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="mb-3">
                            <label class="form-label">Title:</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Content:</label>
                            <textarea class="form-control" name="content" rows="10" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">User ID:</label>
                            <input type="number" class="form-control" name="user_id" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Blog Modal -->
    <div class="modal fade" id="editBlogModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Blog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/CES/Blog_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" id="edit_blog_id">
                        <input type="hidden" name="user_id" id="edit_user_id">
                        
                        <div class="mb-3">
                            <label class="form-label">Title:</label>
                            <input type="text" class="form-control" name="title" id="edit_title" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Content:</label>
                            <textarea class="form-control" name="content" id="edit_content" rows="10" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editBlog(id, title, content, userId) {
            document.getElementById('edit_blog_id').value = id;
            document.getElementById('edit_title').value = title;
            document.getElementById('edit_content').value = content;
            document.getElementById('edit_user_id').value = userId;
        }
        
        function confirmDelete(blogId, userId) {
            if (confirm('Are you sure you want to delete this blog?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/CES/Blog_control';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = blogId;
                
                const userIdInput = document.createElement('input');
                userIdInput.type = 'hidden';
                userIdInput.name = 'user_id';
                userIdInput.value = userId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                form.appendChild(userIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
