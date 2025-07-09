<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Blog Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }
        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }
        .blog-image-placeholder {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            border-radius: 8px 8px 0 0;
        }
        .image-gallery {
            display: flex;
            gap: 10px;
            margin: 15px 0;
            overflow-x: auto;
            padding: 10px 0;
            flex-wrap: wrap;
        }
        .gallery-image {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
            border: 2px solid transparent;
        }
        .gallery-image:hover {
            transform: scale(1.05);
            border-color: #007bff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .modal-image-gallery {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .modal-image-gallery h6 {
            margin-bottom: 10px;
            color: #495057;
            font-weight: 600;
        }
        .modal-image-count {
            background-color: #007bff;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            margin-left: 10px;
        }
        .no-images-message {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
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



        <!-- Blog Display -->
        <div class="row">
            <c:forEach items="${blogList}" var="blog">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card blog-card h-100">
                        <!-- Blog Image -->
                        <c:choose>
                            <c:when test="${not empty blog.images and blog.images.size() > 0}">
                                <img src="${blog.images[0].image_url}" alt="${blog.images[0].image_alt}" class="blog-image" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                <div class="blog-image-placeholder" style="display: none;">blo
                                    <i class="fas fa-image fa-2x"></i>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="blog-image-placeholder">
                                    <i class="fas fa-image fa-2x"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="card-body">
                            <h5 class="card-title">${blog.title}</h5>
                            <div class="blog-meta mb-2">
                                <small>
                                    Created: <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                </small>
                            </div>
                            <div class="blog-content">
                                <p class="card-text">${fn:substring(blog.content, 0, 100)}${fn:length(blog.content) > 100 ? '...' : ''}</p>
                            </div>
                            <div class="blog-meta">
                                <small>Author: ${userNames[blog.user_id]}</small>
                                <br><small><i class="fas fa-images"></i> ${empty blog.images ? 0 : blog.images.size()} image(s)</small>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-info" 
                                        onclick="showBlogContent(this, '${fn:escapeXml(blog.title)}', '${fn:escapeXml(blog.content)}', '${fn:escapeXml(userNames[blog.user_id])}', '<fmt:formatDate value='${blog.created_at}' pattern='dd/MM/yyyy HH:mm'/>', ${blog.blog_id})">
                                    <i class="fas fa-eye me-1"></i>View Details
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
                            <i class="fas fa-user"></i> Author: <span id="modalBlogAuthor"></span><br>
                            <i class="fas fa-calendar"></i> Created: <span id="modalBlogCreated"></span>
                        </small>
                    </div>
                    
                    <!-- Image Gallery Section -->
                    <div id="modalBlogImages" class="modal-image-gallery" style="display: none;">
                        <h6>
                            <i class="fas fa-images"></i> Blog Images
                            <span id="modalImageCount" class="modal-image-count"></span>
                        </h6>
                        <div class="image-gallery" id="modalImageGallery">
                            <!-- Images will be loaded here -->
                        </div>
                    </div>
                    
                    <!-- Blog Content -->
                    <div class="blog-content-section">
                        <h6><i class="fas fa-file-text"></i> Blog Content</h6>
                        <div id="modalBlogContent" style="white-space: pre-wrap; line-height: 1.6; color: #333;"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>







    <script>

        
        function showBlogContent(element, title, content, author, created, blogId) {
            document.getElementById('modalBlogTitle').textContent = title;
            document.getElementById('modalBlogContent').textContent = content;
            document.getElementById('modalBlogAuthor').textContent = author;
            document.getElementById('modalBlogCreated').textContent = created;
            
            // Handle images - we'll load them from the server using blogId
            const imagesContainer = document.getElementById('modalBlogImages');
            const imageGallery = document.getElementById('modalImageGallery');
            const imageCount = document.getElementById('modalImageCount');
            
            imagesContainer.style.display = 'none';
            imageGallery.innerHTML = '';
            
            // Load images via AJAX
            fetch(`viewblogs?action=view&id=${blogId}`, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
                .then(response => response.json())
                .then(data => {
                    const images = data.images || [];
                    
                    // Display images
                    if (images && images.length > 0) {
                        imagesContainer.style.display = 'block';
                        imageCount.textContent = images.length;
                        
                        images.forEach(image => {
                            const imgElement = document.createElement('img');
                            imgElement.src = image.image_url;
                            imgElement.alt = image.image_alt || 'Blog image';
                            imgElement.className = 'gallery-image';
                            imgElement.onclick = () => openImageModal(image.image_url, image.image_alt);
                            imageGallery.appendChild(imgElement);
                        });
                    } else {
                        imageGallery.innerHTML = '<div class="no-images-message">No images available for this blog.</div>';
                        imageCount.textContent = '0';
                        imagesContainer.style.display = 'block';
                    }
                })
                .catch(error => {
                    console.error('Error loading images:', error);
                    imageGallery.innerHTML = '<div class="no-images-message">Error loading images.</div>';
                    imageCount.textContent = '0';
                    imagesContainer.style.display = 'block';
                });
            
            new bootstrap.Modal(document.getElementById('blogContentModal')).show();
        }
        
        function openImageModal(imageUrl, imageAlt) {
            // Create a simple image modal
            const modal = document.createElement('div');
            modal.className = 'modal fade';
            modal.innerHTML = `
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Image Preview</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body text-center">
                            <img src="${imageUrl}" class="img-fluid" alt="${imageAlt || 'Blog image'}">
                        </div>
                    </div>
                </div>
            `;
            document.body.appendChild(modal);
            new bootstrap.Modal(modal).show();
            modal.addEventListener('hidden.bs.modal', () => {
                document.body.removeChild(modal);
            });
        }
        

    </script>
</body>
</html>
