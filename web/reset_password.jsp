<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Boolean verified = (Boolean) session.getAttribute("email_verified");
    String email = (String) session.getAttribute("verification_email");
    if (verified == null || !verified || email == null) {
        response.sendRedirect("send_email.jsp?action=reset");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset your password for: <%= email %></h2>
    <form action="reset-password" method="post">
        <input type="hidden" name="email" value="<%= email %>" />
        <input type="password" name="password" required placeholder="New password" />
        <input type="password" name="confirmPassword" required placeholder="Confirm new password" />
        <button type="submit">Change Password</button>
    </form>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
</body>
</html> 