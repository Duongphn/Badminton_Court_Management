<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
    <head>
        <title>Báo cáo doanh thu & lịch sử đặt sân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
        <style>
            .card {
                border-radius: 16px;
                box-shadow: 0 2px 16px rgba(0,0,0,.07);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0,0,0,.12);
            }
            .table th, .table td {
                vertical-align: middle !important;
            }
            .center-content {
                min-height: 80vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            .scroll-table {
                max-height: 420px;
                overflow-y: auto;
            }
            @media (min-width: 992px) {
                .container-page {
                    max-width: 950px;
                    margin: auto;
                }
            }
            
            /* Custom chart styles */
            .chart-container {
                position: relative;
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                border-radius: 20px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 10px 30px rgba(255, 107, 107, 0.3);
            }
            
            .chart-title {
                color: white;
                font-weight: 600;
                font-size: 1.2rem;
                text-align: center;
                margin-bottom: 20px;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            }
            
            .chart-canvas {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                padding: 15px;
                backdrop-filter: blur(10px);
            }
            
            .revenue-alert {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                border: none;
                border-radius: 15px;
                color: white;
                font-size: 1.1rem;
                box-shadow: 0 5px 20px rgba(255, 107, 107, 0.3);
                animation: pulse 2s infinite;
            }
            
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.02); }
                100% { transform: scale(1); }
            }

            .filter-card {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                border-radius: 15px;
                padding: 20px 25px;
                margin-bottom: 30px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .filter-card .form-label {
                color: white;
                font-weight: 500;
                margin-bottom: 8px;
            }

            .filter-card .form-control {
                border-radius: 10px;
                border: 1px solid #e0e0e0;
                padding: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: border-color 0.3s ease;
            }

            .filter-card .form-control:focus {
                border-color: #ee5a24;
                outline: none;
            }

            .filter-card .row {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .filter-card .col-md-3 {
                flex: 1 1 22%;
                margin-right: 10px;
            }

            .btn-filter {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-weight: 600;
                font-size: 1rem;
                color: white;
                transition: all 0.3s ease, transform 0.2s ease;
                cursor: pointer;
            }

            .btn-filter:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 15px rgba(238, 90, 36, 0.4);
            }

            .btn-filter:active {
                transform: translateY(2px);
            }

        </style>
    </head>
    <body class="bg-light">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Quản lý</a>
                <div class="d-flex">
                    <a class="nav-link text-light" href="login">Đăng xuất</a>
                </div>
            </div>
        </nav>

        <div class="container-page mt-4">
            <div class="row justify-content-center">
                <!-- Sidebar -->
                <div class="col-lg-3 mb-3">
                    <jsp:include page="Sidebar.jsp"/>
                </div>
                <!-- Content center -->
                <div class="col-lg-9 center-content">
                    <div class="w-100 py-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="mb-0"><i class="bi bi-bar-chart-line"></i> Báo cáo doanh thu & lịch sử đặt sân</h2>
                        </div>

                        <!-- Filter Card -->
                        <div class="filter-card">
                            <form class="row g-3" method="get" action="revenue-report">
                                <div class="col-md-3">
                                    <label for="fromDate" class="form-label">Từ ngày</label>
                                    <input type="date" class="form-control" id="fromDate" name="fromDate" value="${fromDate}">
                                </div>

                                <div class="col-md-3">
                                    <label for="toDate" class="form-label">Đến ngày</label>
                                    <input type="date" class="form-control" id="toDate" name="toDate" value="${toDate}">
                                </div>

                                <div class="col-md-3">
                                    <label for="courtId" class="form-label">ID Sân </label>
                                    <input type="number" class="form-control" id="courtId" name="courtId" value="${courtId != null ? courtId : ''}" min="1">
                                </div>

                           

                                <div class="col-12 text-end">
                                    <button type="submit" class="btn btn-filter text-white"><i class="bi bi-funnel"></i> Lọc</button>
                                </div>
                            </form>
                        </div>

                        <!-- Revenue -->
                        <div class="alert revenue-alert mb-4 text-center">
                            <i class="bi bi-cash-coin me-2"></i>
                            <b>Tổng doanh thu: </b>
                            <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                        </div>

                        <!-- Table scrollable -->
                        <div class="card shadow-sm mb-4">
                            <div class="card-body p-0 scroll-table">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle mb-0">
                                        <thead class="table-light text-center">
                                            <tr>
                                                <th>#</th>
                                                <th>ID người đặt</th>
                                                <th>ID sân</th>
                                                <th>Ngày</th>
                                                <th>Thời gian</th>
                                                <th>Trạng thái</th>
                                                <th>Giá (VNĐ)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${bookings}" varStatus="status">
                                                <tr class="text-center">
                                                    <td>${b.booking_id}</td>
                                                    <td>${b.user_id}</td>
                                                    <td>${b.court_id}</td>
                                                    <td>${b.date}</td>
                                                    <td>${b.start_time} - ${b.end_time}</td>
                                                    <td>
                                                        <span class="badge
                                                            <c:choose>
                                                                <c:when test="${b.status eq 'done'}">bg-success</c:when>
                                                                <c:when test="${b.status eq 'pending'}">bg-warning text-dark</c:when>
                                                                <c:otherwise>bg-secondary</c:otherwise>
                                                            </c:choose>
                                                        ">
                                                            ${b.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${b.total_price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${fn:length(bookings) == 0}">
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted">Không có dữ liệu</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer text-center bg-white">
                                <span class="text-muted">Tổng cộng: <b>${fn:length(bookings)}</b> lượt đặt</span>
                            </div>
                        </div>

                        <!-- Biểu đồ doanh thu theo tháng -->
                        <div class="chart-container">
                            <div class="chart-title">
                                <i class="bi bi-calendar-month me-2"></i>Biểu đồ doanh thu theo tháng
                            </div>
                            <div class="chart-canvas">
                                <canvas id="revenueMonthChart" style="height:320px"></canvas>
                            </div>
                        </div>

                        <!-- Biểu đồ doanh thu theo tuần -->
                        <div class="chart-container">
                            <div class="chart-title">
                                <i class="bi bi-calendar-week me-2"></i>Biểu đồ doanh thu theo tuần
                            </div>
                            <div class="chart-canvas">
                                <canvas id="revenueWeekChart" style="height:320px"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Dữ liệu JSON từ servlet
            var revenueByMonth = ${revenueByMonthJson};
            var revenueByWeek = ${revenueByWeekJson};

            // Chuyển dữ liệu về mảng cho Chart.js
            var monthLabels = Object.keys(revenueByMonth).map(m => "Tháng " + m);
            var monthData = Object.values(revenueByMonth);
            var weekLabels = Object.keys(revenueByWeek).map(w => "Tuần " + w);
            var weekData = Object.values(revenueByWeek);

            // Custom gradient colors
            function createGradient(ctx, color1, color2) {
                const gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, color1);
                gradient.addColorStop(1, color2);
                return gradient;
            }

            // Chart theo tháng
            const monthCtx = document.getElementById('revenueMonthChart').getContext('2d');
            new Chart(monthCtx, {
                type: 'bar',
                data: {
                    labels: monthLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: monthData,
                        backgroundColor: createGradient(monthCtx, '#ff6b6b', '#ee5a24'),
                        borderColor: '#ff6b6b',
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false,
                        hoverBackgroundColor: createGradient(monthCtx, '#ee5a24', '#ff6b6b'),
                        hoverBorderColor: '#ee5a24',
                        hoverBorderWidth: 3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: {
                        duration: 2000,
                        easing: 'easeInOutQuart'
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            borderColor: '#ff6b6b',
                            borderWidth: 1,
                            cornerRadius: 10,
                            displayColors: false,
                            callbacks: {
                                label: function(context) {
                                    return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + ' ₫';
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#4a5568',
                                font: {
                                    weight: 'bold'
                                }
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.1)',
                                borderDash: [5, 5]
                            },
                            ticks: {
                                color: '#4a5568',
                                callback: function (value) {
                                    return value.toLocaleString('vi-VN') + ' ₫';
                                }
                            }
                        }
                    },
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    }
                }
            });

            // Chart theo tuần
            const weekCtx = document.getElementById('revenueWeekChart').getContext('2d');
            const weekGradient = weekCtx.createLinearGradient(0, 0, 0, 400);
            weekGradient.addColorStop(0, 'rgba(255, 107, 107, 0.8)');
            weekGradient.addColorStop(1, 'rgba(238, 90, 36, 0.1)');

            new Chart(weekCtx, {
                type: 'line',
                data: {
                    labels: weekLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: weekData,
                        fill: true,
                        backgroundColor: weekGradient,
                        borderColor: '#ff6b6b',
                        borderWidth: 4,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#ff6b6b',
                        pointBorderWidth: 3,
                        pointRadius: 6,
                        pointHoverRadius: 8,
                        pointHoverBackgroundColor: '#ff6b6b',
                        pointHoverBorderColor: '#ffffff',
                        pointHoverBorderWidth: 3,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: {
                        duration: 2500,
                        easing: 'easeInOutQuart'
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            borderColor: '#ff6b6b',
                            borderWidth: 1,
                            cornerRadius: 10,
                            displayColors: false,
                            callbacks: {
                                label: function(context) {
                                    return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + ' ₫';
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#4a5568',
                                font: {
                                    weight: 'bold'
                                }
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.1)',
                                borderDash: [5, 5]
                            },
                            ticks: {
                                color: '#4a5568',
                                callback: function (value) {
                                    return value.toLocaleString('vi-VN') + ' ₫';
                                }
                            }
                        }
                    },
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    }
                }
            });
        </script>
    </body>
</html>
