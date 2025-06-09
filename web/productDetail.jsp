<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Product Detail</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 110px; /* Giảm padding-top để top-bar và navbar dính vào nhau */
            }
            .top-bar {
                background-color: #343a40;
                color: white;
                padding: 8px 0;
                font-size: 0.9rem;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1030;
            }
            .navbar {
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                position: fixed;
                top: 37px; /* Chiều cao của top-bar */
                left: 0;
                right: 0;
                z-index: 1020;
            }
            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;
            }
            .nav-link {
                color: #333;
                font-weight: 500;
            }
            .nav-link:hover {
                color: #0d6efd;
            }
            .dropdown-menu {
                border: none;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            /* Chỉnh lại form search */
            .navbar form.d-flex {
                margin: 0;
                align-items: center;
            }
            .navbar .input-group {
                width: 100%;
                align-items: center;
            }
            .navbar .form-control {
                height: 38px;
            }
            .navbar .btn-outline-primary {
                height: 38px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>
        
        <div class="container mt-5">
            <div class="row">
                <!-- Product Image -->
                <div class="col-md-5">
                    <img src="${product.image_url}" alt="${product.name}" class="img-fluid rounded">
                </div>

                <!-- Product Info -->
                <div class="col-md-7">
                    <h2 class="mb-3">${product.name}</h2>
                    <h4 class="text-muted">${product.brand}</h4>
                    <h3 class="text-danger mb-3">$${product.price}</h3>

                    <p><strong>Category ID:</strong> ${product.category_id}</p>
                    <p><strong>Stock:</strong> 
                        <c:choose>
                            <c:when test="${product.stock > 0}">${product.stock} available</c:when>
                            <c:otherwise><span class="text-danger">Out of Stock</span></c:otherwise>
                        </c:choose>
                    </p>

                    <hr>

                    <h5>Description</h5>
                    <p>${product.description}</p>

                    <h5>Specifications</h5>
                    <p>${product.spec_description}</p>

                    <c:if test="${product.stock > 0}">
                        <a href="${pageContext.request.contextPath}/cart?service=addToCart&productID=${product.id}" class="btn btn-primary mt-3">
                            Add to Cart
                        </a>
                    </c:if>
                </div>
            </div>

            <hr>

            <!-- Related Products Section -->
            <div class="container">
                <h4 class="mt-5">Related Products</h4>
                <div class="row">
                    <c:forEach var="p" items="${relatedProducts}">
                        <c:if test="${p.id != product.id}">
                            <div class="col-md-3 mb-4">
                                <div class="card h-100">
                                    <img src="${p.image_url}" class="card-img-top" alt="${p.name}">
                                    <div class="card-body">
                                        <h5 class="card-title">${p.name}</h5>
                                        <p class="card-text">${p.brand}</p>
                                        <p class="card-text text-danger">$${p.price}</p>
                                        <a href="${pageContext.request.contextPath}/productservlet?service=productDetail&id=${p.id}" class="btn btn-outline-primary btn-sm">View</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Include Customer Feedback Section -->
            <jsp:include page="viewCustomerFeedback.jsp" />
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <!-- Initialize Bootstrap Components -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize all dropdowns
                var dropdowns = document.querySelectorAll('.dropdown-toggle');
                dropdowns.forEach(function(dropdown) {
                    new bootstrap.Dropdown(dropdown);
                });
            });
        </script>
    </body>
</html>
