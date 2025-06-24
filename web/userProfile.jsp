<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thông tin khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h3>Thông tin khách hàng</h3>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty sessionScope.customerAuth}">
                        <%-- Sử dụng customerAuth từ session --%>
                        <div class="mb-3">
                            <label class="form-label">ID Khách hàng:</label>
                            <p class="form-control-static">${sessionScope.customerAuth.customer_id}</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên:</label>
                            <p class="form-control-static">${sessionScope.customerAuth.name}</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <p class="form-control-static">${sessionScope.customerAuth.email}</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại:</label>
                            <p class="form-control-static">${sessionScope.customerAuth.phone}</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ giao hàng:</label>
                            <p class="form-control-static">${sessionScope.customerAuth.shipping_address}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning">
                            Bạn chưa đăng nhập. Vui lòng <a href="login.jsp">đăng nhập</a> để xem thông tin.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>