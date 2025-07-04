<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="card stat-card">
    <div class="card-body">
        <h5 class="card-title">Hồ sơ cá nhân</h5>
        <p>
            <strong>Tên:</strong> ${data.name}
        </p>
        <p>
            <strong>Email:</strong> ${data.email}
            <button type="button" onclick="showEditEmailModal()">Edit</button>
        </p>
        <p>
            <strong>Số điện thoại:</strong> ${data.phone}
            <button type="button" onclick="showEditPhoneModal()">Edit</button>
        </p>
        <p><strong>Địa chỉ giao hàng:</strong> ${data.shipping_address}</p>
        <button>Submit</button>
    </div>               
</div>

<!-- Email Edit Modal -->
<div id="editEmailModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form id="editEmailForm" onsubmit="submitNewEmail(event)">
        <label>Nhập email mới:</label>
        <input type="email" id="newEmailInput" required>
        <button type="submit">Gửi xác nhận</button>
        <button type="button" onclick="closeEditEmailModal()">Hủy</button>
    </form>
</div>
<!-- Token Modal -->
<div id="tokenModal" style="display:none; position:fixed; top:35%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1001;">
    <form id="tokenForm" onsubmit="submitToken(event)">
        <label>Nhập mã xác nhận đã gửi tới email cũ:</label>
        <input type="text" id="tokenInput" required>
        <button type="submit">Xác nhận</button>
        <button type="button" onclick="closeTokenModal()">Hủy</button>
    </form>
</div>
<!-- Phone Edit Modal -->
<div id="editPhoneModal" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1000;">
    <form id="editPhoneForm" onsubmit="submitNewPhone(event)">
        <label>Nhập số điện thoại mới:</label>
        <input type="tel" id="newPhoneInput" required pattern="[0-9]{9,15}">
        <button type="submit">Gửi xác nhận</button>
        <button type="button" onclick="closeEditPhoneModal()">Hủy</button>
    </form>
</div>
<!-- Phone Token Modal -->
<div id="phoneTokenModal" style="display:none; position:fixed; top:35%; left:50%; transform:translate(-50%,-50%); background:#fff; padding:20px; border:1px solid #ccc; z-index:1001;">
    <form id="phoneTokenForm" onsubmit="submitPhoneToken(event)">
        <label>Nhập mã xác nhận đã gửi tới email của bạn:</label>
        <input type="text" id="phoneTokenInput" required>
        <button type="submit">Xác nhận</button>
        <button type="button" onclick="closePhoneTokenModal()">Hủy</button>
    </form>
</div>
<div id="modalOverlay" style="display:none; position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.3); z-index:999;"></div>

<script>
function showEditEmailModal() {
    document.getElementById('editEmailModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
}
function closeEditEmailModal() {
    document.getElementById('editEmailModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}
function showEditPhoneModal() {
    document.getElementById('editPhoneModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
}
function closeEditPhoneModal() {
    document.getElementById('editPhoneModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}

// AJAX: Send new email to server
function submitNewEmail(event) {
    event.preventDefault();
    var newEmail = document.getElementById('newEmailInput').value;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=editEmail&newEmail=' + encodeURIComponent(newEmail)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            closeEditEmailModal();
            showTokenModal();
        } else {
            alert(data.error || 'Có lỗi xảy ra!');
        }
    });
}

// Show token modal
function showTokenModal() {
    document.getElementById('tokenModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
}
function closeTokenModal() {
    document.getElementById('tokenModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}

// AJAX: Submit token to server
function submitToken(event) {
    event.preventDefault();
    var token = document.getElementById('tokenInput').value;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=verifyEmailToken&token=' + encodeURIComponent(token)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            closeTokenModal();
            window.location.reload();
        } else {
            alert(data.error || 'Sai mã xác nhận!');
        }
    });
}

// AJAX: Send new phone to server
function submitNewPhone(event) {
    event.preventDefault();
    var newPhone = document.getElementById('newPhoneInput').value;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=editPhone&newPhone=' + encodeURIComponent(newPhone)
    })
    .then(res => res.json())
    .then (data => {
        if (data.success) {
            closeEditPhoneModal();
            showPhoneTokenModal();
        } else {
            alert(data.error || 'Có lỗi xảy ra!');
        }
    });
}

function showPhoneTokenModal() {
    document.getElementById('phoneTokenModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
}
function closePhoneTokenModal() {
    document.getElementById('phoneTokenModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
}

// AJAX: Submit phone token to server
function submitPhoneToken(event) {
    event.preventDefault();
    var token = document.getElementById('phoneTokenInput').value;
    fetch('editProfile', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=verifyPhoneToken&token=' + encodeURIComponent(token)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            closePhoneTokenModal();
            window.location.reload();
        } else {
            alert(data.error || 'Sai mã xác nhận!');
        }
    });
}
</script>
