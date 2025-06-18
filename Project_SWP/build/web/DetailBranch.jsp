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
        <style>
            .loading-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
            }
            .spinner {
                position: absolute;
                top: 50%;
                left: 50%;
                border: 4px solid #f3f3f3;
                border-top: 4px solid #3498db;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
            }
            @keyframes spin {
                0% {
                    transform: translate(-50%, -50%) rotate(0deg);
                }
                100% {
                    transform: translate(-50%, -50%) rotate(360deg);
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Badminton Management</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <button class="nav-link" onclick="history.back()">Quay lại</button>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container-fluid mt-3">
            <div class="row">
                <div class="col-md-2">
                    <jsp:include page="Sidebar.jsp" />
                </div>
                <div class="col-md-10">
                    <h2>Chi tiết khu vực: ${area_id}</h2>

                    <!-- Area Info -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title mb-3">Branch Information</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Tên khu vực:</strong> ${areaDetail.name}</p>
                                    <p><strong>Địa điểm:</strong> ${areaDetail.location}</p>
                                    <p><strong>Giờ mở cửa:</strong> ${areaDetail.openTime}</p>
                                    <p><strong>Giờ đóng cửa:</strong> ${areaDetail.closeTime}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Mô tả:</strong> ${areaDetail.description}</p>
                                     <p><strong>Tên quản lí:</strong> ${areaDetail.nameStaff}</p>
                                      <p><strong>Số điện thoại:</strong> ${areaDetail.phone_branch}</p>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                <!-- Bảng Shift -->
<h4 class="mt-5">Danh sách ca (Shift)</h4>
<button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addShiftModal">+ Thêm ca</button>
<table id="shiftTable" class="table table-bordered">
    <thead>
        <tr>
            
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
                <td>${shift.shiftName}</td>
                <td>${shift.startTime}</td>
                <td>${shift.endTime}</td>
                <td>
                    <a href="delete-shift?shiftId=${shift.shiftId}&area_id=${area_id}" onclick="return confirmDelete()" class="btn btn-danger">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Add Shift Modal -->
<div class="modal fade" id="addShiftModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <form action="add-shift" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm ca mới</h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="area_id" value="${area_id}" />
                <div class="form-group">
                    <label>Tên ca</label>
                    <input type="text" name="shiftName" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Thời gian bắt đầu</label>
                    <input type="time" name="startTime" class="form-control" step="1800" required />
                </div>
                <div class="form-group">
                    <label>Thời gian kết thúc</label>
                    <input type="time" name="endTime" class="form-control" step="1800" required />
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Thêm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#shiftTable').DataTable({pageLength: 5, lengthChange: false});
    });
</script>
                    <!-- Images -->
                    <h4>Ảnh của khu vực</h4>
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addImageModal">+ Thêm ảnh</button>
                    <table id="table" class="table table-bordered">
                        <thead>
                            <tr>
                               
                                <th>Ảnh</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="image" items="${areaImages}">
                                <tr>
                                  
                                    <td><img src="${image.imageURL}" alt="Branch Image" width="120"></td>
                                    <td>
                                        <a href="delete-image?image_id=${image.image_id}&area_id=${image.area_id}" onclick="return confirmDelete()" class="btn btn-danger">Xóa</a>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
               
                    <!-- Services -->
                    <h4 class="mt-5">Danh sách dịch vụ khu vực</h4>
                    <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addServiceModal">+ Thêm dịch vụ</button>
                    <table id="table2" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Tên dịch vụ</th>
                                <th>Giá</th>
                                <th>Mô tả</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${areaAllServices}">
                                <tr>
                                    <td>${s.service.name}</td>
                                    <td>${s.service.price}</td>
                                    <td>${s.service.description}</td>
                                    <td>
                                        <a href="remove-service?areaServiceID=${s.areaService_id}&area_id=${area_id}" onclick="return confirmDelete()" class="btn btn-danger">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <h4 class="mt-5">Sân trong khu vực này</h4>
                    <table class="table table-bordered" id="courtsTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Số sân</th>
                                <th>Thế loại</th>
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
                                    <td>${loop.count}</td>
                                    <td>${court.court_number}</td>
                                    <td>${court.type}</td>
                                    <td>${court.floor_material}</td>
                                    <td>${court.lighting}</td>
                                    <td>${court.description}</td>
                                    <td>
                                        <c:if test="${not empty court.image_url}">
                                            <img src="${court.image_url}" alt="court image" width="100">
                                        </c:if>
                                    </td>
                                    <td>${court.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Add Image Modal -->
                    <div class="modal fade" id="addImageModal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <form action="add-image" method="post" enctype="multipart/form-data" class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Thêm ảnh</h5>
                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                                </div>
                                <div class="modal-body">
                                   <input type="hidden" name="area_id" value="${area_id}" />

                                    <div class="form-group">
                                        <label for="image">Chọn ảnh</label>
                                        <input type="file" class="form-control" name="image" id="image" accept="image/*" required />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Thêm</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- Add Service Modal -->
                    <div class="modal fade" id="addServiceModal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <form action="add-service-branch" method="post" class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Thêm dịch vụ cho khu vực</h5>
                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="area_id" value="${area_id}" />
                                    <div class="form-group">
                                        <label>Chọn dịch vụ</label>
                                        <select name="service_id" class="form-control" required>
                                            <c:forEach var="service" items="${allServices}">
                                                <option value="${service.service_id}">${service.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Thêm</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <div class="loading-overlay">
            <div class="spinner"></div>
        </div>
                                    <c:if test="${not empty param.message}">
                                        <div class="alert alert-warning">${param.message}</div>
                                    </c:if>
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-warning">${message}</div>
                                    </c:if>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                $('#table, #table2').DataTable({pageLength: 5, lengthChange: false});
                                            });

                                            function confirmDelete() {
                                                return confirm("Do you want to delete this?");
                                            }
        </script>
    </body>
</html>
