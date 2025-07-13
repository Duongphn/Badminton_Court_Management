<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-3">Xác nhận đặt sân</h2>
    <div class="mb-2"><strong>Khách hàng:</strong> ${username}</div>
    <div class="mb-2"><strong>Sân:</strong> ${court.court_number}</div>
    <div class="mb-2"><strong>Khu vực:</strong> ${court.area_id}</div>
    <div class="mb-2"><strong>Ngày:</strong> ${date}</div>

    <c:if test="${not empty promotion}">
        <div class="alert alert-success">
            <b>Khuyến mãi áp dụng:</b>
            <c:if test="${promotion.discountPercent > 0}">
                Giảm <b>${promotion.discountPercent}%</b>
            </c:if>
            <c:if test="${promotion.discountAmount > 0}">
                <c:if test="${promotion.discountPercent > 0}">, </c:if>
                trừ <b>${promotion.discountAmount} VNĐ</b>
            </c:if>
            <c:if test="${not empty promotion.title}">
                <br/><span style="font-style:italic;">${promotion.title}</span>
            </c:if>
        </div>
    </c:if>

    <h5>Khung giờ</h5>
    <ul class="list-group mb-3">
        <li class="list-group-item">
            ${startTime} - ${endTime}
        </li>
    </ul>

    <c:if test="${not empty servicesSelected}">
        <h5>Dịch vụ</h5>
        <ul class="list-group mb-3">
            <c:forEach var="s" items="${servicesSelected}">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    ${s.name}
                    <span>${s.price} VNĐ</span>
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <h5 class="text-end">Tổng cộng: ${totalPrice} VNĐ</h5>

    <form action="add-booking" method="post">
        <input type="hidden" name="confirm" value="true">
        <input type="hidden" name="username" value="${username}">
        <input type="hidden" name="courtId" value="${court.court_id}">
        <input type="hidden" name="date" value="${date}">
        <input type="hidden" name="startTime" value="${startTime}">
        <input type="hidden" name="endTime" value="${endTime}">
        <c:forEach var="sid" items="${selectedServiceIds}">
            <input type="hidden" name="selectedServices" value="${sid}">
        </c:forEach>
        <button type="submit" class="btn btn-primary">Xác nhận</button>
        <a href="add-booking" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
