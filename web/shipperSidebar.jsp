<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("userAuth");
%>
<!-- Shipper Sidebar -->
<div class="col-md-3 col-lg-2 sidebar">
    <!-- Shipper Profile -->
    <div class="shipper-profile d-flex align-items-center" style="padding-top: 36px;">
        <img src="${pageContext.request.contextPath}/assets/admin-avartar.png.jpg" alt="Shipper Avatar" class="shipper-avatar" style="width:50px;height:50px;border-radius:50%;object-fit:cover;background:#e0e7ff;">
        <div class="shipper-info">
            <h6>${user.fullname}</h6>
            <small>Shipper</small>
        </div>
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/shipperdashboard" class="<%= request.getRequestURI().endsWith("shipperdashboard") ? "active" : "" %>">
            <i class="fas fa-home me-2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/shipperorderservlet" target="mainFrame" class="<%= request.getRequestURI().contains("shipperorderservlet") ? "active" : "" %>">
            <i class="fas fa-truck me-2"></i> Đơn hàng giao
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </nav>
</div> 