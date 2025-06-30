<%-- 
    Document   : view-cart
    Created on : Jun 25, 2025, 6:34:07 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart - ShopXinh</title>
        <!-- Thêm Bootstrap CSS -->
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">-->
        <!-- Thêm Font Awesome -->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">-->
        
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                /*margin: 0;*/
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                color: #333;
            }

            .container {
                /*max-width: 1200px;*/
                /*margin: 0 auto;*/
                /*padding: 20px;*/
            }

            .header {
                text-align: center;
                margin-bottom: 40px;
            }

            .header h1 {
                color: white;
                font-size: 3rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                margin-bottom: 10px;
            }

            .header p {
                color: rgba(255,255,255,0.9);
                font-size: 1.2rem;
            }

            .cart-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
                backdrop-filter: blur(10px);
            }

            .cart-header {
                background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .cart-header h2 {
                font-size: 2rem;
                margin-bottom: 10px;
            }

            .cart-items {
                padding: 30px;
            }

            .cart-item {
                display: flex;
                align-items: center;
                padding: 25px;
                border: 2px solid #f8f9fa;
                border-radius: 15px;
                margin-bottom: 20px;
                transition: all 0.3s ease;
                background: linear-gradient(145deg, #ffffff, #f8f9fa);
            }

            .cart-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
                border-color: #667eea;
            }

            .item-image {
                width: 100px;
                height: 100px;
                border-radius: 15px;
                margin-right: 20px;
                object-fit: cover;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .item-details {
                flex: 1;
            }

            .item-name {
                font-size: 1.3rem;
                font-weight: bold;
                color: #2d3436;
                margin-bottom: 8px;
            }

            .item-description {
                color: #636e72;
                margin-bottom: 15px;
                line-height: 1.5;
            }

            .item-price {
                font-size: 1.5rem;
                font-weight: bold;
                color: #e17055;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                margin: 0 20px;
            }

            .quantity-btn1 {
                width: 40px;
                height: 40px;
                border: none;
                border-radius: 50%;
                background: linear-gradient(45deg, #667eea, #764ba2);
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .quantity-btn1:hover {
                transform: scale(1.1);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            }

            .quantity-btn1:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .quantity-input {
                width: 60px;
                height: 40px;
                text-align: center;
                border: 2px solid #ddd;
                border-radius: 10px;
                margin: 0 10px;
                font-size: 1.1rem;
                font-weight: bold;
            }

            .remove-btn1 {
                background: linear-gradient(45deg, #ff7675, #d63031);
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 25px;
                cursor: pointer;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .remove-btn1:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 15px rgba(214, 48, 49, 0.4);
            }

            .remove-btn1:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .cart-summary {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                padding: 30px;
                border-top: 3px solid #667eea;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
                font-size: 1.1rem;
            }

            .summary-row.total {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2d3436;
                border-top: 2px solid #ddd;
                padding-top: 15px;
                margin-top: 20px;
            }

            .checkout-section {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn1 {
                flex: 1;
                padding: 18px 30px;
                border: none;
                border-radius: 25px;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .btn1-continue {
                background: linear-gradient(45deg, #74b9ff, #0984e3);
                color: white;
            }

            .btn1-checkout {
                background: linear-gradient(45deg, #00b894, #00a085);
                color: white;
            }

            .btn1:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .btn1:disabled {
                opacity: 0.5;
                cursor: not-allowed;
                transform: none;
            }

            .empty-cart {
                text-align: center;
                padding: 60px 30px;
                color: #636e72;
            }

            .empty-cart i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: #ddd;
            }

            .empty-cart h3 {
                font-size: 1.5rem;
                margin-bottom: 15px;
            }

            .loading {
                text-align: center;
                padding: 60px 30px;
                color: #636e72;
            }

            .loading-spinner {
                width: 50px;
                height: 50px;
                border: 5px solid #f3f3f3;
                border-top: 5px solid #667eea;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin: 0 auto 20px;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .error-message {
                background: #ff7675;
                color: white;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                text-align: center;
            }

            .success-message {
                background: #00b894;
                color: white;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                text-align: center;
            }

            @media (max-width: 768px) {
                .cart-item {
                    flex-direction: column;
                    text-align: center;
                }

                .item-image {
                    margin-right: 0;
                    margin-bottom: 15px;
                }

                .quantity-controls {
                    margin: 15px 0;
                }

                .checkout-section {
                    flex-direction: column;
                }

                .header h1 {
                    font-size: 2rem;
                }
            }
        </style>
        
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>
        <br>
        <br>
        <div class="container">

            <div class="cart-container">
                <div class="cart-header">
                    <h2>Order Details</h2>
                    <p id="cart-count">Loading...</p>
                </div>

                <div id="message-container"></div>

                <div id="loading-container" class="loading">
                    <div class="loading-spinner"></div>
                    <p>Loading cart...</p>
                </div>

                <div id="cart-items-container" class="cart-items" style="display: none;">
                    <!-- Cart items will be loaded here -->
                </div>

                <div id="empty-cart" class="empty-cart" style="display: none;">
                    <div style="font-size: 4rem; margin-bottom: 20px; color: #ddd;">🛒</div>
                    <h3>Your cart is empty</h3>
                    <p>Add some products to your cart to continue shopping</p>
                    <button class="btn1 btn1-continue" style="margin-top: 20px;" onclick="window.location.href = '/CES/homepageservlet'">
                        🛍️ Continue Shopping
                    </button>
                </div>

                <div id="cart-summary" class="cart-summary" style="display: none;">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span id="subtotal">0₫</span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span id="shipping">Free</span>
                    </div>
                    <div class="summary-row total">
                        <span>Total:</span>
                        <span id="total">0₫</span>
                    </div>

                    <div class="checkout-section">
                        <button class="btn1 btn1-continue" onclick="window.location.href = '/CES/homepageservlet'">
                            🛍️ Continue Shopping
                        </button>
                        <button class="btn1 btn1-checkout" onclick="proceedToCheckout()">
                            💳 Checkout Now
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <jsp:include page="footer.jsp"/>

        <script>
            // Configuration
            const API_BASE_URL = '/CES/CartApiServlet';
            const userId = 1; // This should be dynamically set from session

            // Global variables
            let cartItems = [];
            let isLoading = false;

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                loadCartItems();
            });

            // API Functions
            async function apiCall(url, method = 'GET', data = null) {
                const options = {
                    method: method,
                    headers: {
                        'Content-Type': 'application/json',
                    }
                };

                if (data) {
                    options.body = JSON.stringify(data);
                }

                try {
                    const response = await fetch(url, options);
                    const result = await response.json();

                    if (!response.ok) {
                        throw new Error(result.message || 'API call failed');
                    }

                    return result;
                } catch (error) {
                    console.error('API Error:', error);
                    throw error;
            }
            }

            // Load cart items from server
            async function loadCartItems() {
                try {
                    setLoading(true);
                    const response = await apiCall(API_BASE_URL + '?userId=' + userId);
                    cartItems = response.data || [];
                    renderCartItems();
                } catch (error) {
                    showMessage('Error loading cart: ' + error.message, 'error');
                } finally {
                    setLoading(false);
                }
            }

            // Update item quantity
            async function updateQuantity(itemId, newQuantity) {
                if (newQuantity < 1) {
                    removeItem(itemId);
                    return;
                }

                try {
                    disableButtons(true);
                    await apiCall(API_BASE_URL, 'PUT', {
                        id: itemId,
                        quantity: newQuantity
                    });

                    // Update local data
                    const item = cartItems.find(item => item.id === itemId);
                    if (item) {
                        item.quantity = newQuantity;
                    }

                    renderCartItems();
                    showMessage('Quantity updated!', 'success', 2000);
                } catch (error) {
                    showMessage('Error updating: ' + error.message, 'error');
                    loadCartItems(); // Reload to get correct data
                } finally {
                    disableButtons(false);
                }
            }

            // Remove item from cart
            async function removeItem(itemId) {
                if (!confirm('Are you sure you want to remove this item from cart?')) {
                    return;
                }

                try {
                    disableButtons(true);
                    await apiCall(API_BASE_URL + '?id=' + itemId, 'DELETE');

                    // Remove from local data
                    cartItems = cartItems.filter(item => item.id !== itemId);

                    renderCartItems();
                    showMessage('Item removed from cart!', 'success', 2000);
                } catch (error) {
                    showMessage('Error removing item: ' + error.message, 'error');
                } finally {
                    disableButtons(false);
                }
            }

            // Add item to cart (for future use)
            async function addToCart(productId, quantity = 1) {
                try {
                    await apiCall(API_BASE_URL + '/add', 'POST', {
                        userId: userId,
                        productId: productId,
                        quantity: quantity
                    });

                    loadCartItems();
                    showMessage('Product added to cart!', 'success', 2000);
                } catch (error) {
                    showMessage('Error adding product: ' + error.message, 'error');
            }
            }

            // Render cart items
            function renderCartItems() {
                const container = document.getElementById('cart-items-container');
                const emptyCart = document.getElementById('empty-cart');
                const summary = document.getElementById('cart-summary');
                const countElement = document.getElementById('cart-count');

                if (cartItems.length === 0) {
                    container.style.display = 'none';
                    summary.style.display = 'none';
                    emptyCart.style.display = 'block';
                    countElement.textContent = 'Cart is empty';
                    return;
                }

                container.style.display = 'block';
                summary.style.display = 'block';
                emptyCart.style.display = 'none';
                countElement.textContent = cartItems.length + ' items in cart';

                container.innerHTML = cartItems.map(item =>
                    '<div class="cart-item" data-item-id="' + item.id + '">' +
                            '<img src="' + (item.product.imageUrl || '/api/placeholder/100/100') + '" ' +
                            'alt="' + item.product.name + '" class="item-image">' +
                            '<div class="item-details">' +
                            '<div class="item-name">' + item.product.name + '</div>' +
                            '<div class="item-description">' + (item.product.description || 'High quality product') + '</div>' +
                            '<div class="item-price">' + formatPrice(item.product.price) + '₫</div>' +
                            '</div>' +
                            '<div class="quantity-controls">' +
                            '<button class="quantity-btn1" onclick="updateQuantityUI(' + item.id + ', ' + (item.quantity - 1) + ')">-</button>' +
                            '<input type="number" value="' + item.quantity + '" class="quantity-input" ' +
                            'onchange="updateQuantityUI(' + item.id + ', this.value)" min="1" max="99">' +
                            '<button class="quantity-btn1" onclick="updateQuantityUI(' + item.id + ', ' + (item.quantity + 1) + ')">+</button>' +
                            '</div>' +
                            '<button class="remove-btn1" onclick="removeItem(' + item.id + ')">🗑️ Remove</button>' +
                            '</div>'
                ).join('');

                updateSummary();
            }

            // Update quantity from UI
            function updateQuantityUI(itemId, newQuantity) {
                const quantity = parseInt(newQuantity);
                if (isNaN(quantity) || quantity < 0)
                    return;

                updateQuantity(itemId, quantity);
            }

            // Update summary
            function updateSummary() {
                const subtotal = cartItems.reduce((sum, item) => {
                    return sum + (parseFloat(item.product.price) * item.quantity);
                }, 0);

                document.getElementById('subtotal').textContent = formatPrice(subtotal) + '₫';
                document.getElementById('total').textContent = formatPrice(subtotal) + '₫';
            }

            // Utility functions
            function formatPrice(price) {
                return new Intl.NumberFormat('vi-VN').format(price);
            }

            function setLoading(loading) {
                isLoading = loading;
                const loadingContainer = document.getElementById('loading-container');
                const itemsContainer = document.getElementById('cart-items-container');

                if (loading) {
                    loadingContainer.style.display = 'block';
                    itemsContainer.style.display = 'none';
                } else {
                    loadingContainer.style.display = 'none';
                }
            }

            function disableButtons(disable) {
                const buttons = document.querySelectorAll('.quantity-btn1, .remove-btn1, .btn1');
                buttons.forEach(btn1 => btn1.disabled = disable);
            }

            function showMessage(message, type = 'info', timeout = 5000) {
                const container = document.getElementById('message-container');
                const messageDiv = document.createElement('div');
                messageDiv.className = type === 'error' ? 'error-message' : 'success-message';
                messageDiv.textContent = message;

                container.innerHTML = '';
                container.appendChild(messageDiv);

                if (timeout > 0) {
                    setTimeout(() => {
                        messageDiv.remove();
                    }, timeout);
            }
            }

            // Checkout function
            function proceedToCheckout() {
                if (cartItems.length === 0) {
                    showMessage('Cart is empty, cannot proceed to checkout!', 'error');
                    return;
                }

                // Redirect to checkout page
                window.location.href = '/CES/checkout';
            }

            // Handle page refresh
            window.addEventListener('beforeunload', function () {
                if (isLoading) {
                    return 'There are operations in progress, are you sure you want to leave this page?';
                }
            });
        </script>
    </body>
</html>
