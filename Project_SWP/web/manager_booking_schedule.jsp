<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --card-shadow: 0 20px 40px rgba(0,0,0,0.1);
            --hover-shadow: 0 25px 50px rgba(0,0,0,0.15);
            --border-radius: 20px;
        }

        * {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin: 2rem;
            overflow: hidden;
        }

        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .page-header h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .page-header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-top: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .filter-section {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .form-control, .form-select {
            border: 2px solid rgba(102, 126, 234, 0.1);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .btn {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            border: none;
            transition: all 0.3s ease;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(79, 172, 254, 0.4);
        }

        .btn-warning {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }

        .add-booking-btn {
            background: var(--secondary-gradient);
            color: white;
            border-radius: 50px;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .add-booking-btn:hover {
            color: white;
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(240, 147, 251, 0.4);
        }

        .table-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin: 2rem;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .table {
            margin: 0;
            background: transparent;
        }

        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 1.25rem 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            background: rgba(255, 255, 255, 0.7);
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.8s;
        }

        .badge:hover::before {
            left: 100%;
        }

        .bg-warning {
            background: var(--warning-gradient) !important;
            color: white !important;
        }

        .bg-info {
            background: var(--success-gradient) !important;
            color: white !important;
        }

        .bg-danger {
            background: var(--danger-gradient) !important;
            color: white !important;
        }

        .bg-success {
            background: var(--primary-gradient) !important;
            color: white !important;
        }

        .bg-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%) !important;
            color: white !important;
        }

        .btn-group-sm .btn {
            border-radius: 8px;
            margin: 0 2px;
            min-width: 40px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-group-sm .btn:hover {
            transform: translateY(-2px) scale(1.1);
        }

        .notification-wrapper {
            z-index: 1050;
        }

        .floating-stats {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            z-index: 1000;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .stat-item:last-child {
            margin-bottom: 0;
        }

        .stat-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            color: white;
        }

        .filter-label {
            font-size: 0.9rem;
            font-weight: 600;
            color: #667eea;
            margin-bottom: 0.25rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
            }
            
            .page-header h3 {
                font-size: 2rem;
            }
            
            .filter-section {
                margin: 1rem;
                padding: 1rem;
            }
            
            .table-container {
                margin: 1rem;
            }
            
            .floating-stats {
                bottom: 1rem;
                right: 1rem;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Pulse Animation for New Items */
        .new-item {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(102, 126, 234, 0); }
            100% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0); }
        }
    </style>
</head>
<body>

<!-- Notification -->
<div class="notification-wrapper position-fixed top-0 end-0 p-3 z-3">
    <jsp:include page="notification.jsp"/>
</div>

