<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manager Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Manager</a>
                <div class="d-flex">
                    <!--            <a class="nav-link text-light" href="/profile">Profile</a>-->
                    <a class="nav-link text-light" href="login">Logout</a>
                </div>
            </div>
        </nav>

        <!-- Main Layout -->
        <div class="container-fluid mt-4">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <jsp:include page="Sidebar.jsp" />
                </div>

                <!-- Content -->
                <div class="col-md-8">
                    <div class="container py-4">

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="mb-0"><i class="fas fa-users"></i> Quản Lý Người Dùng</h2>
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-user-plus"></i> Thêm Người Dùng
                            </button>
                        </div>

                        <!-- Search + Filter -->
                        <div class="row mb-3 g-2">
                            <!-- Search + Filter (submit về /users, method GET) -->
                            <form method="get" class="row mb-3 g-2">
                                <div class="col-md-6">
                                    <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Tìm kiếm theo Username, Email, Số điện thoại...">
                                </div>
                                <div class="col-md-3">
                                    <select name="status" class="form-select">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Suspended" ${param.status == 'Suspended' ? 'selected' : ''}>Suspended</option>
                                        <option value="banned" ${param.status == 'banned' ? 'selected' : ''}>Banned</option>
                                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search"></i> Tìm</button>
                                </div>
                            </form>

                        </div>
                        <div class="card shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table id="userTable" class="table table-bordered table-hover mb-0 align-middle">
                                        <thead>
                                            <tr class="align-middle text-center">
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Vai trò</th>
                                                <th>Ngày tạo</th>
                                                <th>Trạng thái</th>
                                                <th>Note</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="userTableBody">
                                            <c:forEach var="user" items="${users}">
                                                <tr class="align-middle text-center" 
                                                    data-username="${user.username}" 
                                                    data-email="${user.email}" 
                                                    data-phone="${user.phone_number}" 
                                                    data-status="${user.status}">
                                                    <td>${user.user_Id}</td>
                                                    <td>
                                                        <i class="fas fa-user-circle text-primary"></i>
                                                        <b>${user.username}</b>
                                                    </td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone_number}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.role eq 'admin'}">
                                                                <span style="background: linear-gradient(90deg, #ff9800 60%, #fff3e0); color:#fff; font-weight:600; padding:4px 14px; border-radius:20px; font-size:14px; letter-spacing:0.3px;">
                                                                    Admin
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.role eq 'staff'}">
                                                                <span style="background: linear-gradient(90deg, #17a2b8 60%, #e0f7fa); color:#fff; font-weight:600; padding:4px 14px; border-radius:20px; font-size:14px; letter-spacing:0.3px;">
                                                                    Staff
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="background: linear-gradient(90deg, #6c757d 60%, #ececec); color:#fff; font-weight:600; padding:4px 14px; border-radius:20px; font-size:14px; letter-spacing:0.3px;">
                                                                    User
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty user.createdAt}">
                                                                <span style="background:#e3f2fd; color:#1565c0; font-weight:bold; border-radius:8px; padding:3px 10px; font-size:15px; letter-spacing:0.5px;">
                                                                    ${user.createdAt}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="background:#efefef; color:#888; border-radius:8px; padding:3px 10px; font-size:15px;">
                                                                    -
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.status eq 'Active'}">
                                                                <span style="background:#1dd167; color:#fff; font-weight:bold; border-radius:10px; padding:3px 14px; font-size:15px; letter-spacing:1px; box-shadow:0 2px 6px rgba(30,255,120,0.1);">
                                                                    Active
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'Suspended'}">
                                                                <span style="background:#ffb300; color:#fff; font-weight:bold; border-radius:10px; padding:3px 14px; font-size:15px; letter-spacing:1px; box-shadow:0 2px 6px rgba(255,180,0,0.13);">
                                                                    Suspended
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'banned'}">
                                                                <span style="background:#ea3a45; color:#fff; font-weight:bold; border-radius:10px; padding:3px 14px; font-size:15px; letter-spacing:1px; box-shadow:0 2px 6px rgba(234,58,69,0.13);">
                                                                    Banned
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.status eq 'pending'}">
                                                                <span style="background:#ffd700; color:#222; font-weight:bold; border-radius:10px; padding:3px 14px; font-size:15px; letter-spacing:1px; box-shadow:0 2px 6px rgba(255,215,0,0.09);">
                                                                    Pending
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="background:#bdbdbd; color:#fff; font-weight:bold; border-radius:10px; padding:3px 14px; font-size:15px; letter-spacing:1px;">
                                                                    -
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><span>${user.note}</span></td>
                                                    <td>
                                                        <button type="button" class="btn btn-warning btn-sm"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#editUserModal"
                                                                data-userid="${user.user_Id}"
                                                                data-username="${user.username}"
                                                                data-email="${user.email}"
                                                                data-phone="${user.phone_number}"
                                                                data-role="${user.role}">
                                                            <i class="fas fa-edit"> edit</i>
                                                        </button>
                                                        <form action="users" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="userId" value="${user.user_Id}">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                <i class="fas fa-trash-alt"> Delete</i>
                                                            </button>
                                                        </form>
                                                        <c:choose>
                                                            <c:when test="${user.status ne 'banned'}">
                                                                <!-- Nút Ban dùng JS mở modal -->
                                                                <button type="button" class="btn btn-dark btn-sm" style="background: #ea3a45; color: #fff;"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#banUserModal"
                                                                        data-userid="${user.user_Id}"
                                                                        data-username="${user.username}">
                                                                    <i class="fas fa-user-slash"></i> Ban
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <!-- Unban giữ nguyên confirm -->
                                                                <form action="users" method="post" class="d-inline" onsubmit="return confirm('Unban user này?');">
                                                                    <input type="hidden" name="action" value="unban">
                                                                    <input type="hidden" name="userId" value="${user.user_Id}">
                                                                    <button type="submit" class="btn btn-success btn-sm">
                                                                        <i class="fas fa-user-check"></i> Unban
                                                                    </button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- Pagination -->
                            <div class="card-footer bg-white">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage-1}">&laquo;</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="users?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="users?page=${currentPage+1}">&raquo;</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const searchInput = document.getElementById('searchInput');
                            const statusFilter = document.getElementById('statusFilter');
                            const tbody = document.getElementById('userTableBody');
                            const rows = Array.from(tbody.querySelectorAll('tr'));

                            function filterTable() {
                                const keyword = searchInput.value.toLowerCase();
                                const status = statusFilter.value;
                                rows.forEach(row => {
                                    const username = row.getAttribute('data-username').toLowerCase();
                                    const email = row.getAttribute('data-email').toLowerCase();
                                    const phone = row.getAttribute('data-phone').toLowerCase();
                                    const rowStatus = row.getAttribute('data-status');

                                    // search theo username, email, phone
                                    const matchSearch = (
                                            username.includes(keyword) ||
                                            email.includes(keyword) ||
                                            phone.includes(keyword)
                                            );
                                    // lọc status
                                    const matchStatus = (status === "" || rowStatus === status);

                                    row.style.display = (matchSearch && matchStatus) ? "" : "none";
                                });
                            }

                            searchInput.addEventListener('input', filterTable);
                            statusFilter.addEventListener('change', filterTable);
                        });

                    </script>
                    <!-- Modal Ban User -->
                    <div class="modal fade" id="banUserModal" tabindex="-1" aria-labelledby="banUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="banUserModalLabel"><i class="fas fa-user-slash"></i> Ban Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="ban">
                                    <input type="hidden" name="userId" id="banUserId">
                                    <div class="mb-3">
                                        <label class="form-label">Lý do Ban</label>
                                        <textarea name="note" class="form-control" id="banNote" required placeholder="Nhập lý do ban..."></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-danger"><i class="fas fa-user-slash"></i> Ban</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <script>
                        // Đổ userId vào modal Ban khi click nút Ban
                        var banUserModal = document.getElementById('banUserModal');
                        banUserModal.addEventListener('show.bs.modal', function (event) {
                            var button = event.relatedTarget;
                            var userId = button.getAttribute('data-userid');
                            document.getElementById('banUserId').value = userId;
                            // Nếu muốn reset note khi mở lại
                            document.getElementById('banNote').value = '';
                        });
                    </script>


                    <!-- Modal Thêm User -->
                    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addUserModalLabel"><i class="fas fa-user-plus"></i> Thêm Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="add">
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" name="phone_number" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Vai trò</label>
                                        <select name="role" class="form-select" required>
                                            <option value="user">User</option>
                                            <option value="staff">Staff</option>
                                            <option value="admin">Admin</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Sửa User -->
                    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="users" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editUserModalLabel"><i class="fas fa-user-edit"></i> Sửa Người Dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" id="editUserId">
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" id="editUsername" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" id="editEmail" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" name="phone_number" id="editPhone" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Vai trò</label>
                                        <select name="role" id="editRole" class="form-select" required>
                                            <option value="user">User</option>
                                            <option value="staff">Staff</option>
                                            <option value="admin">Admin</option>
                                        </select>
                                    </div>
                                    <!-- Có thể thêm field đổi mật khẩu nếu cần -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Bootstrap 5 JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        // Đổ dữ liệu vào modal edit user khi click nút Sửa
                        var editUserModal = document.getElementById('editUserModal');
                        editUserModal.addEventListener('show.bs.modal', function (event) {
                            var button = event.relatedTarget;
                            document.getElementById('editUserId').value = button.getAttribute('data-userid');
                            document.getElementById('editUsername').value = button.getAttribute('data-username');
                            document.getElementById('editEmail').value = button.getAttribute('data-email');
                            document.getElementById('editPhone').value = button.getAttribute('data-phone');
                            document.getElementById('editRole').value = button.getAttribute('data-role');
                        });
                    </script>

                </div>
            </div>
        </div>


    </body>
</html>
