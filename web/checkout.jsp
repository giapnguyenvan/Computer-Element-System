<%-- 
    Document   : checkout
    Created on : Jun 25, 2025, 6:37:27 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
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
                max-width: 1200px;
                /*margin: 0 auto;*/
                /*padding: 20px;*/
            }

            .checkout-header {
                text-align: center;
                margin-bottom: 20px;
            }

            .checkout-header h1 {
                color: #111;
                font-size: 2.2rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                margin-top: 24px;
                margin-bottom: 8px;
            }

            .checkout-header p {
                color: rgba(34,34,34,0.8);
                font-size: 1rem;
                margin-bottom: 0;
            }

            .checkout-content {
                display: grid;
                grid-template-columns: 1fr 400px;
                gap: 30px;
                align-items: flex-start;
            }

            .checkout-form {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                backdrop-filter: blur(10px);
                padding: 18px 16px 18px 16px;
            }

            .order-summary {
                background: white;
                border-radius: 14px;
                box-shadow: 0 10px 24px rgba(0,0,0,0.08);
                overflow: hidden;
                backdrop-filter: blur(10px);
                padding: 14px 12px 16px 12px;
                height: fit-content;
            }

            .order-summary h2 {
                font-size: 1.15rem;
                margin-bottom: 10px;
            }

            .form-group {
                margin-bottom: 14px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #2d3436;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 9px;
                border: 2px solid #e1e5e9;
                border-radius: 15px;
                font-size: 13px;
                transition: all 0.3s ease;
                background: linear-gradient(145deg, #ffffff, #f8f9fa);
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
            }

            .payment-options {
                display: flex;
                gap: 15px;
                margin-top: 10px;
                flex-wrap: wrap;
            }

            .payment-option {
                flex: 1;
                min-width: 200px;
            }

            .payment-option input[type="radio"] {
                display: none;
            }

            .payment-option label {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 12px 16px;
                border: 2px solid #e1e5e9;
                border-radius: 15px;
                background: linear-gradient(145deg, #ffffff, #f8f9fa);
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                text-align: center;
                color: #2d3436;
            }

            .payment-option label i {
                margin-right: 8px;
                font-size: 1.1rem;
            }

            .payment-option input[type="radio"]:checked + label {
                background: linear-gradient(145deg, #f0f4ff, #e8f2ff);
                border-color: #667eea;
                color: #667eea;
                font-weight: 600;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            }

            .payment-option label:hover {
                background: linear-gradient(145deg, #f8f9fa, #f0f4ff);
                border-color: #b3c5ff;
                transform: translateY(-1px);
                box-shadow: 0 3px 10px rgba(102, 126, 234, 0.2);
            }

            .payment-option input[type="radio"]:checked + label i {
                color: #667eea;
            }

            .payment-option:first-child label i {
                color: #28a745;
            }

            .payment-option:last-child label i {
                color: #007bff;
            }

            .payment-option input[type="radio"]:checked + label:first-child i,
            .payment-option input[type="radio"]:checked + label:last-child i {
                color: #667eea;
            }

            @media (max-width: 600px) {
                .payment-options {
                    flex-direction: column;
                }
                .payment-option {
                    min-width: auto;
                }
            }

            .cart-items {
                margin-bottom: 20px;
            }

            .cart-item {
                display: flex;
                align-items: center;
                padding: 12px 8px;
                border: 2px solid #f8f9fa;
                border-radius: 10px;
                margin-bottom: 10px;
                transition: all 0.3s ease;
                background: linear-gradient(145deg, #ffffff, #f8f9fa);
            }

            .cart-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
                border-color: #667eea;
            }

            .item-image {
                width: 50px;
                height: 50px;
                border-radius: 8px;
                margin-right: 10px;
                object-fit: cover;
                box-shadow: 0 2px 6px rgba(0,0,0,0.12);
            }

            .item-info {
                flex: 1;
            }

            .item-info h4 {
                font-size: 0.75rem;
                font-weight: bold;
                color: #2d3436;
                margin-bottom: 4px;
            }

            .item-info .quantity {
                color: #636e72;
                font-size: 0.7rem;
                margin-bottom: 4px;
            }

            .item-info .description {
                color: #636e72;
                margin-bottom: 6px;
                line-height: 1.3;
                font-size: 0.7rem;
            }

            .item-price {
                font-size: 0.85rem;
                font-weight: bold;
                color: #e17055;
            }

            .order-total {
                border-top: 2px solid #667eea;
                padding-top: 10px;
                margin-top: 10px;
            }

            .total-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 8px;
                font-size: 0.98rem;
            }

            .total-row.final {
                font-size: 1.15rem;
                font-weight: bold;
                color: #2d3436;
                border-top: 2px solid #ddd;
                padding-top: 10px;
                margin-top: 10px;
            }

            .checkout-btn {
                width: 100%;
                padding: 10px 0;
                background: linear-gradient(45deg, #00b894, #00a085);
                color: white;
                border: none;
                border-radius: 18px;
                font-size: 1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-top: 12px;
            }

            .checkout-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .checkout-btn:disabled {
                opacity: 0.5;
                cursor: not-allowed;
                transform: none;
            }

            .loading {
                display: none;
                text-align: center;
                padding: 20px;
                color: #636e72;
            }

            .loading.show {
                display: block;
            }

            .error-message {
                background: #f8d7da;
                color: #721c24;
                padding: 15px;
                border-radius: 15px;
                margin-bottom: 20px;
                display: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .success-message {
                background: #d4edda;
                color: #155724;
                padding: 15px;
                border-radius: 15px;
                margin-bottom: 20px;
                display: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
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

            @media (max-width: 900px) {
                .checkout-content {
                    grid-template-columns: 1fr;
                }
                .checkout-form {
                    max-height: none;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="checkout-header">
                <h1>Order Checkout</h1>
                <p>Please review your information and complete your order</p>
            </div>

            <div class="checkout-content">
                <div class="checkout-form">
                    <h2>Shipping Information</h2>

                    <div class="error-message" id="errorMessage"></div>
                    <div class="success-message" id="successMessage"></div>

                    <form id="checkoutForm">
                        <div class="form-group">
                            <label for="fullName">Full Name *</label>
                            <input type="text" id="fullName" name="fullName" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number *</label>
                            <input type="tel" id="phone" name="phone" required onchange="validatePhone()">
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" onchange="validateEmail()">
                        </div>

                        <div class="form-group">
                            <label for="address">Shipping Address *</label>
                            <textarea id="address" name="address" rows="3" required 
                                      placeholder="House number, street name, ward/commune, district, province/city"></textarea>
                        </div>

                        <div class="form-group">
                            <label>Payment Method *</label>
                            <div class="payment-options">
                                <div class="payment-option">
                                    <input type="radio" id="cod" name="paymentMethod" value="1" required>
                                    <label for="cod">
                                        <i class="fas fa-truck"></i>
                                        Cash on Delivery (COD)
                                    </label>
                                </div>
                                <div class="payment-option">
                                    <input type="radio" id="bankTransfer" name="paymentMethod" value="2" required>
                                    <label for="bankTransfer">
                                        <i class="fas fa-university"></i>
                                        Bank Transfer
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="notes">Order Notes</label>
                            <textarea id="notes" name="notes" rows="2" 
                                      placeholder="Additional notes about your order (optional)"></textarea>
                        </div>
                    </form>
                </div>

                <div class="order-summary">
                    <h2>Your Order</h2>

                    <div id="loading-container" class="loading">
                        <p>Loading cart...</p>
                    </div>

                    <div id="empty-cart" class="empty-cart" style="display: none;">
                        <i class="fas fa-shopping-cart"></i>
                        <p>Cart is empty</p>
                    </div>

                    <div id="cart-items-container" class="cart-items">
                        <!-- Cart items will be rendered here -->
                    </div>

                    <div id="cart-summary" class="order-total">
                        <div class="total-row">
                            <span>Subtotal:</span>
                            <span id="subtotal">0₫</span>
                        </div>
                        <div class="total-row">
                            <span>Shipping:</span>
                            <span>Free</span>
                        </div>
                        <div class="total-row final">
                            <span>Total:</span>
                            <span id="total">0₫</span>
                        </div>
                    </div>

                    <button type="button" onclick="processCheckout()" form="checkoutForm" class="checkout-btn" id="checkoutButton">
                        Checkout
                    </button>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <jsp:include page="footer.jsp"/>

        <script>
            // Configuration
            const API_BASE_URL = '${pageContext.request.contextPath}/CartApiServlet';
            const USER_INFO_API_URL = '${pageContext.request.contextPath}/UserInfoApiServlet';
            const userId = 1; // This should be dynamically set from session

            // Global variables
            let cartItems = [];
            let isLoading = false;

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                loadCartItems();
                loadUserInfo(); // Automatically fill user information
            });

            // API Functions
            async function apiCall(url, method = 'GET', data = null) {
                const options = {
                    method: method,
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    credentials: 'same-origin'
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
                    const response = await apiCall(API_BASE_URL);
                    cartItems = response.data || [];
                    renderCartItems();
                } catch (error) {
                    showMessage('Error loading cart: ' + error.message, 'error');
                } finally {
                    setLoading(false);
                }
            }

            // Render cart items
            function renderCartItems() {
                const container = document.getElementById('cart-items-container');
                const emptyCart = document.getElementById('empty-cart');
                const summary = document.getElementById('cart-summary');
                const loadingContainer = document.getElementById('loading-container');

                if (cartItems.length === 0) {
                    container.style.display = 'none';
                    summary.style.display = 'none';
                    emptyCart.style.display = 'block';
                    loadingContainer.style.display = 'none';
                    return;
                }

                container.style.display = 'block';
                summary.style.display = 'block';
                emptyCart.style.display = 'none';
                loadingContainer.style.display = 'none';

                let html = '';
                let total = 0;

                cartItems.forEach(item => {
                    const itemTotal = item.quantity * item.product.price;
                    total += itemTotal;

                    html += '<div class="cart-item" data-item-id="' + item.id + '">' +
                            '<img src="' + (item.product.productImages[0].imageUrl || '${pageContext.request.contextPath}/IMG/product/default.jpg') + '" ' +
                            'alt="' + item.product.name + '" ' +
                            'class="item-image">' +
                            '<div class="item-info">' +
                            '<h4>' + item.product.name + '</h4>' +
                            '<div class="quantity">Quantity: ' + item.quantity + '</div>' +
                            '<div class="description">' + (item.product.description || 'High quality product') + '</div>' +
                            '<div class="item-price">' + formatPrice(itemTotal) + '₫</div>' +
                            '</div>' +
                            '</div>';
                });

                container.innerHTML = html;
                updateSummary(total);
            }

            // Update summary
            function updateSummary(total) {
                document.getElementById('subtotal').textContent = formatPrice(total) + '₫';
                document.getElementById('total').textContent = formatPrice(total) + '₫';
            }

            // Utility functions
            function formatPrice(price) {
                return new Intl.NumberFormat('vi-VN').format(price);
            }

            function isValidVietnamesePhoneNumber(phoneNumber) {
                const regex = /^(\+84|0)(3|5|7|8|9)\d{8}$/;
                return regex.test(phoneNumber);
            }
            function isValidEmail(email) {
                const regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
                return regex.test(email);
            }
            function validatePhone() {
                const phone = document.getElementById("phone");
                if (!isValidVietnamesePhoneNumber(phone.value)) {
                    return false;
                }
                return true;
            }
            function validateEmail() {
                const email = document.getElementById("email");
                if (!isValidEmail(email.value)) {
                    return false;
                }
                return true;
            }
            // Process checkout
            async function processCheckout() {
                if (cartItems.length === 0) {
                    showError('Your cart is empty');
                    return;
                }
                if (!validatePhone()) {
                    showError('Invalid phone number!');
                    return;
                }
                if (!validateEmail()) {
                    showError('Invalid email!');
                    return;
                }
                // Validate form
                const form = document.getElementById('checkoutForm');
                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                try {
                    const checkoutBtn = document.getElementById('checkoutButton');
                    checkoutBtn.disabled = true;
                    checkoutBtn.textContent = 'Processing...';

                    // Prepare order data
                    const formData = new FormData(form);
                    let totalAmount = 0;
                    
                    // Calculate total amount correctly
                    cartItems.forEach(item => {
                        let price = 0;
                        if (item.product && item.product.price) {
                            if (typeof item.product.price === 'object' && item.product.price.value !== undefined) {
                                price = parseFloat(item.product.price.value) || 0;
                            } else {
                                price = parseFloat(item.product.price) || 0;
                            }
                        }
                        totalAmount += item.quantity * price;
                    });
                    
                    const orderData = {
                        totalAmount: totalAmount,
                        paymentMethodId: parseInt(formData.get('paymentMethod')),
                        shippingAddress: formData.get('address'),
                        status: 'pending',
                        orderDetails: cartItems.map(item => {
                            let price = 0;
                            if (item.product && item.product.price) {
                                if (typeof item.product.price === 'object' && item.product.price.value !== undefined) {
                                    price = parseFloat(item.product.price.value) || 0;
                                } else {
                                    price = parseFloat(item.product.price) || 0;
                                }
                            }
                            return {
                                productId: item.productId,
                                quantity: item.quantity || 0,
                                price: price
                            };
                        })
                    };

                    // Send order to API
                    const response = await fetch('${pageContext.request.contextPath}/OrderApiServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        credentials: 'same-origin',
                        body: JSON.stringify(orderData)
                    });

                    if (!response.ok) {
                        throw new Error('HTTP error! status: ' + response.status);
                    }

                    const result = await response.json();

                    if (result.success) {
                        if (orderData.paymentMethodId === 1) { // COD
                            showSuccess('Đặt hàng thành công! Cảm ơn bạn đã mua hàng.');
                            form.reset();
                            setTimeout(() => {
                                loadCartItems();
                                // Pass a flag to homepage to show order success
                                window.location = "${pageContext.request.contextPath}/homePage.jsp?orderSuccess=1";
                            }, 2000);
                        } else {
                            showSuccess('Order placed successfully! Please proceed to payment.');
                            form.reset();
                            setTimeout(() => {
                                loadCartItems();
                                window.location = "${pageContext.request.contextPath}/payment-servlet?orderId=" + result.orderId;
                            }, 2000);
                        }
                    } else {
                        showError('Order failed: ' + (result.message || 'Unknown error'));
                    }
                } catch (error) {
                    console.error('Checkout error:', error);
                    showError('An error occurred while placing order: ' + error.message);
                } finally {
                    const checkoutBtn = document.getElementById('checkoutButton');
                    checkoutBtn.disabled = false;
                    checkoutBtn.textContent = 'Checkout';
                }
            }

            // Show error message
            function showError(message) {
                const errorDiv = document.getElementById('errorMessage');
                errorDiv.textContent = message;
                errorDiv.style.display = 'block';

                // Hide success message
                document.getElementById('successMessage').style.display = 'none';

                // Scroll to top to show error
                window.scrollTo(0, 0);

                // Auto hide after 5 seconds
                setTimeout(() => {
                    errorDiv.style.display = 'none';
                }, 5000);
            }

            // Show success message
            function showSuccess(message) {
                const successDiv = document.getElementById('successMessage');
                successDiv.textContent = message;
                successDiv.style.display = 'block';
                // Hide error message
                document.getElementById('errorMessage').style.display = 'none';
                // Scroll to top to show success
                window.scrollTo(0, 0);
                // Auto hide after 5 seconds
                setTimeout(() => {
                    successDiv.style.display = 'none';
                }, 5000);
            }

            function setLoading(loading) {
                isLoading = loading;
                const loadingContainer = document.getElementById('loading-container');
                const itemsContainer = document.getElementById('cart-items-container');
                const summary = document.getElementById('cart-summary');

                if (loading) {
                    loadingContainer.style.display = 'block';
                    itemsContainer.style.display = 'none';
                    summary.style.display = 'none';
                } else {
                    loadingContainer.style.display = 'none';
                }
            }

            function showMessage(message, type = 'info', timeout = 5000) {
                const container = document.getElementById(type === 'error' ? 'errorMessage' : 'successMessage');
                container.textContent = message;
                container.style.display = 'block';

                if (timeout > 0) {
                    setTimeout(() => {
                        container.style.display = 'none';
                    }, timeout);
                }
            }

            // Load user information and auto-fill form
            async function loadUserInfo() {
                try {
                    const response = await apiCall(USER_INFO_API_URL);
                    if (response.success && response.data) {
                        const userInfo = response.data;
                        document.getElementById('fullName').value = userInfo.fullName || '';
                        document.getElementById('phone').value = userInfo.phone || '';
                        document.getElementById('email').value = userInfo.email || '';
                        document.getElementById('address').value = userInfo.address || '';
                    }
                } catch (error) {
                    // Don't show error as user might not be logged in
                    console.log('Could not load user info:', error.message);
                }
            }
        </script>
    </body>
</html>
