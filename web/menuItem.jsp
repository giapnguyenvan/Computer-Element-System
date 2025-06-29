<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách Menu Item</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .menu-list {
            width: 260px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 8px 0;
            margin: 0;
            list-style: none;
        }
        .menu-list li {
            display: flex;
            align-items: center;
            padding: 10px 18px;
            font-size: 16px;
            color: #222;
            cursor: pointer;
            border-radius: 6px;
            transition: background 0.2s;
        }
        .menu-list li:hover {
            background: #f5f5f5;
        }
        .menu-list .menu-icon {
            width: 24px;
            text-align: center;
            margin-right: 12px;
            font-size: 18px;
        }
        .menu-list .arrow {
            margin-left: auto;
            color: #bbb;
            font-size: 14px;
        }
        .menu-list a {
            color: inherit;
            text-decoration: none;
            flex: 1;
        }
    </style>
</head>
<body>
    <ul class="menu-list">
        <c:forEach var="item" items="${menuItems}">
            <li>
                <span class="menu-icon">
                    <c:if test="${not empty item.icon}">
                        <i class="${item.icon}"></i>
                    </c:if>
                </span>
                <a href="${pageContext.request.contextPath}${item.url}">${item.name}</a>
                <span class="arrow"><i class="fa-solid fa-angle-right"></i></span>
            </li>
        </c:forEach>
    </ul>
</body>
</html> 