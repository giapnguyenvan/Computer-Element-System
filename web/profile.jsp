<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="card stat-card">
    <div class="card-body">
        <h5 class="card-title">Hồ sơ cá nhân</h5>
        <p><strong>Tên:</strong> ${data.name}</p>
        <p><strong>Email:</strong> ${data.email}</p>
        <p><strong>Số điện thoại:</strong> ${data.phone}</p>
        <p><strong>Địa chỉ giao hàng:</strong> ${data.shipping_address}</p>
        <button>Submit</button>
    </div>               
</div>
