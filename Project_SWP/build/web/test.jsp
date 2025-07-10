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
        }
        .table th, .table td {
            vertical-align: middle !important;
        }
        /* Đảm bảo nội dung luôn nằm giữa màn hình (giữa chiều ngang) */
        .center-content {
            min-height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        /* Cuộn dọc khi danh sách dài quá */
        .scroll-table {
            max-height: 420px;
            overflow-y: auto;
        }
        /* Fix spacing ở sidebar */
        @media (min-width: 992px) {
            .container-page {
                max-width: 950px;
                margin: auto;
            }
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

                <!-- Filter Form -->
                <form class="row g-3 mb-4" method="get" action="revenue-report">
                    <div class="col-md-4">
                        <label for="fromDate" class="form-label">Từ ngày</label>
                        <input type="date" class="form-control" id="fromDate" name="fromDate"
                               value="${fromDate}">
                    </div>
                    <div class="col-md-4">
                        <label for="toDate" class="form-label">Đến ngày</label>
                        <input type="date" class="form-control" id="toDate" name="toDate"
                               value="${toDate}">
                    </div>
                    <div class="col-md-4">
                        <label for="courtId" class="form-label">ID Sân (bỏ trống = tất cả)</label>
                        <input type="number" class="form-control" id="courtId" name="courtId"
                               value="${courtId != null ? courtId : ''}" min="1">
                    </div>
                    <div class="col-12 text-end">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-funnel"></i> Lọc</button>
                    </div>
                </form>

                <!-- Revenue -->
                <div class="alert alert-success mb-4 text-center">
                    <i class="bi bi-cash-coin"></i>
                    <b>Tổng doanh thu: </b>
                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                </div>

                <!-- Table scrollable -->
                <div class="card shadow-sm mb-3">
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
                                        <td>
                                            ${b.date}
                                        </td>
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
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
