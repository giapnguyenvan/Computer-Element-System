<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Blog Detail</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .blog-main-image {
            max-width: 100%;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .blog-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .blog-gallery img {
            max-width: 180px;
            max-height: 120px;
            border-radius: 6px;
            object-fit: cover;
        }
        .blog-meta {
            color: #888;
            font-size: 0.95rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp"/>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <c:if test="${not empty blog}">
                    <h1 class="mb-3">${blog.title}</h1>
                    <div class="blog-meta mb-2">
                        <span>By <strong>${author}</strong></span>
                        <span class="ms-3">Created at: <fmt:formatDate value="${blog.created_at}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </div>
                    <c:if test="${not empty blog.mainImage}">
                        <img src="${blog.mainImage.image_url}" alt="${blog.mainImage.image_alt}" class="blog-main-image mb-4"/>
                    </c:if>
                    <div class="mb-4">
                        <div style="white-space: pre-line;">${blog.content}</div>
                    </div>
                    <c:if test="${not empty blog.sortedImages}">
                        <h5>Gallery</h5>
                        <div class="blog-gallery mb-4">
                            <c:forEach var="img" items="${blog.sortedImages}">
                                <img src="${img.image_url}" alt="${img.image_alt}"/>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:if>
                <c:if test="${empty blog}">
                    <div class="alert alert-danger mt-5">Blog not found or an error occurred!</div>
                </c:if>
                <a href="viewblogs" class="btn btn-outline-secondary mt-3">Back to Blog List</a>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 