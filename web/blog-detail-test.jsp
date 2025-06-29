<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Blog Detail Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .blog-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .blog-card:hover {
            transform: translateY(-5px);
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
        .blog-content-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Blog Detail Test with Images</h1>
        
        <!-- Test Blog Cards -->
        <div class="row">
            <c:forEach items="${blogList}" var="blog" varStatus="status">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card blog-card h-100">
                        <!-- Blog Image -->
                        <c:choose>
                            <c:when test="${not empty blog.images and blog.images.size() > 0}">
                                <img src="${blog.images[0].image_url}" alt="${blog.images[0].image_alt}" class="blog-image">
                            </c:when>
                            <c:otherwise>
                                <div class="blog-image-placeholder">
                                    <i class="fas fa-image fa-2x"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="card-body">
                            <h5 class="card-title">${blog.title}</h5>
                            <div class="card-text">
                                <p>${fn:substring(blog.content, 0, 100)}${fn:length(blog.content) > 100 ? '...' : ''}</p>
                            </div>
                            <div class="text-muted">
                                <small>
                                    <i class="fas fa-user"></i> ${customerNames[blog.customer_id]}<br>
                                    <i class="fas fa-calendar"></i> <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                    <c:if test="${not empty blog.images and blog.images.size() > 0}">
                                        <br><i class="fas fa-images"></i> ${blog.images.size()} image(s)
                                    </c:if>
                                </small>
                            </div>
                            
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-info" 
                                        onclick="showBlogDetail(${blog.blog_id}, '${fn:escapeXml(blog.title)}', '${fn:escapeXml(blog.content)}', '${fn:escapeXml(customerNames[blog.customer_id])}', '<fmt:formatDate value='${blog.created_at}' pattern='dd/MM/yyyy HH:mm'/>')">
                                    <i class="fas fa-eye me-1"></i>View Details
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty blogList}">
            <div class="alert alert-info">
                No blogs found. Please add some blogs with images to test the functionality.
            </div>
        </c:if>
    </div>

    <!-- Blog Detail Modal -->
    <div class="modal fade" id="blogDetailModal" tabindex="-1">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showBlogDetail(blogId, title, content, author, created) {
            document.getElementById('modalBlogTitle').textContent = title;
            document.getElementById('modalBlogContent').textContent = content;
            document.getElementById('modalBlogAuthor').textContent = author;
            document.getElementById('modalBlogCreated').textContent = created;
            
            // Handle images
            const imagesContainer = document.getElementById('modalBlogImages');
            const imageGallery = document.getElementById('modalImageGallery');
            const imageCount = document.getElementById('modalImageCount');
            
            imagesContainer.style.display = 'none';
            imageGallery.innerHTML = '';
            
            // Load images for this blog
            loadBlogImages(blogId, imageGallery, imageCount, imagesContainer);
            
            new bootstrap.Modal(document.getElementById('blogDetailModal')).show();
        }
        
        function loadBlogImages(blogId, imageGallery, imageCount, imagesContainer) {
            // Show loading message
            imageGallery.innerHTML = '<div class="no-images-message">Loading images...</div>';
            imagesContainer.style.display = 'block';
            imageCount.textContent = '...';
            
            // Simulate AJAX call to get images
            // In a real implementation, you would make an actual AJAX call here
            setTimeout(() => {
                // For demo purposes, we'll show sample images
                const sampleImages = [
                    { image_url: '/assets/images/blog/sample1.jpg', image_alt: 'Sample image 1' },
                    { image_url: '/assets/images/blog/sample2.jpg', image_alt: 'Sample image 2' },
                    { image_url: '/assets/images/blog/sample3.jpg', image_alt: 'Sample image 3' }
                ];
                
                if (sampleImages.length > 0) {
                    imageCount.textContent = sampleImages.length;
                    imageGallery.innerHTML = '';
                    
                    sampleImages.forEach((image, index) => {
                        const imgElement = document.createElement('img');
                        imgElement.src = image.image_url;
                        imgElement.alt = image.image_alt;
                        imgElement.className = 'gallery-image';
                        imgElement.title = image.image_alt;
                        imgElement.onclick = () => openImageModal(image.image_url, image.image_alt);
                        imageGallery.appendChild(imgElement);
                    });
                } else {
                    imageGallery.innerHTML = '<div class="no-images-message">No images available for this blog</div>';
                    imageCount.textContent = '0';
                }
            }, 1000);
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