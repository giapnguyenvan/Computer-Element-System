<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("userAuth");
%>
<!-- Sidebar -->
<div class="col-md-3 col-lg-2 sidebar">
    <!-- Đã xóa logo-container và chữ CES -->

    <!-- Admin Profile -->
    <div class="admin-profile d-flex align-items-center" style="padding-top: 36px;">
        <img src="${pageContext.request.contextPath}/assets/admin-avartar.png.jpg" alt="Admin Avatar" class="admin-avatar" style="width:50px;height:50px;border-radius:50%;object-fit:cover;background:#e0e7ff;">
        <div class="admin-info">
            <h6>${user.fullname}</h6>
            <small>Administrator</small>
        </div>
    </div>

    <nav>
        <a href="${pageContext.request.contextPath}/adminservlet" class="<%= request.getRequestURI().endsWith("adminservlet") ? "active" : ""%>">
            <i class="fas fa-home me-2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/Account" target="mainFrame" class="<%= request.getRequestURI().contains("Account") ? "active" : ""%>">
            <i class="fas fa-user-gear me-2"></i> Accounts
        </a>
        <a href="${pageContext.request.contextPath}/category?sort=default" target="mainFrame" class="<%= request.getRequestURI().endsWith("categoryList.jsp") ? "active" : ""%>">
            <i class="fas fa-boxes me-2"></i> Categories
        </a>

        <!-- Menu Management Dropdown -->
        <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle <%= request.getRequestURI().contains("menuItemManagement") || request.getRequestURI().contains("menuAttributeManagement") || request.getRequestURI().contains("menuAttributeValueManagement") ? "active" : ""%>" href="#" id="navbarDropdownMenuManagement" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-bars me-2"></i> Menu Management
            </a>
            <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDropdownMenuManagement">
                <li><a class="dropdown-item <%= request.getRequestURI().contains("menuItemManagement") ? "active" : ""%>" href="${pageContext.request.contextPath}/menuItemManagement" target="mainFrame">Menu Level 1</a></li>
                <li><a class="dropdown-item <%= request.getRequestURI().contains("menuAttributeManagement") ? "active" : ""%>" href="${pageContext.request.contextPath}/menuAttributeManagement" target="mainFrame">Menu Level 2</a></li>
                <li><a class="dropdown-item <%= request.getRequestURI().contains("menuAttributeValueManagement") ? "active" : ""%>" href="${pageContext.request.contextPath}/menuAttributeValueManagement" target="mainFrame">Menu Level 3</a></li>
            </ul>
        </div>

        <a href="${pageContext.request.contextPath}/productservlet" target="mainFrame" class="<%= request.getRequestURI().contains("productservlet") ? "active" : ""%>">
            <i class="fas fa-box me-2"></i> Products
        </a>
        <a href="${pageContext.request.contextPath}/manageblogs" target="mainFrame" class="<%= request.getRequestURI().contains("viewblogs") ? "active" : ""%>">
            <i class="fas fa-blog me-2"></i> Blogs
        </a>
        <a href="${pageContext.request.contextPath}/managefeedback" target="mainFrame" class="<%= request.getRequestURI().contains("managefeedback") ? "active" : ""%>">
            <i class="fas fa-comments me-2"></i> Feedbacks
        </a>
        <a href="${pageContext.request.contextPath}/manageshipper" target="mainFrame" class="<%= request.getRequestURI().contains("managefeedback") ? "active" : ""%>">
            <i class="fas fa-truck me-2"></i>Shipper
        </a>
        <a href="${pageContext.request.contextPath}/managevouchers" target="mainFrame" class="<%= request.getRequestURI().contains("managefeedback") ? "active" : ""%>">
            <i class="fas fa-ticket-alt me-2"></i>Vouchers
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </nav>
</div>