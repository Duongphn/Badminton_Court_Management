<%-- 
    Document   : Admin_DashBoard
    Created on : Jun 24, 2025, 8:29:02 AM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>Admin Dashboard</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                color: #333;
                padding-top: 70px;
            }

            .header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 20px rgba(0,0,0,0.1);
                border-bottom: 1px solid rgba(255,255,255,0.2);
                position: fixed;
                top: 0;
                left: 280;
                right: 0;
                z-index: 1000;
                height: 70px;
            }

            .header h3 {
                color: #2c3e50;
                font-size: 1.5em;
                font-weight: 600;
            }

            .logout-button {
                background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 4px 15px rgba(238, 90, 36, 0.3);
            }

            .logout-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(238, 90, 36, 0.4);
            }

            .container {
                display: flex;
                min-height: calc(100vh - 70px);
                position: relative;
            }

            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(15px);
                border-right: 1px solid rgba(255, 255, 255, 0.2);
                position: fixed;
                left: 0;
                top: 70px;
                height: calc(100vh - 70px);
                overflow-y: auto;
                z-index: 100;
            }

            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 30px;
                background: rgba(255, 255, 255, 0.05);
                overflow-y: auto;
                width: calc(100% - 280px);
                min-height: calc(100vh - 70px);
            }

            .dashboard-container {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                backdrop-filter: blur(10px);
            }

            .title {
                font-size: 2.2em;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 25px;
                text-align: center;
                background: linear-gradient(45deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .filter-section {
                background: rgba(102, 126, 234, 0.1);
                border-radius: 15px;
                padding: 20px;
                margin-bottom: 25px;
                border: 1px solid rgba(102, 126, 234, 0.2);
            }

            .filter-section label {
                font-weight: 600;
                color: #2c3e50;
                margin-right: 15px;
            }

            .filter-section select {
                padding: 10px 15px;
                border: 2px solid rgba(102, 126, 234, 0.3);
                border-radius: 10px;
                background: white;
                color: #333;
                font-size: 1em;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .filter-section select:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            }

            .kpi-boxes {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 25px;
                margin-bottom: 40px;
            }

            .kpi {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px;
                padding: 30px 25px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .kpi::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                transition: all 0.3s ease;
                transform: scale(0);
            }

            .kpi:hover::before {
                transform: scale(1);
            }

            .kpi:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
            }

            .kpi h2 {
                font-size: 2.8em;
                font-weight: 700;
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }

            .kpi span {
                font-size: 1.1em;
                opacity: 0.9;
                font-weight: 500;
                position: relative;
                z-index: 1;
            }

            .section-title {
                font-size: 1.5em;
                font-weight: 600;
                color: #2c3e50;
                margin: 30px 0 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title::before {
                content: '';
                width: 4px;
                height: 30px;
                background: linear-gradient(45deg, #667eea, #764ba2);
                border-radius: 2px;
            }

            .table-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background: linear-gradient(45deg, #667eea, #764ba2);
                color: white;
                padding: 18px 15px;
                text-align: center;
                font-weight: 600;
                font-size: 1em;
            }

            td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #f0f0f0;
                transition: all 0.3s ease;
            }

            tr:hover td {
                background: rgba(102, 126, 234, 0.05);
            }

            tr:last-child td {
                border-bottom: none;
            }

            .chart-container {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            #revenueChart {
                max-height: 400px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    position: relative;
                    height: auto;
                    top: 0;
                }

                .main-content {
                    margin-left: 0;
                    width: 100%;
                    padding: 20px;
                }

                .container {
                    flex-direction: column;
                }

                .kpi-boxes {
                    grid-template-columns: 1fr;
                }

                .title {
                    font-size: 1.8em;
                }
            }

            /* Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .dashboard-container,
            .table-container,
            .chart-container {
                animation: fadeInUp 0.6s ease-out;
            }
        </style>
    </head>
    <body>


        <div class="container">
            <div class="sidebar">
                <jsp:include page="Sidebar.jsp"/>
            </div>

            <div class="main-content">
                <div class="header">
                    <h3><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h3>
                    <a href="login" class="logout-button">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </div>

                <div class="dashboard-container">
                    <div class="title">Báo cáo tổng quan quản lý sân</div>

                    <div class="filter-section">
                        <form method="get" action="AdminDashBoard">
                            <label for="filter"><i class="fas fa-filter"></i> Lọc theo:</label>
                            <select name="filter" id="filter" onchange="this.form.submit()">
                                <option value="all" ${filter == 'all' ? 'selected' : ''}>Tất cả</option>
                                <option value="today" ${filter == 'today' ? 'selected' : ''}>Ngày hôm nay</option>
                                <option value="week" ${filter == 'week' ? 'selected' : ''}>Tuần này</option>
                                <option value="month" ${filter == 'month' ? 'selected' : ''}>Tháng này</option>
                            </select>
                        </form>
                    </div>

                    <div class="kpi-boxes">
                        <div class="kpi">
                            <h2>${summary.totalBookings}</h2>
                            <span><i class="fas fa-calendar-check"></i> Tổng lượt đặt</span>
                        </div>
                        <div class="kpi">
                            <h2>${summary.totalRevenue}</h2>
                            <span><i class="fas fa-coins"></i> Tổng doanh thu</span>
                        </div>
                        <div class="kpi">
                            <h2>${summary.returningUsers}</h2>
                            <span><i class="fas fa-users"></i> User quay lại</span>
                        </div>
                        <div class="kpi">
                            <h2>
                                <c:choose>
                                    <c:when test="${summary.avgRating > 0}">
                                        ${summary.avgRating}
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </h2>
                            <span><i class="fas fa-star"></i> Đánh giá trung bình</span>
                        </div>
                    </div>
                </div>

                <div class="section-title">
                    <i class="fas fa-table"></i>
                    Bảng tổng hợp từng sân
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-futbol"></i> Tên sân</th>
                                <th><i class="fas fa-user-tie"></i> Quản lý</th>
                                <th><i class="fas fa-money-bill-wave"></i> Doanh thu</th>
                                <th><i class="fas fa-booking"></i> Lượt đặt</th>
                                <th><i class="fas fa-user-friends"></i> User quay lại</th>
                                <th><i class="fas fa-star"></i> Đánh giá TB</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="court" items="${courtReports}">
                                <tr>
                                    <td>${court.courtName}</td>
                                    <td>${court.managerName}</td>
                                    <td>${court.revenue}</td>
                                    <td>${court.bookings}</td>
                                    <td>${court.returningUsers}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${court.avgRating > 0}">
                                                ${court.avgRating}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="section-title">
                    <i class="fas fa-chart-bar"></i>
                    Biểu đồ doanh thu theo sân
                </div>

                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>

                <script>
                    var ctx = document.getElementById('revenueChart').getContext('2d');
                    var labels = [
                    <c:forEach var="court" items="${courtReports}" varStatus="loop">
                    "${court.courtName}"<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    var data = [
                    <c:forEach var="court" items="${courtReports}" varStatus="loop">
                        ${court.revenue}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];

                    var chart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                    label: 'Doanh thu',
                                    data: data,
                                    backgroundColor: 'rgba(102, 126, 234, 0.8)',
                                    borderColor: 'rgba(102, 126, 234, 1)',
                                    borderWidth: 2,
                                    borderRadius: 8,
                                    borderSkipped: false,
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: {
                                        color: 'rgba(0,0,0,0.1)'
                                    }
                                },
                                x: {
                                    grid: {
                                        display: false
                                    }
                                }
                            }
                        }
                    });
                </script>
            </div>
        </div>
    </body>
</html>