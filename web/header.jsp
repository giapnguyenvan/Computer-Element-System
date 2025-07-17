<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>
<%@ page import="java.util.HashMap" %>

<%
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    if (menuItems == null) {
        menuItems = new java.util.ArrayList<>(); // Fallback
    }
    pageContext.setAttribute("renderedNames", new HashMap<String, Boolean>());
    Gson gson = new Gson();
    String menuDataJson = gson.toJson(menuItems);
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link href="css/header.css" rel="stylesheet">

<style>
    .menu-container {
        position: absolute;
        left: 0;
        top: 100%;
        padding-top: 10px;
        z-index: 1051;
        display: none;
        width: 100%;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
    }
    .menu-container.show-menu {
        display: block !important;
    }
    .menu-list {
        width: 270px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 8px 0;
        margin: 0;
        list-style: none;
    }
    .menu-list li {
        position: relative;
        display: flex;
        align-items: center;
        padding: 10px 18px;
        font-size: 16px;
        color: #000;
        cursor: pointer;
        text-decoration: none;
    }
    .menu-list li:hover {
        background: #f5f5f5;
        color: #000;
    }
    .menu-list li a {
        color: #000;
        text-decoration: none;
        flex: 1;
    }
    .menu-list li a:hover {
        color: #000;
        text-decoration: none;
    }
    .menu-list .menu-icon i {
        color: #000;
    }
    .mega-menu {
        display: none;
        position: absolute;
        left: 100%;
        top: 0;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 15px;
        min-width: 600px;
        z-index: 1000;
    }
    .mega-menu.show-menu {
        display: flex !important;
    }
    .mega-menu-content {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        padding: 10px 0;
    }
    .mega-menu-column {
        flex: 0 0 calc(33.33% - 13.33px);
        max-width: calc(33.33% - 13.33px);
        min-width: 120px;
        box-sizing: border-box;
        padding: 10px;
        background: #f9f9f9;
        border-radius: 5px;
    }
    .mega-menu-column h5 {
        margin: 0 0 10px 0;
        font-size: 16px;
        font-weight: bold;
        word-break: break-word;
    }
    .mega-menu-column.full-width {
        flex: 0 0 100%;
        max-width: 100%;
    }
    .mega-menu-column ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .mega-menu-column li {
        padding: 5px 0;
    }
    .mega-menu-column a {
        color: #000;
        text-decoration: none;
        word-break: break-word;
    }
    .mega-menu-column a:hover {
        color: #007bff;
        text-decoration: underline;
    }
    .third-level-menu {
        display: none;
        position: absolute;
        left: 100%;
        top: 0;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 10px;
        min-width: 200px;
        z-index: 1001;
    }
    .third-level-menu.show-menu {
        display: block !important;
    }
    @media (max-width: 768px) {
        .menu-container {
            width: 100%;
            padding-top: 0;
        }
        .mega-menu {
            min-width: 100%;
            position: static;
            box-shadow: none;
        }
        .mega-menu-content {
            flex-direction: column;
        }
        .mega-menu-column {
            flex: 0 0 100%;
            max-width: 100%;
        }
    }
