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
        <div class="account-container">
            <h2 class="account-title">Thông tin tài khoản</h2>

            <div class="table-responsive">
                <table class="table table-bordered table-hover account-table">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty data}">
                                <c:forEach var="customer" items="${data}">
                                    <tr>
                                        <td>${customer.customer_id}</td>
                                        <td>${customer.name}</td>
                                        <td>${customer.email}</td>
                                        <td>${customer.phone}</td>
                                        <td>${customer.shipping_address}</td>
                                        <td>
                                            <a href="editCustomer?id=${customer.customer_id}" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                            <a href="changePassword?id=${customer.customer_id}" class="btn btn-sm btn-info">
                                                <i class="fas fa-key"></i> Đổi MK
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center text-muted">Không có dữ liệu khách hàng</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <style>
            .account-container {
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                margin: 20px auto;
                max-width: 1200px;
            }
            .account-title {
                color: #2c3e50;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            .account-table {
                font-size: 0.95rem;
            }
            .account-table th {
                font-weight: 600;
                white-space: nowrap;
            }
            .table-responsive {
                overflow-x: auto;
            }
        </style>
    </body>
</html>