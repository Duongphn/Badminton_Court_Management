<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sân</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        body{margin-left:260px;}
        .container{padding-top:20px;}
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Chi tiết sân</h2>
    <c:if test="${not empty court}">
        <table class="table table-bordered">
            <tr><th>ID</th><td>${court.court_id}</td></tr>
            <tr><th>Số sân</th><td>${court.court_number}</td></tr>
            <tr><th>Loại</th><td>${court.type}</td></tr>
            <tr><th>Chất liệu sàn</th><td>${court.floor_material}</td></tr>
            <tr><th>Chiếu sáng</th><td>${court.lighting}</td></tr>
            <tr><th>Mô tả</th><td>${court.description}</td></tr>
            <tr><th>Ảnh</th>
                <td><c:if test='${not empty court.image_url}'><img src='${pageContext.request.contextPath}/${court.image_url}' width='300'/></c:if></td></tr>
            <tr><th>Trạng thái</th><td>${court.status}</td></tr>
            <tr><th>Area ID</th><td>${court.area_id}</td></tr>
        </table>
    </c:if>
    <a href="javascript:history.back()" class="btn btn-secondary">Quay lại</a>
</div>
</body>
</html>
