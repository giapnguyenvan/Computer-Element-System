<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="css/homePage.css" rel="stylesheet">
        <!-- SweetAlert2 for notifications -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1 class="display-4 mb-4">Build Your Dream PC</h1>
                        <p class="lead mb-4">Customize your perfect PC with our easy-to-use PC Builder tool. Select from our wide range of high-quality components.</p>
                        <a href="PCBuilderServlet" class="btn btn-primary btn-lg">Build PC</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features -->
        <section class="py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-shipping-fast feature-icon"></i>
                            <h5>Free Shipping</h5>
                            <p class="mb-0">On orders over $100</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-headset feature-icon"></i>
                            <h5>24/7 Support</h5>
                            <p class="mb-0">Expert assistance</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-shield-alt feature-icon"></i>
                            <h5>Secure Payments</h5>
                            <p class="mb-0">100% secure checkout</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="feature-card">
                            <i class="fas fa-undo feature-icon"></i>
                            <h5>Easy Returns</h5>
                            <p class="mb-0">30-day return policy</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Categories -->
        <section class="py-5">
            <div class="container">
                <h2 class="mb-4">Shop by Category</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card category-card">
                            <img src="https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea" class="card-img-top" alt="Processors">
                            <div class="card-body">
                                <h5 class="card-title">Processors</h5>
                                <p class="card-text">Latest CPUs from Intel & AMD</p>
                                <a href="#cpuProducts" class="btn btn-outline-primary">Shop Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card category-card">
                            <img src="https://images.unsplash.com/photo-1587202372775-e229f172b9d7" class="card-img-top" alt="Graphics Cards">
                            <div class="card-body">
                                <h5 class="card-title">Graphics Cards</h5>
                                <p class="card-text">High-performance GPUs for gaming & work</p>
                                <a href="#gpuProducts" class="btn btn-outline-primary">Shop Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card category-card">
                            <img src="https://images.unsplash.com/photo-1541029071515-84cc54f84dc5" class="card-img-top" alt="Memory (RAM)">
                            <div class="card-body">
                                <h5 class="card-title">Memory (RAM)</h5>
                                <p class="card-text">High-speed RAM for smooth multitasking</p>
                                <a href="#ramProducts" class="btn btn-outline-primary">Shop Now</a>
                            </div>
                        </div>
                    </div>
                    <!-- Add more category cards -->
                </div>
            </div>
        </section>

        <!-- CPU Products Section -->
        <section id="cpuProducts" class="py-5 bg-light">
            <jsp:include page="CPUCategory.jsp" />
        </section>

        <!-- GPU Products Section -->
        <section id="gpuProducts" class="py-5">
            <jsp:include page="GPUCategory.jsp" />
        </section>

        <!-- RAM Products Section -->
        <section id="ramProducts" class="py-5 bg-light">
            <jsp:include page="RAMCategory.jsp" />
        </section>

        <!-- Newsletter -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center">
                        <h3>Subscribe to Our Newsletter</h3>
                        <p>Get the latest updates on new products and upcoming sales</p>
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Your email address">
                                <button class="btn btn-primary" type="submit">Subscribe</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp"/>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Initialize Bootstrap Components -->
        <script>
            // Function to initialize dropdowns
            function initializeDropdowns() {
                try {
                    // Check if Bootstrap is loaded
                    if (typeof bootstrap === 'undefined') {
                        console.error('Bootstrap is not loaded properly');
                        return;
                    }

                    // Initialize all dropdowns
                    const dropdownElementList = document.querySelectorAll('[data-bs-toggle="dropdown"]');
                    if (dropdownElementList.length === 0) {
                        console.warn('No dropdown elements found');
                        return;
                    }

                    dropdownElementList.forEach(dropdownToggle => {
                        try {
                            // Remove any existing dropdown instance
                            const existingDropdown = bootstrap.Dropdown.getInstance(dropdownToggle);
                            if (existingDropdown) {
                                existingDropdown.dispose();
                            }

                            // Create new dropdown instance
                            const dropdown = new bootstrap.Dropdown(dropdownToggle);
                            
                            // Add click handler
                            dropdownToggle.addEventListener('click', function(e) {
                                e.preventDefault();
                                e.stopPropagation();
                                dropdown.toggle();
                            });

                            // Debug info
                            console.log('Dropdown initialized:', dropdownToggle.id);
                        } catch (err) {
                            console.error('Error initializing dropdown:', err);
                        }
                    });

                    // Add hover functionality
                    const dropdownMenus = document.querySelectorAll('.dropdown');
                    dropdownMenus.forEach(dropdown => {
                        const toggle = dropdown.querySelector('[data-bs-toggle="dropdown"]');
                        
                        dropdown.addEventListener('mouseenter', function() {
                            const instance = bootstrap.Dropdown.getInstance(toggle);
                            if (instance) {
                                instance.show();
                            } else {
                                new bootstrap.Dropdown(toggle).show();
                            }
                        });
                        
                        dropdown.addEventListener('mouseleave', function() {
                            const instance = bootstrap.Dropdown.getInstance(toggle);
                            if (instance) {
                                instance.hide();
                            }
                        });
                    });

                    // Log total number of dropdowns
                    console.log('Total dropdowns found:', dropdownElementList.length);
                    
                } catch (err) {
                    console.error('Error in dropdown initialization:', err);
                }
            }

            // Initialize on DOMContentLoaded
            document.addEventListener('DOMContentLoaded', initializeDropdowns);

            // Re-initialize on dynamic content changes
            const observer = new MutationObserver(function(mutations) {
                mutations.forEach(function(mutation) {
                    if (mutation.addedNodes.length || mutation.removedNodes.length) {
                        initializeDropdowns();
                    }
                });
            });

            // Start observing the document with the configured parameters
            observer.observe(document.body, { childList: true, subtree: true });
        </script>

        <!-- Custom JavaScript for Cart Functionality -->
        <script>
                                            // Global variables
                                            let cartCount = 0;
                                            const currentUserId = ${sessionScope.customerAuth.customer_id}; // Thay đổi theo user đang đăng nhập

                                            // Function to change quantity
                                            function changeQuantity(productId, change) {
                                                const quantityInput = document.getElementById('quantity_' + productId);
                                                let currentQuantity = parseInt(quantityInput.value);
                                                let newQuantity = currentQuantity + change;

                                                if (newQuantity < 1)
                                                    newQuantity = 1;
                                                if (newQuantity > 99)
                                                    newQuantity = 99;

                                                quantityInput.value = newQuantity;
                                            }

                                            // Function to add product to cart
                                            async function addToCart(productId, productName, productPrice) {
                                                const quantityInput = document.getElementById('quantity_' + productId);
                                                const quantity = parseInt(quantityInput.value);
                                                const addButton = document.getElementById('addBtn_' + productId);

                                                // Disable button and show loading
                                                addButton.disabled = true;
                                                addButton.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Adding...';

                                                try {
                                                    console.log(JSON.stringify({
                                                        customerId: currentUserId,
                                                        productId: productId,
                                                        quantity: quantity
                                                    }));
                                                    const response = await fetch('/CES/CartApiServlet', {
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

                                                    const result = await response.json();

                                                    if (result.success) {
                                                        // Show success message
                                                        Swal.fire({
                                                            icon: 'success',
                                                            title: 'Success!',
                                                            text: productName + `has been added to your cart!`,
                                                            timer: 2000,
                                                            showConfirmButton: false
                                                        });

                                                        // Update cart count
                                                        updateCartCount();

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
                                                    const response = await fetch('CartApiServlet?userId=' + currentUserId);
                                                    const result = await response.json();

                                                    if (result.success && result.data) {
                                                        const totalItems = result.data.reduce((sum, item) => sum + item.quantity, 0);
                                                        document.getElementById('cartCount').textContent = totalItems;
                                                        cartCount = totalItems;
                                                    }
                                                } catch (error) {
                                                    console.error('Error updating cart count:', error);
                                                }
                                            }

                                            // Initialize cart count on page load
                                            document.addEventListener('DOMContentLoaded', function () {
                                                updateCartCount();

                                                // Add hover effects to product cards
                                                const productCards = document.querySelectorAll('.product-card');
                                                productCards.forEach(card => {
                                                    card.addEventListener('mouseenter', function () {
                                                        this.style.transform = 'translateY(-5px)';
                                                        this.style.transition = 'transform 0.3s ease';
                                                    });

                                                    card.addEventListener('mouseleave', function () {
                                                        this.style.transform = 'translateY(0)';
                                                    });
                                                });
                                            });

                                                // Function to view product feedback
                                                function viewFeedback(productId) {
                                                    // Empty function for now
                                                    console.log('View feedback for product:', productId);
                                                }

                                                // Add keyboard support for quantity inputs
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    const quantityInputs = document.querySelectorAll('[id^="quantity_"]');
                                                    quantityInputs.forEach(input => {
                                                        input.addEventListener('keypress', function (e) {
                                                            if (e.key === 'Enter') {
                                                                const productId = this.id.split('_')[1];
                                                                const productCard = this.closest('.product-card');
                                                                const productName = productCard.querySelector('.card-title').textContent;
                                                                const productPrice = parseFloat(productCard.querySelector('.price').textContent.replace(',', '')); // Sửa lỗi dấu ngoặc
                                                                addToCart(parseInt(productId), productName, productPrice);
                                                            }
                                                        });
                                                    input.addEventListener('change', function () {
                                                        let value = parseInt(this.value);
                                                        if (isNaN(value) || value < 1) {
                                                            value = 1;
                                                        }
                                                        if (value > 99) {
                                                            value = 99;
                                                        }
                                                        this.value = value;
                                                    });
                                                });
                                            });
        </script>

    </body>
</html>