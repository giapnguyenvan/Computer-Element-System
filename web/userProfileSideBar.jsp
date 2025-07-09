<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("customerAuth");
%>
<!-- Sidebar -->
<div class="col-md-3 col-lg-2 sidebar">
    <nav>
        <a href="${pageContext.request.contextPath}/userprofile?action=profile" class="${param.activePage == 'profile' ? 'active' : ''}">
            <i class="fas fa-user me-2"></i> Hồ sơ
        </a>
        <a href="${pageContext.request.contextPath}/userprofile?action=address" class="${param.activePage == 'address' ? 'active' : ''}">
            <i class="fas fa-map-marker-alt me-2"></i> Địa chỉ
        </a>
        <a href="${pageContext.request.contextPath}/userprofile?action=orders" class="${param.activePage == 'orders' ? 'active' : ''}">
            <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/userprofile?action=voucher" class="${param.activePage == 'voucher' ? 'active' : ''}">
            <i class="fas fa-ticket me-2"></i> Voucher
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
        </a>
    </nav>
</div>