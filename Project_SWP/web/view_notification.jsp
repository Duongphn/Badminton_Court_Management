<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Thông Báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f9fafb; /* Nền sáng hơn */
            color: #1f2937; /* Màu chữ tối để dễ đọc */
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        .navbar {
            background-color: #4b5563 !important; /* Đổi sang màu sáng hơn */
            border-bottom: 1px solid #e2e8f0;
        }

        .navbar-brand {
            color: white !important;
            font-weight: 600;
        }

        .nav-link {
            color: #e5e7eb !important;
        }

        .nav-link:hover {
            color: white !important;
        }

        .container {
            max-width: 900px;
            margin-top: 3rem;
        }

        .page-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .page-title {
            color: #1f2937;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .btn-back {
            background-color: #6b7280;
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-back:hover {
            background-color: #4b5563;
            color: white;
        }

        .notification-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #f3f4f6;
            color: #1f2937;
            padding: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .card-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .card-body {
            padding: 2rem;
        }

        .notification-content {
            background-color: #f9fafb;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 3px solid #60a5fa;
        }

        .info-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .info-item {
            background-color: #f9fafb;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .info-label {
            font-weight: 600;
            color: #4b5563;
            margin-bottom: 0.5rem;
        }

        .info-value {
            color: #1f2937;
        }

        .status-container {
            text-align: center;
            margin: 1.5rem 0;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-sent {
            background-color: #10b981;
            color: white;
        }

        .status-scheduled {
            background-color: #f59e0b;
            color: white;
        }

        .status-draft {
            background-color: #6b7280;
            color: white;
        }

        .card-footer {
            background-color: #f9fafb;
            padding: 1rem;
            text-align: center;
            color: #6b7280;
            border-top: 1px solid #e2e8f0;
        }

        .notification-image {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
            margin: 1rem 0;
        }

        @media (max-width: 768px) {
            .info-row {
                grid-template-columns: 1fr;
            }
            
            .container {
                margin-top: 1rem;
            }
            
            .card-body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-bell me-2"></i>
            Quản lý Thông Báo
        </a>
        <div class="d-flex">
            <a class="nav-link" href="login">
                <i class="bi bi-box-arrow-right me-1"></i>
                Đăng xuất
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">
            <i class="bi bi-envelope-open me-2"></i>
            Chi Tiết Thông Báo
        </h1>
        <a href="${pageContext.request.contextPath}/notification_list" class="btn-back">
            <i class="bi bi-arrow-left"></i>
            Quay lại
        </a>
    </div>

    <!-- Notification Card -->
    <div class="notification-card">
        <div class="card-header">
            <h2 class="card-title">
                <i class="bi bi-megaphone me-2"></i>
                ${notification.title}
            </h2>
        </div>
        
        <div class="card-body">
            <!-- Content -->
            <div class="notification-content">
                ${notification.content}
            </div>

            <!-- Image -->
            <c:if test="${not empty notification.imageUrl}">
                <div class="text-center">
                    <img src="${fn:replace(fn:escapeXml(notification.imageUrl), ' ', '%20')}"
                         class="notification-image" 
                         alt="Notification Image">
                </div>
            </c:if>

            <!-- Information -->
            <div class="info-row">
                <div class="info-item">
                    <div class="info-label">
                        <i class="bi bi-calendar-plus me-1"></i>
                        Lên lịch
                    </div>
                    <div class="info-value">${notification.scheduledTime}</div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">
                        <i class="bi bi-send me-1"></i>
                        Đã gửi
                    </div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${not empty notification.sentTime}">${notification.sentTime}</c:when>
                            <c:otherwise>
                                <span class="text-muted">Chưa gửi</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Status -->
            <div class="status-container">
                <div class="info-label mb-2">Trạng thái</div>
                <c:choose>
                    <c:when test="${notification.status eq 'sent'}">
                        <span class="status-badge status-sent">
                            <i class="bi bi-check-circle"></i>
                            Đã gửi
                        </span>
                    </c:when>
                    <c:when test="${notification.status eq 'scheduled'}">
                        <span class="status-badge status-scheduled">
                            <i class="bi bi-clock"></i>
                            Đã lên lịch
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-draft">
                            <i class="bi bi-pencil"></i>
                            Bản nháp
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="card-footer">
            <i class="bi bi-calendar3 me-1"></i>
            Ngày tạo: ${notification.createdAt}
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
