<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.CourtDAO,java.util.List,Model.Courts" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #eef1f7;
            font-family: 'Roboto', sans-serif;
        }

        .main-content {
            padding: 30px;
            background-color: #fff;
            margin-top: 20px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            padding: 12px;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f3f5;
        }

        .modal-content {
            border-radius: 10px;
        }

        .modal-header {
            background-color: #007bff;
            color: #fff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            display: none;
            animation: slideInRight 0.3s ease-out;
        }

        .notification.success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .notification.error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .notification .close-btn {
            float: right;
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: inherit;
            padding: 0;
            margin-left: 10px;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
            }
            .search-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            .search-bar .form-inline {
                width: 100%;
                margin-bottom: 10px;
            }
            .notification {
                right: 10px;
                left: 10px;
                min-width: auto;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navigation_court.jsp" />

<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-md-2 mb-4">
            <jsp:include page="Sidebar.jsp" />
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
    <h1 class="text-center mb-4"><i class="fas fa-building"></i> Quản Lý Sân Cầu Lông</h1>

    <div class="search-bar">
        <div class="form-inline">
            <input type="text" id="searchInput" class="form-control mr-2" placeholder="Tìm kiếm theo số sân">
            <button class="btn btn-outline-primary" onclick="searchCourts()"><i class="fas fa-search"></i> Tìm kiếm</button>
        </div>
        <button class="btn btn-success" data-toggle="modal" data-target="#addCourtModal"><i class="fas fa-plus"></i> Thêm Sân</button>
    </div>

    <!-- Modal thêm sân -->
    <div class="modal fade" id="addCourtModal" tabindex="-1" aria-labelledby="addCourtModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Thêm Sân</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body">
                    <form action="courts" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label>Tên Sân</label>
                            <input type="text" class="form-control" name="courtNumber" required>
                        </div>
                        <div class="form-group">
                            <label>Loại Sân</label>
                            <input type="text" class="form-control" name="type">
                        </div>
                        <div class="form-group">
                            <label>Chất Liệu Sàn</label>
                            <input type="text" class="form-control" name="floorMaterial">
                        </div>
                        <div class="form-group">
                            <label>Hệ Thống Chiếu Sáng</label>
                            <input type="text" class="form-control" name="lighting">
                        </div>
                        <div class="form-group">
                            <label>Mô Tả</label>
                            <input type="text" class="form-control" name="description">
                        </div>
                        <div class="form-group">
                            <label>Ảnh</label>
                            <input type="file" class="form-control" name="image" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label>Trạng Thái</label>
                            <select class="form-control" name="status" required>
                                <option value="available">Available</option>
                                <option value="maintenance">Maintenance</option>
                                <option value="booked">Booked</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Khu Vực ID</label>
                            <input type="number" class="form-control" id="addAreaId" name="areaId" required min="1">
                            <small class="form-text text-muted">Nhập ID khu vực hợp lệ</small>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Lưu</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal sửa sân -->
    <div class="modal fade" id="updateCourtModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Sửa Sân</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body">
                    <form action="courts" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="courtId" id="updateCourtId">
                        <div class="form-group">
                            <label>Tên Sân</label>
                            <input type="text" class="form-control" id="updateCourtNumber" name="courtNumber" required>
                        </div>
                        <div class="form-group">
                            <label>Loại Sân</label>
                            <input type="text" class="form-control" id="updateType" name="type">
                        </div>
                        <div class="form-group">
                            <label>Chất Liệu Sàn</label>
                            <input type="text" class="form-control" id="updateFloorMaterial" name="floorMaterial">
                        </div>
                        <div class="form-group">
                            <label>Hệ Thống Chiếu Sáng</label>
                            <input type="text" class="form-control" id="updateLighting" name="lighting">
                        </div>
                        <div class="form-group">
                            <label>Mô Tả</label>
                            <input type="text" class="form-control" id="updateDescription" name="description">
                        </div>
                        <input type="hidden" name="currentImage" id="currentImage">
                        <div class="form-group">
                            <label>Ảnh</label>
                            <input type="file" class="form-control" id="updateImage" name="image" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label>Trạng Thái</label>
                            <select class="form-control" id="updateStatus" name="status" required>
                                <option value="available">Available</option>
                                <option value="maintenance">Maintenance</option>
                                <option value="booked">Booked</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Khu Vực ID</label>
                            <input type="number" class="form-control" id="updateAreaId" name="areaId" required min="1">
                            <small class="form-text text-muted">Nhập ID khu vực hợp lệ</small>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Cập Nhật</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sân -->
    <div class="card">
        <div class="card-header"><h4 class="mb-0">Danh Sách Sân</h4></div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>Mã Sân</th>
                        <th>Tên Sân</th>
                        <th>Loại</th>
                        <th>Chất Liệu</th>
                        <th>Chiếu Sáng</th>
                        <th>Mô Tả</th>
                        <th>Trạng Thái</th>
                        <th>Khu Vực ID</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="court" items="${courts}">
                        <tr>
                            <td>${court.court_id}</td>
                            <td><a href="staff-court-detail?courtId=${court.court_id}">${court.court_number}</a></td>
                            <td>${court.type}</td>
                            <td>${court.floor_material}</td>
                            <td>${court.lighting}</td>
                            <td>${court.description}</td>
                            <td>${court.status}</td>
                            <td>${court.area_id}</td>
                            <td>
                                <button class="btn btn-sm btn-warning edit-btn"
                                        data-id="${court.court_id}"
                                        data-number="${court.court_number}"
                                        data-type="${court.type}"
                                        data-floor="${court.floor_material}"
                                        data-lighting="${court.lighting}"
                                        data-description="${court.description}"
                                        data-status="${court.status}"
                                        data-area="${court.area_id}"
                                        ><i class="fas fa-edit"></i> Sửa</button>
                                <form action="courts" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="courtId" value="${court.court_id}">
                                    <button type="submit" class="btn btn-sm btn-danger"
                                            onclick="return confirm('Bạn có chắc muốn xóa sân này?')">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </button>
                                </form>
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
    window.onload = function() {
        const notification = document.getElementById('notification');
        if (notification) {
            notification.style.display = 'block';
            // Tự động ẩn sau 5 giây
            setTimeout(() => {
                closeNotification();
            }, 5000);
        }
    };

    // Đóng thông báo
    function closeNotification() {
        const notification = document.getElementById('notification');
        if (notification) {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                notification.style.display = 'none';
            }, 300);
        }
    }
    
    
    

    function searchCourts() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let rows = document.querySelectorAll("table tbody tr");
        rows.forEach(row => {
            let courtNumber = row.cells[1].textContent.toUpperCase();
            row.style.display = courtNumber.includes(input) ? "" : "none";
        });
    }

    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            document.getElementById('updateCourtId').value = this.dataset.id;
            document.getElementById('updateCourtNumber').value = this.dataset.number;
            document.getElementById('updateType').value = this.dataset.type || '';
            document.getElementById('updateFloorMaterial').value = this.dataset.floor || '';
            document.getElementById('updateLighting').value = this.dataset.lighting || '';
            document.getElementById('updateDescription').value = this.dataset.description || '';
            document.getElementById('currentImage').value = this.dataset.image || '';
            document.getElementById('updateStatus').value = this.dataset.status;
            document.getElementById('updateAreaId').value = this.dataset.area;
            $('#updateCourtModal').modal('show');
        });
    });
</script>
</body>
</html>
