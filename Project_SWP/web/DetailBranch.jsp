<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Branch Detail</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #377dff;           /* Xanh biển đậm */
                --secondary-color: #2b4c7e;         /* Xanh navy */
                --success-color: #48e6a0;           /* Xanh lá nhạt */
                --danger-color: #ff6b6b;            /* Đỏ dùng cho xóa/cảnh báo */
                --warning-color: #ffbe76;           /* Cam nhạt */
                --info-color: #3ec6e0;              /* Xanh cyan */
                --light-color: #f5faff;             /* Nền xanh nhạt */
                --dark-color: #23304d;              /* Xanh navy đậm */
                --gradient-bg: linear-gradient(135deg, #377dff 0%, #3ec6e0 100%);
                --card-shadow: 0 4px 20px rgba(55,125,255,0.08);
                --hover-shadow: 0 8px 30px rgba(55,125,255,0.18);
            }
           body {
    background-color: #f4f6f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    min-height: 100vh;
}
          .navbar {
    background-color: #ffffff !important;
    padding: 10px 20px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    border: none;
}
.navbar-brand {
    color: #007bff !important;
    font-weight: 700;
    font-size: 1.5rem;
}


            .navbar-toggler {
                border-color: rgba(255,255,255,0.3);
            }

            .nav-link {
                color: white !important;
                background: rgba(255,255,255,0.1) !important;
                border: 1px solid rgba(255,255,255,0.2) !important;
                border-radius: 25px !important;
                padding: 8px 20px !important;
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.2) !important;
                transform: translateY(-2px);
            }

            .container-fluid {
                padding: 0;
            }

           .main-content {
    padding: 30px;
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 0 15px rgba(0,0,0,0.05);
}

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

            .page-title {
                background: var(--gradient-bg);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 700;
                font-size: 2.5rem;
                margin-bottom: 30px;
                text-align: center;
            }

            .info-card {
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fc 100%);
                border: none;
                border-radius: 20px;
                box-shadow: var(--card-shadow);
                transition: all 0.3s ease;
                margin-bottom: 30px;
                overflow: hidden;
            }

            .info-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--hover-shadow);
            }

            .card-header-custom {
                background: var(--gradient-bg);
                color: white;
                padding: 20px;
                border-radius: 20px 20px 0 0 !important;
                border: none;
            }


            .card-title {
                font-weight: 600;
                margin: 0;
                font-size: 1.3rem;
            }

            .info-item {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                padding: 10px;
                background: rgba(102, 126, 234, 0.05);
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .info-item:hover {
                background: rgba(102, 126, 234, 0.1);
                transform: translateX(5px);
            }

            .info-icon {
                color: var(--primary-color);
                margin-right: 15px;
                font-size: 1.2rem;
                min-width: 25px;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 40px 0 20px 0;
                padding-bottom: 15px;
                border-bottom: 3px solid var(--primary-color);
            }

            .section-title {
                color: var(--dark-color);
                font-weight: 600;
                font-size: 1.8rem;
                margin: 0;
            }

            .btn-custom {
                background: var(--gradient-bg);
                border: none;
                color: white;
                padding: 12px 25px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(55,125,255,0.18);
            }
            .btn-custom:hover {
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(55,125,255,0.30);
            }


            .btn-custom i {
                margin-right: 8px;
            }

            .table-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: var(--card-shadow);
                margin-bottom: 30px;
            }

            .table {
                margin: 0;
                border-collapse: separate;
                border-spacing: 0;
            }

            .table thead th {
                background: var(--gradient-bg);
                color: white;
                border: none;
                font-weight: 600;
                padding: 20px 15px;
                text-align: center;
                font-size: 0.95rem;
            }


            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: rgba(102, 126, 234, 0.05);
                transform: scale(1.01);
            }

           .table thead th {
    background-color: #007bff !important;
    color: #fff;
    border: none;
}

            .table tbody tr:first-child td {
                border-top: none;
            }

            .btn-danger-custom {
                background: linear-gradient(135deg, #ff6b6b, #fd5e53);
                border: none;
                color: white;
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.85rem;
                transition: all 0.3s ease;
            }
            .btn-danger-custom:hover {
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(238, 90, 82, 0.30);
            }

           .modal-content {
    border-radius: 12px;
}
.modal-header {
    background-color: #007bff;
    color: #fff;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

            .modal-title {
                font-weight: 600;
                font-size: 1.3rem;
            }

            .modal-body {
                padding: 30px;
            }

            .form-group label {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 8px;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 12px 15px;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .modal-footer {
                border: none;
                padding: 20px 30px 30px;
            }

            .loading-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
                z-index: 9999;
                backdrop-filter: blur(5px);
            }

            .spinner {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                border: 4px solid rgba(255,255,255,0.3);
                border-top: 4px solid #ffffff;
                border-radius: 50%;
                width: 60px;
                height: 60px;
                animation: spin 1s linear infinite;
            }

            .loading-text {
                position: absolute;
                top: 60%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;
                font-size: 1.1rem;
                font-weight: 500;
                margin-top: 20px;
            }

            @keyframes spin {
                0% {
                    transform: translate(-50%, -50%) rotate(0deg);
                }
                100% {
                    transform: translate(-50%, -50%) rotate(360deg);
                }
            }

            .court-image {
                border-radius: 10px;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .court-image:hover {
                transform: scale(1.1);
                box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            }

            .branch-image {
                border-radius: 15px;
                transition: all 0.3s ease;
                cursor: pointer;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .branch-image:hover {
                transform: scale(1.05);
                box-shadow: 0 6px 25px rgba(0,0,0,0.2);
            }

            .alert-custom {
                border: none;
                border-radius: 15px;
                padding: 20px;
                margin: 20px 0;
                font-weight: 500;
                box-shadow: var(--card-shadow);
            }

            .alert-success-custom {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
                border-left: 5px solid #28a745;
            }

            .alert-warning-custom {
                background: linear-gradient(135deg, #fff3cd, #ffeaa7);
                color: #856404;
                border-left: 5px solid #ffc107;
            }

            .alert-error-custom {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                color: #721c24;
                border-left: 5px solid #dc3545;
            }

            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 10px;
                color: white;
                font-weight: 500;
                z-index: 10000;
                transform: translateX(400px);
                transition: all 0.3s ease;
                box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            }

            .notification.show {
                transform: translateX(0);
            }

            .notification.success {
                background: linear-gradient(135deg, #48e6a0, #22b8cf);
            }
            .notification.error {
                background: linear-gradient(135deg, #ff6b6b, #fd7e14);
            }
            .notification.warning {
                background: linear-gradient(135deg, #ffe066, #ffd166);
                color: #8d6708;
            }


            .close-btn {
                margin-left: 15px;
                cursor: pointer;
                font-weight: bold;
            }

            .stats-card {
                background: var(--gradient-bg);
                color: white;
                border-radius: 15px;
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
                transition: all 0.3s ease;
            }

            .stats-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--hover-shadow);
            }

            .stats-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 5px;
            }

            .stats-label {
                font-size: 0.9rem;
                opacity: 0.9;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .main-content {
                    margin: 10px;
                    padding: 20px;
                }

                .page-title {
                    font-size: 2rem;
                }

                .section-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .table-responsive {
                    font-size: 0.8rem;
                }

            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shuttlecock-cock"></i>

            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <button class="nav-link" onclick="history.back()">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại
                        </button>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <div >
                        <jsp:include page="Sidebar.jsp" />
                    </div>
                </div>
                <div class="col-md-10" style="margin-left: 280px">
                    <div class="main-content">
                        <h1 class="page-title">Chi tiết khu vực: ${area_id}</h1>

                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number">${listShift.size()}</div>
                                    <div class="stats-label">Ca làm việc</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number">${areaImages.size()}</div>
                                    <div class="stats-label">Hình ảnh</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number">${areaAllServices.size()}</div>
                                    <div class="stats-label">Dịch vụ</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="stats-number">${areaCourts.size()}</div>
                                    <div class="stats-label">Sân cầu lông</div>
                                </div>
                            </div>
                        </div>

                        <!-- Area Info -->
                        <div class="info-card">
                            <div class="card-header-custom">
                                <h4 class="card-title">
                                    <i class="fas fa-info-circle"></i>
                                    Thông tin khu vực
                                </h4>
                            </div>
                            <div class="card-body p-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <i class="fas fa-building info-icon"></i>
                                            <div>
                                                <strong>Tên khu vực:</strong> ${areaDetail.name}
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <i class="fas fa-map-marker-alt info-icon"></i>
                                            <div>
                                                <strong>Địa điểm:</strong> ${areaDetail.location}
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <i class="fas fa-clock info-icon"></i>
                                            <div>
                                                <strong>Giờ mở cửa:</strong> ${areaDetail.openTime}
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <i class="fas fa-clock info-icon"></i>
                                            <div>
                                                <strong>Giờ đóng cửa:</strong> ${areaDetail.closeTime}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <i class="fas fa-align-left info-icon"></i>
                                            <div>
                                                <strong>Mô tả:</strong> ${areaDetail.description}
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <i class="fas fa-user-tie info-icon"></i>
                                            <div>
                                                <strong>Tên quản lí:</strong> ${areaDetail.nameStaff}
                                            </div>
                                        </div>
                                        <div class="info-item">
                                            <i class="fas fa-phone info-icon"></i>
                                            <div>
                                                <strong>Số điện thoại:</strong> ${areaDetail.phone_branch}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <!-- Courts Section -->
                        <div class="section-header">
                            <h4 class="section-title">
                                <i class="fas fa-tennis-ball"></i>
                                Sân trong khu vực
                            </h4>
                        </div>

                        <div class="table-container">
                            <div class="table-responsive">
                                <table class="table" id="courtsTable">
                                    <thead>
                                        <tr>

                                            <th>Số sân</th>
                                            <th>Thể loại</th>
                                            <th>Sàn sân</th>
                                            <th>Ánh sáng</th>
                                            <th>Mô tả</th>
                                            <th>Ảnh</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="court" items="${areaCourts}" varStatus="loop">
                                            <tr>

                                                <td><strong>Sân ${court.court_number}</strong></td>
                                                <td><span class="badge badge-info">${court.type}</span></td>
                                                <td>${court.floor_material}</td>
                                                <td>${court.lighting}</td>
                                                <td>${court.description}</td>
                                                <td>
                                                    <c:if test="${not empty court.image_url}">
                                                        <img src="${court.image_url}" 
                                                             alt="court image" 
                                                             width="100" 
                                                             class="court-image"
                                                             onclick="openImageModal('${court.image_url}')">
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <span class="badge ${court.status == 'Active' ? 'badge-success' : 'badge-secondary'}">
                                                        ${court.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Shifts Section -->
                        <div class="section-header">
                            <h4 class="section-title">
                                <i class="fas fa-calendar-alt"></i>
                                Danh sách ca làm việc
                            </h4>
                            <button type="button" class="btn btn-custom" data-toggle="modal" data-target="#addShiftModal">
                                <i class="fas fa-plus"></i>
                                Thêm ca
                            </button>
                        </div>

                        <div class="table-container">
                            <div class="table-responsive">
                                <table id="shiftTable" class="table">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên ca</th>
                                            <th>Thời gian bắt đầu</th>
                                            <th>Thời gian kết thúc</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="shift" items="${listShift}" varStatus="loop">
                                            <tr>
                                                <td>${loop.count}</td>
                                                <td><strong>${shift.shiftName}</strong></td>
                                                <td><i class="fas fa-play text-success"></i> ${shift.startTime}</td>
                                                <td><i class="fas fa-stop text-danger"></i> ${shift.endTime}</td>
                                                <td>
                                                    <a href="delete-shift?shiftId=${shift.shiftId}&area_id=${area_id}" 
                                                       onclick="return confirmDelete('ca làm việc này')" 
                                                       class="btn btn-danger-custom">
                                                        <i class="fas fa-trash"></i>
                                                        Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Images Section -->
                        <div class="section-header">
                            <h4 class="section-title">
                                <i class="fas fa-images"></i>
                                Ảnh của khu vực
                            </h4>
                            <button type="button" class="btn btn-custom" data-toggle="modal" data-target="#addImageModal">
                                <i class="fas fa-plus"></i>
                                Thêm ảnh
                            </button>
                        </div>

                        <div class="table-container">
                            <div class="table-responsive">
                                <table id="imageTable" class="table">
                                    <thead>
                                        <tr>

                                            <th>Ảnh</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="image" items="${areaImages}" varStatus="loop">
                                            <tr>

                                                <td>
                                                    <img src="${image.imageURL}" 
                                                         alt="Branch Image" 
                                                         width="120" 
                                                         class="branch-image"
                                                         onclick="openImageModal('${image.imageURL}')">
                                                </td>
                                                <td>
                                                    <a href="delete-image?image_id=${image.image_id}&area_id=${image.area_id}" 
                                                       onclick="return confirmDelete('ảnh này')" 
                                                       class="btn btn-danger-custom">
                                                        <i class="fas fa-trash"></i>
                                                        Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Services Section -->
                        <div class="section-header">
                            <h4 class="section-title">
                                <i class="fas fa-concierge-bell"></i>
                                Danh sách dịch vụ
                            </h4>
                            <button type="button" class="btn btn-custom" data-toggle="modal" data-target="#addServiceModal">
                                <i class="fas fa-plus"></i>
                                Thêm dịch vụ
                            </button>
                        </div>

                        <div class="table-container">
                            <div class="table-responsive">
                                <table id="serviceTable" class="table">
                                    <thead>
                                        <tr>

                                            <th>Tên dịch vụ</th>
                                            <th>Giá</th>
                                            <th>Mô tả</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="s" items="${areaAllServices}" varStatus="loop">
                                            <tr>

                                                <td><strong>${s.service.name}</strong></td>
                                                <td><span class="badge badge-success">${s.service.price} VNĐ</span></td>
                                                <td>${s.service.description}</td>
                                                <td>
                                                    <a href="remove-service?areaServiceID=${s.areaService_id}&area_id=${area_id}" 
                                                       onclick="return confirmDelete('dịch vụ này')" 
                                                       class="btn btn-danger-custom">
                                                        <i class="fas fa-trash"></i>
                                                        Xóa
                                                    </a>
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

        <!-- Modals -->
        <!-- Add Shift Modal -->
        <div class="modal fade" id="addShiftModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <form action="add-shift" method="post" class="modal-content" onsubmit="showLoading()">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-plus-circle"></i>
                            Thêm ca mới
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span style="color: white;">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="area_id" value="${area_id}" />
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Tên ca</label>
                            <input type="text" name="shiftName" class="form-control" placeholder="Nhập tên ca làm việc" required />
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-play"></i> Thời gian bắt đầu</label>
                            <input type="time" name="startTime" class="form-control" step="1800" required />
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-stop"></i> Thời gian kết thúc</label>
                            <input type="time" name="endTime" class="form-control" step="1800" required />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-custom">
                            <i class="fas fa-save"></i>
                            Thêm ca
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <i class="fas fa-times"></i>
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Add Image Modal -->
        <div class="modal fade" id="addImageModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <form action="add-image" method="post" enctype="multipart/form-data" class="modal-content" onsubmit="showLoading()">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-image"></i>
                            Thêm ảnh mới
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span style="color: white;">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="area_id" value="${area_id}" />
                        <div class="form-group">
                            <label for="image"><i class="fas fa-upload"></i> Chọn ảnh</label>
                            <input type="file" class="form-control" name="image" id="image" accept="image/*" required />
                            <small class="form-text text-muted">Chỉ chấp nhận file ảnh (JPG, PNG, GIF)</small>
                        </div>
                        <div class="form-group">
                            <div id="imagePreview" style="display: none;">
                                <img id="previewImg" src="" alt="Preview" style="max-width: 100%; height: 200px; object-fit: cover; border-radius: 10px; margin-top: 10px;">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-custom">
                            <i class="fas fa-save"></i>
                            Thêm ảnh
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <i class="fas fa-times"></i>
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Add Service Modal -->
        <div class="modal fade" id="addServiceModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <form action="add-service-branch" method="post" class="modal-content" onsubmit="showLoading()">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-concierge-bell"></i>
                            Thêm dịch vụ cho khu vực
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span style="color: white;">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="area_id" value="${area_id}" />
                        <div class="form-group">
                            <label><i class="fas fa-list"></i> Chọn dịch vụ</label>
                            <select name="service_id" class="form-control" required>
                                <option value="">-- Chọn dịch vụ --</option>
                                <c:forEach var="service" items="${allServices}">
                                    <option value="${service.service_id}">${service.name} - ${service.price} VNĐ</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-custom">
                            <i class="fas fa-save"></i>
                            Thêm dịch vụ
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <i class="fas fa-times"></i>
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Image View Modal -->
        <div class="modal fade" id="imageViewModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-eye"></i>
                            Xem ảnh
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="modalImage" src="" alt="Full Image" style="max-width: 100%; height: auto; border-radius: 15px;">
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="spinner"></div>
            <div class="loading-text">Đang xử lý...</div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div class="notification success show" id="successNotification">
                <i class="fas fa-check-circle"></i>
                ${param.success}
                <span class="close-btn" onclick="hideNotification('successNotification')">&times;</span>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="notification error show" id="errorNotification">
                <i class="fas fa-exclamation-circle"></i>
                ${param.error}
                <span class="close-btn" onclick="hideNotification('errorNotification')">&times;</span>
            </div>
        </c:if>

        <c:if test="${not empty param.message}">
            <div class="notification warning show" id="messageNotification">
                <i class="fas fa-info-circle"></i>
                ${param.message}
                <span class="close-btn" onclick="hideNotification('messageNotification')">&times;</span>
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="notification warning show" id="messageNotification2">
                <i class="fas fa-info-circle"></i>
                ${message}
                <span class="close-btn" onclick="hideNotification('messageNotification2')">&times;</span>
            </div>
        </c:if>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

        <script>
                    $(document).ready(function () {
                        // Initialize DataTables
                        $('#shiftTable, #imageTable, #serviceTable, #courtsTable').DataTable({
                            pageLength: 5,
                            lengthChange: false,
                            language: {
                                "sProcessing": "Đang xử lý...",
                                "sLengthMenu": "Xem _MENU_ mục",
                                "sZeroRecords": "Không tìm thấy dòng nào phù hợp",
                                "sInfo": "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ mục",
                                "sInfoEmpty": "Đang xem 0 đến 0 trong tổng số 0 mục",
                                "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                                "sInfoPostFix": "",
                                "sSearch": "Tìm kiếm:",
                                "sUrl": "",
                                "oPaginate": {
                                    "sFirst": "Đầu",
                                    "sPrevious": "Trước",
                                    "sNext": "Tiếp",
                                    "sLast": "Cuối"
                                }
                            }
                        });

                        // Auto hide notifications after 5 seconds
                        setTimeout(function () {
                            $('.notification.show').removeClass('show');
                        }, 5000);

                        // Image preview functionality
                        $('#image').change(function () {
                            const file = this.files[0];
                            if (file) {
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#previewImg').attr('src', e.target.result);
                                    $('#imagePreview').show();
                                }
                                reader.readAsDataURL(file);
                            }
                        });

                        // Form validation
                        $('form').submit(function () {
                            let isValid = true;
                            $(this).find('input[required], select[required]').each(function () {
                                if (!$(this).val()) {
                                    isValid = false;
                                    $(this).addClass('is-invalid');
                                } else {
                                    $(this).removeClass('is-invalid');
                                }
                            });
                            return isValid;
                        });
                    });

                    function confirmDelete(itemName) {
                        return confirm(`Bạn có chắc chắn muốn xóa ${itemName} không?\nHành động này không thể hoàn tác!`);
                    }

                    function showLoading() {
                        $('#loadingOverlay').fadeIn();
                    }

                    function hideLoading() {
                        $('#loadingOverlay').fadeOut();
                    }

                    function hideNotification(id) {
                        $('#' + id).removeClass('show');
                    }

                    function openImageModal(imageUrl) {
                        $('#modalImage').attr('src', imageUrl);
                        $('#imageViewModal').modal('show');
                    }

                    // Show success notification for successful operations
                    function showSuccessNotification(message) {
                        const notification = $(`
                    <div class="notification success" id="dynamicNotification">
                        <i class="fas fa-check-circle"></i>
            ${message}
                        <span class="close-btn" onclick="hideNotification('dynamicNotification')">&times;</span>
                    </div>
                `);

                        $('body').append(notification);
                        setTimeout(() => notification.addClass('show'), 100);
                        setTimeout(() => notification.removeClass('show'), 5000);
                    }

                    // Check URL parameters for success messages
                    $(document).ready(function () {
                        const urlParams = new URLSearchParams(window.location.search);

                        if (urlParams.get('shift_added') === 'true') {
                            showSuccessNotification('Thêm ca làm việc thành công!');
                        }

                        if (urlParams.get('image_added') === 'true') {
                            showSuccessNotification('Thêm ảnh thành công!');
                        }

                        if (urlParams.get('service_added') === 'true') {
                            showSuccessNotification('Thêm dịch vụ thành công!');
                        }

                        if (urlParams.get('deleted') === 'true') {
                            showSuccessNotification('Xóa thành công!');
                        }
                    });

                    // Add loading animation for delete operations
                    $('a[href*="delete"]').click(function (e) {
                        if (confirm($(this).data('confirm') || 'Bạn có chắc chắn muốn xóa không?')) {
                            showLoading();
                        } else {
                            e.preventDefault();
                        }
                    });

                    // Smooth scrolling for anchor links
                    $('a[href^="#"]').on('click', function (event) {
                        var target = $(this.getAttribute('href'));
                        if (target.length) {
                            event.preventDefault();
                            $('html, body').stop().animate({
                                scrollTop: target.offset().top - 100
                            }, 1000);
                        }
                    });
        </script>
    </body>
</html>