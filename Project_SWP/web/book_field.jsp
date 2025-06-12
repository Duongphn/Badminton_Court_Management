<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .booking-container {
            max-width: 600px;
            background: #fff;
            padding: 2rem;
            margin: 3rem auto;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
        .booking-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #2f3542;
            margin-bottom: 1.5rem;
        }
        label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #34495e;
        }
        .form-control {
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #ff4757;
            border-color: #ff4757;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #ff6b81;
            border-color: #ff6b81;
        }
    </style>
</head>
<body>

<div class="container booking-container">
    <h2 class="booking-title">Đặt sân: ${court.court_number}</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-danger">${message}</div>
    </c:if>

    <form action="book-field" method="post">
        <input type="hidden" name="courtId" value="${court.court_id}" />

        <div class="mb-3">
            <label for="date">Chọn ngày</label>
            <input type="date" id="date" name="date" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="startTime">Giờ bắt đầu</label>
            <input type="time" id="startTime" name="startTime" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="endTime">Giờ kết thúc</label>
            <input type="time" id="endTime" name="endTime" class="form-control" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Kiểm tra & Xác nhận</button>
        </div>
    </form>
</div>
         <jsp:include page="homefooter.jsp" />

</body>
</html>
