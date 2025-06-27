<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Blog Test with Images</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Blog Test with Images</h1>
        
        <!-- Test Blog Display -->
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
                            <div class="card-text">
                                <p>${fn:substring(blog.content, 0, 100)}${fn:length(blog.content) > 100 ? '...' : ''}</p>
                            </div>
                            <div class="text-muted">
                                <small>
                                    Author: ${customerNames[blog.customer_id]}<br>
                                    Created: <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                    <c:if test="${not empty blog.images and blog.images.size() > 0}">
                                        <br><i class="fas fa-images"></i> ${blog.images.size()} image(s)
                                    </c:if>
                                </small>
                            </div>
                            
                            <!-- Image Gallery -->
                            <c:if test="${not empty blog.images and blog.images.size() > 1}">
                                <div class="image-gallery">
                                    <c:forEach items="${blog.images}" var="image" varStatus="status">
                                        <c:if test="${status.index > 0}">
                                            <img src="${image.image_url}" alt="${image.image_alt}" class="gallery-image">
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:if>
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 