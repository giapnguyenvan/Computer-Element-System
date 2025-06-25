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
        .login-main-row {
            min-height: 100vh;
            display: flex;
        }
        .login-left {
            position: relative;
            background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
            color: #fff;
            flex: 1;
            display: flex;
            align-items: stretch;
            min-width: 400px;
            overflow: hidden;
        }
        .login-left::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(93,46,188,0.85);
            z-index: 1;
        }
        .login-left > * {
            position: relative;
            z-index: 2;
        }
        .login-left-content {
            text-align: center;
            color: #fff;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            padding: 20px;
            margin: auto;
        }
        .login-left-content h1 {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }
        .login-left-content p {
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            text-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
        }
        .login-left-content a {
            font-size: 1.25rem;
        }
        .login-right {
            flex: 1.2;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f4f6fb;
            min-height: 100vh;
        }
        .login-form-box {
            width: 100%;
            max-width: 400px;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(44, 62, 80, 0.12);
            padding: 48px 36px 36px 36px;
            margin: 32px 0;
            display: flex;
            flex-direction: column;
            align-items: stretch;
            transition: box-shadow 0.2s;
        }
        .login-form-box:hover {
            box-shadow: 0 12px 40px rgba(44, 62, 80, 0.18);
        }
        .login-form-box h2 {
            font-family: 'Times New Roman', Times, serif;
            font-size: 2.1rem;
            font-weight: 800;
            margin-bottom: 10px;
            text-align: center;
            color: #222;
            letter-spacing: -1px;
        }
        .login-form-box p {
            margin-bottom: 28px;
            text-align: center;
            color: #666;
        }
        .login-form-box .form-label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }
        .login-form-box .form-control {
            width: 100%;
            box-sizing: border-box;
            border-radius: 10px;
            min-height: 46px;
            font-size: 1.08rem;
            border: 1.5px solid #e0e3ea;
            margin-bottom: 18px;
            padding: 10px 16px;
            background: #fff;
            transition: border-color 0.2s;
        }
        .login-form-box .form-control:focus {
            border-color: #705FBC;
            box-shadow: 0 0 0 2px rgba(112,95,188,0.08);
        }
        .login-form-box .btn-warning {
            width: 100%;
            min-height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.13rem;
            margin: 20px 0 12px 0;
            border-radius: 8px;
            background: #ffc107;
            border: none;
            color: #222;
            box-shadow: none;
            padding: 0;
            transition: background 0.2s, color 0.2s;
        }
        .login-form-box .btn-warning:hover {
            background: #e0a800;
            color: #fff;
        }
        .login-form-box .alert {
            width: 100%;
            text-align: center;
            margin-bottom: 1rem;
            border-radius: 8px;
        }
        .login-form-box a {
            color: #705FBC;
            text-decoration: none;
            font-weight: 500;
        }
        .login-form-box a:hover {
            text-decoration: underline;
        }
        @media (max-width: 900px) {
            .login-main-row {
                flex-direction: column;
            }
            .login-left, .login-right {
                min-width: 100vw;
            }
        }
        /* Overlay for modal (custom, to ensure always on top) */
        .custom-modal-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            width: 100vw; height: 100vh;
            background: rgba(44, 62, 80, 0.45);
            z-index: 1050;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* Custom modal content for verify reset */
        .custom-modal-content {
            position: relative;
            z-index: 1060;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 12px 48px rgba(44,62,80,0.25), 0 1.5px 8px rgba(44,62,80,0.10);
            padding: 32px 28px 24px 28px;
            min-width: 340px;
            max-width: 95vw;
            max-height: 95vh;
            margin: auto;
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .custom-modal-content .modal-header {
            background: #6c5ce7;
            color: #fff;
            border-radius: 16px 16px 0 0;
            padding: 18px 24px 12px 24px;
            text-align: center;
            border-bottom: none;
        }
        .custom-modal-content .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }
        .custom-modal-content .modal-body {
            padding: 18px 0 0 0;
        }
        @media (max-width: 600px) {
            .custom-modal-content {
                min-width: 90vw;
                padding: 16px 6px 12px 6px;
            }
        }
    </style>
</head>
<body>
<div class="login-main-row">
    <div class="login-left">
        <div class="login-left-content">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet" style="color: white;">
                <i class="fas fa-microchip me-2"></i>
                <span class="fw-bold">CES</span>
            </a>
            <h1>Forgot Your Password?</h1>
            <p>
                Enter your username and email to reset your password.<br>
                We'll send you instructions to recover your account.
            </p>
            <a href="login.jsp" class="btn btn-primary btn-lg" style="color: white">Back to Login</a>
        </div>
    </div>
    <div class="login-right">
        <div class="login-form-box">
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
                <button type="submit" class="btn btn-warning">Reset Password</button>
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
    </div>
    <div class="modal-body">
      <form id="verifyResetForm" action="forget-password" method="post">
        <input type="hidden" name="action" value="verify" />
        <div class="mb-3">
          <input type="text" class="form-control" name="code" maxlength="6" pattern="\d{6}" required placeholder="Verification code" />
        </div>
        <div class="mb-3">
          <input type="password" class="form-control" name="newPassword" minlength="8" required placeholder="New password (min 8 characters)" />
        </div>
        <div class="mb-3">
          <input type="password" class="form-control" name="confirmPassword" minlength="8" required placeholder="Confirm new password" />
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
        verifyForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(verifyForm);
            fetch('forget-password', {
                method: 'POST',
                body: formData,
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(res => res.json())
            .then(data => {
                const resultDiv = document.getElementById('verifyResetResult');
                if (data.success) {
                    resultDiv.innerHTML = `<div class="alert alert-success">${data.message}</div>`;
                    setTimeout(() => { window.location.href = 'login.jsp'; }, 2000);
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
    document.addEventListener("DOMContentLoaded", function() {
      const overlay = document.getElementById('customVerifyResetOverlay');
      if (overlay) {
        document.body.style.overflow = 'hidden';
        overlay.addEventListener('click', function(e) {
          if (e.target === overlay) {
            e.stopPropagation();
          }
        });
        window.addEventListener('keydown', function(e) {
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
</script>
</body>
</html>