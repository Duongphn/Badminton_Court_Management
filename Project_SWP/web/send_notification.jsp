<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Gửi Thông Báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>

<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quản lý</a>
        <div class="d-flex">
            <a class="nav-link text-light" href="login">Đăng xuất</a>
        </div>
    </div>
</nav>

<!-- Giao diện -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Menu bên trái -->
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp"/>
        </div>

        <!-- Nội dung chính -->
        <div class="col-md-8">
            <div class="container py-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="bi bi-send"></i> Gửi Thông Báo</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="mb-4 text-primary">Thông báo: <strong>${notification.title}</strong></h5>

                        <!-- Lọc theo vai trò -->
                        <form class="mb-3 d-flex justify-content-between" method="get" action="send-notification">
                            <input type="hidden" name="nId" value="${notification.notificationId}" />
                            <select class="form-select w-25" name="role" onchange="this.form.submit()">
                                <option value="">Tất cả vai trò</option>
                                <option value="admin" ${role == 'admin' ? 'selected' : ''}>Quản trị viên</option>
                                <option value="staff" ${role == 'staff' ? 'selected' : ''}>Nhân viên</option>
                                <option value="user" ${role == 'user' ? 'selected' : ''}>Người dùng</option>
                            </select>
                        </form>

                        <!-- Gửi hàng loạt -->
                        <form method="post" action="${pageContext.request.contextPath}/send-notification">
                            <input type="hidden" name="notificationId" value="${notification.notificationId}" />

                            <table class="table table-bordered align-middle">
                                <thead class="table-light text-center">
                                    <tr>
                                        <th><input type="checkbox" id="selectAll" class="form-check-input"></th>
                                        <th>STT</th>
                                        <th>Tài khoản</th>
                                        <th>Vai trò</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${userList}" varStatus="loop">
                                        <tr>
                                            <td class="text-center">
                                                <input type="checkbox" name="userIds" value="${u.user_Id}" class="form-check-input singleCheckbox">
                                            </td>
                                            <td class="text-center">${loop.index + 1}</td>
                                            <td>${u.username} (${u.email})</td>
                                            <td class="text-center">${u.role}</td>
                                            <td class="text-center">
                                                <form method="post" action="${pageContext.request.contextPath}/send-notification">
                                                    <input type="hidden" name="notificationId" value="${notification.notificationId}" />
                                                    <input type="hidden" name="userIds" value="${u.user_Id}" />
                                                    <button type="submit" class="btn btn-outline-success btn-sm"
                                                            onclick="return confirm('Bạn có chắc chắn muốn gửi thông báo cho ${u.username}?');">
                                                        <i class="bi bi-send-fill"></i> Gửi
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <div class="d-flex justify-content-center mt-3">
                                <ul class="pagination">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="send-notification?nId=${notification.notificationId}&page=${i}&role=${role}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="d-flex justify-content-between mt-4">
                                <a href="notification_list" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Quay lại
                                </a>
                                <button type="submit" class="btn btn-success"
                                        onclick="return confirm('Bạn có chắc chắn muốn gửi thông báo đến các người dùng đã chọn?');">
                                    <i class="bi bi-send-fill"></i> Gửi tất cả đã chọn
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("selectAll").addEventListener("change", function () {
        document.querySelectorAll(".singleCheckbox").forEach(cb => cb.checked = this.checked);
    });
</script>
</body>
</html>
