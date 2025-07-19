<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Post" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="homehead.jsp" />

<div style="max-width: 1100px; margin: auto; padding: 20px; font-family: Arial, sans-serif;">
    <h2 style="text-align: center; color: #e63946; margin-bottom: 30px;">Danh sách bài viết</h2>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <%
        String postStatus = (String) session.getAttribute("postStatus");
        if (postStatus != null) {
    %>
    <div class="alert alert-warning alert-dismissible fade show" role="alert" style="max-width: 800px; margin: 20px auto;">
        <%= postStatus %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
    </div>
    <%
            session.removeAttribute("postStatus");
        }
    %>

    <!-- Bộ lọc và tìm kiếm -->
    <form method="get" action="PostView" style="display: flex; justify-content: space-between; margin-bottom: 20px;">
        <div>
            <label for="type">Loại bài viết:</label>
            <select name="type" id="type">
                <option value="">Tất cả</option>
                <option value="news" <%= "news".equals(request.getParameter("type")) ? "selected" : "" %>>Tin tức</option>
                <option value="partner" <%= "partner".equals(request.getParameter("type")) ? "selected" : "" %>>Tìm đối</option>
                <option value="common" <%= "common".equals(request.getParameter("type")) ? "selected" : "" %>>Phổ thông</option>
            </select>
            <input type="submit" value="Lọc bài viết" style="padding: 3px 10px; background-color: gray; color: white; border: none; cursor: pointer;" />
        </div>
        <div>
            <input type="text" name="search" placeholder="Tìm tiêu đề..."
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                   style="padding: 5px; width: 200px;" />
            <input type="submit" value="Tìm Kiếm" style="padding: 6px 12px; background-color: gray; color: white; border: none; cursor: pointer;" />
        </div>
    </form>

    <%-- Nhận dữ liệu từ servlet --%>
    <%
        String typeParam = request.getParameter("type");
        Post newsFeatured = (Post) request.getAttribute("newsFeatured");
        List<Post> otherPosts = (List<Post>) request.getAttribute("otherPosts");
        List<Post> posts = (List<Post>) request.getAttribute("posts");
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    %>

    <% if (typeParam == null || typeParam.isEmpty()) { %>
    <div class="row">
        <!-- Cột to bên trái: bài tin tức mới nhất -->
<div class="col-md-6">
            <% Post n = newsFeatured; %>
            <% if (n != null) { %>
            <div class="card mb-4 shadow" style="overflow:hidden;">
                <div class="card-body" style="padding:0;">
                    <% if (n != null && n.getImage() != null && !n.getImage().isEmpty()) { %>
                    <img src="<%= request.getContextPath() + "/uploads/" + n.getImage() %>" 
                         style="width:100%;height:240px;object-fit:cover;display:block;">
                    <% } %>
                    <div style="padding:20px 20px 10px 20px;">
                        <span class="badge bg-primary mb-2">Tin tức mới nhất</span>
                        <h2 class="card-title" style="color:#e63946;">
                            <a href="PostDetail?id=<%= n.getPostId() %>" style="color:#e63946;text-decoration:none;">
                                <%= n.getTitle() %>
                            </a>
                        </h2>
                        <div style="font-size:14px;color:#888;margin-bottom:8px;">
                            📅 <%= df.format(n.getCreatedAt()) %> | 🏷️ <%= n.getType() %>
                        </div>
                        <p style="color:#333;">
                            <%= n.getContent().length() > 200 ? n.getContent().substring(0, 200) + "..." : n.getContent() %>
                        </p>
                        <a href="PostDetail?id=<%= n.getPostId() %>" style="color:#e63946;font-weight:bold;">Xem chi tiết</a>
                    </div>
                </div>
            </div>
            <% } else { %>
            <div class="alert alert-info">Chưa có bài tin tức nào nổi bật.</div>
            <% } %>
        </div>
        <!-- Cột nhỏ bên phải: tất cả các bài blog đã approved (mọi loại) -->
        <div class="col-md-5">
            <% if (otherPosts != null && !otherPosts.isEmpty()) {
                for (Post p : otherPosts) { %>
            <div class="card mb-3 shadow-sm" style="overflow:hidden;">
                <div class="card-body p-2" style="display:flex;align-items:center;gap:15px;">
                    <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="<%= request.getContextPath() + "/uploads/" + p.getImage() %>"
                         style="width:70px;height:70px;object-fit:cover;border-radius:8px;">
                    <% } %>
                    <div style="flex:1;">
                        <h6 class="card-title" style="margin-bottom:5px;">
                            <a href="PostDetail?id=<%= p.getPostId() %>" style="color:#e63946;text-decoration:none;"><%= p.getTitle() %></a>
                        </h6>
                        <div style="font-size:12px;color:#888;">
                            📅 <%= df.format(p.getCreatedAt()) %> | 🏷️ <%= p.getType() %>
                        </div>
                    </div>
</div>
            </div>
            <% }
            } else { %>
            <div class="alert alert-info" style="font-size:14px;">Không có bài viết nào khác.</div>
            <% } %>
        </div>
    </div>
    <% } else { %>
    <%-- Khi lọc theo loại cụ thể, chỉ hiển thị danh sách bài loại đó --%>
    <% if (posts != null && !posts.isEmpty()) {
        for (Post p : posts) { %>
    <div class="card mb-3 shadow-sm">
        <div class="card-body">
            <h5 class="card-title">
                <a href="PostDetail?id=<%= p.getPostId() %>" style="color:#e63946;text-decoration:none;"><%= p.getTitle() %></a>
            </h5>
            <div style="font-size: 14px; color: #555; margin-bottom: 8px;">
                📅 <%= df.format(p.getCreatedAt()) %> | 🏷️ <%= p.getType() %>
            </div>
            <p class="card-text" style="color:#333;">
                <%= p.getContent().length() > 150 ? p.getContent().substring(0, 150) + "..." : p.getContent() %>
            </p>
            <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
            <img src="<%= request.getContextPath() %>/uploads/<%= p.getImage() %>" style="max-width:150px;max-height:120px;object-fit:cover;border-radius:8px;">
            <% } %>
            <a href="PostDetail?id=<%= p.getPostId() %>" class="btn btn-link p-0" style="color:#e63946;">Xem chi tiết</a>
        </div>
    </div>
    <% }
        } else { %>
    <p style="text-align: center; font-style: italic; color: #888;">Không có bài viết nào phù hợp.</p>
    <% } %>
    <% } %>

    <div style="margin-top: 10px;">
        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#createPostModal">
            + Đăng bài viết
        </button>
        <a href="MyPost" class="btn btn-primary" style="white-space:nowrap;">
            <i class="bi bi-person-lines-fill"></i> Bài viết của tôi
        </a>
    </div>

    <!-- Modal đăng bài -->
    <div class="modal fade" id="createPostModal" tabindex="-1" aria-labelledby="createPostModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="color: white; background: red">
                    <h5 class="modal-title" id="createPostModalLabel">Đăng bài viết mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                
                <form method="post" action="AddPost" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề bài viết</label>
                            <input type="text" class="form-control" name="title" id="title" required>
                        </div>

                        <div class="mb-3">
