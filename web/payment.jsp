<%-- 
    Document   : BuySubjectPage
    Created on : Jun 15, 2024, 9:07:16 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment</title>
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

            .navbar {
                background: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                box-shadow: var(--box-shadow);
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                color: var(--primary-color) !important;
            }

            .window {
                max-width: 1200px;
                width: 95%;
                min-height: 600px;
                display: flex;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                margin: 2rem auto;
                overflow: hidden;
                position: relative;
            }

            .order-info {
                flex: 1;
                padding: 30px 24px 30px 24px;
                display: flex;
                flex-direction: column;
                position: relative;
                border-right: 1px solid rgba(0, 0, 0, 0.1);
            }

            .order-info h1 {
                color: #111;
                font-size: 2.2rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }

            .product-image {
                width: 100%;
                max-width: 400px;
                height: 250px;
                object-fit: cover;
                border-radius: var(--border-radius);
                margin: 0 auto 1.5rem;
                display: block;
                box-shadow: var(--box-shadow);
            }

            .order-details {
                background: #f8f9fa;
                padding: 24px;
                border-radius: 20px;
                margin-top: auto;
                box-shadow: 0 5px 15px rgba(0,0,0,0.04);
            }

            .detail-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 14px 0;
                border-bottom: 1px solid #e1e5e9;
            }

            .detail-row:last-child {
                border-bottom: none;
                font-weight: 600;
                font-size: 1.1rem;
                color: #667eea;
                margin-top: 0.5rem;
                padding-top: 1rem;
                border-top: 2px solid #667eea;
            }

            .detail-label {
                font-weight: 500;
                color: #2d3436;
            }

            .detail-value {
                font-weight: 600;
                color: #3b82f6;
            }

            .credit-info {
                flex: 1;
                padding: 30px 24px 30px 24px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                border-radius: 20px;
            }

            .qr-section h1 {
                color: #111;
                font-size: 2rem;
                font-weight: 600;
                margin-bottom: 2rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }

            .qr-code {
                width: 280px;
                height: 280px;
                border-radius: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                background: white;
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .payment-info {
                text-align: center;
                color: #2d3436;
                margin-top: 1rem;
            }

            .payment-amount {
                font-size: 1.5rem;
                font-weight: 700;
                color: #00b894;
                margin: 0.5rem 0;
            }

            .theme-switch {
                position: relative;
            }

            .form-switch .form-check-input {
                width: 3rem;
                height: 1.5rem;
                border-radius: 2rem;
                background-color: #6c757d;
                border: none;
                transition: var(--transition);
            }

            .form-switch .form-check-input:checked {
                background-color: var(--success-color);
                border-color: var(--success-color);
            }

            .form-switch .form-check-input:focus {
                box-shadow: 0 0 0 0.25rem rgba(16, 185, 129, 0.25);
            }

            .profile-img {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid var(--primary-color);
            }

            .loading-spinner {
                display: none;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 1000;
            }

            .spinner-border {
                width: 3rem;
                height: 3rem;
                color: var(--primary-color);
            }

            .status-indicator {
                position: absolute;
                top: 1rem;
                right: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 2rem;
                font-size: 0.875rem;
                font-weight: 500;
                background: #ffc107; /* vàng mặc định cho pending/processing */
                color: #212529;
            }

            .status-indicator.success {
                background: #28a745; /* xanh cho thành công */
                color: #fff;
            }

            .status-indicator.error {
                background: #dc3545; /* đỏ cho lỗi */
                color: #fff;
            }

            .status-indicator.pending, .status-indicator.processing {
                background: #ffc107; /* vàng cho chờ thanh toán và đang xử lý */
                color: #212529;
            }

            /* Dark theme styles */
            [data-bs-theme="dark"] {
                --light-color: #374151;
                --dark-color: #f9fafb;
            }

            [data-bs-theme="dark"] .window {
                background: #1f2937;
                color: #f9fafb;
            }

            [data-bs-theme="dark"] .order-details {
                background: #374151;
            }

            [data-bs-theme="dark"] .credit-info {
                background: linear-gradient(135deg, #374151 0%, #4b5563 100%);
            }

            [data-bs-theme="dark"] .qr-code {
                background: #4b5563;
            }

            /* Responsive design */
            @media (max-width: 900px) {
                .window {
                    flex-direction: column;
                    margin: 1rem;
                    width: calc(100% - 2rem);
                }

                .order-info, .credit-info {
                    padding: 18px 8px;
                }

                .order-info {
                    border-right: none;
                    border-bottom: 1px solid #e1e5e9;
                }

                .qr-code {
                    width: 220px;
                    height: 220px;
                }
            }

            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .pulse {
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }
        </style>
    </head>

    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>
        <!-- Loading Spinner -->
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container-fluid" style="padding-top: 100px;">
            <div class="window fade-in">
                <!-- Status Indicator -->
                <div class="status-indicator" id="statusIndicator">
                    <i class="fas fa-hourglass-half me-1"></i>Waiting for payment
                </div>

                <!-- Order Information -->
                <div class="order-info">
                    <h1><i class="fas fa-info-circle me-2"></i>Order Information</h1>

                    <div class="order-details">
                        <c:forEach items="${order.orderDetails}" var="orderDetail">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fas fa-box me-2"></i>Product Name:</span>
                                <span class="detail-value">${orderDetail.product.name}</span>
                                <span class="detail-label"><i class="fas fa-sort-numeric-up me-2"></i>Quantity:</span>
                                <span class="detail-value">${orderDetail.quantity}</span>
                            </div>
                        </c:forEach>

                        <div class="detail-row">
                            <span class="detail-label"><i class="fas fa-money-bill-wave me-2"></i>TOTAL:</span>
                            <span class="detail-value">${transaction.totalAmount} VND</span>
                        </div>
                    </div>
                </div>

                <!-- Payment Information -->
                <div class="credit-info">
                    <div class="qr-section" style="display: flex; flex-direction: column; justify-content: center; align-items: center">
                        <h1><i class="fas fa-qrcode me-2"></i>Scan to pay</h1>

                        <img src="https://img.vietqr.io/image/MB-0343811285-qr_only.jpg?amount=${transaction.totalAmount}&addInfo=${transaction.transactionCode}&accountName=Truong%20Duc%20Kien" 
                             alt="Payment QR Code" class="qr-code pulse" id="qrCode">

                        <div class="payment-info">
                            <div><i class="fas fa-university me-2"></i><strong>Bank:</strong> MB Bank</div>
                            <div><i class="fas fa-credit-card me-2"></i><strong>Account Number:</strong> 0343811285</div>
                            <div><i class="fas fa-user me-2"></i><strong>Account Name:</strong>Truong Duc Kien</div>
                            <div class="payment-amount">
                                <i class="fas fa-coins me-1"></i>${transaction.totalAmount} VND
                            </div>
                            <div class="text-muted">
                                <i class="fas fa-receipt me-1"></i>Transaction Code: ${transaction.transactionCode}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="footer.jsp"/>
        
        <script>
            function getCookie(name) {
                const nameEQ = name + "=";
                const ca = document.cookie.split(';');
                for (let i = 0; i < ca.length; i++) {
                    let c = ca[i];
                    while (c.charAt(0) === ' ')
                        c = c.substring(1, c.length);
                    if (c.indexOf(nameEQ) === 0)
                        return c.substring(nameEQ.length, c.length);
                }
                return null;
            }

            // Payment Status Management
            let paymentCheckInterval;

            function updatePaymentStatus(status, message) {
                const indicator = document.getElementById('statusIndicator');
                const qrCode = document.getElementById('qrCode');
                // Ensure className always has status-indicator and status
                indicator.className = `status-indicator ${status}`;
                switch (status) {
                    case 'success':
                        indicator.innerHTML = '<i class="fas fa-check-circle me-1"></i>' + message;
                        qrCode.classList.remove('pulse');
                        break;
                    case 'error':
                        indicator.innerHTML = '<i class="fas fa-exclamation-triangle me-1"></i>' + message;
                        qrCode.classList.remove('pulse');
                        break;
                    case 'processing':
                        indicator.innerHTML = '<i class="fas fa-sync fa-spin me-1"></i>' + message;
                        qrCode.classList.add('pulse');
                        break;
                    case 'pending':
                        indicator.innerHTML = '<i class="fas fa-hourglass-half me-1"></i>' + message;
                        qrCode.classList.add('pulse');
                        break;
                    default:
                        indicator.innerHTML = message;
                        qrCode.classList.add('pulse');
                }
            }

            // Payment Processing
            async function checkPaymentStatus(amount) {
                try {
                    const response = await fetch('/CES/payment-servlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            transactionCode: '${transaction.transactionCode}',
                            amount: amount
                        })
                    });

                    if (response.ok) {
                        const data = await response.json();

                        if (data.status === 200) {
                            updatePaymentStatus('success', 'Payment successful!');
                            clearInterval(paymentCheckInterval);

                            setTimeout(() => {
                                window.location = '/CES/homepageservlet';
                            }, 2000);
                        } else if (data.status !== 200) {
                            updatePaymentStatus('error', 'Payment failed');
                            clearInterval(paymentCheckInterval);
                        }
                    }
                } catch (error) {
                    console.error('Payment check error:', error);
                }
            }

            // Google Sheets Integration (Alternative approach)
            async function checkGoogleSheets() {
                const HEAD_URL = "https://docs.google.com/spreadsheets/d/";
                const SHEET_ID = "1MARmRVl1EmxijN9fsb4QbWgOxDtL2c_yIPtHJc8hkBY";
                const GID_STRING = "gviz/tq?sheet=trans";
                const sizeOfCell = 10;
                try {
                    let sheet_range = "A2:F" + (sizeOfCell + 1);
                    let full_link = HEAD_URL + SHEET_ID + "/" + GID_STRING + "&range=" + sheet_range;

                    const response = await fetch(full_link);
                    const dataText = await response.text();
                    const data = JSON.parse(dataText.substr(47).slice(0, -2)).table.rows;
                    console.log(data);
                    if (data) {
                        data.forEach(row => {
                            const amount = parseFloat(row.c[2].v);
                            console.log(amount);
                            const description = row.c[1].v;

                            // Check transaction code in description
                            var transactionCode = '${transaction.transactionCode}';
                            var expectedAmount = ${transaction.totalAmount} * 0.99;
                            var isValidTransaction = false;

                            // Use contains to check transaction code
                            if (description && description.indexOf(transactionCode) !== -1) {
                                console.log('Transaction code found in description: ' + description);
                                console.log('Looking for transaction code: ' + transactionCode);
                                isValidTransaction = true;
                            }

                            if (isValidTransaction && amount >= expectedAmount) {
                                console.log('Valid transaction found! Amount: ' + amount + ', Expected: ' + expectedAmount);
                                clearInterval(paymentCheckInterval);
                                checkPaymentStatus(amount);
                            } else if (isValidTransaction) {
                                console.log('Transaction code found but amount insufficient. Amount: ' + amount + ', Expected: ' + expectedAmount);
                            }
                        });
                    }
                } catch (error) {
                    console.error('Google Sheets check error:', error);
                }
            }

            // Initialize
            document.addEventListener('DOMContentLoaded', function () {
                updatePaymentStatus('pending', 'Waiting for payment');
                // Start payment checking
                paymentCheckInterval = setInterval(checkGoogleSheets, 3000);

                // Auto-timeout after 10 minutes
                setTimeout(() => {
                    if (paymentCheckInterval) {
                        clearInterval(paymentCheckInterval);
                        updatePaymentStatus('error', 'Payment timeout');
                    }
                }, 600000);
            });

            // Handle page visibility change
            document.addEventListener('visibilitychange', function () {
                if (document.hidden) {
                    if (paymentCheckInterval) {
                        clearInterval(paymentCheckInterval);
                    }
                } else {
                    if (!paymentCheckInterval) {
                        paymentCheckInterval = setInterval(checkGoogleSheets, 3000);
                    }
                }
            });
        </script>
    </body>
</html>