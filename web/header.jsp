<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>

<%
    // Giả định menuItems đã được set trong request attribute bởi Servlet
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    if (menuItems == null) {
        // Fallback: Nếu menuItems không có trong request, thử lấy từ DAO (chỉ trong trường hợp debug hoặc truy cập trực tiếp JSP)
        // Thực tế, dữ liệu này nên được chuẩn bị bởi Servlet chính gọi header.jsp
        menuItems = dal.MenuItemDAO.getAllMenuItemsWithAttributesAndValues();
    }
    Gson gson = new Gson();
    String menuDataJson = gson.toJson(menuItems).replace("\"", "&quot;").replace("'", "&#39;");
%>

<style>
    /* Add a black border at the bottom of the navbar */
    .navbar {
        border-bottom: 1px solid #000;
    }
    /* Fix tạm thời cho dropdown menu Bootstrap */
    /* REMOVED: .dropdown-menu.show { display: block !important; opacity: 1 !important; visibility: visible !important; } */
    
    /* Menu List Styles - Reverted to work with Bootstrap dropdown */
    /* REMOVED: .dropdown-menu { overflow: visible; } */

    .menu-container {
        position: absolute;
        left: 0; /* Adjust as needed */
        top: 100%; /* Position below the parent */
        padding-top: 10px; /* Space between toggle and menu */
        z-index: 1050; /* Ensure it's above other content */
        display: none; /* Hidden by default, controlled by JS */
        overflow: visible; /* Crucial for mega-menu to extend outside */
    }
    .menu-container.show-menu {
        display: block !important; /* Explicitly show when JS adds this class */
    }

    .menu-list {
        width: 270px; /* Adjusted to match min-width from previous step */
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 8px 0;
        margin: 0;
        list-style: none;
        /* These display and overflow rules are now handled by .menu-container */
        /* REMOVED: display: none; */
        /* REMOVED: overflow: visible; */
    }
    /* REMOVED: .menu-list.show-menu { display: block !important; } */

    .menu-list li {
        position: relative;
        display: flex;
        align-items: center;
        padding: 10px 18px;
        font-size: 16px;
        color: #222;
        cursor: pointer;
        border-radius: 6px;
        transition: background 0.2s;
    }
    .menu-list li:hover {
        background: #f5f5f5;
    }
    /* Ensure the direct child a takes full width within the li */
    .menu-list li > a {
        flex: 1;
        display: flex;
        align-items: center;
        color: inherit;
        text-decoration: none;
    }

    .menu-list .menu-icon {
        width: 24px;
        text-align: center;
        margin-right: 12px;
        font-size: 18px;
    }
    .menu-list .arrow-icon {
        margin-left: auto;
        color: #bbb;
        font-size: 14px;
    }

    /* Specific styles for menu-item-level-1 to ensure correct display and spacing */
    .menu-item-level-1 {
        /* The padding is already on .menu-list li, so no need to duplicate */
    }

    /* Specific styles for menu-item-level-2 to ensure correct display and spacing */
    .menu-item-level-2 {
        /* The padding is already on .menu-list li, so no need to duplicate */
    }

    /* Mega Menu Styles (Copied from menuItem.jsp) */
    .mega-menu {
        display: none; /* Hidden by default */
        position: absolute;
        left: 100%; /* Position to the right of the parent li */
        top: 0;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 15px;
        min-width: 600px; /* Adjust as needed */
        z-index: 1000;
    }

    .mega-menu.show-menu {
        display: flex !important; /* Use flex for the mega menu content */
    }

    .mega-menu-content {
        display: flex; /* Use flexbox for columns */
        flex-wrap: wrap;
        gap: 20px; /* Space between columns */
    }
    
    .mega-menu-column {
        flex: 1;
        min-width: 180px;
        padding-right: 15px;
        flex-grow: 1; /* Added for better column distribution */
        flex-shrink: 0; /* Prevent shrinking below min-width */
    }

    .mega-menu-column h5 {
        font-size: 16px;
        font-weight: bold;
        color: #d9534f; /* Red color for headers */
        margin-bottom: 10px;
        border-bottom: 1px solid #eee;
        padding-bottom: 5px;
    }

    .mega-menu-column ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .mega-menu-column ul li a {
        display: block;
        padding: 5px 0;
        color: #333;
        text-decoration: none;
        transition: color 0.2s;
    }

    .mega-menu-column ul li a:hover {
        color: #0d6efd;
    }

    /* Third level menu (MenuAttributeValue) */
    .third-level-menu {
        display: none; /* Hidden by default */
        position: absolute;
        left: 100%; /* Position to the right of the parent li */
        top: 0;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 15px;
        min-width: 200px; /* Adjust as needed */
        z-index: 1001;
    }

    .third-level-menu.show-menu {
        display: block !important; /* Force display */
    }

    .menu-item-level-1 .dropdown-item {
        /* padding-right: 35px; */ /* Removed as we are controlling overall padding for li now */
    }

    /* The .arrow-icon on the top level menu item should use margin-left: auto */
    .nav-item.dropdown > .arrow-icon {
        margin-left: auto; 
        position: static; /* Override absolute positioning for top-level arrow */
    }

    /* Menu Container & List Styles (Copied/Adjusted from menuItem.jsp) */
    /* REMOVED DUPLICATE BLOCK */
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
                <li class="nav-item position-relative">
                    <a class="nav-link" href="#" id="menuDropdown">
                        <i class="fas fa-bars me-1"></i>Menu
                    </a>
                    <div class="menu-container">
                        <ul class="menu-list p-0" style="min-width: 270px;" aria-labelledby="menuDropdown">
                            <c:forEach var="item" items="${menuItems}">
                                <li class="position-relative d-flex align-items-center menu-item-level-1">
                                    <a class="d-flex align-items-center w-100" href="${pageContext.request.contextPath}${item.url}">
                                        <span style="width: 24px; text-align: center; margin-right: 12px;">
                                            <c:if test="${not empty item.icon}">
                                                <i class="${item.icon}"></i>
                                            </c:if>
                                        </span>
                                        <span>${item.name}</span>
                                    </a>
                                    <c:if test="${not empty item.menuAttributes}">
                                        <span class="ms-auto text-secondary arrow-icon"><i class="fa-solid fa-angle-right"></i></span>
                                        <div class="mega-menu">
                                            <div class="mega-menu-content">
                                                <c:forEach var="attribute" items="${item.menuAttributes}">
                                                    <div class="mega-menu-column">
                                                        <h5>${attribute.name}</h5>
                                                        <ul>
                                                            <li class="position-relative menu-item-level-2">
                                                                <a href="${pageContext.request.contextPath}${attribute.url}">${attribute.name}</a>
                                                                <c:if test="${not empty attribute.menuAttributeValues}">
                                                                    <span class="ms-auto text-secondary arrow-icon"><i class="fa-solid fa-angle-right"></i></span>
                                                                    <div class="third-level-menu">
                                                                        <ul>
                                                                            <c:forEach var="value" items="${attribute.menuAttributeValues}">
                                                                                <li><a href="${pageContext.request.contextPath}${value.url}">${value.value}</a></li>
                                                                            </c:forEach>
                                                                        </ul>
                                                                    </div>
                                                                </c:if>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
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

