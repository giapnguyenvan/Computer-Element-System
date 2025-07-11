<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
            background: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center center/cover no-repeat;
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
        
        /* Loading Modal Styles */
        #loadingModal .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        #loadingModal .modal-body {
            padding: 2rem;
        }
        
        #loadingModal .spinner-border {
            width: 3rem;
            height: 3rem;
        }
        
        #loadingModal .modal-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        #loadingModal .text-muted {
            color: #6c757d !important;
            font-size: 0.875rem;
        }
        
        /* Verification Modal Styles */
        .verification-modal-content {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border: none;
        }
        
        .verification-modal-header {
            background-color: #6c5ce7;
            color: white;
            text-align: center;
            font-size: 1.5rem;
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
            border-bottom: none;
        }
        
        .verification-modal-header .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }
        
        .verification-modal-header .btn-close-white {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        
        .verification-modal-body {
            padding: 30px;
        }
        
        .verification-input {
            border-radius: 8px;
            margin-bottom: 15px;
            border: 1.5px solid #e0e3ea;
            padding: 12px 15px;
            font-size: 1rem;
        }
        
        .verification-input:focus {
            border-color: #6c5ce7;
            box-shadow: 0 0 0 2px rgba(108, 92, 231, 0.1);
        }
        
        .verification-btn {
            background-color: #6c5ce7;
            border: none;
            padding: 12px 20px;
            width: 100%;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .verification-btn:hover {
            background-color: #5a4bcf;
        }
        
        .verification-modal-body .alert {
            margin-top: 20px;
            padding: 15px;
            font-size: 1rem;
            border-radius: 8px;
        }
        
        .verification-modal-body .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .verification-modal-body .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .resend-code-btn {
            color: #6c5ce7;
            text-decoration: none;
            font-size: 0.9rem;
            border: none;
            background: none;
            padding: 0;
        }
        
        .resend-code-btn:hover {
            color: #5a4bcf;
            text-decoration: underline;
        }
        
        /* Validation Error Styles */
        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }
        
        .form-control.is-invalid + .invalid-feedback {
            display: block;
        }
        
        /* Disabled button styles */
        .btn-register:disabled {
            background: #6c757d !important;
            color: #fff !important;
            cursor: not-allowed !important;
            opacity: 0.6;
        }
        
        /* Disabled form styles */
        .form-disabled {
            opacity: 0.6;
            pointer-events: none;
        }
    </style>
</head>
<body>
   
    <div class="auth-main-row">
        <div class="auth-left">
            <div class="auth-left-content">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/homepageservlet">
                    
                    <span class="fw-bold">CES</span>
                </a>
                <h1>Welcome to CES</h1>
                <p>
                    Join us to build your dream PC and enjoy exclusive member benefits.<br>
                    Sign up now and start your journey!
                </p>
                <a href="PCBuilderServlet" class="btn btn-primary btn-lg" style="color: white">Build PC</a>
            </div>
        </div>
        <div class="auth-right">
            <div class="auth-form-box">
                <h2>Sign Up</h2>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert"><%= error %></div>
                <% } %>
                <% String registerMessage = (String) request.getAttribute("registerMessage"); %>
                <% if (registerMessage != null) { %>
                    <div class="alert alert-success" role="alert"><%= registerMessage %></div>
                <% } %>
                <div id="clientError" class="alert alert-danger" style="display:none;" role="alert"></div>

                <form action="register" method="post" id="registerForm">
                    <div class="form-col">
                        <label class="form-label" for="fullname">Full Name:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" required
                               value="${param.fullname != null ? param.fullname : (not empty fullname ? fullname : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               value="${param.email != null ? param.email : (not empty email ? email : '')}">
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="gender">Gender:</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="">-- Select gender --</option>
                            <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                        <div class="invalid-feedback" id="genderError"></div>
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="dateOfBirth">Date of Birth:</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required
                               value="${param.dateOfBirth != null ? param.dateOfBirth : ''}">
                        <div class="invalid-feedback" id="dateOfBirthError"></div>
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="phone">Phone Number:</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required
                               value="${param.phone != null ? param.phone : (not empty phone ? phone : '')}">
                        <div class="invalid-feedback" id="phoneError"></div>
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                        <div class="invalid-feedback" id="passwordError"></div>
                    </div>
                    <div class="form-col">
                        <label class="form-label" for="confirmPassword">Confirm Password:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        <div class="invalid-feedback" id="confirmPasswordError"></div>
                    </div>
                    <div class="form-col-full">
                        <label class="form-label">Shipping Address:</label>
                        <div style="display: flex; gap: 8px;">
                            <select id="province" name="province" class="form-control" required style="flex:1; min-width:0;">
                                <option value="">-- Select province --</option>
                            </select>
                            <select id="district" name="district" class="form-control" required disabled style="flex:1; min-width:0;">
                                <option value="">-- Select district --</option>
                            </select>
                            <select id="ward" name="ward" class="form-control" required disabled style="flex:1; min-width:0;">
                                <option value="">-- Select ward --</option>
                            </select>
                        </div>
                        <div class="invalid-feedback" id="provinceError"></div>
                        <div class="invalid-feedback" id="districtError"></div>
                        <div class="invalid-feedback" id="wardError"></div>
                    </div>
                    <div class="form-col-full">
                        <label class="form-label" for="addressDetail">Address Detail:</label>
                        <input type="text" class="form-control" id="addressDetail" name="addressDetail"
                               value="${param.addressDetail != null ? param.addressDetail : (not empty addressDetail ? addressDetail : '')}">
                        <div class="invalid-feedback" id="addressDetailError"></div>
                    </div>
                    
                    <!-- Hidden inputs to ensure address values are always sent -->
                    <input type="hidden" id="provinceHidden" name="provinceHidden">
                    <input type="hidden" id="districtHidden" name="districtHidden">
                    <input type="hidden" id="wardHidden" name="wardHidden">
                    
                    <button type="submit" class="btn-register">Sign Up</button>
                </form>
                <div class="login-link">
                    <p>Already have an account? <a href="login.jsp">Login now</a></p>
                </div>
                <!-- Popup nhập mã xác thực -->
                <div class="modal fade" id="verificationModal" tabindex="-1" aria-labelledby="verificationModalLabel" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="verificationModalLabel">Enter verification code</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <form action="check-verification" method="post">
                        <div class="modal-body">
                          <div class="mb-3">
                            <label for="verificationCode" class="form-label">Verification code sent to your email:</label>
                            <input type="text" class="form-control" id="verificationCode" name="code" required maxlength="6">
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="submit" class="btn btn-primary">Verify</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>

                <!-- Verification Modal với thiết kế mới -->
                <div class="modal fade" id="verificationModalNew" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="verificationModalNewLabel" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content verification-modal-content">
                      <div class="modal-header verification-modal-header">
                        <h4 class="modal-title" id="verificationModalNewLabel">Enter the 6-digit code</h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body verification-modal-body">
                        <form action="check-verification" method="post" id="verificationForm">
                          <div class="mb-3">
                            <input type="text" class="form-control verification-input" name="code" maxlength="6" pattern="\d{6}" required placeholder="Verification code" />
                          </div>
                          <button type="submit" class="btn btn-primary verification-btn">Verify</button>
                        </form>
                        <div class="text-center mt-3">
                          <button type="button" class="btn btn-link resend-code-btn" onclick="resendVerificationCode()">Resend Code</button>
                        </div>
                        <!-- Display error message if exists -->
                        <c:if test="${not empty error}">
                          <div class="alert alert-danger mt-3">${error}</div>
                        </c:if>
                        <!-- Display success message if exists -->
                        <c:if test="${not empty message}">
                          <div class="alert alert-success mt-3">${message}</div>
                        </c:if>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Loading Modal -->
                <div class="modal fade" id="loadingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="loadingModalLabel" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered modal-sm">
                    <div class="modal-content">
                      <div class="modal-body text-center">
                        <div class="spinner-border text-primary mb-3" role="status">
                          <span class="visually-hidden">Loading...</span>
                        </div>
                        <h6 class="modal-title" id="loadingModalLabel">Processing Registration...</h6>
                        <p class="text-muted small" id="loadingModalText">Please wait while we create your account and send verification code</p>
                        <p class="text-muted small" id="loadingModalSubtext">Do not close this window or refresh the page</p>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
        </div>
    </div>
    <% if (request.getAttribute("showVerificationPopup") != null) { %>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
      // Hide loading modal and show verification popup immediately
      const loadingModal = bootstrap.Modal.getInstance(document.getElementById('loadingModal'));
      if (loadingModal) {
        loadingModal.hide();
      }
      
      // Show verification popup
      var myModal = new bootstrap.Modal(document.getElementById('verificationModalNew'));
      myModal.show();
    });
    </script>
    <% } %>
    <script src="vietnam-provinces.json" type="application/json" id="locationsData"></script>
    <script>
    let locationsData = [];
    document.addEventListener('DOMContentLoaded', function() {
      fetch('vietnam-provinces.json')
        .then(response => response.json())
        .then(data => {
          locationsData = data;
          populateProvinces();
        });

      const provinceSelect = document.getElementById('province');
      const districtSelect = document.getElementById('district');
      const wardSelect = document.getElementById('ward');

      function populateProvinces() {
        provinceSelect.innerHTML = '<option value="">-- Select province --</option>';
        locationsData.forEach(province => {
          const option = document.createElement('option');
          option.value = province.name;
          option.textContent = province.name;
          provinceSelect.appendChild(option);
        });
        districtSelect.innerHTML = '<option value="">-- Select district --</option>';
        districtSelect.disabled = true;
        wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
        wardSelect.disabled = true;
      }

      provinceSelect.addEventListener('change', function() {
        const selectedProvince = locationsData.find(p => p.name === this.value);
        if (selectedProvince) {
          districtSelect.innerHTML = '<option value="">-- Select district --</option>';
          selectedProvince.districts.forEach(district => {
            const option = document.createElement('option');
            option.value = district.name;
            option.textContent = district.name;
            districtSelect.appendChild(option);
          });
          districtSelect.disabled = false;
          wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
          wardSelect.disabled = true;
        } else {
          districtSelect.innerHTML = '<option value="">-- Select district --</option>';
          districtSelect.disabled = true;
          wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
          wardSelect.disabled = true;
        }
      });

      districtSelect.addEventListener('change', function() {
        const selectedProvince = locationsData.find(p => p.name === provinceSelect.value);
        if (selectedProvince) {
          const selectedDistrict = selectedProvince.districts.find(d => d.name === this.value);
          if (selectedDistrict) {
            wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
            selectedDistrict.wards.forEach(ward => {
              const option = document.createElement('option');
              option.value = ward.name;
              option.textContent = ward.name;
              wardSelect.appendChild(option);
            });
            wardSelect.disabled = false;
          } else {
            wardSelect.innerHTML = '<option value="">-- Select ward --</option>';
            wardSelect.disabled = true;
          }
        }
      });

      // After locationsData is loaded and dropdowns are populated
      const paramProvince = "${param.province != null ? param.province : (not empty province ? province : '')}";
      const paramDistrict = "${param.district != null ? param.district : (not empty district ? district : '')}";
      const paramWard = "${param.ward != null ? param.ward : (not empty ward ? ward : '')}";

      function setSelectedAddress() {
        if (paramProvince) {
          provinceSelect.value = paramProvince;
          provinceSelect.dispatchEvent(new Event('change'));
          setTimeout(() => {
            if (paramDistrict) {
              districtSelect.value = paramDistrict;
              districtSelect.dispatchEvent(new Event('change'));
              setTimeout(() => {
                if (paramWard) {
                  wardSelect.value = paramWard;
                }
              }, 100);
            }
          }, 100);
        }
      }

      // Call after dropdowns are populated
      setTimeout(setSelectedAddress, 300);
    });
    </script>
    <script>
        function validateEmail(email) {
            const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return re.test(email) && email.length <= 100;
        }

        function validatePassword(password) {
            const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            return re.test(password);
        }

        function validateVietnamesePhone(phone) {
            // Vietnamese phone number format: 0xxxxxxxxx (10 digits starting with 0) or +84...
            const re = /^(0|\+84)(3[2-9]|5[6|8|9]|7[0|6-9]|8[1-5]|9[0-9])[0-9]{7}$/;
            return re.test(phone);
        }

        function validateFullName(name) {
            if (!name || name.trim() === '') return false;
            if (name.length > 50) return false;
            return true;
        }

        function validateGender(gender) {
            return gender && gender !== '';
        }

        function validateDateOfBirth(dateOfBirth) {
            if (!dateOfBirth || dateOfBirth.trim() === '') return false;
            
            // Check if date is in the past and user is at least 13 years old
            const today = new Date();
            const birthDate = new Date(dateOfBirth);
            const age = today.getFullYear() - birthDate.getFullYear();
            const monthDiff = today.getMonth() - birthDate.getMonth();
            
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            
            return age >= 13 && age <= 120;
        }

        function validateAddressField(fieldValue) {
            if (!fieldValue || fieldValue.trim() === '') {
                return "This field is required.";
            }
            if (fieldValue.length < 2 || fieldValue.length > 100) {
                return "Length must be between 2 and 100 characters.";
            }
            // Check for dangerous characters
            const dangerousChars = /[<>{}[]\\$%]/;
            if (dangerousChars.test(fieldValue)) {
                return "Contains invalid characters (<, >, {, }, [, ], \\, $, %).";
            }
            return null; // Valid
        }

        function showFieldError(fieldId, errorMessage) {
            const field = document.getElementById(fieldId);
            const errorDiv = document.getElementById(fieldId + 'Error');
            field.classList.add('is-invalid');
            errorDiv.textContent = errorMessage;
            errorDiv.style.display = 'block';
        }

        function clearFieldError(fieldId) {
            const field = document.getElementById(fieldId);
            const errorDiv = document.getElementById(fieldId + 'Error');
            field.classList.remove('is-invalid');
            errorDiv.style.display = 'none';
        }

        const registerForm = document.getElementById('registerForm');
        let isSubmitting = false; // Track submission status
        
        if (registerForm) {
            console.log('Register form found, adding event listener...');
            registerForm.addEventListener('submit', function (event) {
                console.log('Form submitted, isSubmitting:', isSubmitting);
                // Prevent duplicate submission
                if (isSubmitting) {
                    event.preventDefault();
                    console.log('Preventing duplicate submission');
                    return;
                }
                
                isSubmitting = true;
                console.log('Setting isSubmitting to true');
                
                // Show loading modal immediately for sending verification code
                const loadingModalElement = document.getElementById('loadingModal');
                const loadingLabel = document.getElementById('loadingModalLabel');
                const loadingText = document.getElementById('loadingModalText');
                const loadingSubtext = document.getElementById('loadingModalSubtext');
                
                if (loadingModalElement) {
                    // Update loading modal content for verification
                    if (loadingLabel) loadingLabel.textContent = 'Sending verification code...';
                    if (loadingText) loadingText.textContent = 'Please wait while we send the verification code to your email';
                    if (loadingSubtext) loadingSubtext.textContent = 'Please check your email inbox';
                    
                    const loadingModal = new bootstrap.Modal(loadingModalElement);
                    console.log('Showing loading modal immediately for verification...');
                    loadingModal.show();
                }
                
                const fullname = document.getElementById('fullname').value;
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const phone = document.getElementById('phone').value;
                const gender = document.getElementById('gender').value;
                const dateOfBirth = document.getElementById('dateOfBirth').value;
                const addressDetail = document.getElementById('addressDetail').value;
                const ward = document.getElementById('ward').value;
                const district = document.getElementById('district').value;
                const province = document.getElementById('province').value;
                const errorDiv = document.getElementById('clientError');
                let hasFieldErrors = false;

                // Copy dropdown values to hidden inputs to ensure they are sent
                document.getElementById('provinceHidden').value = province;
                document.getElementById('districtHidden').value = district;
                document.getElementById('wardHidden').value = ward;

                // Clear all field errors first
                clearFieldError('fullname');
                clearFieldError('email');
                clearFieldError('password');
                clearFieldError('confirmPassword');
                clearFieldError('phone');
                clearFieldError('gender');
                clearFieldError('dateOfBirth');
                clearFieldError('addressDetail');
                clearFieldError('ward');
                clearFieldError('district');
                clearFieldError('province');

                // Validate fullname
                if (!validateFullName(fullname)) {
                    showFieldError('fullname', 'Full Name is required and must not exceed 50 characters.');
                    hasFieldErrors = true;
                }

                // Validate email
                if (!validateEmail(email)) {
                    showFieldError('email', 'Invalid email. Please enter a valid email address (max 100 characters).');
                    hasFieldErrors = true;
                }

                // Validate gender
                if (!validateGender(gender)) {
                    showFieldError('gender', 'Please select your gender.');
                    hasFieldErrors = true;
                }

                // Validate date of birth
                if (!validateDateOfBirth(dateOfBirth)) {
                    showFieldError('dateOfBirth', 'Please enter a valid date of birth. You must be at least 13 years old.');
                    hasFieldErrors = true;
                }

                // Validate password
                if (!validatePassword(password)) {
                    showFieldError('password', 'Password must be at least 8 characters long, including uppercase, lowercase, numbers and special characters.');
                    hasFieldErrors = true;
                }

                // Validate password confirmation
                if (password !== confirmPassword) {
                    showFieldError('confirmPassword', 'Password confirmation does not match.');
                    hasFieldErrors = true;
                }

                // Validate phone number
                if (!validateVietnamesePhone(phone)) {
                    showFieldError('phone', 'Please enter a valid Vietnamese phone number.');
                    hasFieldErrors = true;
                }

                // Validate addressDetail (optional)
                if (addressDetail && addressDetail.trim() !== '') {
                    if (addressDetail.length < 2 || addressDetail.length > 100) {
                        showFieldError('addressDetail', 'Length must be between 2 and 100 characters.');
                        hasFieldErrors = true;
                    } else {
                        const dangerousChars = /[<>{}[\\]$%]/;
                        if (dangerousChars.test(addressDetail)) {
                            showFieldError('addressDetail', 'Contains invalid characters (<, >, {, }, [, ], \\, $, %).');
                            hasFieldErrors = true;
                        }
                    }
                }

                // Validate address dropdowns
                if (!province) {
                    showFieldError('province', 'Please select a province/city.');
                    hasFieldErrors = true;
                }
                if (!district) {
                    showFieldError('district', 'Please select a district.');
                    hasFieldErrors = true;
                }
                if (!ward) {
                    showFieldError('ward', 'Please select a ward/commune.');
                    hasFieldErrors = true;
                }

                if (hasFieldErrors) {
                    console.log('Validation errors found, preventing submission');
                    event.preventDefault();
                    errorDiv.innerHTML = 'Please correct the errors above.';
                    errorDiv.style.display = 'block';
                    isSubmitting = false; // Reset submission status
                    
                    // Hide loading modal if validation fails
                    const loadingModal = bootstrap.Modal.getInstance(document.getElementById('loadingModal'));
                    if (loadingModal) {
                        loadingModal.hide();
                    }
                } else {
                    console.log('No validation errors, proceeding with submission');
                    errorDiv.style.display = 'none';
                    
                    // Disable form để tránh duplicate submission
                    const submitButton = registerForm.querySelector('button[type="submit"]');
                    submitButton.disabled = true;
                    submitButton.textContent = 'Signing Up...';
                    
                    // Disable tất cả input fields
                    const inputs = registerForm.querySelectorAll('input, select');
                    inputs.forEach(input => {
                        input.disabled = true;
                    });
                    
                    // Add disabled class to form
                    registerForm.classList.add('form-disabled');
                    
                    // Submit form immediately (loading already shown)
                    setTimeout(() => {
                        console.log('Submitting form...');
                        registerForm.submit();
                    }, 100);
                    
                    // Timeout để tự động ẩn loading modal nếu có lỗi (30 giây)
                    setTimeout(() => {
                        if (isSubmitting) {
                            const loadingModal = bootstrap.Modal.getInstance(document.getElementById('loadingModal'));
                            if (loadingModal) {
                                loadingModal.hide();
                            }
                            // Re-enable form
                            isSubmitting = false;
                            submitButton.disabled = false;
                            submitButton.textContent = 'Sign Up';
                            inputs.forEach(input => {
                                input.disabled = false;
                            });
                            registerForm.classList.remove('form-disabled');
                        }
                    }, 30000);
                }
            });
        }
    </script>
    
    <script>
        function resendVerificationCode() {
            const resendBtn = document.querySelector('.resend-code-btn');
            const email = document.getElementById('email').value;
            
            if (!email) {
                alert('Please enter your email address first');
                return;
            }
            
            // Disable button and show loading
            resendBtn.disabled = true;
            resendBtn.textContent = 'Sending...';
            
            // Show loading modal
            const loadingModal = new bootstrap.Modal(document.getElementById('loadingModal'));
            loadingModal.show();
            
            // Update loading modal content for verification
            const loadingLabel = document.getElementById('loadingModalLabel');
            const loadingText = document.getElementById('loadingModalText');
            const loadingSubtext = document.getElementById('loadingModalSubtext');
            if (loadingLabel) loadingLabel.textContent = 'Sending verification code...';
            if (loadingText) loadingText.textContent = 'Please wait while we send the verification code to your email';
            if (loadingSubtext) loadingSubtext.textContent = 'Please check your email inbox';
            
            // Send AJAX request to resend verification code
            fetch('send-verification', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'email=' + encodeURIComponent(email) + '&action=resend'
            })
            .then(response => response.text())
            .then(data => {
                // Hide loading modal
                loadingModal.hide();
                
                if (data === 'success') {
                    // Show success message in verification popup instead of alert
                    const verificationModal = document.getElementById('verificationModalNew');
                    if (verificationModal) {
                        const alertDiv = document.createElement('div');
                        alertDiv.className = 'alert alert-success mt-3';
                        alertDiv.innerHTML = '<i class="fa fa-check-circle me-2"></i>Verification code has been resent to your email';
                        
                        const modalBody = verificationModal.querySelector('.verification-modal-body');
                        if (modalBody) {
                            // Remove any existing success alerts
                            const existingAlerts = modalBody.querySelectorAll('.alert-success');
                            existingAlerts.forEach(alert => alert.remove());
                            
                            // Add new success alert
                            modalBody.appendChild(alertDiv);
                            
                            // Auto-remove alert after 5 seconds
                            setTimeout(() => {
                                if (alertDiv.parentNode) {
                                    alertDiv.remove();
                                }
                            }, 5000);
                        }
                    }
                } else {
                    alert('Failed to resend verification code: ' + data);
                }
                resendBtn.textContent = 'Resend Code';
                resendBtn.disabled = false;
            })
            .catch(error => {
                // Hide loading modal
                loadingModal.hide();
                
                alert('Failed to resend verification code. Please try again.');
                resendBtn.textContent = 'Resend Code';
                resendBtn.disabled = false;
            });
        }
        
        // Auto-focus on verification code input when modal opens
        document.addEventListener('DOMContentLoaded', function() {
            const verificationModal = document.getElementById('verificationModalNew');
            if (verificationModal) {
                verificationModal.addEventListener('shown.bs.modal', function () {
                    document.querySelector('.verification-input').focus();
                });
            }
        });
    </script>
</body>
</html>