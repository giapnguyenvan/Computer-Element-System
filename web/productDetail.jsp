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
            .quantity-selector {
                display: flex;
                border: 1px solid #ccc;
                border-radius: 4px;
                overflow: hidden;
                width: 120px;
                height: 36px;
                background: #fff;
            }
            .qty-btn {
                width: 36px;
                border: none;
                background: none;
                font-size: 1.25rem;
                color: #333;
                cursor: pointer;
                outline: none;
                transition: background 0.2s;
            }
            .qty-btn:hover {
                background: #f0f0f0;
            }
            .qty-input {
                width: 48px;
                border: none;
                outline: none;
                font-size: 1.25rem;
                background: none;
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
                    <img src="${product.imageUrl}" alt="${product.name}" class="img-fluid rounded">
                </div>

                <!-- Product Info -->
                <div class="col-md-7">
                    <h2 class="mb-3">${product.name}</h2>
                    <h4 class="text-muted">${product.brandName}</h4>
                    <h3 class="text-danger mb-3">$${product.price}</h3>

                    <p><strong>Category:</strong> ${product.componentTypeName}</p>
                    <p><strong>Stock:</strong> 
                        <span id="stockDisplay">${product.stock}</span> available
                    </p>
                    <p><strong>Status:</strong> ${product.status}</p>
                    <p><strong>Model:</strong> ${product.model}</p>
                    <p><strong>Series:</strong> ${product.seriesName}</p>
                    <p><strong>SKU:</strong> ${product.sku}</p>
                    <p><strong>Created At:</strong> ${product.createdAt}</p>

                    <hr>

                    <h5>Description</h5>
                    <p>${product.description}</p>

                    <c:if test="${product.stock > 0}">
                        <div class="d-flex align-items-center mt-4">
                            <div class="quantity-selector" style="width: 120px; margin-right: 15px;">
                                <button type="button" class="qty-btn" onclick="changeQuantity(${product.productId}, -1)">-</button>
                                <input type="number" id="quantity_${product.productId}" value="1" min="1" max="${product.stock}" class="qty-input" style="text-align:center;">
                                <button type="button" class="qty-btn" onclick="changeQuantity(${product.productId}, 1)">+</button>
                            </div>
                            <button class="btn btn-primary" 
                                    onclick="addToCart(${product.productId}, '${product.name}', ${product.price})"
                                    id="addBtn_${product.productId}">
                                <i class="fas fa-cart-plus me-2"></i>Add to Cart
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <hr>

            <!-- Related Products Section -->
            <div class="container">
                <h4 class="mt-5">Related Products</h4>
                <div class="row">
                    <c:forEach var="p" items="${relatedProducts}">
                        <c:if test="${p.productId != product.productId}">
                            <div class="col-md-3 mb-4">
                                <div class="card h-100">
                                    <img src="${p.imageUrl}" class="card-img-top" alt="${p.name}">
                                    <div class="card-body">
                                        <h5 class="card-title">${p.name}</h5>
                                        <p class="card-text">${p.brandName}</p>
                                        <p class="card-text text-danger">$${p.price}</p>
                                        <a href="${pageContext.request.contextPath}/productservlet?service=productDetail&id=${p.productId}" class="btn btn-outline-primary btn-sm">View</a>
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
        <!-- Đã được load trong header.jsp -->
        
        <!-- Initialize Bootstrap Components -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize all dropdowns
                var dropdowns = document.querySelectorAll('.dropdown-toggle');
                dropdowns.forEach(function(dropdown) {
                    new bootstrap.Dropdown(dropdown);
                });
            });

            function validateQuantity() {
                const quantityInput = document.getElementById('quantity');
                const maxStock = ${product.stock};
                let value = parseInt(quantityInput.value);
                
                if (isNaN(value) || value < 1) {
                    value = 1;
                } else if (value > maxStock) {
                    value = maxStock;
                }
                
                quantityInput.value = value;
            }

            function incrementQuantity() {
                const quantityInput = document.getElementById('quantity');
                const maxStock = ${product.stock};
                let value = parseInt(quantityInput.value);
                
                if (value < maxStock) {
                    quantityInput.value = value + 1;
                }
            }

            function decrementQuantity() {
                const quantityInput = document.getElementById('quantity');
                let value = parseInt(quantityInput.value);
                
                if (value > 1) {
                    quantityInput.value = value - 1;
                }
            }
        </script>

        <!-- SweetAlert2 for notifications -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <!-- Custom JavaScript for Cart Functionality -->
        <script>
            // Global variables
            let cartCount = 0;
            <c:choose>
                <c:when test="${not empty sessionScope.customerAuth}">
                    const currentUserId = ${sessionScope.customerAuth.customer_id};
                </c:when>
                <c:when test="${not empty sessionScope.userAuth}">
                    const currentUserId = ${sessionScope.userAuth.id};
                </c:when>
                <c:otherwise>
                    const currentUserId = 0;
                </c:otherwise>
            </c:choose>

            // Function to change quantity
            function changeQuantity(productId, change) {
                const quantityInput = document.getElementById('quantity_' + productId);
                let currentQuantity = parseInt(quantityInput.value);
                let newQuantity = currentQuantity + change;

                if (newQuantity < 1)
                    newQuantity = 1;
                if (newQuantity > ${product.stock})
                    newQuantity = ${product.stock};

                quantityInput.value = newQuantity;
            }

            // Function to add product to cart
            async function addToCart(productId, productName, productPrice) {
                // Check if user is logged in
                if (currentUserId === 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Please Login',
                        text: 'You need to login to add products to cart'
                    });
                    return;
                }

                const quantityInput = document.getElementById('quantity_' + productId);
                const quantity = parseInt(quantityInput.value);
                const addButton = document.getElementById('addBtn_' + productId);

                // Validate quantity
                if (isNaN(quantity) || quantity < 1) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Quantity',
                        text: 'Please enter a valid quantity'
                    });
                    return;
                }

                // Disable button and show loading
                addButton.disabled = true;
                addButton.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Adding...';

                try {
                    console.log('Sending request to add to cart:', {
                        userId: currentUserId,
                        productId: productId,
                        quantity: quantity
                    });

                    const response = await fetch('${pageContext.request.contextPath}/CartApiServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            customerId: currentUserId,
                            productId: productId,
                            quantity: quantity
                        })
                    });

                    console.log('Response status:', response.status);
                    const result = await response.json();
                    console.log('Response data:', result);

                    if (result.success) {
                        // Show success message
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: productName + ' has been added to your cart!',
                            timer: 2000,
                            showConfirmButton: false
                        });

                        // Update cart count
                        updateCartCount();

                        // Update stock display
                        const stockDisplay = document.getElementById('stockDisplay');
                        if (stockDisplay && result.remainingStock !== undefined) {
                            stockDisplay.textContent = result.remainingStock;
                        }

                        // Reset quantity to 1
                        quantityInput.value = 1;

                        // Add visual feedback
                        addButton.classList.add('btn-success');
                        addButton.innerHTML = '<i class="fas fa-check me-2"></i>Added!';

                        setTimeout(() => {
                            addButton.classList.remove('btn-success');
                            addButton.innerHTML = '<i class="fas fa-cart-plus me-2"></i>Add to Cart';
                        }, 2000);
                    } else {
                        throw new Error(result.message || 'Failed to add to cart');
                    }
                } catch (error) {
                    console.error('Error adding to cart:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: error.message || 'Failed to add product to cart. Please try again.'
                    });
                } finally {
                    // Re-enable button
                    addButton.disabled = false;
                    if (!addButton.classList.contains('btn-success')) {
                        addButton.innerHTML = '<i class="fas fa-cart-plus me-2"></i>Add to Cart';
                    }
                }
            }

            // Function to update cart count
            async function updateCartCount() {
                try {
                    const response = await fetch('${pageContext.request.contextPath}/CartApiServlet?customerId=' + currentUserId);
                    const result = await response.json();

                    if (result.success && result.data) {
                        const totalItems = result.data.reduce((sum, item) => sum + item.quantity, 0);
                        const cartCountElement = document.getElementById('cartCount');
                        if (cartCountElement) {
                            cartCountElement.textContent = totalItems;
                        }
                        cartCount = totalItems;
                    }
                } catch (error) {
                    // Ignore error
                }
            }

            // Initialize cart count on page load
            document.addEventListener('DOMContentLoaded', function() {
                updateCartCount();

                // Add keyboard support for quantity input
                const quantityInput = document.getElementById('quantity_${product.productId}');
                if (quantityInput) {
                    quantityInput.addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') {
                            addToCart(${product.productId}, '${product.name}', ${product.price});
                        }
                    });

                    quantityInput.addEventListener('change', function() {
                        let value = parseInt(this.value);
                        if (isNaN(value) || value < 1) {
                            value = 1;
                        }
                        if (value > ${product.stock}) {
                            value = ${product.stock};
                        }
                        this.value = value;
                    });
                }
            });
        </script>

        <c:if test="${empty product}">
            <div class="alert alert-danger mt-5">Không tìm thấy sản phẩm hoặc có lỗi xảy ra! Vui lòng thử lại.</div>
            <c:remove var="product" scope="request"/>
            <c:remove var="relatedProducts" scope="request"/>
            <c:remove var="feedbackList" scope="request"/>
            <c:remove var="totalPages" scope="request"/>
            <c:remove var="currentPage" scope="request"/>
            <c:remove var="averageRating" scope="request"/>
            <c:remove var="totalFeedback" scope="request"/>
            <jsp:include page="footer.jsp"/>
        </c:if>
    </body>
</html>
