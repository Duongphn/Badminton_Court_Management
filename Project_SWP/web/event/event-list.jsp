<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 50%, #dc2626 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: linear-gradient(135deg, #7f1d1d 0%, #991b1b 100%) !important;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            border-bottom: 3px solid #dc2626;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        
        .nav-link {
            font-weight: 600;
            transition: all 0.3s ease;
            padding: 8px 16px !important;
            border-radius: 20px;
        }
        
        .nav-link:hover {
            background: rgba(255,255,255,0.1);
            transform: translateY(-2px);
        }
        
        .sidebar {
            background: rgba(255,255,255,0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            margin: 20px 0;
            padding: 20px;
        }
        
        .main-content {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            margin: 20px 0;
            padding: 0;
            overflow: hidden;
        }
        
        .content-header {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }
        
        .content-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: rotate(45deg);
        }
        
        .content-header h2 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            position: relative;
            z-index: 1;
        }
        
        .content-header .btn {
            position: relative;
            z-index: 1;
        }
        
        .content-body {
            padding: 2.5rem;
        }
        
        .alert {
            border-radius: 15px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            color: #166534;
            border-left: 4px solid #10b981;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
            color: #7f1d1d;
            border-left: 4px solid #dc2626;
        }
        
        .alert-warning {
            background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%);
            color: #92400e;
            border-left: 4px solid #f59e0b;
        }
        
        .btn-add {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.3);
        }
        
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(220, 38, 38, 0.4);
            color: white;
        }
        
        .search-form {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border: 2px solid #fecaca;
        }
        
        .form-control {
            border: 2px solid #fecaca;
            border-radius: 10px;
            padding: 12px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #dc2626;
            box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.1);
        }
        
        .btn-search {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border: none;
            color: white;
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.3);
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 2px solid #fecaca;
        }
        
        .table thead th {
            background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%);
            color: #7f1d1d;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1.2rem;
            border: none;
            font-size: 0.9rem;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
            transform: translateX(5px);
        }
        
        .table tbody td {
            padding: 1.2rem;
            vertical-align: middle;
            border-color: #fecaca;
            font-weight: 500;
            color: #374151;
        }
        
        .table tbody td:first-child {
            font-weight: 700;
            color: #dc2626;
            font-size: 1.1rem;
        }
        
        .badge {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
        }
        
        .bg-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%) !important;
        }
        
        .bg-secondary {
            background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%) !important;
        }
        
        .btn-sm {
            padding: 8px 12px;
            border-radius: 8px;
            font-weight: 600;
            margin: 2px;
            transition: all 0.3s ease;
        }
        
        .btn-info {
            background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);
            border: none;
            color: white;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            border: none;
            color: white;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none;
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border: none;
            color: white;
        }
        
        .btn-sm:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .pagination-container {
            background: white;
            border-radius: 0 0 15px 15px;
            padding: 1.5rem;
            border-top: 2px solid #fecaca;
        }
        
        .pagination-info {
            color: #6b7280;
            font-weight: 500;
            padding: 10px 0;
        }
        
        .pagination-info i {
            color: #dc2626;
            margin-right: 5px;
        }
        
        .pagination .page-link {
            color: #dc2626;
            border: 2px solid #fecaca;
            margin: 0 2px;
            border-radius: 8px;
            padding: 10px 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            background: white;
        }
        
        .pagination .page-link:hover {
            background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%);
            color: #7f1d1d;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(220, 38, 38, 0.2);
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border-color: #dc2626;
            color: white;
            box-shadow: 0 3px 10px rgba(220, 38, 38, 0.3);
        }
        
        .pagination .page-item.disabled .page-link {
            color: #9ca3af;
            background: #f9fafb;
            border-color: #e5e7eb;
            cursor: not-allowed;
        }
        
        .pagination .page-item.disabled .page-link:hover {
            transform: none;
            box-shadow: none;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border: 2px solid #fecaca;
        }
        
        .stats-item {
            text-align: center;
            padding: 1rem;
        }
        
        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            color: #dc2626;
            margin-bottom: 0.5rem;
        }
        
        .stats-label {
            color: #6b7280;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .content-header {
                padding: 1.5rem;
            }
            
            .content-header h2 {
                font-size: 1.5rem;
            }
            
            .content-body {
                padding: 1.5rem;
            }
            
            .btn-sm {
                padding: 6px 8px;
                font-size: 0.8rem;
            }
            
            .table-responsive {
                font-size: 0.9rem;
            }
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #6b7280;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #fca5a5;
            margin-bottom: 1rem;
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="fas fa-calendar-check"></i> Quản lý Sự kiện
        </a>
        <div class="d-flex">
            <a class="nav-link text-light" href="login">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2">
            <div class="sidebar">
                <jsp:include page="../Sidebar.jsp" />
            </div>
        </div>

        <!-- Nội dung chính -->
        <div class="col-md-10">
            <div class="main-content fade-in">
                <div class="content-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2>
                            <i class="fas fa-calendar-alt"></i> Quản lý Sự kiện
                        </h2>
                        <a href="manage-event?action=add" class="btn-add">
                            <i class="fas fa-plus-circle"></i> Thêm Sự kiện
                        </a>
                    </div>
                </div>
                
                <div class="content-body">
                    <!-- Thông báo thành công/lỗi -->
                    <c:if test="${param.success == 'email_sent'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i> 
                            <strong>Thành công!</strong> 
                            Đã gửi email mời tham gia cho ${param.count}/${param.total} người dùng.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.error == 'event_not_found'}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i> 
                            <strong>Lỗi!</strong> Không tìm thấy sự kiện!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.error == 'no_users_found'}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i> 
                            <strong>Cảnh báo!</strong> Không tìm thấy người dùng nào để gửi email!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.error == 'send_email_failed'}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i> 
                            <strong>Lỗi!</strong> Gửi email thất bại!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- Thống kê nhanh -->
                    <div class="stats-card">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="stats-item">
                                    <div class="stats-number">${eventList.size()}</div>
                                    <div class="stats-label">Tổng sự kiện</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-item">
                                    <div class="stats-number" id="activeEvents">0</div>
                                    <div class="stats-label">Đang hoạt động</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-item">
                                    <div class="stats-number" id="inactiveEvents">0</div>
                                    <div class="stats-label">Không hoạt động</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-item">
                                    <div class="stats-number">${totalPages}</div>
                                    <div class="stats-label">Tổng trang</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bộ lọc / Tìm kiếm -->
                    <div class="search-form">
                        <form action="manage-event" method="get" class="row g-3">
                            <div class="col-md-8">
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0" style="border-color: #fecaca;">
                                        <i class="fas fa-search text-danger"></i>
                                    </span>
                                    <input type="text" name="keyword" value="${param.keyword}" class="form-control border-start-0" placeholder="Tìm theo tên sự kiện...">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-search w-100">
                                    <i class="fas fa-search"></i> Tìm kiếm
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="table-container">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-hashtag"></i> ID</th>
                                        <th><i class="fas fa-calendar-alt"></i> Tên Sự kiện</th>
                                        <th><i class="fas fa-heading"></i> Tiêu đề</th>
                                        <th><i class="fas fa-clock"></i> Ngày bắt đầu</th>
                                        <th><i class="fas fa-clock"></i> Ngày kết thúc</th>
                                        <th><i class="fas fa-map-marker-alt"></i> Khu vực</th>
                                        <th><i class="fas fa-toggle-on"></i> Trạng thái</th>
                                        <th><i class="fas fa-cogs"></i> Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="event" items="${eventList}">
                                        <tr>
                                            <td>
                                                <span class="badge bg-primary">#${event.eventId}</span>
                                            </td>
                                            <td class="text-start">
                                                <strong>${event.name}</strong>
                                            </td>
                                            <td class="text-start">
                                                <span class="text-muted">${event.title}</span>
                                            </td>
                                            <td>
                                                <i class="fas fa-calendar text-danger"></i>
                                                <fmt:formatDate value="${event.startDate}" pattern="dd/MM/yyyy"/>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-clock"></i>
                                                    <fmt:formatDate value="${event.startDate}" pattern="HH:mm"/>
                                                </small>
                                            </td>
                                            <td>
                                                <i class="fas fa-calendar text-danger"></i>
                                                <fmt:formatDate value="${event.endDate}" pattern="dd/MM/yyyy"/>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-clock"></i>
                                                    <fmt:formatDate value="${event.endDate}" pattern="HH:mm"/>
                                                </small>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty event.areaName}">
                                                        <i class="fas fa-map-marker-alt text-danger"></i>
                                                        ${event.areaName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">
                                                            <i class="fas fa-question-circle"></i>
                                                            Chưa có
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${event.status}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check-circle"></i> Hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            <i class="fas fa-times-circle"></i> Không hoạt động
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="manage-event?action=participants&id=${event.eventId}" class="btn btn-info btn-sm" title="Xem người tham gia">
                                                        <i class="fas fa-users"></i>
                                                    </a>
                                                    <a href="manage-event?action=edit&id=${event.eventId}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="manage-event?action=sendEmail&id=${event.eventId}" class="btn btn-success btn-sm" title="Gửi email"
                                                       onclick="return confirm('Bạn có chắc chắn muốn gửi email mời tham gia cho tất cả người dùng?')">
                                                        <i class="fas fa-envelope"></i>
                                                    </a>
                                                    <a href="manage-event?action=delete&id=${event.eventId}" class="btn btn-danger btn-sm" title="Xóa"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xoá sự kiện này không?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty eventList}">
                                        <tr>
                                            <td colspan="8" class="empty-state">
                                                <i class="fas fa-calendar-times"></i>
                                                <h4>Không có sự kiện nào</h4>
                                                <p>Hiện tại chưa có sự kiện nào được tạo.</p>
                                                <a href="manage-event?action=add" class="btn btn-add">
                                                    <i class="fas fa-plus-circle"></i> Tạo sự kiện đầu tiên
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <div class="pagination-container">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <div class="pagination-info">
                                        <span class="text-muted">
                                            <i class="fas fa-info-circle"></i>
                                            Hiển thị trang ${currentPage} / ${totalPages} 
                                            (${eventList.size()} sự kiện)
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-end mb-0">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="manage-event?page=1&keyword=${param.keyword}" title="Trang đầu">
                                                        <i class="fas fa-angle-double-left"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item">
                                                    <a class="page-link" href="manage-event?page=${currentPage - 1}&keyword=${param.keyword}" title="Trang trước">
                                                        <i class="fas fa-chevron-left"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <c:choose>
                                                <c:when test="${totalPages <= 7}">
                                                    <!-- Hiển thị tất cả trang nếu <= 7 trang -->
                                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="manage-event?page=${i}&keyword=${param.keyword}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Hiển thị phân trang thông minh -->
                                                    <c:if test="${currentPage > 3}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="manage-event?page=1&keyword=${param.keyword}">1</a>
                                                        </li>
                                                        <c:if test="${currentPage > 4}">
                                                            <li class="page-item disabled">
                                                                <span class="page-link">...</span>
                                                            </li>
                                                        </c:if>
                                                    </c:if>
                                                    
                                                    <c:forEach var="i" begin="${currentPage - 2}" end="${currentPage + 2}">
                                                        <c:if test="${i >= 1 && i <= totalPages}">
                                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                <a class="page-link" href="manage-event?page=${i}&keyword=${param.keyword}">${i}</a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${currentPage < totalPages - 2}">
                                                        <c:if test="${currentPage < totalPages - 3}">
                                                            <li class="page-item disabled">
                                                                <span class="page-link">...</span>
                                                            </li>
                                                        </c:if>
                                                        <li class="page-item">
                                                            <a class="page-link" href="manage-event?page=${totalPages}&keyword=${param.keyword}">${totalPages}</a>
                                                        </li>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="manage-event?page=${currentPage + 1}&keyword=${param.keyword}" title="Trang sau">
                                                        <i class="fas fa-chevron-right"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item">
                                                    <a class="page-link" href="manage-event?page=${totalPages}&keyword=${param.keyword}" title="Trang cuối">
                                                        <i class="fas fa-angle-double-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tính toán thống kê
    document.addEventListener('DOMContentLoaded', function() {
        const statusBadges = document.querySelectorAll('.badge');
        let activeCount = 0;
        let inactiveCount = 0;
        
        statusBadges.forEach(badge => {
            if (badge.textContent.includes('Hoạt động')) {
                activeCount++;
            } else if (badge.textContent.includes('Không hoạt động')) {
                inactiveCount++;
            }
        });
        
        // Hiệu ứng đếm số
        animateNumber('activeEvents', activeCount);
        animateNumber('inactiveEvents', inactiveCount);
        
        // Tự động ẩn alerts sau 5 giây
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    });
    
    function animateNumber(elementId, targetNumber) {
        const element = document.getElementById(elementId);
        let currentNumber = 0;
        const increment = targetNumber / 50; // Chia thành 50 bước
        
        const timer = setInterval(() => {
            currentNumber += increment;
            if (currentNumber >= targetNumber) {
                element.textContent = targetNumber;
                clearInterval(timer);
            } else {
                element.textContent = Math.floor(currentNumber);
            }
        }, 20);
    }
    
    // Xác nhận xóa với modal đẹp hơn
    function confirmDelete(eventName) {
        return confirm(`Bạn có chắc chắn muốn xóa sự kiện "${eventName}"?\n\nHành động này không thể hoàn tác!`);
    }
    
    // Tooltip cho các nút
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
    const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
</script>
</body>
</html>