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
        <h5 class="card-title">Your Vouchers</h5>

        <c:choose>
            <c:when test="${empty vouchers}">
                <p>You don't have any vouchers yet.</p>
            </c:when>
            <c:otherwise>
                <div class="voucher-list">
                    <c:forEach var="v" items="${vouchers}">
                        <div class="voucher-item">
                            <div class="voucher-header">${v.code}</div>
                            <div class="voucher-detail">📄 <strong>Description:</strong> ${v.description}</div>
                            <div class="voucher-detail">🎯 <strong>Discount Type:</strong> 
                                <c:choose>
                                    <c:when test="${v.discount_type == 'percent'}">
                                        ${v.discount_value}% discount
                                    </c:when>
                                    <c:otherwise>
                                        ${v.discount_value} VND fixed discount
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="voucher-detail">💵 <strong>Minimum Order:</strong> ${v.min_order_amount} VND</div>
                            <div class="voucher-detail">📅 <strong>Valid Period:</strong> 
                                <fmt:formatDate value="${v.start_date}" pattern="dd/MM/yyyy" /> - 
                                <fmt:formatDate value="${v.end_date}" pattern="dd/MM/yyyy" />
                            </div>
                            <div class="voucher-detail">🔖 <strong>Status:</strong> ${v.status}</div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>