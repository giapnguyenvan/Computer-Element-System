<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Send Verification Email</title>
</head>
<body>
    <h2>Enter your email to receive a verification code</h2>
    <form action="send-verification" method="post">
        <input type="email" name="email" required placeholder="Your email" />
        <input type="hidden" name="action" value="${param.action != null ? param.action : 'register'}" />
        <button type="submit">Send Code</button>
    </form>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
</body>
</html> 