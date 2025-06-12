<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">Xác nhận đặt sân</h2>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title text-primary">Thông tin đặt sân</h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Sân:</strong> ${court.court_number}</li>
                <li class="list-group-item"><strong>Khu vực:</strong> ${court.area_id}</li>
                <li class="list-group-item"><strong>Ngày:</strong> ${date}</li>
                <li class="list-group-item"><strong>Giờ bắt đầu:</strong> ${startTime}</li>
                <li class="list-group-item"><strong>Giờ kết thúc:</strong> ${endTime}</li>
                <li class="list-group-item"><strong>Tổng tiền:</strong> <span class="text-danger fw-bold">${totalPrice} VNĐ</span></li>
            </ul>
        </div>
    </div>

    <form action="confirm-booking" method="post" class="mt-4">
        <input type="hidden" name="courtId" value="${court.court_id}">
        <input type="hidden" name="areaId" value="${court.area_id}">
        <input type="hidden" name="date" value="${date}">
        <input type="hidden" name="startTime" value="${startTime}">
        <input type="hidden" name="endTime" value="${endTime}">
        <input type="hidden" name="totalPrice" value="${totalPrice}">
        <button type="submit" class="btn btn-success">Xác nhận đặt sân</button>
        <a href="book-field?courtId=${court.court_id}" class="btn btn-secondary ms-2">Quay lại</a>
    </form>

</div>

</body>
</html>
