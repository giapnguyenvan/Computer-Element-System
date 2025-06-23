<%-- 
    Document   : BuySubjectPage
    Created on : Jun 15, 2024, 9:07:16 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán khóa học - Cuz Learning</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

            :root {
                --primary-color: #4f46e5;
                --success-color: #10b981;
                --danger-color: #ef4444;
                --warning-color: #f59e0b;
                --info-color: #3b82f6;
                --light-color: #f8fafc;
                --dark-color: #1e293b;
                --border-radius: 12px;
                --box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                margin: 0;
                padding: 0;
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
                border-radius: var(--border-radius);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                margin: 2rem auto;
                overflow: hidden;
                position: relative;
            }

            .order-info {
                flex: 1;
                padding: 2rem;
                display: flex;
                flex-direction: column;
                position: relative;
                border-right: 1px solid rgba(0, 0, 0, 0.1);
            }

            .order-info h1 {
                color: var(--dark-color);
                font-weight: 600;
                margin-bottom: 1.5rem;
                text-align: center;
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
                background: var(--light-color);
                padding: 1.5rem;
                border-radius: var(--border-radius);
                margin-top: auto;
            }

            .detail-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 0;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            }

            .detail-row:last-child {
                border-bottom: none;
                font-weight: 600;
                font-size: 1.1rem;
                color: var(--primary-color);
                margin-top: 0.5rem;
                padding-top: 1rem;
                border-top: 2px solid var(--primary-color);
            }

            .detail-label {
                font-weight: 500;
                color: var(--dark-color);
            }

            .detail-value {
                font-weight: 600;
                color: var(--info-color);
            }

            .credit-info {
                flex: 1;
                padding: 2rem;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            }

            .qr-section h1 {
                color: var(--dark-color);
                font-weight: 600;
                margin-bottom: 2rem;
                text-align: center;
            }

            .qr-code {
                width: 280px;
                height: 280px;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                background: white;
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .payment-info {
                text-align: center;
                color: var(--dark-color);
                margin-top: 1rem;
            }

            .payment-amount {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--success-color);
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
                background: var(--warning-color);
                color: white;
            }

            .status-indicator.success {
                background: var(--success-color);
            }

            .status-indicator.error {
                background: var(--danger-color);
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
            @media (max-width: 768px) {
                .window {
                    flex-direction: column;
                    margin: 1rem;
                    width: calc(100% - 2rem);
                }

                .order-info, .credit-info {
                    padding: 1.5rem;
                }

                .order-info {
                    border-right: none;
                    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container">
                <a class="navbar-brand" href="homepageservlet">
                    <i class="fas fa-graduation-cap me-2"></i>Cuz Learning
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarContent" aria-controls="navbarContent" 
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarContent">
                    <div class="navbar-nav ms-auto d-flex align-items-center">
                        <!-- Theme Switch -->
                        <div class="form-check form-switch me-3">
                            <input class="form-check-input" type="checkbox" role="switch" 
                                   id="themeSwitch" onchange="switchTheme()">
                            <label class="form-check-label" for="themeSwitch">
                                <i class="fas fa-moon"></i>
                            </label>
                        </div>

                        <!-- User Dropdown -->
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" 
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <c:choose>
                                    <c:when test="${sessionScope.customer != null}">
                                        <img src="https://gcs.tripi.vn/public-tripi/tripi-feed/img/474074hYy/anh-nen-hoa-anh-dao-dep-nhat_025505349.jpg"
                                             alt="Profile" class="profile-img">
                                        <span class="ms-2 d-none d-md-inline">${sessionScope.customer.name}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGU0uf9RH5npQE6jWFRwRHNWoTTyy4NuxPo0rzkJm8tA&s"
                                             alt="Guest" class="profile-img">
                                        <span class="ms-2 d-none d-md-inline">Khách</span>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <c:choose>
                                    <c:when test="${sessionScope.customer != null}">
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Hồ sơ</a></li>
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-book me-2"></i>Khóa học của tôi</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li><a class="dropdown-item" href="./Account"><i class="fas fa-sign-in-alt me-2"></i>Đăng nhập/Đăng ký</a></li>
                                        </c:otherwise>
                                    </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Loading Spinner -->
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Đang tải...</span>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container-fluid" style="padding-top: 100px;">
            <div class="window fade-in">
                <!-- Status Indicator -->
                <div class="status-indicator" id="statusIndicator">
                    <i class="fas fa-clock me-1"></i>Chờ thanh toán
                </div>

                <!-- Order Information -->
                <div class="order-info">
                    <h1><i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng</h1>



                    <div class="order-details">
                        <c:forEach items="${order.orderDetails}" var="orderDetail">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fas fa-code me-2"></i>Tên sản phẩm:</span>
                                <span class="detail-value">${orderDetail.product.name}</span>
                                <span class="detail-label"><i class="fas fa-code me-2"></i>Số lượng:</span>
                                <span class="detail-value">${orderDetail.quantity}</span>
                            </div>
                        </c:forEach>

                        <div class="detail-row">
                            <span class="detail-label"><i class="fas fa-money-bill-wave me-2"></i>TỔNG CỘNG:</span>
                            <span class="detail-value">${transaction.totalAmount} VND</span>
                        </div>
                    </div>
                </div>

                <!-- Payment Information -->
                <div class="credit-info">
                    <div class="qr-section" style="display: flex; flex-direction: column; justify-content: center; align-items: center">
                        <h1><i class="fas fa-qrcode me-2"></i>Quét mã để thanh toán</h1>

                        <img src="https://img.vietqr.io/image/MB-0817300803-qr_only.jpg?amount=${transaction.totalAmount}&addInfo=${transaction.transactionCode}&accountName=Nguyen%20Duc%20Cuong" 
                             alt="QR Code thanh toán" class="qr-code pulse" id="qrCode">

                        <div class="payment-info">
                            <div><i class="fas fa-bank me-2"></i><strong>Ngân hàng:</strong> MB Bank</div>
                            <div><i class="fas fa-money-bill-wave me-2"></i><strong>Số tài khoản:</strong> 0817300803</div>
                            <div><i class="fas fa-user me-2"></i><strong>Tên tài khoản:</strong>Nguyen Duc Cuong</div>
                            <div class="payment-amount">
                                <i class="fas fa-dollar-sign me-1"></i>${transaction.totalAmount} VND
                            </div>
                            <div class="text-muted">
                                <i class="fas fa-hashtag me-1"></i>Mã GD: ${transaction.transactionCode}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Form -->
        <form action="Lesson" method="get" style="display: none;" id="redirectForm">
            <input type="hidden" name="actionCheck" value="viewLessonList">
            <input type="hidden" name="subjectId" value="${subject.subjectId}">
        </form>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
                                       // Theme Management
                                       function switchTheme() {
                                           const themeSwitch = document.getElementById("themeSwitch");
                                           const theme = themeSwitch.checked ? 'dark' : 'light';

                                           document.documentElement.setAttribute("data-bs-theme", theme);
                                           setCookie('currentTheme', theme, 365);

                                           // Update icon
                                           const icon = themeSwitch.nextElementSibling.querySelector('i');
                                           icon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
                                       }

                                       function initializeTheme() {
                                           const savedTheme = getCookie('currentTheme');
                                           const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                                           const theme = savedTheme || (prefersDark ? 'dark' : 'light');

                                           document.documentElement.setAttribute('data-bs-theme', theme);
                                           document.getElementById("themeSwitch").checked = theme === 'dark';

                                           const icon = document.querySelector('#themeSwitch + label i');
                                           icon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
                                       }

                                       function setCookie(name, value, days) {
                                           const expires = new Date();
                                           expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
                                           document.cookie = `${name}=${value};expires=${expires.toUTCString()};path=/;SameSite=Lax`;
                                       }

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

                                           indicator.className = `status-indicator ${status}`;

                                           switch (status) {
                                               case 'success':
                                                   indicator.innerHTML = '<i class="fas fa-check me-1"></i>' + message;
                                                   qrCode.classList.remove('pulse');
                                                   break;
                                               case 'error':
                                                   indicator.innerHTML = '<i class="fas fa-times me-1"></i>' + message;
                                                   qrCode.classList.remove('pulse');
                                                   break;
                                               case 'processing':
                                                   indicator.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>' + message;
                                                   break;
                                               default:
                                                   indicator.innerHTML = '<i class="fas fa-clock me-1"></i>' + message;
                                                   qrCode.classList.add('pulse');
                                           }
                                       }

                                       // Payment Processing
                                       async function checkPaymentStatus() {
                                           try {
                                               const response = await fetch('/payment-check', {
                                                   method: 'POST',
                                                   headers: {
                                                       'Content-Type': 'application/json',
                                                   },
                                                   body: JSON.stringify({
                                                       transactionCode: '${transaction.transactionCode}',
                                                       amount: ${transaction.totalAmount}
                                                   })
                                               });

                                               if (response.ok) {
                                                   const data = await response.json();

                                                   if (data.status === 'success') {
                                                       updatePaymentStatus('success', 'Thanh toán thành công!');
                                                       clearInterval(paymentCheckInterval);

                                                       setTimeout(() => {
                                                           document.getElementById('redirectForm').submit();
                                                       }, 2000);
                                                   } else if (data.status === 'error') {
                                                       updatePaymentStatus('error', 'Thanh toán thất bại');
                                                       clearInterval(paymentCheckInterval);
                                                   }
                                               }
                                           } catch (error) {
                                               console.error('Lỗi kiểm tra thanh toán:', error);
                                           }
                                       }

                                       // Google Sheets Integration (Alternative approach)
                                       async function checkGoogleSheets() {
                                           const SHEET_ID = "1eBH93hAdhslmqjEsqEj2KCHVHdSjy553BZs_ZJ6ZEr4";
                                           const API_KEY = "YOUR_API_KEY"; // Replace with actual API key
                                           const range = "DataPage!A2:F100";

                                           try {
                                               const url = `https://sheets.googleapis.com/v4/spreadsheets/${SHEET_ID}/values/${range}?key=${API_KEY}`;
                                               const response = await fetch(url);
                                               const data = await response.json();
                                               console.log(data.values.length);
                                               if (data.values) {
                                                   data.values.forEach(row => {
                                                       const amount = parseFloat(row[2]);
                                                       const description = row[1];

                                                       if (amount >= ${transaction.totalAmount} * 0.99) {
                                                           const transactionMatch = true;
                                                           if (transactionMatch && row[1] === '${transaction.transactionCode}') {
                                                               updatePaymentStatus('success', 'Thanh toán thành công!');
                                                               clearInterval(paymentCheckInterval);

                                                               setTimeout(() => {
                                                                   document.getElementById('redirectForm').submit();
                                                               }, 2000);
                                                           }
                                                       }
                                                   });
                                               }
                                           } catch (error) {
                                               console.error('Lỗi kiểm tra Google Sheets:', error);
                                           }
                                       }

                                       // Show loading
                                       function showLoading() {
                                           document.getElementById('loadingSpinner').style.display = 'block';
                                       }

                                       function hideLoading() {
                                           document.getElementById('loadingSpinner').style.display = 'none';
                                       }

                                       // Initialize
                                       document.addEventListener('DOMContentLoaded', function () {
                                           initializeTheme();
                                           updatePaymentStatus('pending', 'Chờ thanh toán');

                                           // Start payment checking
                                           paymentCheckInterval = setInterval(checkGoogleSheets, 3000);

                                           // Auto-timeout after 10 minutes
                                           setTimeout(() => {
                                               if (paymentCheckInterval) {
                                                   clearInterval(paymentCheckInterval);
                                                   updatePaymentStatus('error', 'Hết thời gian thanh toán');
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