<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .voucher-list {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-top: 20px;
    }
    .voucher-item {
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 10px;
        background-color: #f9f9f9;
    }
    .voucher-header {
        font-weight: bold;
        font-size: 16px;
        color: #007BFF;
        margin-bottom: 8px;
    }
    .voucher-detail {
        margin-bottom: 5px;
        font-size: 14px;
    }
</style>

<div class="card stat-card">
    <div class="card-body">
        <h5 class="card-title">Danh sách Voucher của bạn</h5>

        <c:choose>
            <c:when test="${empty vouchers}">
                <p>Bạn chưa có voucher nào.</p>
            </c:when>
            <c:otherwise>
                <div class="voucher-list">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="voucher-item">
                            <div class="voucher-header">${v.code}</div>
                            <div class="voucher-detail">📄 <strong>Mô tả:</strong> ${v.description}</div>
                            <div class="voucher-detail">🎯 <strong>Loại giảm:</strong> 
                                <c:choose>
                                    <c:when test="${v.discount_type == 'percent'}">
                                        ${v.discount_value}% giảm giá
                                    </c:when>
                                    <c:otherwise>
                                        ${v.discount_value} VND giảm cố định
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="voucher-detail">💵 <strong>Đơn tối thiểu:</strong> ${v.min_order_amount} VND</div>
                            <div class="voucher-detail">📅 <strong>Thời gian:</strong> 
                                <fmt:formatDate value="${v.start_date}" pattern="dd/MM/yyyy" /> - 
                                <fmt:formatDate value="${v.end_date}" pattern="dd/MM/yyyy" />
                            </div>
                            <div class="voucher-detail">🔖 <strong>Trạng thái:</strong> ${v.status}</div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>