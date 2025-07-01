<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("userAuth");
%>
<!-- Staff Sidebar -->
<div class="col-md-3 col-lg-2 sidebar">
    <!-- Staff Profile -->
    <div class="staff-profile d-flex align-items-center" style="padding-top: 36px;">
        <img src="${pageContext.request.contextPath}/assets/admin-avartar.png.jpg" alt="Staff Avatar" class="staff-avatar" style="width:50px;height:50px;border-radius:50%;object-fit:cover;background:#e0e7ff;">
        <div class="staff-info">
            <h6>${user.fullname}</h6>
            <small>Staff Member</small>
        </div>
    </div>

    <nav>
        <a href="${pageContext.request.contextPath}/staffservlet" class="<%= request.getRequestURI().endsWith("staffservlet") ? "active" : "" %>">
            <i class="fas fa-home me-2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/productservlet" target="mainFrame" class="<%= request.getRequestURI().contains("productservlet") ? "active" : "" %>">
            <i class="fas fa-box me-2"></i> Products
        </a>
        <a href="${pageContext.request.contextPath}/manageblogs" target="mainFrame" class="<%= request.getRequestURI().contains("viewblogs") ? "active" : "" %>">
            <i class="fas fa-blog me-2"></i> Blogs
        </a>
        <a href="${pageContext.request.contextPath}/managefeedback" target="mainFrame" class="<%= request.getRequestURI().contains("managefeedback") ? "active" : "" %>">
            <i class="fas fa-comments me-2"></i> Feedbacks
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </nav>
</div> 