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
                <input type="hidden" name="page" value="${currentPage}">
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
                    <input type="text" name="search" class="form-control" placeholder="Search in blogs..." 
                           value="${param.search}" onkeyup="if(event.keyCode === 13) this.form.submit();">
                </div>
            </form>
        </div>

        <!-- Blog Display -->
        <div class="row">
            <c:forEach items="${blogList}" var="blog">
                <div class="col-md-6">
                    <div class="card blog-card">
                        <div class="card-body">
                            <h5 class="card-title"><c:out value="${blog.title}"/></h5>
                            <div class="blog-meta mb-2">
                                <small>Created: <c:out value="${blog.created_at}"/> | Updated: <c:out value="${blog.updated_at}"/></small>
                            </div>
                            <div class="blog-content mb-3">
                                <p class="card-text"><c:out value="${blog.content}"/></p>
                            </div>
                            <div class="blog-meta">
                                <small>User ID: <c:out value="${blog.user_id}"/></small>
                            </div>
                            <div class="action-buttons">
                                <button type="button" class="btn btn-sm btn-primary" 
                                        onclick="editBlog('${blog.id}', '${blog.title}', '${blog.content}', '${blog.user_id}')"
                                        data-bs-toggle="modal" data-bs-target="#editBlogModal">
                                    Edit
                                </button>
                                <button type="button" class="btn btn-sm btn-info" 
                                        onclick="viewFullBlog('${blog.id}')"
                                        data-bs-toggle="modal" data-bs-target="#viewBlogModal">
                                    View
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" 
                                        onclick="deleteBlog('${blog.id}')"
                                        data-bs-toggle="modal" data-bs-target="#deleteBlogModal">
                                    Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty blogList}">
                <div class="col-12 text-center">
                    <div class="alert alert-info" role="alert">
                        No blogs found.
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Blog pagination" class="d-flex justify-content-center">
                <ul class="pagination">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="viewblogs?page=${currentPage - 1}&sortBy=${param.sortBy}&search=${param.search}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="viewblogs?page=${i}&sortBy=${param.sortBy}&search=${param.search}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="viewblogs?page=${currentPage + 1}&sortBy=${param.sortBy}&search=${param.search}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
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
                <form action="Blog_control" method="POST">
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
                <form action="Blog_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="blog_id" id="edit_blog_id">
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

    <!-- View Blog Modal -->
    <div class="modal fade" id="viewBlogModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="view_title"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="blog-meta mb-3">
                        <small id="view_meta"></small>
                    </div>
                    <div id="view_content"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Blog Modal -->
    <div class="modal fade" id="deleteBlogModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Blog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="Blog_control" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="blog_id" id="delete_blog_id">
                        <p>Are you sure you want to delete this blog? This action cannot be undone.</p>
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
        function editBlog(id, title, content, userId) {
            document.getElementById('edit_blog_id').value = id;
            document.getElementById('edit_user_id').value = userId;
            document.getElementById('edit_title').value = title;
            document.getElementById('edit_content').value = content;
        }
        
        function viewFullBlog(id) {
            // Find the blog in the current page
            const blogs = document.querySelectorAll('.blog-card');
            for (let blog of blogs) {
                if (blog.querySelector('[onclick*="' + id + '"]')) {
                    const title = blog.querySelector('.card-title').textContent;
                    const content = blog.querySelector('.card-text').textContent;
                    const meta = blog.querySelector('.blog-meta').textContent;
                    
                    document.getElementById('view_title').textContent = title;
                    document.getElementById('view_meta').textContent = meta;
                    document.getElementById('view_content').textContent = content;
                    break;
                }
            }
        }
        
        function deleteBlog(id) {
            document.getElementById('delete_blog_id').value = id;
        }
    </script>
</body>
</html>
