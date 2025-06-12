<%-- 
    Document   : jsp
    Created on : May 30, 2025, 4:44:51 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger" >${sessionScope.error}</div>
    </c:if>
    </body>
</html>
