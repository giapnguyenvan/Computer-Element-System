<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Chakra Petch Font -->
        <link href="https://fonts.googleapis.com/css2?family=Chakra+Petch:wght@400;500;600&display=swap" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="css/ramCategory.css" rel="stylesheet">
        <style>
            .product-price {
                font-family: "Chakra Petch", sans-serif !important;
                font-size: 20px !important;
                color: #FB4E4E !important;
            }
            .page-link {
                cursor: pointer;
            }
        </style>
        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <%
            ProductDAO productDAO = new ProductDAO();


            int productsPerPage = 4;
            int componentTypeId = 3; // RAM


            int currentPage = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }


            int totalProducts = productDAO.getTotalProductsByComponentType(componentTypeId);
            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);


            List<Products> ramProducts = productDAO.getProductsWithPagingByComponentType(componentTypeId, currentPage, productsPerPage);


            request.setAttribute("ramProducts", ramProducts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
        %>


        <div class="container">
            <div class="ram-section">
                <div class="ram-header">
                    <h2 class="ram-title">RAM Products</h2>
                </div>


                <div class="products-grid" id="ramProductsContainer">
                    <c:forEach var="product" items="${ramProducts}">
                        <div class="product-card">
                            <a href="${pageContext.request.contextPath}/productservlet?service=productDetail&id=${product.productId}" style="text-decoration: none; color: inherit;">
                                <img src="${product.imageUrl}" class="product-image" alt="${product.name}">
                                <h5 class="product-title">${product.name}</h5>
                                <p class="product-description">${product.description}</p>
                            </a>
                            <div class="product-price">
                                <fmt:formatNumber value="${product.price}" type="number" pattern="###,###"/> VNĐ
                            </div>


                            <!-- Add to Cart Button -->
                            <button class="btn btn-primary add-to-cart-btn"
                                    onclick="addToCart('${product.productId}', '${product.name}', '${product.price}')"
                                    id="addBtn_${product.productId}">
                                <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                            </button>
                        </div>
                    </c:forEach>
                </div>


                <!-- Pagination -->
                <div class="pagination-container">
                    <ul class="pagination" id="ramPaginationContainer">
                        <!-- Previous button -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" onclick="loadRAMPage(${currentPage - 1})" tabindex="-1">Previous</a>
                        </li>


                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                <a class="page-link" onclick="loadRAMPage(${pageNumber})">${pageNumber}</a>
                            </li>
                        </c:forEach>


                        <!-- Next button -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" onclick="loadRAMPage(${currentPage + 1})">Next</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


        <!-- Custom JavaScript -->
        <script>
            // Global variables
            let currentUserId = 0;
           
            // Get current user ID from session
            <c:choose>
                <c:when test="${not empty sessionScope.customerAuth}">
                    currentUserId = ${sessionScope.customerAuth.customer_id};
                </c:when>
                <c:when test="${not empty sessionScope.userAuth}">
                    currentUserId = ${sessionScope.userAuth.id};
                </c:when>
                <c:otherwise>
                    currentUserId = 0;
                </c:otherwise>
            </c:choose>


                                // Function to load page content using AJAX
                                function loadRAMPage(pageNumber) {
                                    // Prevent loading if it's a disabled button or current page
                                    const currentPage = parseInt(document.querySelector('#ramPaginationContainer .page-item.active .page-link').textContent);
                                    if (pageNumber === currentPage ||
                                            document.querySelector('#ramPaginationContainer .page-item.disabled .page-link[onclick*="loadRAMPage(' + pageNumber + ')"]')) {
                                        return;
                                    }


                                    // Show loading indicator
                                    const productsContainer = document.getElementById('ramProductsContainer');
                                    productsContainer.style.opacity = '0.5';


                                    fetch('${pageContext.request.contextPath}/RAMCategoryServlet?page=' + pageNumber, {
                                        method: 'GET',
                                        headers: {
                                            'X-Requested-With': 'XMLHttpRequest'
                                        }
                                    })
                                            .then(response => {
                                                if (!response.ok) {
                                                    throw new Error('Network response was not ok');
                                                }
                                                return response.text();
                                            })
                                            .then(html => {
                                                // Create a temporary container
                                                const temp = document.createElement('div');
                                                temp.innerHTML = html;


                                                // Update products
                                                const newProducts = temp.querySelector('#ramProductsContainer');
                                                if (newProducts) {
                                                    productsContainer.innerHTML = newProducts.innerHTML;
                                                }


                                                // Update pagination
                                                const newPagination = temp.querySelector('#ramPaginationContainer');
                                                if (newPagination) {
                                                    document.getElementById('ramPaginationContainer').innerHTML = newPagination.innerHTML;
                                                }


                                                // Update active states
                                                document.querySelectorAll('#ramPaginationContainer .page-item').forEach(item => {
                                                    item.classList.remove('active');
                                                });
                                                const activePageLink = document.querySelector('#ramPaginationContainer .page-link[onclick*="loadRAMPage(' + pageNumber + ')"]');
                                                if (activePageLink) {
                                                    activePageLink.parentElement.classList.add('active');
                                                }


                                                // Restore opacity
                                                productsContainer.style.opacity = '1';


                                                // Reinitialize event handlers if needed
                                                initializeRAMEventHandlers();
                                            })
                                            .catch(error => {
                                                console.error('Error loading page:', error);
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'Failed to load page. Please try again.'
                                                });
                                                // Restore opacity
                                                productsContainer.style.opacity = '1';
                                            });
                                }


                                // Function to initialize event handlers
                                function initializeRAMEventHandlers() {
                                    // Add any event handlers that need to be reinitialized after content update
                                    document.querySelectorAll('#ramProductsContainer .add-to-cart-btn').forEach(button => {
                                        const productId = button.id.replace('addBtn_', '');
                                        const productName = button.closest('.product-card').querySelector('.product-title').textContent;
                                        const productPrice = button.closest('.product-card').querySelector('.product-price').textContent;


                                        button.onclick = () => addToCart(productId, productName, productPrice);
                                    });
                                }


                                // Initialize event handlers on page load
                                document.addEventListener('DOMContentLoaded', initializeRAMEventHandlers);






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


                                    const addButton = document.getElementById('addBtn_' + productId);


                                    // Disable button and show loading
                                    addButton.disabled = true;
                                    addButton.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Adding...';


                                    try {
                                        const response = await fetch('${pageContext.request.contextPath}/CartApiServlet', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/json'
                                            },
                                            body: JSON.stringify({
                                                customerId: currentUserId,
                                                productId: productId,
                                                quantity: 1
                                            })
                                        });


                                        const result = await response.json();


                                        if (result.success) {
                                            // Show success message
                                            Swal.fire({
                                                icon: 'success',
                                                title: 'Success!',
                                                text: productName + ' has been added to your cart!',
                                                timer: 2000,
                                                showConfirmButton: false
                                            });


                                            // Add visual feedback
                                            addButton.classList.add('btn-success');
                                            addButton.innerHTML = '<i class="fas fa-check me-2"></i>Added!';


                                            // Update header cart count if function exists
                                            if (typeof updateHeaderCartCount === 'function') {
                                                updateHeaderCartCount();
                                            }
                                           
                                            setTimeout(() => {
                                                addButton.classList.remove('btn-success');
                                                addButton.innerHTML = '<i class="fas fa-shopping-cart me-2"></i>Add to Cart';
                                                addButton.disabled = false;
                                            }, 2000);
                                        } else {
                                            throw new Error(result.message || 'Unknown error');
                                        }
                                    } catch (error) {
                                        console.error('Error adding to cart:', error);
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Error',
                                            text: 'Failed to add product to cart. Please try again.'
                                        });
                                        // Re-enable button on error
                                        addButton.disabled = false;
                                        addButton.innerHTML = '<i class="fas fa-shopping-cart me-2"></i>Add to Cart';
                                    }
                                }
        </script>
    </body>
</html>