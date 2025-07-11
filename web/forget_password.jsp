<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Forgot Password | Computer Element System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- EduChamp CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            body, .auth-form-box, .auth-form-box * {
                font-family: 'Times New Roman', Times, serif !important;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: none;
            }
            .auth-main-row {
                min-height: 100vh;
                display: flex;
            }
            .auth-left {
                position: relative;
                background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
                color: #fff;
                flex: 1;
                display: flex;
                align-items: stretch;
                min-width: 400px;
                overflow: hidden;
            }
            .auth-left::before {
                content: '';
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                background: rgba(93,46,188,0.85);
                z-index: 1;
            }
            .auth-left > * {
                position: relative;
                z-index: 2;
            }
            .auth-left-content {
                text-align: center;
                color: #fff;
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                max-width: 600px;
                padding: 20px;
                margin: auto;
            }
            .auth-left-content .navbar-brand {
                color: white;
                display: flex;
                align-items: center;
                gap: 8px;
                justify-content: center;
                margin-bottom: 30px;
                font-size: 2rem;
                text-decoration: none;
            }
            .auth-left-content .fw-bold {
                font-size: 2rem;
                text-decoration: underline;
            }
            .auth-left-content h1 {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 1.5rem;
            }
            .auth-left-content p {
                font-size: 1.25rem;
                margin-bottom: 1.5rem;
                text-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
            }
            .auth-left-content a.btn {
                font-size: 1.25rem;
                color: white;
                background: #0d6efd;
                border-radius: 8px;
                border: none;
                padding: 0.75rem 2rem;
                display: inline-block;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(44, 62, 80, 0.13);
                transition: background 0.2s, color 0.2s;
            }
            .auth-left-content a.btn:hover {
                background: #0056b3;
                color: #fff;
            }
            .auth-right {
                flex: 1.2;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f4f6fb;
                min-height: 100vh;
            }
            .auth-form-box {
                width: 100%;
                max-width: 440px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 8px 32px rgba(44, 62, 80, 0.12);
                padding: 32px 24px 24px 24px;
                margin: 24px 0;
                display: flex;
                flex-direction: column;
                align-items: stretch;
                transition: box-shadow 0.2s;
            }
            .auth-form-box:hover {
                box-shadow: 0 12px 40px rgba(44, 62, 80, 0.18);
            }
            .auth-form-box h2 {
                font-family: 'Times New Roman', Times, serif;
                font-size: 2rem;
                font-weight: 800;
                margin-bottom: 10px;
                text-align: center;
                color: #222;
                letter-spacing: -1px;
            }
            .auth-form-box p {
                margin-bottom: 28px;
                text-align: center;
                color: #666;
            }
            .auth-form-box .form-label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
                font-size: 1rem;
            }
            .auth-form-box .form-control {
                width: 100%;
                box-sizing: border-box;
                border-radius: 10px;
                min-height: 40px;
                font-size: 1rem;
                border: 1.5px solid #e0e3ea;
                margin-bottom: 14px;
                padding: 8px 12px;
                background: #fff;
                transition: border-color 0.2s;
            }
            .auth-form-box .form-control:focus {
                border-color: #705FBC;
                box-shadow: 0 0 0 2px rgba(112,95,188,0.08);
            }
            .auth-form-box .btn-primary, .auth-form-box .btn-register, .auth-form-box button[type="submit"] {
                width: 100%;
                min-height: 44px;
                border-radius: 8px;
                background: #0d6efd;
                color: #fff;
                font-weight: 700;
                font-size: 1.13rem;
                border: none;
                box-shadow: none;
                margin: 12px 0 8px 0;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s, color 0.2s;
            }
            .auth-form-box .btn-primary:hover, .auth-form-box .btn-register:hover, .auth-form-box button[type="submit"]:hover {
                background: #0056b3;
                color: #fff;
            }
            .auth-form-box .alert {
                width: 100%;
                text-align: center;
                margin-bottom: 1rem;
                border-radius: 8px;
                font-size: 1rem;
                padding: 12px 8px;
            }
            .auth-form-box a {
                color: #705FBC;
                text-decoration: none;
                font-weight: 500;
            }
            .auth-form-box a:hover {
                text-decoration: underline;
            }
            .auth-form-box .login-link {
                text-align: center;
                margin-top: 8px;
                font-size: 0.98rem;
            }
            .auth-form-box .login-link a {
                color: #333;
                text-decoration: none;
            }
            .auth-form-box .login-link a:hover {
                text-decoration: underline;
            }
            @media (max-width: 900px) {
                .auth-main-row {
                    flex-direction: column;
                }
                .auth-left, .auth-right {
                    min-width: 100vw;
                }
            }
            /* Overlay for modal (custom, to ensure always on top) */
            .custom-modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(44, 62, 80, 0.35);
                z-index: 1050;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .custom-modal-content {
                position: relative;
                z-index: 1060;
                background: #fff;
                border-radius: 24px;
                box-shadow: 0 12px 48px rgba(44,62,80,0.25), 0 2px 12px rgba(44,62,80,0.12);
                padding: 0;
                min-width: 340px;
                max-width: 95vw;
                max-height: 95vh;
                margin: auto;
                display: flex;
                flex-direction: column;
                align-items: stretch;
                overflow: hidden;
            }
            .custom-modal-content .modal-header {
                background: #0D6CF8;
                color: #fff;
                border-radius: 24px 24px 0 0;
                padding: 28px 32px 16px 32px;
                border-bottom: none;
                text-align: center;
                justify-content: center;
                position: relative;
            }
            .custom-modal-content .btn-close {
                position: absolute;
                top: 18px;
                right: 22px;
                width: 32px;
                height: 32px;
                background: transparent;
                border: none;
                color: #fff;
                font-size: 1.7rem;
                opacity: 0.85;
                z-index: 2;
                cursor: pointer;
                transition: opacity 0.2s, background 0.2s;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .custom-modal-content .btn-close:hover {
                opacity: 1;
                background: rgba(255,255,255,0.13);
            }
            .custom-modal-content .modal-title {
                font-size: 1.7rem;
                font-weight: 800;
                margin: 0;
                letter-spacing: -1px;
                width: 100%;
            }
            .custom-modal-content .modal-body {
                padding: 28px 32px 24px 32px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            #verifyResetForm {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 14px;
                margin-bottom: 10px;
            }
            #verifyResetForm .form-group,
            #verifyResetForm .mb-3 {
                width: 100%;
                max-width: 340px;
                margin-left: auto;
                margin-right: auto;
            }
            #verifyResetForm .form-control {
                border-radius: 10px;
                min-height: 40px;
                font-size: 1.05rem;
                border: 1.5px solid #e0e3ea;
                padding: 8px 12px;
                margin-bottom: 0;
                background: #f8f8fc;
                transition: border-color 0.2s;
                text-align: left;
                width: 100%;
                box-sizing: border-box;
            }
            #verifyResetForm .form-label {
                font-weight: 600;
                color: #222;
                margin-bottom: 4px;
                text-align: left;
            }
            #verifyResetForm button[type="submit"] {
                border-radius: 10px;
                background: #0984e3;
                color: #fff;
                font-weight: 700;
                font-size: 1.08rem;
                min-height: 42px;
                border: none;
                box-shadow: none;
                margin-top: 6px;
                transition: background 0.2s, color 0.2s;
                width: 100%;
            }
            #verifyResetForm button[type="submit"]:hover {
                background: #74b9ff;
                color: #fff;
            }
            .custom-modal-content .alert {
                width: 100%;
                text-align: center;
                margin-top: 12px;
                border-radius: 10px;
                font-size: 1rem;
                padding: 12px 8px;
            }
            .custom-modal-content .verify-message {
                width: 100%;
                text-align: center;
                margin-top: 18px;
                color: #7f8fa6;
                font-size: 0.98rem;
                font-weight: 500;
                letter-spacing: 0.1px;
            }
            @media (max-width: 600px) {
                .custom-modal-content, .custom-modal-content .modal-body {
                    padding: 10px 4vw !important;
                    min-width: 90vw;
                }
                .custom-modal-content .modal-header {
                    padding: 18px 4vw 10px 4vw;
                }
            }
        </style>
    </head>
    <body>
        <div class="auth-main-row">
            <div class="auth-left">
                <div class="auth-left-content">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet">
                        <i class="fas fa-microchip me-2"></i>
                        <span class="fw-bold">CES</span>
                    </a>
                    <h1>Forgot Your Password?</h1>
                    <p>
                        Enter your username and email to reset your password.<br>
                        We'll send you instructions to recover your account.
                    </p>
                    <a href="login.jsp" class="btn btn-primary btn-lg">Back to Login</a>
                </div>
            </div>
            <div class="auth-right">
                <div class="auth-form-box">
                    <h2>Forgot Password</h2>
                    <p>Enter your details to reset your password</p>
                    <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">${success}</div>
                    </c:if>
                    <form action="forget-password" method="post" id="forgetPasswordForm">
                        <div class="mb-3">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   value="${param.email != null ? param.email : (not empty email ? email : '')}">
                        </div>
                        <button type="submit" class="btn btn-primary">Reset Password</button>
                    </form>
                    <div class="login-link" style="text-align:center; margin-top:15px;">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Custom Overlay Modal for verification reset -->
        <c:if test="${not empty showVerifyResetPopup}">
            <div class="custom-modal-overlay" id="customVerifyResetOverlay">
                <div class="custom-modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title w-100 text-center" id="verifyResetModalLabel">Reset Your Password</h4>
                        <button type="button" class="btn-close" aria-label="Close" onclick="closeVerifyResetModal()">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="verifyResetForm" action="forget-password" method="post">
                            <input type="hidden" name="action" value="verify" />
                            <div class="mb-3 text-start">
                                <label for="code" class="form-label">Verification Code</label>
                                <input type="text" class="form-control" id="code" name="code" maxlength="6" pattern="\d{6}" required />
                            </div>

                            <div class="mb-3 text-start">
                                <label for="newPassword" class="form-label">New Password <span class="text-muted">(min 8 characters)</span></label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" minlength="8" required />
                            </div>

                            <div class="mb-3 text-start">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" minlength="8" required />
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Reset Password</button>
                        </form>
                        <div id="verifyResetResult"></div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger mt-3">${error}</div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success mt-3">${message}</div>
                        </c:if>
                        <div class="verify-message">A verification code has been sent to your email. Please enter the code to reset your password.</div>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- End Custom Overlay Modal -->

        <div id="verifyResetModalContainer"></div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validateEmail(email) {
                const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                return re.test(email);
            }

            const forgetPasswordForm = document.getElementById('forgetPasswordForm');
            if (forgetPasswordForm) {
                forgetPasswordForm.addEventListener('submit', function (event) {
                    const email = document.getElementById('email').value;
                    const errorDiv = document.getElementById('clientError');
                    let errors = [];

                    if (!validateEmail(email)) {
                        errors.push("Invalid email format.");
                    }

                    if (errors.length > 0) {
                        event.preventDefault();
                        errorDiv.innerHTML = errors.join('<br>');
                        errorDiv.style.display = 'block';
                    } else {
                        errorDiv.style.display = 'none';
                    }
                });
            }

            // AJAX for verify reset form
            const verifyForm = document.getElementById('verifyResetForm');
            if (verifyForm) {
                verifyForm.addEventListener('submit', function (e) {
                    e.preventDefault();
                    const formData = new FormData(verifyForm);
                    fetch('forget-password', {
                        method: 'POST',
                        body: formData,
                        headers: {'X-Requested-With': 'XMLHttpRequest'}
                    })
                            .then(res => res.json())
                            .then(data => {
                                const resultDiv = document.getElementById('verifyResetResult');
                                if (data.success) {
                                    resultDiv.innerHTML = `<div class="alert alert-success">${data.message}</div>`;
                                    setTimeout(() => {
                                        window.location.href = 'login.jsp';
                                    }, 2000);
                                } else {
                                    resultDiv.innerHTML = `<div class="alert alert-danger">${data.message}</div>`;
                                }
                            })
                            .catch(() => {
                                document.getElementById('verifyResetResult').innerHTML = '<div class="alert alert-danger">System error. Please try again.</div>';
                            });
                });
            }

            // Prevent closing overlay by click outside or ESC
            document.addEventListener("DOMContentLoaded", function () {
                const overlay = document.getElementById('customVerifyResetOverlay');
                if (overlay) {
                    document.body.style.overflow = 'hidden';
                    overlay.addEventListener('click', function (e) {
                        if (e.target === overlay) {
                            e.stopPropagation();
                        }
                    });
                    window.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') {
                            e.preventDefault();
                        }
                    });
                }
            });

            // Hàm gọi khi gửi email thành công (ví dụ sau khi nhận response thành công từ server)
            function showVerifyResetModal() {
                fetch('verify_reset.jsp')
                        .then(res => res.text())
                        .then(html => {
                            document.getElementById('verifyResetModalContainer').innerHTML = html;
                            var modal = new bootstrap.Modal(document.getElementById('verifyResetModal'), {
                                backdrop: 'static',
                                keyboard: false
                            });
                            modal.show();
                        });
            }

            function closeVerifyResetModal() {
                const overlay = document.getElementById('customVerifyResetOverlay');
                if (overlay) {
                    overlay.style.display = 'none';
                    document.body.style.overflow = '';
                }
            }
        </script>
    </body>
</html>