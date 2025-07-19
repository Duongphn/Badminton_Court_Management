<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Nhân viên</a>
        <a class="nav-link text-light" href="login">Đăng xuất</a>
    </div>
</nav>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="Sidebar_Staff.jsp" />
        </div>
        <div class="col-md-9">
            <h2 class="mb-4">Tổng quan</h2>
            <div class="row text-center mb-4">
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Lượt đặt hôm nay</h5>
                            <p class="card-text fs-3">${todayBookings}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Doanh thu (7 ngày)</h5>
                            <p class="card-text fs-3"><fmt:formatNumber value="${weeklyRevenue}" type="number"/></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title">Courts</h5>
                            <p class="card-text">Còn trống: ${statusCounts.available}</p>
                            <p class="card-text">Đang sử dụng: ${statusCounts.occupied}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <h5 class="card-title">Đánh giá</h5>
                            <p class="card-text fs-3">${reviewCount}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header"><strong>Khung giờ đặt nhiều</strong></div>
                        <div class="card-body">
                            <canvas id="hourChart" height="200"></canvas>
</div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header"><strong>Sân được đặt nhiều nhất</strong></div>
                        <div class="card-body">
                            <canvas id="courtChart" height="200"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const hourly = ${hourlyJson};
    const topCourts = ${topCourtsJson};
    new Chart(document.getElementById('hourChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: Object.keys(hourly),
            datasets: [{label: 'Bookings', data: Object.values(hourly), backgroundColor: 'rgba(54,162,235,0.6)'}]
        }
    });
    new Chart(document.getElementById('courtChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: Object.keys(topCourts),
            datasets: [{label: 'Bookings', data: Object.values(topCourts), backgroundColor: 'rgba(255,99,132,0.6)'}]
        }
    });
</script>
</body>
</html>