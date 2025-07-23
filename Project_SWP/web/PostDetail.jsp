<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Post, Model.User, java.text.SimpleDateFormat" %>
<%@page import="java.util.Map, java.util.HashMap" %>
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
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

<style>
    .post-container {
        max-width: 900px;
        margin: 2rem auto;
        padding: 0 1rem;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .post-card {
        background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .post-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
    }
    
    .post-header {
        padding: 2rem 2rem 1rem;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        position: relative;
    }
    
    .post-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><radialGradient id="a" cx="50%" cy="0%" r="100%"><stop offset="0%" stop-color="%23fff" stop-opacity=".1"/><stop offset="100%" stop-color="%23fff" stop-opacity="0"/></radialGradient></defs><rect width="100" height="20" fill="url(%23a)"/></svg>');
    }
    
    .post-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 0;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        position: relative;
        z-index: 1;
    }
    
    .post-meta {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        margin-top: 1rem;
        font-size: 0.95rem;
        opacity: 0.9;
        position: relative;
        z-index: 1;
    }
    
    .meta-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.3rem 0.8rem;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 20px;
        backdrop-filter: blur(10px);
    }
    
    .post-content-wrapper {
        padding: 2rem;
    }
    
    .post-image {
        width: 100%;
        max-height: 400px;
        object-fit: cover;
        border-radius: 15px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        transition: transform 0.3s ease;
        margin-bottom: 2rem;
    }
    
    .post-image:hover {
        transform: scale(1.02);
    }
    
    .post-content {
        font-size: 1.1rem;
        line-height: 1.8;
        color: #2c3e50;
        margin-bottom: 2rem;
    }
    
    .reaction-section {
        background: linear-gradient(145deg, #f8f9fa, #e9ecef);
        padding: 1.5rem;
        border-radius: 15px;
        margin: 1.5rem 0;
        border: 1px solid rgba(0, 0, 0, 0.05);
    }
    
    .reaction-buttons {
        display: flex;
        gap: 0.8rem;
        margin-bottom: 1rem;
        flex-wrap: wrap;
    }
    
    .reaction-btn {
        padding: 0.8rem 1.5rem;
        border: 2px solid;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .reaction-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
    
    .reaction-counts {
        display: flex;
        gap: 1.5rem;
        flex-wrap: wrap;
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 2px solid rgba(0, 0, 0, 0.1);
    }
    
    .count-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 600;
        color: #495057;
        padding: 0.5rem 1rem;
        background: white;
        border-radius: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .owner-actions {
        display: flex;
        gap: 1rem;
        margin: 2rem 0;
        flex-wrap: wrap;
    }
    
    .action-btn {
        padding: 1rem 2rem;
        border-radius: 12px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.8rem;
        font-size: 1rem;
    }
    
    .action-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    }
    
    .btn-edit {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }
    
    .btn-delete {
        background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
        color: #d63384;
    }
    
    .alert-custom {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 15px;
        padding: 1rem 1.5rem;
        margin: 1rem 0;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
    }
    
    .modal-content {
        border: none;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
    }
    
    .modal-header {
        border-radius: 20px 20px 0 0;
        border-bottom: none;
        padding: 1.5rem 2rem;
    }
    
    .modal-body {
        padding: 2rem;
    }
    
    .form-control, .form-select {
        border-radius: 12px;
        border: 2px solid #e9ecef;
        padding: 0.8rem 1rem;
        font-size: 1rem;
        transition: all 0.3s ease;
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    }
    
    .divider {
        height: 2px;
        background: linear-gradient(90deg, transparent, #667eea, transparent);
        margin: 2rem 0;
        border: none;
    }
    
    .type-badge {
        display: inline-block;
        padding: 0.4rem 1rem;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .no-post-alert {
        text-align: center;
        padding: 3rem;
        background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
        border-radius: 20px;
        color: #721c24;
        font-size: 1.2rem;
        font-weight: 600;
    }
    
    @media (max-width: 768px) {
        .post-title {
            font-size: 2rem;
        }
        
        .post-meta {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.8rem;
        }
        
        .reaction-buttons {
            justify-content: center;
        }
        
        .reaction-counts {
            justify-content: center;
        }
        
        .owner-actions {
            justify-content: center;
        }
    }
</style>

<div class="post-container">
    <% if (post != null) { %>
    
    <div class="post-card">
        <div class="post-header">
            <h1 class="post-title"><%= post.getTitle() %></h1>
            <div class="post-meta">
                <div class="meta-item">
                    <i class="fas fa-calendar-alt"></i>
                    <%= df.format(post.getCreatedAt()) %>
                </div>
                <div class="meta-item">
                    <i class="fas fa-tag"></i>
                    <span class="type-badge"><%= post.getType() %></span>
                </div>
            </div>
        </div>

        <div class="post-content-wrapper">
            <%
                String imgSrc = (post.getImage() != null && !post.getImage().isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + post.getImage() 
                    : request.getContextPath() + "/images/no-image.png";
            %>
            <img 
                src="<%= imgSrc %>" 
                class="post-image"
                onerror="this.onerror=null;this.src='<%=request.getContextPath()%>/images/no-image.png';"
                alt="Ảnh bài viết"
            >

            <div class="post-content">
                <%= post.getContent() %>
            </div>
            
            <% String userReaction = (String) request.getAttribute("userReaction"); %>
            <% if (userReaction != null) { %>
            <div class="alert-custom">
                <i class="fas fa-heart"></i> Bạn đã thả cảm xúc: <strong><%= userReaction %></strong>
            </div>
            <% } %>

            <div class="reaction-section">
                <form action="ReactionUser" method="post">
                    <input type="hidden" name="postId" value="<%= post.getPostId() %>"/>
                    <% String userReaction2 = (String) request.getAttribute("userReaction"); %>
                    
                    <div class="reaction-buttons">
                        <button type="submit" name="reaction" value="like"
                                class="reaction-btn <%= "like".equals(userReaction2) ? "btn btn-primary" : "btn btn-outline-primary" %>">
                            <i class="fas fa-thumbs-up"></i> Like
                        </button>
                        <button type="submit" name="reaction" value="love"
                                class="reaction-btn <%= "love".equals(userReaction2) ? "btn btn-danger" : "btn btn-outline-danger" %>">
                            <i class="fas fa-heart"></i> Love
                        </button>
                        <button type="submit" name="reaction" value="haha"
                                class="reaction-btn <%= "haha".equals(userReaction2) ? "btn btn-warning" : "btn btn-outline-warning" %>">
                            <i class="fas fa-laugh"></i> Haha
                        </button>
                        <button type="submit" name="reaction" value="sad"
                                class="reaction-btn <%= "sad".equals(userReaction2) ? "btn btn-secondary" : "btn btn-outline-secondary" %>">
                            <i class="fas fa-sad-tear"></i> Buồn
                        </button>
                    </div>
                </form>

                <%
                    Map<String, Integer> reactionCounts = (Map<String, Integer>) request.getAttribute("reactionCounts");
                    if (reactionCounts == null) reactionCounts = new java.util.HashMap<>();
                %>
                <div class="reaction-counts">
                    <div class="count-item">
                        <i class="fas fa-thumbs-up text-primary"></i>
                        <%= reactionCounts.getOrDefault("like", 0) %> Like
                    </div>
                    <div class="count-item">
                        <i class="fas fa-heart text-danger"></i>
                        <%= reactionCounts.getOrDefault("love", 0) %> Love
                    </div>
                    <div class="count-item">
                        <i class="fas fa-laugh text-warning"></i>
                        <%= reactionCounts.getOrDefault("haha", 0) %> Haha
                    </div>
                    <div class="count-item">
                        <i class="fas fa-sad-tear text-secondary"></i>
                        <%= reactionCounts.getOrDefault("sad", 0) %> Buồn
                    </div>
                </div>
            </div>

            <hr class="divider"/>
            
            <% if (isOwner) { %>
            <div class="owner-actions">
                <button class="action-btn btn-edit" data-bs-toggle="modal" data-bs-target="#editPostModal">
                    <i class="fas fa-edit"></i> Sửa bài viết
                </button>

                <button class="action-btn btn-delete" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">
                    <i class="fas fa-trash-alt"></i> Xóa bài viết
                </button>
            </div>
            <% } %>
        </div>
    </div>

    <% if (isOwner) { %>
    <!-- Modal cập nhật bài viết -->
    <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form method="post" action="UpdatePost">
                    <div class="modal-header" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                        <h5 class="modal-title text-white" id="editPostModalLabel">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa bài viết
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="postId" value="<%= post.getPostId() %>"/>

                        <div class="mb-4">
                            <label for="title" class="form-label fw-bold">
                                <i class="fas fa-heading me-2"></i>Tiêu đề
                            </label>
                            <input type="text" class="form-control" id="title" name="title" value="<%= post.getTitle() %>" required>
                        </div>

                        <div class="mb-4">
                            <label for="content" class="form-label fw-bold">
                                <i class="fas fa-align-left me-2"></i>Nội dung
                            </label>
                            <textarea class="form-control" id="content" name="content" rows="6" required><%= post.getContent() %></textarea>
                        </div>

                        <div class="mb-4">
                            <label for="postType" class="form-label fw-bold">
                                <i class="fas fa-tag me-2"></i>Loại bài viết
                            </label>
                            <select class="form-select" id="type" name="type">
                                <option value="common" <%= "common".equals(post.getType()) ? "selected" : "" %>>Phổ thông</option>
                                <option value="partner" <%= "partner".equals(post.getType()) ? "selected" : "" %>>Tìm đối</option>
                                <option value="news" <%= "news".equals(post.getType()) ? "selected" : "" %>>Tin tức</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                        <button type="submit" class="btn" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white;">
                            <i class="fas fa-save me-2"></i>Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal xác nhận xoá -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);">
                    <h5 class="modal-title" style="color: #721c24;" id="confirmDeleteLabel">
                        <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa bài viết
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body" style="font-size: 1.1rem; color: #495057;">
                    <i class="fas fa-question-circle me-2" style="color: #dc3545;"></i>
                    Bạn có chắc chắn muốn xóa bài viết "<strong><%= post.getTitle() %></strong>" không? 
                    <br><br>
                    <span class="text-muted"><i class="fas fa-info-circle me-1"></i>Thao tác này không thể hoàn tác.</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Hủy
                    </button>
                    <a href="DeletePostView?id=<%= post.getPostId() %>" class="btn btn-danger">
                        <i class="fas fa-trash-alt me-2"></i>Xóa
                    </a>
                </div>
            </div>
        </div>
    </div>
    <% } %>
    
    <div style="margin-top: 3rem;">
        <jsp:include page="Comment.jsp">
            <jsp:param name="postId" value="<%= post.getPostId() %>" />
        </jsp:include>
    </div>

    <% } else { %>
    <div class="no-post-alert">
        <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
        <br>Không tìm thấy bài viết.
    </div>
    <% } %>
</div>

<jsp:include page="homefooter.jsp" />