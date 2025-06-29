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
        }
        .gallery-image {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .gallery-image:hover {
            transform: scale(1.05);
        }
        .image-upload-area {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            background-color: #f8f9fa;
            transition: border-color 0.3s;
        }
        .image-upload-area:hover {
            border-color: #198754;
        }
        .image-upload-area.dragover {
            border-color: #198754;
            background-color: #e8f5e8;
        }
        .image-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }
        .image-preview-item {
            position: relative;
            width: 120px;
            height: 80px;
        }
        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
        }
        .image-preview-item .remove-btn {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 10px;
            cursor: pointer;
        }
        .image-alt-input {
            margin-top: 5px;
            font-size: 0.8em;
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
            <c:choose>
                <c:when test="${not empty sessionScope.customerAuth}">
                    <button type="button" class="btn btn-success add-blog-btn" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                        <i class="fas fa-plus me-2"></i>Add New Blog
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-success add-blog-btn" disabled>
                        <i class="fas fa-plus me-2"></i>Add New Blog
                    </button>
                    <span class="ms-3 align-self-center text-danger">Please log in to add a new blog.</span>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Blog Display -->
        <div class="row">
            <c:forEach items="${blogList}" var="blog">
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
                            <div class="blog-meta mb-2">
                                <small>
                                    Created: <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                </small>
                            </div>
                            <div class="blog-content">
                                <p class="card-text">${fn:substring(blog.content, 0, 100)}${fn:length(blog.content) > 100 ? '...' : ''}</p>
                            </div>
                            <div class="blog-meta">
                                <small>Author: ${customerNames[blog.customer_id]}</small>
                                <c:if test="${not empty blog.images and blog.images.size() > 0}">
                                    <br><small><i class="fas fa-images"></i> ${blog.images.size()} image(s)</small>
                                </c:if>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-sm btn-info" 
                                        onclick="showBlogContent(this)" 
                                        data-title="${fn:escapeXml(blog.title)}"
                                        data-content="${fn:escapeXml(blog.content)}"
                                        data-author="${fn:escapeXml(customerNames[blog.customer_id])}"
                                        data-created="<fmt:formatDate value='${blog.created_at}' pattern='dd/MM/yyyy HH:mm'/>"
                                        data-images='${blog.images != null ? blog.images : "[]"}'>
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
                    
                    <!-- Image Gallery -->
                    <div id="modalBlogImages" class="image-gallery" style="display: none;">
                        <!-- Images will be loaded here -->
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
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Blog</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="addBlogForm" action="viewblogs" method="POST" enctype="multipart/form-data">
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
                        
                        <!-- Image Upload Section -->
                        <div class="mb-3">
                            <label class="form-label">Blog Images</label>
                            <div class="image-upload-area" id="imageUploadArea">
                                <i class="fas fa-cloud-upload-alt fa-2x mb-2"></i>
                                <p class="mb-2">Drag and drop images here or click to select</p>
                                <input type="file" id="imageInput" name="images" multiple accept="image/*" style="display: none;">
                                <button type="button" class="btn btn-outline-primary" onclick="document.getElementById('imageInput').click()">
                                    Select Images
                                </button>
                            </div>
                            <div class="image-preview" id="imagePreview"></div>
                        </div>
                        
                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${not empty sessionScope.customerAuth}">
                                    <input type="hidden" id="customerId" name="customer_id" value="${sessionScope.customerAuth.customer_id}" />
                                    <div class="form-text">
                                        Author: <strong>${sessionScope.customerAuth.name}</strong>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <label for="customerId" class="form-label">Author (Customer) *</label>
                                    <select class="form-select" id="customerId" name="customer_id" required>
                                        <option value="">Select a customer...</option>
                                        <c:forEach items="${customerList}" var="customer">
                                            <option value="${customer.customer_id}">
                                                ${customer.customer_id} - ${customer.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">Select the customer who will be the author of this blog</div>
                                </c:otherwise>
                            </c:choose>
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
        // Global variables for image management
        let uploadedImages = [];
        
        function showBlogContent(element) {
            const title = element.getAttribute('data-title');
            const content = element.getAttribute('data-content');
            const author = element.getAttribute('data-author');
            const created = element.getAttribute('data-created');
            const imagesData = element.getAttribute('data-images');
            
            document.getElementById('modalBlogTitle').textContent = title;
            document.getElementById('modalBlogContent').textContent = content;
            document.getElementById('modalBlogAuthor').textContent = author;
            document.getElementById('modalBlogCreated').textContent = created;
            
            // Handle images
            const imagesContainer = document.getElementById('modalBlogImages');
            imagesContainer.innerHTML = '';
            
            if (imagesData && imagesData !== '[]') {
                try {
                    const images = JSON.parse(imagesData);
                    if (images.length > 0) {
                        images.forEach(image => {
                            const imgElement = document.createElement('img');
                            imgElement.src = image.image_url;
                            imgElement.alt = image.image_alt || 'Blog image';
                            imgElement.className = 'gallery-image';
                            imgElement.onclick = () => openImageModal(image.image_url);
                            imagesContainer.appendChild(imgElement);
                        });
                        imagesContainer.style.display = 'flex';
                    } else {
                        imagesContainer.style.display = 'none';
                    }
                } catch (e) {
                    imagesContainer.style.display = 'none';
                }
            } else {
                imagesContainer.style.display = 'none';
            }
            
            new bootstrap.Modal(document.getElementById('blogContentModal')).show();
        }
        
        function openImageModal(imageUrl) {
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
                            <img src="${imageUrl}" class="img-fluid" alt="Blog image">
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
        
        // Image upload handling
        const imageUploadArea = document.getElementById('imageUploadArea');
        const imageInput = document.getElementById('imageInput');
        const imagePreview = document.getElementById('imagePreview');
        
        imageUploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            imageUploadArea.classList.add('dragover');
        });
        
        imageUploadArea.addEventListener('dragleave', () => {
            imageUploadArea.classList.remove('dragover');
        });
        
        imageUploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            imageUploadArea.classList.remove('dragover');
            const files = e.dataTransfer.files;
            handleImageFiles(files);
        });
        
        imageInput.addEventListener('change', (e) => {
            handleImageFiles(e.target.files);
        });
        
        function handleImageFiles(files) {
            Array.from(files).forEach((file, index) => {
                if (file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        const imageData = {
                            file: file,
                            url: e.target.result,
                            alt: file.name,
                            order: uploadedImages.length + 1
                        };
                        uploadedImages.push(imageData);
                        displayImagePreview(imageData);
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
        
        function displayImagePreview(imageData) {
            const previewItem = document.createElement('div');
            previewItem.className = 'image-preview-item';
            previewItem.innerHTML = `
                <img src="${imageData.url}" alt="${imageData.alt}">
                <button type="button" class="remove-btn" onclick="removeImage(${uploadedImages.indexOf(imageData)})">
                    <i class="fas fa-times"></i>
                </button>
                <input type="text" class="form-control image-alt-input" 
                       placeholder="Alt text" value="${imageData.alt}"
                       onchange="updateImageAlt(${uploadedImages.indexOf(imageData)}, this.value)">
            `;
            imagePreview.appendChild(previewItem);
        }
        
        function removeImage(index) {
            uploadedImages.splice(index, 1);
            imagePreview.innerHTML = '';
            
            // Redisplay remaining images
            uploadedImages.forEach(imageData => {
                displayImagePreview(imageData);
            });
        }
        
        function updateImageAlt(index, altText) {
            if (uploadedImages[index]) {
                uploadedImages[index].alt = altText;
            }
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
            
            // Add image data to form
            uploadedImages.forEach((imageData, index) => {
                const imageInput = document.createElement('input');
                imageInput.type = 'hidden';
                imageInput.name = `image_urls[${index}]`;
                imageInput.value = imageData.url;
                this.appendChild(imageInput);
                
                const altInput = document.createElement('input');
                altInput.type = 'hidden';
                altInput.name = `image_alts[${index}]`;
                altInput.value = imageData.alt;
                this.appendChild(altInput);
            });
            
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
            
            // Clear image previews
            uploadedImages = [];
            document.getElementById('imagePreview').innerHTML = '';
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