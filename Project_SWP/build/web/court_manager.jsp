<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.CourtDAO,java.util.List,Model.Courts" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    if (request.getAttribute("courts") == null) {
        CourtDAO dao = new CourtDAO();
        List<Courts> courts = dao.getAllCourts();
        request.setAttribute("courts", courts);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sân Cầu Lông</title>
    <!-- Bootstrap + Font -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #3b82f6;
            --light-color: #f8fafc;
            --dark-color: #1e293b;
            --muted-color: #64748b;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            color: var(--dark-color);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-lg);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            font-size: 1.5rem;
        }

        .navbar .nav-link {
            color: var(--dark-color) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .navbar .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            margin: 30px 0;
            box-shadow: var(--shadow-xl);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .main-content::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.05) 0%, transparent 70%);
            animation: floating 20s infinite ease-in-out;
        }

        @keyframes floating {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
        }

        .page-title {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 1;
        }

        /* Search Bar */
        .search-bar {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
        }

        .search-input-group {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            max-width: 400px;
        }

        .search-input {
            border: 2px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 20px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            flex: 1;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        /* Buttons */
        .btn {
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        /* Table */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            z-index: 1;
        }

        .table-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px 30px;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .table {
            margin-bottom: 0;
            background: transparent;
        }

        .table th {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(139, 92, 246, 0.1));
            color: var(--dark-color);
            font-weight: 600;
            padding: 18px 15px;
            border: none;
            position: relative;
        }

        .table th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }

        .table td {
            padding: 15px;
            border: none;
            border-bottom: 1px solid rgba(226, 232, 240, 0.5);
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .table-hover tbody tr:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: translateX(5px);
        }

        .table-hover tbody tr:hover td {
            border-bottom-color: var(--primary-color);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-available {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
        }

        .status-maintenance {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
        }

        .status-booked {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        /* Modal */
        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: var(--shadow-xl);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border: none;
            padding: 20px 30px;
        }

        .modal-title {
            font-weight: 600;
            font-size: 1.3rem;
        }

        .modal-body {
            padding: 30px;
        }

        .modal-footer {
            border: none;
            padding: 20px 30px;
            background: rgba(248, 250, 252, 0.8);
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        /* Form */
        .form-group label {
            font-weight: 500;
            color: var(--dark-color);
            margin-bottom: 8px;
        }

        .form-control {
            border: 2px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 350px;
            padding: 20px 25px;
            border-radius: 15px;
            box-shadow: var(--shadow-xl);
            display: none;
            animation: slideInRight 0.5s ease-out;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .notification.success {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.9), rgba(5, 150, 105, 0.9));
            color: white;
        }

        .notification.error {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.9), rgba(220, 38, 38, 0.9));
            color: white;
        }

        .notification .close-btn {
            float: right;
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: inherit;
            padding: 0;
            margin-left: 15px;
            transition: all 0.3s ease;
        }

        .notification .close-btn:hover {
            transform: scale(1.1);
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%) scale(0.8);
                opacity: 0;
            }
            to {
                transform: translateX(0) scale(1);
                opacity: 1;
            }
        }

        @keyframes slideOutRight {
            from {
                transform: translateX(0) scale(1);
                opacity: 1;
            }
            to {
                transform: translateX(100%) scale(0.8);
                opacity: 0;
            }
        }

        /* Court Link */
        .court-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .court-link:hover {
            color: var(--secondary-color);
            text-decoration: none;
            transform: translateX(3px);
        }

        /* Price Display */
        .price-display {
            font-weight: 600;
            color: var(--success-color);
            font-size: 1.1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
                margin: 15px 0;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .search-bar {
                flex-direction: column;
                align-items: stretch;
                gap: 20px;
            }
            
            .search-input-group {
                max-width: none;
            }
            
            .notification {
                right: 10px;
                left: 10px;
                min-width: auto;
            }
            
            .table-container {
                overflow-x: auto;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Hover Effects */
        .btn-sm {
            padding: 8px 16px;
            font-size: 12px;
            margin: 2px;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
            justify-content: center;
            align-items: center;
        }

        /* Enhanced shadows for depth */
        .card-hover {
            transition: all 0.3s ease;
        }

        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="fas fa-basketball-ball"></i> Court Manager
        </a>
        <div class="d-flex">
            <a class="nav-link" href="login">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</nav>

<c:if test="${sessionScope.user.role eq 'admin'}">
                    <!-- Modal thêm sân -->
                    <div class="modal fade" id="addCourtModal" tabindex="-1" aria-labelledby="addCourtModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Thêm Sân Mới</h5>
                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                                </div>
                                <div class="modal-body">
                                    <form action="courts" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="action" value="add">
                                        <c:if test="${not empty areaId}">
                                            <input type="hidden" name="redirectAreaId" value="${areaId}">
                                        </c:if>
                                        <div class="form-group">
                                            <label><i class="fas fa-tag"></i> Tên Sân</label>
                                            <input type="text" class="form-control" name="courtNumber" required>
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-layer-group"></i> Loại Sân</label>
                                            <input type="text" class="form-control" name="type">
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-cube"></i> Chất Liệu Sàn</label>
                                            <input type="text" class="form-control" name="floorMaterial">
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-lightbulb"></i> Hệ Thống Chiếu Sáng</label>
                                            <input type="text" class="form-control" name="lighting">
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-dollar-sign"></i> Giá</label>
                                            <input type="number" step="0.01" class="form-control" name="price" required>
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-align-left"></i> Mô Tả</label>
                                            <input type="text" class="form-control" name="description">
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-image"></i> Ảnh</label>
                                            <input type="file" class="form-control" name="image" accept="image/*">
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-toggle-on"></i> Trạng Thái</label>
                                            <select class="form-control" name="status" required>
                                                <option value="available">Available</option>
                                                <option value="maintenance">Maintenance</option>
                                                <option value="booked">Booked</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label><i class="fas fa-map-marker-alt"></i> Khu Vực ID</label>
                                            <input type="number" class="form-control" id="addAreaId" name="areaId" required min="1" value="${areaId}">
                                            <small class="form-text text-muted">Nhập ID khu vực hợp lệ</small>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-save"></i> Lưu
                                            </button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                <i class="fas fa-times"></i> Hủy
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Modal sửa sân -->
                <div class="modal fade" id="updateCourtModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><i class="fas fa-edit"></i> Chỉnh Sửa Sân</h5>
                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <form action="courts" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="update">
                                    <c:if test="${not empty areaId}">
                                        <input type="hidden" name="redirectAreaId" value="${areaId}">
                                    </c:if>
                                    <input type="hidden" name="courtId" id="updateCourtId">
                                    <div class="form-group">
                                        <label><i class="fas fa-tag"></i> Tên Sân</label>
                                        <input type="text" class="form-control" id="updateCourtNumber" name="courtNumber" required>
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-layer-group"></i> Loại Sân</label>
                                        <input type="text" class="form-control" id="updateType" name="type">
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-cube"></i> Chất Liệu Sàn</label>
                                        <input type="text" class="form-control" id="updateFloorMaterial" name="floorMaterial">
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-lightbulb"></i> Hệ Thống Chiếu Sáng</label>
                                        <input type="text" class="form-control" id="updateLighting" name="lighting">
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-dollar-sign"></i> Giá</label>
                                        <input type="number" step="0.01" class="form-control" id="updatePrice" name="price" required>
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-align-left"></i> Mô Tả</label>
                                        <input type="text" class="form-control" id="updateDescription" name="description">
                                    </div>
                                    <input type="hidden" name="currentImage" id="currentImage">
                                    <div class="form-group">
                                        <label><i class="fas fa-image"></i> Ảnh</label>
                                        <input type="file" class="form-control" id="updateImage" name="image" accept="image/*">
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-toggle-on"></i> Trạng Thái</label>
                                        <select class="form-control" id="updateStatus" name="status" required>
                                            <option value="available">Available</option>
                                            <option value="maintenance">Maintenance</option>
                                            <option value="booked">Booked</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label><i class="fas fa-map-marker-alt"></i> Khu Vực ID</label>
                                        <input type="number" class="form-control" id="updateAreaId" name="areaId" required min="1">
                                        <small class="form-text text-muted">Nhập ID khu vực hợp lệ</small>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-check"></i> Cập Nhật
                                        </button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                            <i class="fas fa-times"></i> Hủy
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-md-2 mb-4">
            <c:choose>
                <c:when test="${fn:toLowerCase(fn:trim(sessionScope.user.role)) eq 'staff'}">
                    <jsp:include page="Sidebar_Staff.jsp" />
                </c:when>
                <c:otherwise>
                    <jsp:include page="Sidebar.jsp" />
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-md-10">
            <!-- Thông báo -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div id="notification" class="notification success">
                    <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                    <button class="close-btn" onclick="closeNotification()">&times;</button>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div id="notification" class="notification error">
                    <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                    <button class="close-btn" onclick="closeNotification()">&times;</button>
                </div>
            </c:if>

            <div class="main-content">
                <h1 class="page-title">
                    <i class="fas fa-building"></i> Quản Lý Sân Cầu Lông
                </h1>

                <div class="search-bar">
                    <div class="search-input-group">
                        <input type="text" id="searchInput" class="search-input" placeholder="🔍 Tìm kiếm theo số sân...">
                        <button class="btn btn-outline-primary" onclick="searchCourts()">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                    <c:if test="${sessionScope.user.role eq 'admin'}">
                        <button class="btn btn-success" data-toggle="modal" data-target="#addCourtModal">
                            <i class="fas fa-plus"></i> Thêm Sân
                        </button>
                    </c:if>
                </div>

                

                <!-- Danh sách sân -->
                <div class="table-container card-hover">
                    <div class="table-header">
                        <i class="fas fa-list"></i> Danh Sách Sân Cầu Lông
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> Mã Sân</th>
                                <th><i class="fas fa-tag"></i> Tên Sân</th>
                                <th><i class="fas fa-layer-group"></i> Loại</th>
                                <th><i class="fas fa-cube"></i> Chất Liệu</th>
                                <th><i class="fas fa-lightbulb"></i> Chiếu Sáng</th>
                                <th><i class="fas fa-dollar-sign"></i> Giá</th>
                                <th><i class="fas fa-align-left"></i> Mô Tả</th>
                                <th><i class="fas fa-toggle-on"></i> Trạng Thái</th>
                                <th><i class="fas fa-map-marker-alt"></i> Khu Vực ID</th>
                                <th><i class="fas fa-cogs"></i> Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="court" items="${courts}">
                                <tr>
                                    <td><span class="badge badge-secondary">${court.court_id}</span></td>
                                    <td>
                                        <a href="staff-court-detail?courtId=${court.court_id}" class="court-link">
                                            <i class="fas fa-external-link-alt"></i> ${court.court_number}
                                        </a>
                                    </td>
                                    <td>${court.type}</td>
                                    <td>${court.floor_material}</td>
                                    <td>${court.lighting}</td>
                                    <td><span class="price-display">${court.price}đ</span></td>
                                    <td>${court.description}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${court.status eq 'available'}">
                                                <span class="status-badge status-available">
                                                    <i class="fas fa-check-circle"></i> Available
                                                </span>
                                            </c:when>
                                            <c:when test="${court.status eq 'maintenance'}">
                                                <span class="status-badge status-maintenance">
                                                    <i class="fas fa-wrench"></i> Maintenance
                                                </span>
                                            </c:when>
                                            <c:when test="${court.status eq 'booked'}">
                                                <span class="status-badge status-booked">
                                                    <i class="fas fa-calendar-check"></i> Booked
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td><span class="badge badge-info">${court.area_id}</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-sm btn-warning edit-btn"
                                                    data-id="${court.court_id}"
                                                    data-number="${court.court_number}"
                                                    data-type="${court.type}"
                                                    data-floor="${court.floor_material}"
                                                    data-lighting="${court.lighting}"
                                                    data-description="${court.description}"
                                                    data-status="${court.status}"
                                                    data-area="${court.area_id}"
                                                    data-price="${court.price}"
                                                    title="Chỉnh sửa sân">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <c:if test="${sessionScope.user.role eq 'admin'}">
                                                <form action="courts" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <c:if test="${not empty areaId}">
                                                        <input type="hidden" name="redirectAreaId" value="${areaId}">
                                                    </c:if>
                                                    <input type="hidden" name="courtId" value="${court.court_id}">
                                                    <button type="submit" class="btn btn-sm btn-danger"
                                                            onclick="return confirm('Bạn có chắc muốn xóa sân này không?')"
                                                            title="Xóa sân">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </c:if>
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

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Notification handling
    window.onload = function() {
        const notification = document.getElementById('notification');
        if (notification) {
            notification.style.display = 'block';
            // Auto hide after 5 seconds
            setTimeout(() => {
                closeNotification();
            }, 5000);
        }
        
        // Add loading states to buttons
        addLoadingStates();
        
        // Initialize tooltips
        $('[data-toggle="tooltip"]').tooltip();
    };

    // Close notification with animation
    function closeNotification() {
        const notification = document.getElementById('notification');
        if (notification) {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                notification.style.display = 'none';
            }, 300);
        }
    }

    // Enhanced search function
    function searchCourts() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toUpperCase();
        const rows = document.querySelectorAll("table tbody tr");
        
        // Add loading state to search button
        const searchBtn = document.querySelector('.btn-outline-primary');
        const originalText = searchBtn.innerHTML;
        searchBtn.innerHTML = '<div class="loading"></div> Đang tìm...';
        searchBtn.disabled = true;
        
        setTimeout(() => {
            let visibleCount = 0;
            rows.forEach(row => {
                const courtNumber = row.cells[1].textContent.toUpperCase();
                const courtType = row.cells[2].textContent.toUpperCase();
                const isVisible = courtNumber.includes(filter) || courtType.includes(filter);
                
                if (isVisible) {
                    row.style.display = "";
                    row.style.animation = "fadeIn 0.3s ease-in";
                    visibleCount++;
                } else {
                    row.style.display = "none";
                }
            });
            
            // Show result count
            showSearchResults(visibleCount);
            
            // Restore search button
            searchBtn.innerHTML = originalText;
            searchBtn.disabled = false;
        }, 500);
    }

    // Show search results count
    function showSearchResults(count) {
        const existingResult = document.querySelector('.search-result');
        if (existingResult) {
            existingResult.remove();
        }
        
        const searchBar = document.querySelector('.search-bar');
        const resultDiv = document.createElement('div');
        resultDiv.className = 'search-result';
        resultDiv.innerHTML = `
            <small class="text-muted">
                <i class="fas fa-info-circle"></i> Tìm thấy ${count} kết quả
            </small>
        `;
        searchBar.appendChild(resultDiv);
        
        setTimeout(() => {
            if (resultDiv.parentNode) {
                resultDiv.remove();
            }
        }, 3000);
    }

    // Enhanced edit modal
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            // Add loading state
            const originalText = this.innerHTML;
            this.innerHTML = '<div class="loading"></div>';
            this.disabled = true;
            
            setTimeout(() => {
                // Populate modal fields
                document.getElementById('updateCourtId').value = this.dataset.id;
                document.getElementById('updateCourtNumber').value = this.dataset.number;
                document.getElementById('updateType').value = this.dataset.type || '';
                document.getElementById('updateFloorMaterial').value = this.dataset.floor || '';
                document.getElementById('updateLighting').value = this.dataset.lighting || '';
                document.getElementById('updateDescription').value = this.dataset.description || '';
                document.getElementById('currentImage').value = this.dataset.image || '';
                document.getElementById('updateStatus').value = this.dataset.status;
                document.getElementById('updatePrice').value = this.dataset.price;
                document.getElementById('updateAreaId').value = this.dataset.area;
                
                // Show modal
                $('#updateCourtModal').modal('show');
                
                // Restore button
                this.innerHTML = originalText;
                this.disabled = false;
            }, 300);
        });
    });

    // Add loading states to form submissions
    function addLoadingStates() {
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<div class="loading"></div> Đang xử lý...';
                    submitBtn.disabled = true;
                }
            });
        });
    }

    // Enhanced search with Enter key
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchCourts();
        }
    });

    // Real-time search
    document.getElementById('searchInput').addEventListener('input', function() {
        clearTimeout(this.searchTimeout);
        this.searchTimeout = setTimeout(() => {
            searchCourts();
        }, 300);
    });

    // Add fade-in animation to table rows
    document.querySelectorAll('table tbody tr').forEach((row, index) => {
        row.style.animation = `fadeIn 0.5s ease-in ${index * 0.1}s both`;
    });

    // Add CSS for fadeIn animation
    const style = document.createElement('style');
    style.textContent = `
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
    `;
    document.head.appendChild(style);

    // Modal enhancement
    $('.modal').on('show.bs.modal', function() {
        $(this).find('.modal-dialog').css({
            'transform': 'scale(0.8)',
            'opacity': '0'
        });
        setTimeout(() => {
            $(this).find('.modal-dialog').css({
                'transform': 'scale(1)',
                'opacity': '1',
                'transition': 'all 0.3s ease'
            });
        }, 50);
    });

    // Add hover effect to table rows
    document.querySelectorAll('table tbody tr').forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(5px)';
            this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.1)';
        });
        
        row.addEventListener('mouseleave', function() {
            this.style.transform = 'translateX(0)';
            this.style.boxShadow = 'none';
        });
    });
</script>
</body>
</html>