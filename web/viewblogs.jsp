<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            cursor: pointer;
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
        .stats-section {
            margin: 30px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 10px;
            text-align: center;
        }
        .modal-content {
            max-height: 90vh;
            overflow-y: auto;
        }
        .add-blog-btn {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .add-blog-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container mt-5">
        
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
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="viewblogs" method="GET" class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">Sort By:</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="newest" ${param.sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="oldest" ${param.sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                        <option value="title" ${param.sortBy == 'title' ? 'selected' : ''}>Title</option>
                        <option value="author" ${param.sortBy == 'author' ? 'selected' : ''}>Author Name</option>
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

        <!-- Add New Blog Button -->
        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-success add-blog-btn" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                <i class="fas fa-plus me-2"></i>Add New Blog
            </button>
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
                                    Created: ${blog.created_at}
                                </small>
                            </div>
                            <div class="blog-content">
                                <p class="card-text">${fn:substring(blog.content, 0, 200)}${fn:length(blog.content) > 200 ? '...' : ''}</p>
                            </div>
                            <div class="blog-meta">
                                <small>Author: ${customerNames[blog.customer_id]}</small>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-info" 
                                        onclick="showBlogContent(this)" 
                                        data-title="${fn:escapeXml(blog.title)}"
                                        data-content="${fn:escapeXml(blog.content)}"
                                        data-author="${fn:escapeXml(customerNames[blog.customer_id])}"
                                        data-created="${blog.created_at}">
                                    View Details
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

        <!-- Stats Section -->
        <div class="stats-section">
            <h5 class="mb-2">Total Blogs: ${totalBlogs}</h5>
            <p class="mb-0">Page ${currentPage} of ${totalPages}</p>
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

    <!-- Blog Content Modal -->
    <div class="modal fade" id="blogContentModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalBlogTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="blog-meta mb-3">
                        <small>
                            Author: <span id="modalBlogAuthor"></span><br>
                            Created: <span id="modalBlogCreated"></span>
                        </small>
                    </div>
                    <div id="modalBlogContent" style="white-space: pre-wrap;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add New Blog Modal -->
    <div class="modal fade" id="addBlogModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Blog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="addBlogForm" action="viewblogs" method="POST">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="blogTitle" class="form-label">Blog Title *</label>
                            <input type="text" class="form-control" id="blogTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="blogContent" class="form-label">Blog Content *</label>
                            <textarea class="form-control" id="blogContent" name="content" rows="8" required 
                                      oninput="updateCharCount()"></textarea>
                            <div class="form-text">
                                <span id="charCount">0</span> characters
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="customerId" class="form-label">Author (Customer) *</label>
                            <select class="form-select" id="customerId" name="customer_id" required>
                                <option value="">Select a customer...</option>
                                <c:forEach items="${customerList}" var="customer">
                                    <option value="${customer.customer_id}" 
                                            ${sessionScope.userAuth != null && sessionScope.user_id == customer.customer_id ? 'selected' : ''}>
                                        ${customer.customer_id} - ${customer.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">Select the customer who will be the author of this blog</div>
                        </div>
                        <input type="hidden" name="action" value="add">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">Create Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showBlogContent(element) {
            const title = element.getAttribute('data-title');
            const content = element.getAttribute('data-content');
            const author = element.getAttribute('data-author');
            const created = element.getAttribute('data-created');
            
            document.getElementById('modalBlogTitle').textContent = title;
            document.getElementById('modalBlogContent').textContent = content;
            document.getElementById('modalBlogAuthor').textContent = author;
            document.getElementById('modalBlogCreated').textContent = created;
            
            new bootstrap.Modal(document.getElementById('blogContentModal')).show();
        }
        
        // Handle add blog form submission
        document.getElementById('addBlogForm').addEventListener('submit', function(e) {
            const title = document.getElementById('blogTitle').value.trim();
            const content = document.getElementById('blogContent').value.trim();
            const customerId = document.getElementById('customerId').value.trim();
            
            if (!title || !content || !customerId) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return false;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating...';
            submitBtn.disabled = true;
        });
        
        // Clear form when modal is hidden
        document.getElementById('addBlogModal').addEventListener('hidden.bs.modal', function() {
            document.getElementById('addBlogForm').reset();
            const submitBtn = document.querySelector('#addBlogForm button[type="submit"]');
            submitBtn.innerHTML = 'Create Blog';
            submitBtn.disabled = false;
            document.getElementById('charCount').textContent = '0';
        });
        
        // Update character count
        function updateCharCount() {
            const content = document.getElementById('blogContent').value;
            const charCount = document.getElementById('charCount');
            charCount.textContent = content.length;
        }
    </script>
</body>
</html>
