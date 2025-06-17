<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Post" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản Lý Bài Viết</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            body {
                background: #f5f6fa;
            }
            .card-main {
                border-radius: 18px;
                box-shadow: 0 4px 18px 0 rgba(0,0,0,.08);
                border: none;
            }
            .header {
                margin-left: 250px;
                padding: 10px 20px;
                background-color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ccc;
            }
            .logout-button {
                color: red;
                border: 1px solid red;
                padding: 6px 14px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                transition: 0.3s;
            }
            .logout-button:hover {
                background-color: red;
                color: white;
            }
            .search-icon {
                position: absolute;
                top: 10px;
                left: 18px;
                color: #ccc;
            }
            .btn-add {
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h3></h3>
            <a href="login" class="logout-button">Logout</a>
        </div>

        <div class="row g-0">
            <jsp:include page="Sidebar.jsp"/>
            <div class="col-10 pt-5 px-4">
                <div class="card card-main px-4 py-3 " style="width:100%; max-width:1200px; margin-left: 270px;">
                    <div class="d-flex align-items-center mb-3">
                        <span style="font-size: 2rem; margin-right: 10px;">📝</span>
                        <h2 class="mb-0" style="color:#2366d1; font-weight: 700;">Danh sách bài viết</h2>
                    </div>
                    <!-- Form tìm kiếm & lọc -->
                    <div class="d-flex align-items-center mb-3" style="gap: 10px;">
                        <form class="d-flex align-items-center flex-grow-1" style="max-width: 650px;" action="ViewPostManager" method="get">
                            <span class="search-icon">🔍</span>
                            <input type="text" class="form-control ps-5 me-2" placeholder="Tìm tiêu đề, người đăng..." name="search" value="${param.search != null ? param.search : ''}"/>
                            <select class="form-select me-2" style="width: 130px;" name="type">
                                <option value="">Tất cả thể loại</option>
                                <option value="news" ${param.type == 'news' ? 'selected' : ''}>Tin tức</option>
                                <option value="partner" ${param.type == 'partner' ? 'selected' : ''}>Tìm đối</option>
                                <option value="common" ${param.type == 'common' ? 'selected' : ''}>Phổ thông</option>
                            </select>
                            <select class="form-select me-2" style="width: 130px;" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ duyệt</option>
                                <option value="approved" ${param.status == 'approved' ? 'selected' : ''}>Đã duyệt</option>
                                <option value="rejected" ${param.status == 'rejected' ? 'selected' : ''}>Từ chối</option>
                            </select>
                            <button class="btn btn-primary btn-sm" type="submit">Tìm</button>
                        </form>
                        <button class="btn btn-success btn-sm ms-2 flex-shrink-0" data-bs-toggle="modal" data-bs-target="#addPostModal">+ Đăng bài viết</button>
                    </div>
                    <!-- Bảng bài viết -->
                    <table class="table table-bordered align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th style="width:6%;">ID</th>
                                <th>Tiêu đề</th>
                                <th style="width:16%;">Loại</th>
                                <th style="width:18%;">Người đăng</th>
                                <th style="width:13%;">Ngày tạo</th>
                                <th style="width:13%;">Trạng thái</th>
                                <th style="width:17%;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    if (posts != null && !posts.isEmpty()) {
        for (Post p : posts) {
                            %>
                            <tr>
                                <td><%= p.getPostId() %></td>
                                <td><%= p.getTitle() %></td>
                                <td>
                                    <% if ("news".equals(p.getType())) { %>Tin tức
                                    <% } else if ("partner".equals(p.getType())) { %>Tìm đối
                                    <% } else if ("common".equals(p.getType())) { %>Phổ thông
                                    <% } else { %><%= p.getType() %><% } %>
                                </td>
                                <td><%= p.getCreatedByName() %></td> <!-- sửa lại nếu có phương thức lấy tên -->
                                <td><%= df.format(p.getCreatedAt()) %></td>
                                <td>
                                    <% if ("pending".equals(p.getStatus())) { %>Chờ duyệt
                                    <% } else if ("approved".equals(p.getStatus())) { %>Đã duyệt
                                    <% } else if ("rejected".equals(p.getStatus())) { %>Từ chối
                                    <% } else { %><%= p.getStatus() %><% } %>
                                </td>
                                <td>
                                    <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%=p.getPostId()%>">
                                        Chi tiết / Sửa
                                    </button>
                                </td>
                            </tr>

                            <!-- Modal chỉnh sửa + duyệt bài -->
                        <div class="modal fade" id="editModal<%=p.getPostId()%>" tabindex="-1" aria-labelledby="editModalLabel<%=p.getPostId()%>" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form action="UpdatePostManager" method="post">
                                        <input type="hidden" name="postId" value="<%=p.getPostId()%>" />
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editModalLabel<%=p.getPostId()%>">Chỉnh sửa bài viết</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <strong class="form-label">Tiêu đề</strong>
                                                <input type="text" name="title" class="form-control" value="<%=p.getTitle()%>" required />
                                            </div>
                                            <div class="mb-3">
                                                <strong class="form-label">Nội dung</strong>
                                                <textarea name="content" rows="6" class="form-control" required><%=p.getContent()%></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <strong class="form-label">Loại bài viết</strong>
                                                <select name="type" class="form-select" required>
                                                    <option value="news" <%= "news".equals(p.getType()) ? "selected" : "" %>>Tin tức</option>
                                                    <option value="common" <%= "common".equals(p.getType()) ? "selected" : "" %>>Phổ thông</option>
                                                    <option value="partner" <%= "partner".equals(p.getType()) ? "selected" : "" %>>Tìm đối</option>
                                                </select>
                                            </div>
                                            <p><strong>Người đăng:</strong> <%=p.getCreatedByName()%></p>
                                            <p><strong>Ngày tạo:</strong> <%= df.format(p.getCreatedAt()) %></p>
                                            <p><strong>Trạng thái:</strong>
                                                <% if ("pending".equals(p.getStatus())) { %>Chờ duyệt
                                                <% } else if ("approved".equals(p.getStatus())) { %>Đã duyệt
                                                <% } else if ("rejected".equals(p.getStatus())) { %>Từ chối
                                                <% } else { %><%= p.getStatus() %><% } %>
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            <form action="UpdatePostManager" method="post" style="display:inline;">
                                                <input type="hidden" name="postId" value="<%=p.getPostId()%>" />
                                                <button type="submit" name="action" value="approve" class="btn btn-success">Duyệt bài</button>
                                            </form>
                                            <form action="UpdatePostManager" method="post" style="display:inline;">
                                                <input type="hidden" name="postId" value="<%=p.getPostId()%>" />
                                                <button type="submit" name="action" value="reject" class="btn btn-warning">Từ chối</button>
                                            </form>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">Không có bài viết phù hợp</td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <!-- Phân trang -->
                    <%
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Integer totalPages = (Integer) request.getAttribute("totalPages");
                        if (currentPage == null) currentPage = 1;
                        if (totalPages == null) totalPages = 1;

                        String typeParam = request.getParameter("type") != null ? "&type=" + request.getParameter("type") : "";
                        String searchParam = request.getParameter("search") != null ? "&search=" + request.getParameter("search") : "";
                    %>
                    <div style="text-align: center; margin-top: 30px;">
                        <ul class="pagination justify-content-center">
                            <% for (int i = 1; i <= totalPages; i++) { %>
                            <li class="page-item <%= (i == currentPage ? "active" : "") %>">
                                <a class="page-link" href="ViewPostManager?page=<%= i %><%= typeParam %><%= searchParam %>"><%= i %></a>
                            </li>
                            <% } %>
                        </ul>
                    </div>

                    <div class="modal fade" id="addPostModal" tabindex="-1" aria-labelledby="addPostModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <form action="AddPostManager" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addPostModalLabel">Đăng bài viết mới</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Tiêu đề</label>
                                            <input type="text" class="form-control" name="title" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Nội dung</label>
                                            <textarea class="form-control" name="content" rows="5" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Loại bài viết</label>
                                            <select class="form-select" name="type" required>
                                                <option value="news">Tin tức</option>
                                                <option value="common">Phổ thông</option>
                                                <option value="partner">Tìm đối</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Đăng bài viết</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
