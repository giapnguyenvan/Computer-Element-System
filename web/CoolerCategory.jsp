<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>

<%
    ProductDAO productDAO = new ProductDAO();
    int productsPerPage = 4;
    int componentTypeId = 8; // Cooler
    int currentPage = 1;
    String pageStr = request.getParameter("page");
    if (pageStr != null && !pageStr.isEmpty()) {
        currentPage = Integer.parseInt(pageStr);
    }
    int totalProducts = productDAO.getTotalProductsByComponentType(componentTypeId);
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
    List<Products> coolerProducts = productDAO.getProductsWithPagingByComponentType(componentTypeId, currentPage, productsPerPage);
    request.setAttribute("coolerProducts", coolerProducts);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
%>
<div class="container">
    <div class="cpu-section">
        <div class="cpu-header">
            <h2 class="cpu-title">Cooler Products</h2>
        </div>
        <div class="products-grid" id="coolerProductsContainer">
            <c:forEach var="product" items="${coolerProducts}">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/productservlet?service=productDetail&id=${product.productId}" style="text-decoration: none; color: inherit; display: block;">
                        <img src="${product.imageUrl}" class="product-image" alt="${product.name}">
                        <h5 class="product-title">${product.name}</h5>
                        <p class="product-description">${product.description}</p>
                    </a>
                    <div class="product-price">
                        <fmt:formatNumber value="${product.price}" type="number" pattern="###,###"/> VNĐ
                    </div>
                    <button class="btn btn-primary add-to-cart-btn"
                            onclick="addToCart('${product.productId}', '${product.name}', '${product.price}')"
                            id="addBtn_${product.productId}">
                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                    </button>
                </div>
            </c:forEach>
        </div>
        <div class="pagination-container">
            <ul class="pagination" id="coolerPaginationContainer">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" onclick="loadCoolerPage(${currentPage - 1})" tabindex="-1">Previous</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a class="page-link" onclick="loadCoolerPage(${pageNumber})">${pageNumber}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" onclick="loadCoolerPage(${currentPage + 1})">Next</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
function loadCoolerPage(pageNumber) {
    const currentPage = parseInt(document.querySelector('#coolerPaginationContainer .page-item.active .page-link').textContent);
    if (pageNumber === currentPage ||
        document.querySelector('#coolerPaginationContainer .page-item.disabled .page-link[onclick*="loadCoolerPage(' + pageNumber + ')"]')) {
        return;
    }
    const productsContainer = document.getElementById('coolerProductsContainer');
    productsContainer.style.opacity = '0.5';
    fetch('${pageContext.request.contextPath}/CoolerCategoryServlet?page=' + pageNumber, {
        method: 'GET',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => response.text())
    .then(html => {
        const temp = document.createElement('div');
        temp.innerHTML = html;
        const newProducts = temp.querySelector('#coolerProductsContainer');
        if (newProducts) productsContainer.innerHTML = newProducts.innerHTML;
        const newPagination = temp.querySelector('#coolerPaginationContainer');
        if (newPagination) document.getElementById('coolerPaginationContainer').innerHTML = newPagination.innerHTML;
        productsContainer.style.opacity = '1';
    })
    .catch(() => { productsContainer.style.opacity = '1'; });
}
</script> 