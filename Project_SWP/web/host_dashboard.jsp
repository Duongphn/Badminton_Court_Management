<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Manager</a>
        <div class="d-flex">
<!--            <a class="nav-link text-light" href="/profile">Profile</a>-->
            <a class="nav-link text-light" href="login">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Layout -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp" />
        </div>

        <!-- Content -->
        <div class="col-md-9">
            <h2 class="mb-4">Dashboard Overview</h2>

            <!-- Stats Cards -->
            <div class="row text-center mb-4">
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Areas</h5>
                            <p class="card-text fs-3">${areaCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Courts</h5>
                            <p class="card-text fs-3">${courtCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title">Bookings</h5>
                            <p class="card-text fs-3">${bookingCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <h5 class="card-title">Reviews</h5>
                            <p class="card-text fs-3">${reviewCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chart -->
            <div class="card">
                <div class="card-header">
                    <strong>Area Statistics (Courts, Bookings, Reviews)</strong>
                </div>
                <div class="card-body">
                    <canvas id="areaChart" height="100"></canvas>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Chart JS -->
<script>
    const ctx = document.getElementById('areaChart').getContext('2d');
    const areaChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ${areaLabelsJson}, 
            datasets: [
                {
                    label: 'Courts',
                    data: ${courtDataJson},
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                },
                {
                    label: 'Bookings',
                    data: ${bookingDataJson},
                    backgroundColor: 'rgba(255, 206, 86, 0.7)',
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 1
                },
                {
                    label: 'Reviews',
                    data: ${reviewDataJson},
                    backgroundColor: 'rgba(255, 99, 132, 0.7)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Per-Area Statistics Overview'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 1 }
                }
            }
        }
    });
</script>

</body>
</html>
