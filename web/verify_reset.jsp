<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  #verifyResetModal .modal-content {
    border-radius: 22px;
    box-shadow: 0 8px 32px rgba(44, 62, 80, 0.18), 0 1.5px 8px rgba(44,62,80,0.10);
    border: none;
    padding: 0;
    background: #fff;
    max-width: 420px;
    margin: auto;
  }
  #verifyResetModal .modal-header {
    background: linear-gradient(90deg, #7b2ff2 0%, #f357a8 100%);
    color: #fff;
    border-radius: 22px 22px 0 0;
    padding: 28px 32px 16px 32px;
    border-bottom: none;
    text-align: center;
    justify-content: center;
  }
  #verifyResetModal .modal-title {
    font-size: 1.7rem;
    font-weight: 800;
    margin: 0;
    letter-spacing: -1px;
    width: 100%;
  }
  #verifyResetModal .modal-body {
    padding: 28px 32px 24px 32px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  #verifyResetForm {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: stretch;
    gap: 14px;
    margin-bottom: 10px;
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
  }
  #verifyResetForm .form-control:focus {
    border-color: #7b2ff2;
    box-shadow: 0 0 0 2px rgba(123,47,242,0.08);
    background: #fff;
  }
  #verifyResetForm button[type="submit"] {
    border-radius: 10px;
    background: linear-gradient(90deg, #7b2ff2 0%, #f357a8 100%);
    color: #fff;
    font-weight: 700;
    font-size: 1.08rem;
    min-height: 42px;
    border: none;
    box-shadow: none;
    margin-top: 6px;
    transition: background 0.2s, color 0.2s;
  }
  #verifyResetForm button[type="submit"]:hover {
    background: linear-gradient(90deg, #f357a8 0%, #7b2ff2 100%);
    color: #fff;
  }
  #verifyResetModal .alert {
    width: 100%;
    text-align: center;
    margin-top: 12px;
    border-radius: 10px;
    font-size: 1rem;
    padding: 12px 8px;
  }
  @media (max-width: 600px) {
    #verifyResetModal .modal-content, #verifyResetModal .modal-body {
      padding: 10px 4vw !important;
      min-width: 90vw;
    }
    #verifyResetModal .modal-header {
      padding: 18px 4vw 10px 4vw;
    }
  }
</style>
<!-- BEGIN: Verify Reset Modal Fragment -->
<div class="modal fade" id="verifyResetModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="verifyResetModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title w-100 text-center" id="verifyResetModalLabel">Reset Your Password</h4>
      </div>
      <div class="modal-body">
        <form id="verifyResetForm" action="forget-password" method="post">
          <input type="hidden" name="action" value="verify" />
          <input type="text" class="form-control" name="code" maxlength="6" pattern="\d{6}" required placeholder="Verification code" />
          <input type="password" class="form-control" name="newPassword" minlength="8" required placeholder="New password (min 8 characters)" />
          <input type="password" class="form-control" name="confirmPassword" minlength="8" required placeholder="Confirm new password" />
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
</div>
<!-- END: Verify Reset Modal Fragment --> 