<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh mục GearVN</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4">Danh mục sản phẩm GearVN</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${empty error}">
        <c:forEach var="cat" items="${categories}">
            <div class="card mb-3">
                <div class="card-header fw-bold">${cat.name}</div>
                <div class="card-body">
                    <c:if test="${empty cat.subCategories}">
                        <span class="text-muted">Không có submenu</span>
                    </c:if>
                    <c:forEach var="sub" items="${cat.subCategories}">
                        <h6 class="mt-3">${sub.title}</h6>
                        <ul>
                            <c:forEach var="item" items="${sub.items}">
                                <li>${item}</li>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>
</body>
</html> 