<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    /* Add a black border at the bottom of the navbar */
    .navbar {
        border-bottom: 1px solid #000;
    }
    /* Fix tạm thời cho dropdown menu Bootstrap */
    .dropdown-menu.show { display: block !important; opacity: 1 !important; visibility: visible !important; }
</style>
<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Top Bar -->
<div class="top-bar">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <i class="fas fa-phone-alt me-2"></i> 24/7 Customer Service: 1-800-123-4567
            </div>
            <div class="col-md-6 text-end">
                <span class="me-3"><i class="fas fa-truck me-1"></i> Free shipping on orders over $100</span>
                <span><i class="fas fa-map-marker-alt me-1"></i> Track Order</span>
            </div>
        </div>
    </div>
</div>

<!-- Main Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet">
            <i class="fas fa-microchip me-2"></i>
            <span class="fw-bold">CES</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="menuDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-bars me-1"></i>Menu
                    </a>
                    <ul class="dropdown-menu p-0" aria-labelledby="menuDropdown" style="min-width: 270px;">
                        <c:forEach var="item" items="${menuItems}">
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}${item.url}">
                                    <span style="width: 24px; text-align: center; margin-right: 12px;">
                                        <c:if test="${not empty item.icon}">
                                            <i class="${item.icon}"></i>
                                        </c:if>
                                    </span>
                                    <span>${item.name}</span>
                                    <span class="ms-auto text-secondary"><i class="fa-solid fa-angle-right"></i></span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">New Arrivals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Today's Deals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Custom Builds</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/viewblogs">Blog</a>
                </li>
            </ul>
            <form class="d-flex me-3">
                <div class="input-group">
                    <input type="search" class="form-control" placeholder="Search products...">
                    <button class="btn btn-outline-primary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.userAuth or not empty sessionScope.customerAuth}">
                        <!-- User Dropdown -->
                        <div class="dropdown me-3">
                            <c:choose>
                                <c:when test="${fn:toLowerCase(sessionScope.user_role) eq 'admin'}">
                                    <a class="btn btn-outline-primary dropdown-toggle" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user me-1"></i>
                                        ${fn:trim(fn:replace(sessionScope.user_name, '(Admin)', ''))} (Admin)
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item text-primary" href="${pageContext.request.contextPath}/adminservlet">
                                                <i class="fas fa-gauge-high me-2"></i>Admin Dashboard
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/adminservlet">
                                                <i class="fas fa-user-circle me-2"></i>Profile
                                            </a>
                                        </li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orderHistory"><i class="fas fa-history me-2"></i>Order History</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                    </ul>
                                </c:when>
                                <c:when test="${fn:toLowerCase(sessionScope.user_role) eq 'staff'}">
                                    <a class="btn btn-outline-primary dropdown-toggle" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user me-1"></i>
                                        ${sessionScope.user_name} (Staff)
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item text-primary" href="${pageContext.request.contextPath}/staffservlet">
                                                <i class="fas fa-gauge-high me-2"></i>Staff Dashboard
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/staffservlet">
                                                <i class="fas fa-user-circle me-2"></i>Profile
                                            </a>
                                        </li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orderHistory"><i class="fas fa-history me-2"></i>Order History</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn btn-outline-primary dropdown-toggle" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user me-1"></i>
                                        ${sessionScope.user_name}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/userprofile?action=profile">
                                                <i class="fas fa-user-circle me-2"></i>Profile
                                            </a>
                                        </li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userprofile?action=orders"><i class="fas fa-history me-2"></i>Order History</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary me-2">
                            <i class="fas fa-user me-1"></i> Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary me-2">
                            <i class="fas fa-user-plus me-1"></i> Register
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="#" onclick="checkLoginBeforeCart(event)" class="btn btn-outline-primary position-relative">
                    <i class="fas fa-shopping-cart"></i>
                    <span id="cartCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        0
                    </span>
                </a>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- SweetAlert2 for notifications -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
// Global variable for current user ID
let headerCurrentUserId = 0;

// Get current user ID from session
<c:choose>
    <c:when test="${not empty sessionScope.customerAuth}">
        headerCurrentUserId = ${sessionScope.customerAuth.customer_id};
    </c:when>
    <c:when test="${not empty sessionScope.userAuth}">
        headerCurrentUserId = ${sessionScope.userAuth.id};
    </c:when>
    <c:otherwise>
        headerCurrentUserId = 0;
    </c:otherwise>
</c:choose>

// Function to check login before accessing cart
function checkLoginBeforeCart(event) {
    event.preventDefault(); // Prevent default link behavior
    
    if (headerCurrentUserId === 0) {
        // User not logged in - show warning
        Swal.fire({
            icon: 'warning',
            title: 'Please Login',
            text: 'You need to login to access your cart',
            showCancelButton: true,
            confirmButtonText: 'Login Now',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirect to login page
                window.location.href = '${pageContext.request.contextPath}/login.jsp';
            }
        });
    } else {
        // User is logged in - redirect to cart
        window.location.href = '${pageContext.request.contextPath}/view-cart.jsp';
    }
}

// Function to update cart count
async function updateHeaderCartCount() {
    try {
        if (headerCurrentUserId === 0) {
            // User not logged in - set count to 0
            const cartCountElement = document.getElementById('cartCount');
            if (cartCountElement) {
                cartCountElement.textContent = '0';
            }
            return;
        }
        
        const response = await fetch('${pageContext.request.contextPath}/CartApiServlet?customerId=' + headerCurrentUserId);
        const result = await response.json();

        if (result.success && result.data) {
            const totalItems = result.data.reduce((sum, item) => sum + item.quantity, 0);
            const cartCountElement = document.getElementById('cartCount');
            if (cartCountElement) {
                cartCountElement.textContent = totalItems;
            }
        }
    } catch (error) {
        console.error('Error updating cart count:', error);
        // Set count to 0 on error
        const cartCountElement = document.getElementById('cartCount');
        if (cartCountElement) {
            cartCountElement.textContent = '0';
        }
    }
}

// Đảm bảo dropdown menu hoạt động đúng
document.addEventListener('DOMContentLoaded', function() {
    console.log('[Header] DOM loaded, initializing dropdowns...');
    
    // Initialize all dropdowns
    var dropdowns = document.querySelectorAll('.dropdown-toggle');
    console.log('[Header] Found ' + dropdowns.length + ' dropdowns');
    
    dropdowns.forEach(function(dropdown, index) {
        console.log('[Header] Initializing dropdown ' + index + ':', dropdown);
        try {
            new bootstrap.Dropdown(dropdown);
            console.log('[Header] Dropdown ' + index + ' initialized successfully');
        } catch (error) {
            console.error('[Header] Error initializing dropdown ' + index + ':', error);
        }
    });
    
    // Debug menu items
    console.log('[Header] Menu items count:', ${fn:length(menuItems)});
    console.log('[Header] Menu items:', ${menuItems});
    
    // Update cart count on page load
    updateHeaderCartCount();
});
</script> 