<div id="menuDataJsonContainer" data-json="<%= menuDataJson %>" style="display:none;"></div>

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
    console.log('[Header] DOM loaded, initializing custom menu dropdown...');
    
    const menuDropdownToggle = document.getElementById('menuDropdown');
    // Correctly get the menu-container element
    const menuContainer = document.querySelector('.navbar-nav .menu-container'); 

    if (menuDropdownToggle && menuContainer) {
        // Handle showing the main menu on hover
        menuDropdownToggle.addEventListener('mouseenter', () => {
            menuContainer.classList.add('show-menu');
        });

        // Handle hiding the main menu when mouse leaves toggle or list
        menuDropdownToggle.addEventListener('mouseleave', (event) => {
            if (!menuContainer.contains(event.relatedTarget)) {
                menuContainer.classList.remove('show-menu');
            }
        });

        menuContainer.addEventListener('mouseleave', (event) => {
            if (!menuDropdownToggle.contains(event.relatedTarget)) {
                menuContainer.classList.remove('show-menu');
            }
        });

        // Keep main menu open if mouse enters the menu list from anywhere (e.g. from an item's arrow)
        menuContainer.addEventListener('mouseenter', () => {
            menuContainer.classList.add('show-menu');
        });
    }

    // No Bootstrap dropdown initialization for the main menu, as it's custom handled
    // But ensure other Bootstrap dropdowns (like user profile) still work
    var otherDropdowns = document.querySelectorAll('.dropdown-toggle:not(#menuDropdown)');
    otherDropdowns.forEach(function(dropdown, index) {
        try {
            new bootstrap.Dropdown(dropdown);
            console.log('[Header] Other Dropdown ' + index + ' initialized successfully');
        } catch (error) {
            console.error('[Header] Error initializing other dropdown ' + index + ':', error);
        }
    });
    
    // Debug menu items
    const menuData = JSON.parse(document.getElementById('menuDataJsonContainer').dataset.json);
    console.log('[Header] Menu items count:', menuData.length);
    console.log('[Header] Menu items:', menuData);
    
    // Add hover logic for main menu items (level 1) to show mega menu
    document.querySelectorAll('.menu-item-level-1').forEach(listItem => {
        const megaMenu = listItem.querySelector('.mega-menu');
        if (megaMenu) {
            listItem.addEventListener('mouseenter', () => {
                megaMenu.classList.add('show-menu');
            });
            listItem.addEventListener('mouseleave', (event) => {
                if (!megaMenu.contains(event.relatedTarget)) {
                    megaMenu.classList.remove('show-menu');
                }
            });
        }
    });

    // Add hover logic for second level attributes (level 2) to show third level values
    document.querySelectorAll('.menu-item-level-2').forEach(li => {
        const thirdLevelMenu = li.querySelector('.third-level-menu');
        if (thirdLevelMenu) {
            li.addEventListener('mouseenter', (event) => {
                event.stopPropagation(); // Stop propagation to prevent parent menu from hiding
                thirdLevelMenu.classList.add('show-menu');
            });
            li.addEventListener('mouseleave', (event) => {
                event.stopPropagation(); // Stop propagation
                thirdLevelMenu.classList.remove('show-menu');
            });
        }
    });

    // Update cart count on page load
    updateHeaderCartCount();
});
</script> 