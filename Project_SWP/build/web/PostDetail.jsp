<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Post, Model.User, DAO.PostDAO, java.text.SimpleDateFormat" %>
<jsp:include page="homehead.jsp" />

<%
    Post post = (Post) request.getAttribute("post");
    User user = null;
    if (session != null) user = (User) session.getAttribute("user");
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    boolean isOwner = false;
    if (post != null && user != null) {
        isOwner = user.getUser_Id() == post.getCreatedBy();
    }
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<div style="max-width: 800px; margin: auto; padding: 20px;">
    <% if (post != null) { %>
    <h2 style="color: #e63946;"><%= post.getTitle() %></h2>
    <div style="color: #666; font-size: 14px;">
        📅 <%= df.format(post.getCreatedAt()) %> | 🏷️ <%= post.getType() %>
    </div>
    <%
    // Lấy link ảnh (nếu có) hoặc trả về ảnh mặc định
    String imgSrc = (post.getImage() != null && !post.getImage().isEmpty()) 
        ? request.getContextPath() + "/uploads/" + post.getImage() 
        : request.getContextPath() + "/images/no-image.png";
    %>
    <div style="margin: 20px 0 10px 0;">
        <img 
            src="<%= imgSrc %>" 
            style="max-width:100%;max-height:320px;object-fit:cover;border-radius:12px;box-shadow:0 1px 8px #eee;"
            onerror="this.onerror=null;this.src='<%=request.getContextPath()%>/images/no-image.png';"
            alt="Ảnh bài viết"
            >
    </div>

    <div style="margin-top: 20px; font-size: 16px;">
        <%= post.getContent() %>
    </div>

    <% String userReaction = (String) request.getAttribute("userReaction"); %>
    <% if (userReaction != null) { %>
    <div class="alert alert-info mt-3">
        Bạn đã thả cảm xúc: <strong><%= userReaction %></strong>
    </div>
    <% } %>

    <div class="mt-4">
        <form action="ReactionUser" method="post" style="display: inline;">
            <input type="hidden" name="postId" value="<%= post.getPostId() %>"/>
            <button type="submit" name="reaction" value="like" class="btn btn-outline-primary btn-sm">👍 Like</button>
            <button type="submit" name="reaction" value="love" class="btn btn-outline-danger btn-sm">❤️ Love</button>
            <button type="submit" name="reaction" value="haha" class="btn btn-outline-warning btn-sm">😂 Haha</button>
            <button type="submit" name="reaction" value="sad" class="btn btn-outline-secondary btn-sm">😢 Buồn</button>
        </form>
    </div>

    <hr/>
    <% if (isOwner) { %>

    <div class="d-flex gap-2 mt-3">
        <button class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#editPostModal">
            ✏️ Sửa bài viết
        </button>

        <button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">
            🗑️ Xóa bài viết
        </button>
    </div>
    <hr/>

    <!-- Modal cập nhật bài viết -->
    <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form method="post" action="UpdatePost">
                    <div class="modal-header bg-warning text-white">
                        <h5 class="modal-title" id="editPostModalLabel">Chỉnh sửa bài viết</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="postId" value="<%= post.getPostId() %>"/>

                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="title" name="title" value="<%= post.getTitle() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="content" class="form-label">Nội dung</label>
                            <textarea class="form-control" id="content" name="content" rows="6" required><%= post.getContent() %></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="postType" class="form-label">Loại bài viết</label>
                            <select class="form-select" id="type" name="type">
                                <option value="common" <%= "common".equals(post.getType()) ? "selected" : "" %>>Phổ thông</option>
                                <option value="partner" <%= "partner".equals(post.getType()) ? "selected" : "" %>>Tìm đối</option>
                                <option value="admin" <%= "admin".equals(post.getType()) ? "selected" : "" %>>Tin tức</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="confirmDeleteLabel">Xác nhận xóa bài viết</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa bài viết "<strong><%= post.getTitle() %></strong>" không? Thao tác này không thể hoàn tác.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a href="DeletePostView?id=<%= post.getPostId() %>" class="btn btn-danger">Xóa</a>
                </div>
            </div>
        </div>
    </div>
    <% } %>
    <% } else { %>
    <div class="alert alert-danger">Không tìm thấy bài viết!</div>
    <% } %>
</div>

<jsp:include page="homefooter.jsp" />
