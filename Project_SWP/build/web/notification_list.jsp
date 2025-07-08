<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách thông báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quản lý Thông Báo</a>
        <div class="d-flex">
            <a class="nav-link text-light" href="login">Đăng xuất</a>
        </div>
    </div>
</nav>

<!-- Layout -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp"/>
        </div>

        <!-- Nội dung -->
        <div class="col-md-8">
            <div class="container py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0"><i class="bi bi-bell"></i> Danh sách thông báo</h2>
                    <a href="${pageContext.request.contextPath}/create-notification" class="btn btn-success">
                        <i class="bi bi-plus-circle"></i> Tạo thông báo
                    </a>
                </div>

                <!-- Form tìm kiếm và lọc -->
                <form class="mb-3 d-flex" method="get" action="notification_list">
                    <input type="text" name="keyword" value="${keyword}" class="form-control me-2" placeholder="Tìm kiếm theo tiêu đề...">
                    <select name="status" class="form-control me-2">
                        <option value="">Tất cả trạng thái</option>
                        <option value="sent" ${status == 'sent' ? 'selected' : ''}>Đã gửi</option>
                        <option value="scheduled" ${status == 'scheduled' ? 'selected' : ''}>Đã lên lịch</option>
                        <option value="draft" ${status == 'draft' ? 'selected' : ''}>Bản nháp</option>
                    </select>
                    <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                </form>

                <!-- Hiển thị thông báo lỗi nếu không có kết quả -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>

                <!-- Bảng thông báo -->
                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0 align-middle">
                                <thead class="table-light text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Tiêu đề</th>
                                    <th>File đính kèm</th>
                                    <th>Lên lịch</th>
                                    <th>Đã gửi</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành động</th>
                                    <th>Gửi</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="n" items="${notifications}">
                                    <tr class="text-center">
                                        <td>${n.notificationId}</td>
                                        <td class="text-start">${n.title}</td>
                                        <td>
                                            <c:if test="${not empty n.imageUrl}">
                                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#previewModal_${n.notificationId}">
                                                    <i class="bi bi-eye"></i> Xem
                                                </button>
                                            </c:if>
                                        </td>
                                        <td>${n.scheduledTime}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty n.sentTime}">${n.sentTime}</c:when>
                                                <c:otherwise><span class="text-muted">Chưa gửi</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${n.status eq 'scheduled'}">
                                                    <span class="badge bg-warning text-dark">Đã lên lịch</span>
                                                </c:when>
                                                <c:when test="${n.status eq 'sent'}">
                                                    <span class="badge bg-success">Đã gửi</span>
                                                </c:when>
                                                <c:when test="${n.status eq 'draft'}">
                                                    <span class="badge bg-secondary">Bản nháp</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-dark">${n.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${n.createdAt}</td>
                                        <td>
                                            <!-- Kiểm tra nếu thông báo đã gửi thì chỉ cho phép xem -->
                                            <c:choose>
                                                <c:when test="${n.status eq 'sent'}">
                                                    <!-- Nút "Xem lại" cho thông báo đã gửi -->
                                                    <a href="${pageContext.request.contextPath}/view-notification?id=${n.notificationId}" class="btn btn-info btn-sm">
                                                        <i class="bi bi-eye"></i> Xem lại
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Nút sửa chỉ dành cho các thông báo chưa gửi -->
                                                    <a href="${pageContext.request.contextPath}/edit-notification?id=${n.notificationId}" class="btn btn-warning btn-sm">
                                                        <i class="bi bi-pencil-square"></i> Sửa
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <!-- Nếu thông báo đã gửi, chỉ hiển thị "Đã gửi", không cho phép gửi lại -->
                                            <c:choose>
                                                <c:when test="${n.status eq 'sent'}">
                                                    <span class="text-muted">Đã gửi</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/send-notification?nId=${n.notificationId}" 
                                                       class="btn btn-primary btn-sm"
                                                       onclick="return confirm('Bạn có chắc muốn gửi thông báo này không?');">
                                                        <i class="bi bi-send"></i> Gửi
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>

                                    <!-- Modal xem ảnh -->
                                    <div class="modal fade" id="previewModal_${n.notificationId}" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-xl modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xem ảnh thông báo</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body text-center">
                                                    <img src="${fn:replace(fn:escapeXml(n.imageUrl), ' ', '%20')}"
                                                         class="img-fluid" alt="Preview" style="max-height:600px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-center bg-white">
                        <span class="text-muted">Tổng cộng: ${fn:length(notifications)} thông báo</span>
                    </div>
                </div>

                <!-- Phân trang -->
                <div class="mt-3 d-flex justify-content-center">
                    <ul class="pagination">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="notification_list?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${status}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