<label for="content" class="form-label">Nội dung</label>
                            <textarea class="form-control" name="content" id="content" rows="6" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">Ảnh bài viết (không bắt buộc)</label>
                            <input type="file" class="form-control" name="image" id="image" accept="image/*">
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="isPartner" id="isPartner" value="true">
                            <label class="form-check-label" for="isPartner">
                                Tôi muốn tìm đối đánh cầu
                            </label>
                        </div>

                        <!-- Phần thông tin tìm đối - mặc định ẩn -->
                        <div id="partnerFields" style="display: none;">
                            <div class="alert alert-info">
                                <strong>Thông tin tìm đối:</strong> Vui lòng điền đầy đủ thông tin dưới đây
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Trình độ mong muốn <span style="color:red">*</span></label>
                                <input type="text" class="form-control" name="preferred_level" placeholder="Ví dụ: Trung bình, Khá, Giỏi">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Giới tính mong muốn <span style="color:red">*</span></label>
                                <select class="form-select" name="preferred_gender">
                                    <option value="">Chọn giới tính</option>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                    <option value="Không yêu cầu">Không yêu cầu</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Thời gian mong muốn <span style="color:red">*</span></label>
                                <input type="text" class="form-control" name="preferred_time" placeholder="Ví dụ: Thứ 2, 4, 6 từ 18:00-20:00">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Khu vực mong muốn <span style="color:red">*</span></label>
<input type="text" class="form-control" name="preferred_area" placeholder="Ví dụ: Hà Nội, Cầu Giấy, Hà Đông,...">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Ghi chú thêm</label>
                                <textarea class="form-control" name="partner_note" rows="2" placeholder="Thông tin bổ sung khác..."></textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">Đăng bài</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Script để hiển thị/ẩn phần tìm đối -->
    <script>
        document.getElementById('isPartner').addEventListener('change', function() {
            const partnerFields = document.getElementById('partnerFields');
            const partnerInputs = partnerFields.querySelectorAll('input, select, textarea');
            
            if (this.checked) {
                partnerFields.style.display = 'block';
                // Kích hoạt các trường bắt buộc
                partnerInputs.forEach(input => {
                    if (input.name === 'preferred_level' || input.name === 'preferred_gender' || 
                        input.name === 'preferred_time' || input.name === 'preferred_area') {
                        input.required = true;
                    }
                });
            } else {
                partnerFields.style.display = 'none';
                // Xóa yêu cầu bắt buộc và làm trống giá trị
                partnerInputs.forEach(input => {
                    input.required = false;
                    input.value = '';
                });
            }
        });
    </script>

    <%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;

    String typeParamForPage = request.getParameter("type") != null ? "&type=" + request.getParameter("type") : "";
    String searchParam = request.getParameter("search") != null ? "&search=" + request.getParameter("search") : "";
    %>

    <div style="text-align: center; margin-top: 30px;">
        <ul class="pagination justify-content-center">
            <% for (int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= (i == currentPage ? "active" : "") %>">
                <a class="page-link" href="PostView?page=<%= i %><%= typeParamForPage %><%= searchParam %>"><%= i %></a>
            </li>
            <% } %>
        </ul>
    </div>
</div>
<jsp:include page="homefooter.jsp" />