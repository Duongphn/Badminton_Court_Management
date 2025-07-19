<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đặt sân</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f6fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            margin: 2rem 0;
            padding: 1rem;
        }
        .page-header {
            background: #667eea;
            color: white;
            padding: 1rem 1rem;
            border-radius: 10px 10px 0 0;
            margin-bottom: 1rem;
        }
        .filter-section {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1rem 1rem;
            margin-bottom: 1rem;
        }
        .table-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            padding: 0.5rem;
        }
        .table thead th {
            background: #667eea;
            color: white;
            border: none;
        }
        .table tbody tr:hover {
            background: #eef2fb;
        }
        .badge {
            border-radius: 12px;
            font-size: 0.9rem;
            padding: 0.4em 0.8em;
        }
        .bg-warning { background: #f0932b !important; color: #fff !important; }
        .bg-info { background: #00b894 !important; color: #fff !important; }
        .bg-danger { background: #eb2f06 !important; color: #fff !important; }
        .bg-success { background: #6ab04c !important; color: #fff !important; }
        .bg-secondary { background: #636e72 !important; color: #fff !important; }
        .add-booking-btn {
            background: #764ba2;
            color: #fff;
            border-radius: 20px;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        .add-booking-btn:hover {
            background: #5f3796;
            color: #fff;
        }
        .floating-stats {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 1rem;
            min-width: 180px;
            z-index: 1000;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }
        .stat-icon {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            color: #fff;
        }
        @media (max-width: 992px) {
            .floating-stats { position: static; margin: 1rem 0; }
        }
        @media (max-width: 768px) {
            .main-container, .table-container, .filter-section { padding: 0.5rem; margin: 0.5rem 0; }
            .page-header { padding: 0.5rem; }
            .floating-stats { position: static; margin: 0.5rem 0; }
            .table-responsive { font-size: 0.95rem; }
        }
    </style>
</head>
<body>
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
                            <label class="form-label">Khu vực</label>
                            <select name="areaId" class="form-select">
                                <option value="">Tất cả khu vực</option>
                                <c:forEach var="a" items="${areas}">
                                    <option value="${a.area_id}" <c:if test="${areaId == a.area_id}">selected</c:if>>${a.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="form-label">Từ ngày</label>
                            <input type="date" name="startDate" value="${startDate}" class="form-control"/>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="form-label">Đến ngày</label>
                            <input type="date" name="endDate" value="${endDate}" class="form-control"/>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <label class="form-label">Trạng thái</label>
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
                <!-- Booking Table with Pagination -->
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
                                <c:set var="pageSize" value="10"/>
                                <c:set var="page" value="${param.page != null ? param.page : 1}"/>
                                <c:set var="start" value="${(page-1)*pageSize}"/>
                                <c:set var="end" value="${start + pageSize}"/>
                                <c:set var="total" value="${fn:length(bookings)}"/>
                                <c:forEach var="b" items="${bookings}" varStatus="status">
                                    <c:if test="${status.index >= start && status.index < end}">
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
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- Pagination -->
                    <nav aria-label="Page navigation" class="mt-3">
                        <ul class="pagination justify-content-center">
                            <c:set var="totalPages" value="${(total/pageSize) + (total%pageSize > 0 ? 1 : 0)}"/>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item <c:if test='${i == page}'>active</c:if>">
                                    <a class="page-link"
                                       href="?page=${i}
                                       <c:if test='${not empty areaId}'> &amp;areaId=${areaId}</c:if>
                                       <c:if test='${not empty startDate}'> &amp;startDate=${startDate}</c:if>
                                       <c:if test='${not empty endDate}'> &amp;endDate=${endDate}</c:if>
                                       <c:if test='${not empty status}'> &amp;status=${status}</c:if>
                                       ">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
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
</body>
</html>