<div class="container-fluid p-0">
    <div class="row g-0">
        <!-- Sidebar -->
        <div class="col-md-3 d-none d-md-block">
            <c:choose>
                <c:when test="${sessionScope.user.role eq 'staff'}">
                    <jsp:include page="Sidebar_Staff.jsp" />
                </c:when>
                <c:otherwise>
                    <jsp:include page="Sidebar.jsp" />
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="main-container">
                <!-- Page Header -->
                <div class="page-header">
                    <h3><i class="fas fa-calendar-alt me-3"></i>Quản lý đặt sân</h3>
                    <div class="subtitle">Theo dõi và quản lý tất cả các đặt sân một cách hiệu quả</div>
                </div>

                <!-- Filter Section -->
                <div class="filter-section">
                    <form class="row g-3 align-items-end" method="get" action="manager-booking-schedule">
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="filter-label">Khu vực</label>
                            <select name="areaId" class="form-select">
                                <option value="">Tất cả khu vực</option>
                                <c:forEach var="a" items="${areas}">
                                    <option value="${a.area_id}" <c:if test="${areaId == a.area_id}">selected</c:if>>${a.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="filter-label">Từ ngày</label>
                            <input type="date" name="startDate" value="${startDate}" class="form-control"/>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="filter-label">Đến ngày</label>
                            <input type="date" name="endDate" value="${endDate}" class="form-control"/>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="filter-label">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="">Tất cả trạng thái</option>
                                <option value="pending" <c:if test="${status eq 'pending'}">selected</c:if>>Chờ xử lý</option>
                                <option value="confirmed" <c:if test="${status eq 'confirmed'}">selected</c:if>>Đã xác nhận</option>
                                <option value="cancelled" <c:if test="${status eq 'cancelled'}">selected</c:if>>Đã hủy</option>
                                <option value="completed" <c:if test="${status eq 'completed'}">selected</c:if>>Hoàn thành</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-filter me-2"></i>Lọc
                            </button>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <a href="add-booking" class="add-booking-btn w-100 text-center">
                                <i class="fas fa-plus me-2"></i>Thêm đặt sân
                            </a>
                        </div>
                    </form>
                </div>

                <!-- Booking Table -->
                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle text-center mb-0">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                    <th><i class="fas fa-futbol me-2"></i>Sân</th>
                                    <th><i class="fas fa-map-marker-alt me-2"></i>Khu vực</th>
                                    <th><i class="fas fa-user me-2"></i>Khách hàng</th>
                                    <th><i class="fas fa-calendar me-2"></i>Ngày</th>
                                    <th><i class="fas fa-clock me-2"></i>Giờ</th>
                                    <th><i class="fas fa-money-bill-wave me-2"></i>Tổng</th>
                                    <th><i class="fas fa-concierge-bell me-2"></i>Dịch vụ</th>
                                    <th><i class="fas fa-info-circle me-2"></i>Trạng thái</th>
                                    <th><i class="fas fa-cogs me-2"></i>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr class="booking-row">
                                        <td><strong>#${b.booking_id}</strong></td>
                                        <td>
                                            <div class="d-flex align-items-center justify-content-center">
                                                <i class="fas fa-futbol text-primary me-2"></i>
                                                <span>${b.courtNumber}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark">${b.areaName}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center justify-content-center">
                                                <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 30px; height: 30px; font-size: 12px;">
                                                    ${b.customerName.substring(0,1).toUpperCase()}
                                                </div>
                                                <span>${b.customerName}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="text-primary fw-bold">${b.date}</div>
                                        </td>
                                        <td>
                                            <div class="badge bg-info text-white">${b.start_time} - ${b.end_time}</div>
                                        </td>
                                        <td>
                                            <div class="text-success fw-bold">${b.totalPrice}</div>
                                        </td>
                                        <td>
                                            <div class="text-muted small">${serviceNames[b.booking_id]}</div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status eq 'pending'}">
                                                    <span class="badge bg-warning">
                                                        <i class="fas fa-clock me-1"></i>Chờ xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status eq 'confirmed'}">
                                                    <span class="badge bg-info">
                                                        <i class="fas fa-check-circle me-1"></i>Đã xác nhận
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status eq 'cancelled'}">
                                                    <span class="badge bg-danger">
                                                        <i class="fas fa-times-circle me-1"></i>Đã hủy
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status eq 'completed'}">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-check-double me-1"></i>Hoàn thành
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">
                                                        <i class="fas fa-question me-1"></i>${b.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <c:if test="${b.status eq 'pending'}">
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="confirm" />
                                                        <button type="submit" class="btn btn-success" title="Xác nhận">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </form>
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="cancel" />
                                                        <button type="submit" class="btn btn-danger" title="Hủy">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${b.status eq 'confirmed'}">
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="complete" />
                                                        <button type="submit" class="btn btn-secondary" title="Hoàn thành">
                                                            <i class="fas fa-check-double"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <a href="update-booking?bookingId=${b.booking_id}" class="btn btn-primary" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Floating Stats -->
<div class="floating-stats d-none d-lg-block">
    <div class="stat-item">
        <div class="stat-icon bg-warning">
            <i class="fas fa-clock"></i>
        </div>
        <div>
            <div class="fw-bold">Chờ xử lý</div>
            <div class="text-muted small">
                <c:set var="pendingCount" value="0" />
                <c:forEach var="b" items="${bookings}">
                    <c:if test="${b.status eq 'pending'}">
                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                    </c:if>
                </c:forEach>
                ${pendingCount} đặt sân
            </div>
        </div>
    </div>
    <div class="stat-item">
        <div class="stat-icon bg-info">
            <i class="fas fa-check"></i>
        </div>
        <div>
            <div class="fw-bold">Đã xác nhận</div>
            <div class="text-muted small">
                <c:set var="confirmedCount" value="0" />
                <c:forEach var="b" items="${bookings}">
                    <c:if test="${b.status eq 'confirmed'}">
                        <c:set var="confirmedCount" value="${confirmedCount + 1}" />
                    </c:if>
                </c:forEach>
                ${confirmedCount} đặt sân
            </div>
        </div>
    </div>
    <div class="stat-item">
        <div class="stat-icon bg-success">
            <i class="fas fa-check-double"></i>
        </div>
        <div>
            <div class="fw-bold">Hoàn thành</div>
            <div class="text-muted small">
                <c:set var="completedCount" value="0" />
                <c:forEach var="b" items="${bookings}">
                    <c:if test="${b.status eq 'completed'}">
                        <c:set var="completedCount" value="${completedCount + 1}" />
                    </c:if>
                </c:forEach>
                ${completedCount} đặt sân
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add smooth scrolling and animations
    document.addEventListener('DOMContentLoaded', function() {
        // Animate table rows on hover
        const tableRows = document.querySelectorAll('.booking-row');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px)';
            });
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });

        // Add loading animation to buttons
        const buttons = document.querySelectorAll('button[type="submit"]');
        buttons.forEach(button => {
            button.addEventListener('click', function() {
                if (!this.disabled) {
                    const originalText = this.innerHTML;
                    this.innerHTML = '<span class="loading-spinner me-2"></span>Đang xử lý...';
                    this.disabled = true;
                    
                    // Re-enable after 3 seconds (adjust as needed)
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                    }, 3000);
                }
            });
        });

        // Add fade-in animation to new items
        const newItems = document.querySelectorAll('.new-item');
        newItems.forEach(item => {
            item.style.animation = 'pulse 2s infinite';
        });
    });
</script>
</body>
</html>