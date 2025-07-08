<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Promotion Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background-color: #f4f6f9;
            }
            .main-content {
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }
            .table th, .table td {
                vertical-align: middle;
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
            .notification.success {
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                position: fixed;
                top: 20px;
                right: 20px;
                border-radius: 10px;
                z-index: 9999;
                animation: fadeIn 0.5s;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            .close-btn {
                border: none;
                background: transparent;
                color: white;
                font-size: 18px;
                cursor: pointer;
            }
            .pagination {
    display: flex !important;
}
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-custom">
            <a class="navbar-brand font-weight-bold" href="#">🏷 Promotion Admin</a>
            <div class="ml-auto">
                <a class="btn btn-outline-danger" href="login">Đăng xuất</a>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row mt-4">
                <div class="col-md-2 mb-4">
                    <jsp:include page="Sidebar.jsp"/>
                </div>
                <div class="col-md-10">
                    <div class="main-content">
                        <h3 class="mb-4 text-primary">🎫 Quản lý khuyến mãi</h3>
                        <!-- Search Bar -->
                        <form action="search-promotion" method="POST" class="form-inline mb-4">
                            <input type="text" name="searchInput" value="${searchKeyword}" class="form-control mr-2 w-50" placeholder="🔍 Tìm kiếm khuyến mãi">
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </form>

                        <!-- Notification -->
                        <c:if test="${not empty sessionScope.success}">
                            <div id="notification" class="notification success">
                                <i class="fas fa-check-circle"></i> ${sessionScope.success}
                                <button class="close-btn" onclick="closeNotification()">&times;</button>
                            </div>
                        </c:if>

                        <!-- Promotions Table -->
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Tiêu đề</th>
                                        <th>Miêu tả</th>
                                        <th>Giảm (%)</th>
                                        <th>Giảm (VNĐ)</th>
                                        <th>Bắt đầu</th>
                                        <th>Kết thúc</th>
                                        <th>Trạng thái</th>
                                        <th>Khu vực áp dụng</th>
                                        <th style="width: 180px;">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="promo" items="${promotionList}" varStatus="loop">
                                        <tr>
                                            <td>${promo.title}</td>
                                            <td>${promo.description}</td>
                                            <td>${promo.discountPercent}</td>
                                            <td>${promo.discountAmount}</td>
                                            <td>${promo.startDate}</td>
                                            <td>${promo.endDate}</td>
                                            <td>
                                                <span class="badge ${promo.status == 'active' ? 'badge-success' : 'badge-secondary'}">
                                                    ${promo.status == 'active' ? 'Đang áp dụng' : 'Ngừng'}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${empty promo.areaNames}">EMPTY</c:if>
                                                <c:forEach var="areaName" items="${promo.areaNames}">
                                                    <span class="badge badge-info">${areaName}</span>
                                                </c:forEach>
                                            </td>
                                            
                                            <td>
                                                <button  class="btn btn-warning btn-sm" data-toggle="modal" data-target="#updateModal${loop.index}">Sửa</button>
                                            <a href="delele-promotion?promotionId=${promo.promotionId}" class="btn btn-danger btn-sm" onclick="confirmDelete()">Xóa</a>
                                                
                                                <div class="modal fade" id="updateModal${loop.index}" tabindex="-1" role="dialog">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <form action="edit-promotion" method="POST">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title">Sửa khuyến mãi</h5>
                                                                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="promotionId" value="${promo.promotionId}">
                                                                    <div class="form-group">
                                                                        <label>Tiêu đề</label>
                                                                        <input type="text" name="title" class="form-control" value="${promo.title}" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Miêu tả</label>
                                                                        <textarea name="description" class="form-control">${promo.description}</textarea>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Giảm (%)</label>
                                                                        <input type="number" step="0.01" name="discountPercent" class="form-control" value="${promo.discountPercent}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Giảm (VNĐ)</label>
                                                                        <input type="number" step="0.01" name="discountAmount" class="form-control" value="${promo.discountAmount}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Bắt đầu</label>
                                                                        <input type="date" name="startDate" class="form-control" value="${promo.startDate}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Kết thúc</label>
                                                                        <input type="date" name="endDate" class="form-control" value="${promo.endDate}">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Trạng thái</label>
                                                                        <select name="status" class="form-control">
                                                                            <option value="active" ${promo.status == 'active' ? 'selected' : ''}>Đang áp dụng</option>
                                                                            <option value="inactive" ${promo.status == 'inactive' ? 'selected' : ''}>Ngừng</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Khu vực áp dụng:</label><br/>
                                                                        <c:forEach var="area" items="${areaList}">
                                                                            <input type="checkbox" name="area_id" value="${area.area_id}" 
                                                                                   <c:if test="">checked</c:if>
                                                                                   > ${area.name}<br/>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <ul class="pagination justify-content-center mt-4">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="manage-promotion?page=${currentPage - 1}">Previous</a>
                            </li>
                            <c:forEach begin="1" end="${numberOfPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="manage-promotion?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == numberOfPages ? 'disabled' : ''}">
                                <a class="page-link" href="manage-promotion?page=${currentPage + 1}">Next</a>
                            </li>
                        </ul>

                        <button class="btn btn-success mt-4" data-toggle="modal" data-target="#addModal">+ Thêm khuyến mãi</button>

                        <!-- Modal Thêm khuyến mãi -->
                        <div class="modal fade" id="addModal" tabindex="-1" role="dialog">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="add-promotion" method="POST">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Thêm khuyến mãi</h5>
                                            <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label>Tiêu đề</label>
                                                <input type="text" name="title" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Miêu tả</label>
                                                <textarea name="description" class="form-control"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label>Giảm (%)</label>
                                                <input type="number" step="0.01" name="discountPercent" class="form-control" value="0">
                                            </div>
                                            <div class="form-group">
                                                <label>Giảm (VNĐ)</label>
                                                <input type="number" step="0.01" name="discountAmount" class="form-control" value="0">
                                            </div>
                                            <div class="form-group">
                                                <label>Bắt đầu</label>
                                                <input type="date" name="startDate" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Kết thúc</label>
                                                <input type="date" name="endDate" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Trạng thái</label>
                                                <select name="status" class="form-control">
                                                    <option value="active">Đang áp dụng</option>
                                                    <option value="inactive">Ngừng</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>Khu vực áp dụng:</label><br/>
                                                <c:forEach var="area" items="${areaList}">
                                                    <input type="checkbox" name="areaIds" value="${area.area_id}"> ${area.name}<br/>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Thêm</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Kết thúc modal thêm -->

                    </div>
                </div>
            </div>
        </div>

        <script>
             function confirmDelete() {
                return confirm("Do you want to delete this?");
            }
            function closeNotification() {
                const notification = document.getElementById('notification');
                if (notification) {
                    notification.style.animation = 'slideOutRight 0.3s ease-out';
                    setTimeout(() => {
                        notification.style.display = 'none';
                    }, 300);
                }
            }
        </script>
    
       <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
