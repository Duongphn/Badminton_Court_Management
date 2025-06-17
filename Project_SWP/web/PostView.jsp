<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Post" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="homehead.jsp" />

<div style="max-width: 1100px; margin: auto; padding: 20px; font-family: Arial, sans-serif;">
    <h2 style="text-align: center; color: #e63946; margin-bottom: 30px;">Danh sách bài viết</h2>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bộ lọc và tìm kiếm -->
    <form method="get" action="PostView" style="display: flex; justify-content: space-between; margin-bottom: 20px;">
        <div>
            <label for="type">Loại bài viết:</label>
            <select name="type" id="type">
                <option value="">Tất cả</option>
                <option value="admin" <%= "admin".equals(request.getParameter("type")) ? "selected" : "" %>>Tin tức</option>
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

    <!-- Danh sách bài viết dạng thẻ -->
    <%
        List<Post> posts = (List<Post>) request.getAttribute("posts");
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        if (posts != null && !posts.isEmpty()) {
            for (Post p : posts) {
    %>
    <div style="
         border: 1px solid #eee;
         padding: 15px;
         margin-bottom: 20px;
         border-radius: 8px;
         background-color: #fff;
         box-shadow: 0 2px 4px rgba(0,0,0,0.05);
         ">
        <h3 style="margin-top: 0; color: #e63946;"><%= p.getTitle() %></h3>

        <div style="font-size: 14px; color: #555; margin-bottom: 8px;">
            📅 <%= df.format(p.getCreatedAt()) %> | 🏷️ <%= p.getType() %>
        </div>

        <p style="margin: 12px 0; color: #333;">
            <%= p.getContent().length() > 150 ? p.getContent().substring(0, 150) + "..." : p.getContent() %>
        </p>

        <a href="PostDetail?id=<%= p.getPostId() %>" style="color: #e63946; font-weight: bold;">Xem chi tiết</a>
    </div>
    <%
            }
        } else {
    %>
    <p style="text-align: center; font-style: italic; color: #888;">Không có bài viết nào phù hợp.</p>
    <%
        }
    %>

</div>
<div style="margin-left: 250px; margin-top: 10px;">
    <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#createPostModal">
        + Đăng bài viết
    </button>
</div>
<div class="modal fade" id="createPostModal" tabindex="-1" aria-labelledby="createPostModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form method="post" action="AddPost">
                <div class="modal-header" style="color : white; background: red">
                    <h5 class="modal-title" id="createPostModalLabel">Đăng bài viết mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="title" class="form-label">Tiêu đề bài viết</label>
                        <input type="text" class="form-control" name="title" id="title" required>
                    </div>

                    <div class="mb-3">
                        <label for="content" class="form-label">Nội dung</label>
                        <textarea class="form-control" name="content" id="content" rows="6" required></textarea>
                    </div>

                    <!--                    <div class="mb-3">
                                            <label for="image" class="form-label">Ảnh bài viết (không bắt buộc)</label>
                                            <input type="file" class="form-control" name="image" id="image" accept="image/*">
                                        </div>-->

                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="true" name="isPartner" id="isPartner">
                        <label class="form-check-label" for="isPartner">
                            Tôi muốn tìm đối đánh cầu
                        </label>
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
            <a class="page-link" href="PostView?page=<%= i %><%= typeParam %><%= searchParam %>"><%= i %></a>
        </li>
        <% } %>
    </ul>
</div>

<jsp:include page="homefooter.jsp" />
