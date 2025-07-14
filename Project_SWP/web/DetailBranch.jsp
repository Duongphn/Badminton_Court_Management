

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
    --primary-color: #007bff;
    --danger-color: #dc3545;
    --warning-color: #ffc107;
    --success-color: #28a745;
    --info-color: #17a2b8;
    --light-color: #f8f9fa;
    --dark-color: #343a40;
}

body {
    background-color: #f4f6f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    min-height: 100vh;
}

.navbar {
    background-color: #ffffff;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    padding: 10px 20px;
}

.navbar-brand {
    font-weight: bold;
    font-size: 1.5rem;
    color: var(--primary-color) !important;
}

.nav-link {
    color: var(--primary-color) !important;
    font-weight: 500;
}

.main-content {
    padding: 30px;
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 0 15px rgba(0,0,0,0.05);
}

.page-title {
    color: #343a40;
    font-weight: 700;
    font-size: 2.5rem;
    margin-bottom: 30px;
    text-align: center;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 40px 0 20px 0;
    padding-bottom: 15px;
    border-bottom: 2px solid var(--primary-color);
}

.section-title {
    color: var(--dark-color);
    font-weight: 600;
    font-size: 1.6rem;
}

.btn-custom {
    background-color: #28a745;
    color: white;
    border-radius: 8px;
    padding: 10px 20px;
    font-weight: 500;
    border: none;
    transition: 0.3s;
}

.btn-custom:hover {
    background-color: #0056b3;
    color: white;
}

.btn-danger-custom {
    background-color: var(--danger-color);
    color: white;
    border-radius: 8px;
    padding: 6px 15px;
    font-size: 0.9rem;
    border: none;
    transition: 0.3s;
}

.btn-danger-custom:hover {
    background-color: #c82333;
    color: white;
}

.table-container {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
    margin-bottom: 30px;
}

.table thead th {
    background-color: #343a40;
    color: white;
    text-align: center;
    font-weight: 600;
    padding: 15px;
}

.table tbody td {
    text-align: center;
    vertical-align: middle;
}

.table tbody tr:hover {
    background-color: #f1f1f1;
}

.stats-card {
    background-color: #343a40;
    color: white;
    border-radius: 15px;
    padding: 20px;
    text-align: center;
    margin-bottom: 20px;
}

.stats-number {
    font-size: 2rem;
    font-weight: 700;
}

.stats-label {
    font-size: 0.9rem;
    opacity: 0.9;
}

/* Modal Styling */
.modal-content {
    border-radius: 12px;
}

.modal-header {
    background-color: var(--primary-color);
    color: white;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

.modal-title {
    font-weight: 600;
}

.form-control {
    border-radius: 8px;
    border: 1px solid #ced4da;
    padding: 10px;
}

.form-control:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
}

/* Notification Box */
.notification {
    position: fixed;
    top: 20px;
    right: 20px;
    padding: 15px 20px;
    border-radius: 10px;
    color: white;
    font-weight: 500;
    z-index: 10000;
    display: none;
}

.notification.show {
    display: block;
    animation: fadeIn 0.5s ease-in-out;
}

.notification.success {
    background-color: var(--success-color);
}

.notification.error {
    background-color: var(--danger-color);
}

.notification.warning {
    background-color: var(--warning-color);
    color: #856404;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateX(100px); }
    to { opacity: 1; transform: translateX(0); }
}

/* Responsive */
@media (max-width: 768px) {
    .main-content {
        padding: 20px;
    }

    .page-title {
        font-size: 2rem;
    }

    .table-responsive {
        font-size: 0.9rem;
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
                                           
                                            <th>Tên ca</th>
                                            <th>Thời gian bắt đầu</th>
                                            <th>Thời gian kết thúc</th>
                                            <th>Giá (VND)</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="shift" items="${listShift}" varStatus="loop">
                                            <tr>
                                               
                                                <td><strong>${shift.shiftName}</strong></td>
                                                <td><i class="fas fa-play text-success"></i> ${shift.startTime}</td>
                                                <td><i class="fas fa-stop text-danger"></i> ${shift.endTime}</td>
                                                <td><i class="fas fa-stop text-primary"></i> ${shift.price}</td>
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
                         <div class="form-group">
                            <label><i class="fas fa-stop"></i> Thời gian kết thúc</label>
                            <input type="number" name="price" class="form-control"  required />
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