</style>

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
                        Menu
                    </a>
                    <div class="menu-container">
                        <ul class="menu-list p-0" style="min-width: 270px;" aria-labelledby="menuDropdown">
                            <c:forEach var="item" items="${menuItems}">
                                <li class="position-relative d-flex align-items-center menu-item-level-1">
                                    <a class="d-flex align-items-center w-100" href="${pageContext.request.contextPath}${item.url}">
                                        <span style="width: 24px; text-align: center; margin-right: 12px;" class="menu-icon">
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
                                                    <c:if test="${empty pageScope.renderedNames[attribute.name]}">
                                                        <div class="mega-menu-column" data-content="${attribute.name}">
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
                                                        <c:set target="${renderedNames}" property="${attribute.name}" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </li>
                <li class="nav-item"><a class="nav-link" href="#">New Arrivals</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Today's Deals</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Custom Builds</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/viewblogs">Blog</a></li>
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
                <a href="#" onclick="checkLoginBeforeCart(event)" class="btn btn-outline-primary position-relative" id="cartButton">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // Function to check login before accessing cart
    function checkLoginBeforeCart(event) {
        event.preventDefault();
        
        // Check if user is logged in
        const isLoggedIn = ${not empty sessionScope.userAuth or not empty sessionScope.customerAuth};
        
        if (isLoggedIn) {
            // User is logged in, redirect to cart
            window.location.href = '${pageContext.request.contextPath}/view-cart';
        } else {
            // User is not logged in, show login prompt
            Swal.fire({
                title: 'Login Required',
                text: 'Please login to view your cart',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Go to Login',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }
            });
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        console.log('[Header] DOM loaded, initializing custom menu dropdown...');
        const menuDropdownToggle = document.getElementById('menuDropdown');
        const menuContainer = document.querySelector('.navbar-nav .menu-container');

        if (menuDropdownToggle && menuContainer) {
            menuDropdownToggle.addEventListener('mouseenter', () => {
                console.log('[Header] Mouse enter menuDropdownToggle');
                menuContainer.classList.add('show-menu');
            });
            menuDropdownToggle.addEventListener('mouseleave', () => {
                console.log('[Header] Mouse leave menuDropdownToggle');
                menuContainer.classList.remove('show-menu');
            });
            menuContainer.addEventListener('mouseenter', () => {
                console.log('[Header] Mouse enter menuContainer');
                menuContainer.classList.add('show-menu');
            });
            menuContainer.addEventListener('mouseleave', () => {
                console.log('[Header] Mouse leave menuContainer');
                menuContainer.classList.remove('show-menu');
            });
        }

        document.querySelectorAll('.menu-item-level-1').forEach(listItem => {
            const megaMenu = listItem.querySelector('.mega-menu');
            if (megaMenu) {
                listItem.addEventListener('mouseenter', () => {
                    console.log('[Header] Mouse enter level 1:', listItem);
                    megaMenu.classList.add('show-menu');
                });
                listItem.addEventListener('mouseleave', () => {
                    console.log('[Header] Mouse leave level 1:', listItem);
                    megaMenu.classList.add('show-menu');
                });
                listItem.addEventListener('mouseleave', () => {
                    console.log('[Header] Mouse leave level 1:', listItem);
                    megaMenu.classList.remove('show-menu');
                });
                megaMenu.addEventListener('mouseenter', () => {
                    console.log('[Header] Mouse enter mega-menu');
                    megaMenu.classList.add('show-menu');
                });
                megaMenu.addEventListener('mouseleave', () => {
                    console.log('[Header] Mouse leave mega-menu');
                    megaMenu.classList.remove('show-menu');
                });
            }
        });

        document.querySelectorAll('.menu-item-level-2').forEach(li => {
            const thirdLevelMenu = li.querySelector('.third-level-menu');
            if (thirdLevelMenu) {
                li.addEventListener('mouseenter', (event) => {
                    console.log('[Header] Mouse enter level 2:', li);
                    event.stopPropagation();
                    thirdLevelMenu.classList.add('show-menu');
                });
                li.addEventListener('mouseleave', (event) => {
                    console.log('[Header] Mouse leave level 2:', li);
                    event.stopPropagation();
                    thirdLevelMenu.classList.remove('show-menu');
                });
                thirdLevelMenu.addEventListener('mouseenter', () => {
                    console.log('[Header] Mouse enter third-level-menu');
                    thirdLevelMenu.classList.add('show-menu');
                });
                thirdLevelMenu.addEventListener('mouseleave', () => {
                    console.log('[Header] Mouse leave third-level-menu');
                    thirdLevelMenu.classList.remove('show-menu');
                });
            }
        });

        const maxChars = 15;
        document.querySelectorAll('.mega-menu-column').forEach(column => {
            const content = column.getAttribute('data-content');
            if (content && content.length > maxChars) {
                column.classList.add('full-width');
            }
        });

        const menuData = JSON.parse(document.getElementById('menuDataJsonContainer').dataset.json);
        console.log('[Header] Menu items count:', menuData.length);
        console.log('[Header] Menu items:', menuData);
        
        // Update cart count on page load
        updateCartCountInHeader();
    });

    // Function to update cart count in header
    function updateCartCountInHeader() {
        const isLoggedIn = ${not empty sessionScope.userAuth or not empty sessionScope.customerAuth};
        
        if (isLoggedIn) {
            fetch('${pageContext.request.contextPath}/CartApiServlet')
                .then(response => response.json())
                .then(result => {
                    if (result.success && result.data) {
                        const totalItems = result.data.reduce((sum, item) => sum + item.quantity, 0);
                        const cartCountElement = document.getElementById('cartCount');
                        if (cartCountElement) {
                            cartCountElement.textContent = totalItems;
                        }
                    }
                })
                .catch(error => {
                    console.error('Error updating cart count:', error);
                });
        }
    }

    // Make updateCartCountInHeader available globally
    window.updateCartCountInHeader = updateCartCountInHeader;
</script>