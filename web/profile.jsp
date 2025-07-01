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
    <form id="editEmailForm" method="post" action="editProfile">
        <label>Nhập email mới:</label>
        <input type="email" name="newEmail" required>
        <input type="hidden" name="action" value="editEmail">
        <button type="submit">Gửi xác nhận</button>
        <button type="button" onclick="closeEditEmailModal()">Hủy</button>
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
    alert('Chức năng cập nhật số điện thoại đang phát triển!');
}
</script>
