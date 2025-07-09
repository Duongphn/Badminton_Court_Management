<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h3 {
            font-weight: bold;
        }
        .form-select, .form-control {
            min-width: 150px;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<!-- Notification -->
<div class="notification-wrapper position-fixed top-0 end-0 p-3 z-3">
    <jsp:include page="notification.jsp"/>
</div>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 mb-3">
            <jsp:include page="Sidebar.jsp"/>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h3 class="mb-4">Quản lí lịch đặt sân</h3>

                    <!-- Filter Form -->
                    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                        <form class="row gx-2 gy-2 align-items-center" method="get" action="manager-booking-schedule">
                            <div class="col-auto">
                                <select name="areaId" class="form-select">
                                    <option value="">Tất cả khu vực</option>
                                    <c:forEach var="a" items="${areas}">
                                        <option value="${a.area_id}" <c:if test="${areaId == a.area_id}">selected</c:if>>${a.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-auto">
                                <input type="date" name="startDate" value="${startDate}" class="form-control"/>
                            </div>
                            <div class="col-auto">
                                <input type="date" name="endDate" value="${endDate}" class="form-control"/>
                            </div>
                            <div class="col-auto">
                                <select name="status" class="form-select">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="pending" <c:if test="${status eq 'pending'}">selected</c:if>>Pending</option>
                                    <option value="confirmed" <c:if test="${status eq 'confirmed'}">selected</c:if>>Confirmed</option>
                                    <option value="cancelled" <c:if test="${status eq 'cancelled'}">selected</c:if>>Cancelled</option>
                                    <option value="completed" <c:if test="${status eq 'completed'}">selected</c:if>>Completed</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary px-4">Lọc</button>
                            </div>
                        </form>
                        <a href="add-booking" class="btn btn-success px-4">+ Thêm đặt sân</a>
                    </div>

                    <!-- Booking Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Sân</th>
                                    <th>Khu vực</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày</th>
                                    <th>Giờ</th>
                                    <th>Tổng</th>
                                    <th>Dịch vụ</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr>
                                        <td>${b.booking_id}</td>
                                        <td>${b.courtNumber}</td>
                                        <td>${b.areaName}</td>
                                        <td>${b.customerName}</td>
                                        <td>${b.date}</td>
                                        <td>${b.start_time} - ${b.end_time}</td>
                                        <td>${b.totalPrice}</td>
                                        <td>${serviceNames[b.booking_id]}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status eq 'pending'}">
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </c:when>
                                                <c:when test="${b.status eq 'confirmed'}">
                                                    <span class="badge bg-info text-dark">Confirmed</span>
                                                </c:when>
                                                <c:when test="${b.status eq 'cancelled'}">
                                                    <span class="badge bg-danger">Cancelled</span>
                                                </c:when>
                                                <c:when test="${b.status eq 'completed'}">
                                                    <span class="badge bg-success">Completed</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${b.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <c:if test="${b.status eq 'pending'}">
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="confirm" />
                                                        <button type="submit" class="btn btn-success">✔</button>
                                                    </form>
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="cancel" />
                                                        <button type="submit" class="btn btn-danger">✖</button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${b.status eq 'confirmed'}">
                                                    <form action="confirm-booking-manager" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                        <input type="hidden" name="action" value="complete" />
                                                        <button type="submit" class="btn btn-secondary">✓</button>
                                                    </form>
                                                </c:if>
                                                <a href="update-booking?bookingId=${b.booking_id}" class="btn btn-primary">✎</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div> <!-- end table-responsive -->
                </div> <!-- end card-body -->
            </div> <!-- end card -->
        </div> <!-- end main content -->
    </div> <!-- end row -->
</div> <!-- end container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
