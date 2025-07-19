<%@ page import="java.util.List, Model.Comment, Model.User" %>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Comment> commentList = (List<Comment>) request.getAttribute("commentList");
    if (commentList == null) commentList = new java.util.ArrayList<>();
    User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
    int postId = (request.getAttribute("postId") != null) ? (int) request.getAttribute("postId") : -1;
%>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
<!-- Để style y như cũ -->

<style>
    .comment-section {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 20px;
        margin-top: 20px;
    }

    .comment-box {
        background: white;
        border-radius: 12px;
        padding: 16px;
        margin-bottom: 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        position: relative;
        transition: all 0.3s ease;
    }

    .comment-box:hover {
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }

    .reply-box {
        margin-left: 20px;
        margin-top: 12px;
        border-left: 3px solid #007bff;
        padding-left: 15px;
    }

    .comment-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
    }

    .comment-user {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .comment-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: linear-gradient(135deg, #007bff, #6610f2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 14px;
    }

    .comment-username {
        font-weight: 600;
        color: #333;
        font-size: 14px;
    }

    .comment-time {
        font-size: 12px;
        color: #6c757d;
        margin-left: 8px;
    }

    .comment-content {
        color: #495057;
        line-height: 1.5;
        margin-bottom: 12px;
        word-wrap: break-word;
    }

    .comment-actions {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .action-btn {
        background: none;
        border: none;
        color: #6c757d;
        font-size: 13px;
        cursor: pointer;
        padding: 4px 8px;
        border-radius: 6px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .action-btn:hover {
        background: #f8f9fa;
        color: #007bff;
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        border-radius: 8px;
        min-width: 140px;
    }

    .dropdown-item {
        padding: 8px 16px;
        font-size: 13px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .dropdown-item:hover {
        background: #f8f9fa;
    }

    .more-btn {
        background: none;
        border: none;
        color: #6c757d;
        font-size: 16px;
        cursor: pointer;
        padding: 4px 8px;
        border-radius: 6px;
        transition: all 0.2s ease;
    }

    .more-btn:hover {
        background: #f8f9fa;
        color: #333;
    }

    .reply-form {
        margin-top: 8px;
        display: none;
        background: #f8f9fa;
        padding: 12px;
        border-radius: 8px;
        border: 1px solid #dee2e6;
    }

    .reply-form.active {
        display: block;
    }

    .main-comment-form {
        background: white;
        border-radius: 12px;
        padding: 16px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .form-control {
        border-radius: 8px;
        border: 1px solid #dee2e6;
        padding: 12px;
        font-size: 14px;
        resize: vertical;
    }

    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
    }

    .btn-primary {
        border-radius: 8px;
        padding: 8px 16px;
        font-size: 14px;
        font-weight: 500;
    }

    .btn-sm {
        padding: 4px 12px;
        font-size: 12px;
    }

    .edit-form {
        display: none;
        background: #fff3cd;
        padding: 12px;
        border-radius: 8px;
        border: 1px solid #ffeaa7;
        margin-top: 8px;
    }

    .edit-form.active {
        display: block;
    }

    .section-title {
        color: #333;
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .login-alert {
        border-radius: 8px;
        border: 1px solid #bee5eb;
        background: #d1ecf1;
        color: #0c5460;
    }

    .comment-stats {
        color: #6c757d;
        font-size: 13px;
        margin-bottom: 16px;
    }

    /* Report Modal Styles */
    .report-modal .modal-content {
        border: none;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }

    .report-modal .modal-header {
        border-bottom: 1px solid #eee;
        padding: 20px 24px 16px;
        background: linear-gradient(135deg, #ff6b6b, #ee5a24);
        color: white;
        border-radius: 16px 16px 0 0;
    }

    .report-modal .modal-title {
        font-weight: 600;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .report-modal .btn-close {
        filter: invert(1);
        opacity: 0.8;
    }

    .report-modal .btn-close:hover {
        opacity: 1;
    }

    .report-modal .modal-body {
        padding: 24px;
    }

    .report-reason-option {
        border: 2px solid #e9ecef;
        border-radius: 8px;
        padding: 12px 16px;
        margin-bottom: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .report-reason-option:hover {
        border-color: #007bff;
        background: #f8f9ff;
    }

    .report-reason-option.selected {
        border-color: #007bff;
        background: #e7f3ff;
    }

    .report-reason-option input[type="radio"] {
        width: 18px;
        height: 18px;
        accent-color: #007bff;
    }

    .report-reason-label {
        flex: 1;
        font-weight: 500;
        color: #333;
    }

    .report-reason-desc {
        font-size: 12px;
        color: #6c757d;
        margin-top: 4px;
    }

    .report-custom-reason {
        margin-top: 12px;
        display: none;
    }

    .report-custom-reason.active {
        display: block;
    }

    .report-custom-reason textarea {
        border: 2px solid #e9ecef;
        border-radius: 8px;
        padding: 12px;
        min-height: 80px;
        resize: vertical;
    }

    .report-custom-reason textarea:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
    }

    .report-warning {
        background: #fff3cd;
        border: 1px solid #ffeaa7;
        border-radius: 8px;
        padding: 12px;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #856404;
    }

    .report-modal .modal-footer {
        border-top: 1px solid #eee;
        padding: 16px 24px 20px;
        background: #f8f9fa;
        border-radius: 0 0 16px 16px;
    }

    .report-submit-btn {
        background: linear-gradient(135deg, #ff6b6b, #ee5a24);
        border: none;
        padding: 10px 24px;
        font-weight: 500;
        border-radius: 8px;
    }

    .report-submit-btn:hover {
        background: linear-gradient(135deg, #ff5252, #e55100);
        transform: translateY(-1px);
    }

    .report-submit-btn:disabled {
        opacity: 0.6;
        cursor: not-allowed;
    }
</style>

<div class="comment-section">
    <div class="section-title">
        <i class="fas fa-comments"></i> Bình luận
        <span class="comment-stats">(<%= commentList.size() %> bình luận)</span>
    </div>

    <%-- FORM GỬI BÌNH LUẬN GỐC --%>
    <% if (currentUser != null && postId > 0) { %>
    <div class="main-comment-form">
        <form method="post" action="AddComment">
            <input type="hidden" name="postId" value="<%= postId %>"/>
            <div class="d-flex gap-3">
                <div class="comment-avatar"><%= currentUser.getUsername().substring(0, 1).toUpperCase() %></div>
                <div class="flex-grow-1">
                    <textarea name="content" class="form-control" rows="3" placeholder="Chia sẻ suy nghĩ của bạn..." required></textarea>
                    <div class="d-flex justify-content-end mt-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Gửi bình luận
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <% } %>

    <div class="comments-list">
        <% if (commentList.isEmpty()) { %>
        <div class="text-center py-5">
            <i class="fas fa-comments fa-3x text-muted mb-3"></i>
            <p class="text-muted">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
        </div>
        <% } else { %>
            <%-- DUYỆT COMMENT GỐC --%>
            <% for (Comment c : commentList) { %>
                <div class="comment-box">
                    <div class="comment-header">
                        <div class="comment-user">
                            <div class="comment-avatar"><%= c.getUser().getUsername().substring(0,1).toUpperCase() %></div>
                            <div>
                                <div class="comment-username"><%= c.getUser().getUsername() %></div>
                                <div class="comment-time"><i class="fas fa-clock"></i> <%= c.getCreatedAt() %></div>
                            </div>
                        </div>
                        <%-- Dropdown sửa, xóa, báo cáo --%>
                        <div class="dropdown">
                            <button class="more-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-ellipsis-h"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <% boolean canEdit = (currentUser != null && c.getUser() != null && currentUser.getUser_Id() == c.getUser().getUser_Id()); %>
                                <% if (canEdit) { %>
                                <li><a class="dropdown-item" href="#" onclick="showEditComment(<%= c.getCommentId() %>);return false;"><i class="fas fa-edit"></i> Sửa</a></li>
                                <li><a class="dropdown-item text-danger" href="#" onclick="confirmDeleteComment(<%= c.getCommentId() %>);return false;"><i class="fas fa-trash"></i> Xóa</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <% } %>
                                <% if (currentUser != null) { %>
                                <li><a class="dropdown-item text-warning" href="#" onclick="reportComment(<%= c.getCommentId() %>);return false;"><i class="fas fa-flag"></i> Báo cáo</a></li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                    <div class="comment-content" id="comment-content-<%= c.getCommentId() %>"><%= c.getContent() %></div>
                    <%-- FORM SỬA BÌNH LUẬN --%>
                    <% if (canEdit) { %>
                    <div class="edit-form" id="edit-form-<%= c.getCommentId() %>">
                        <form method="post" action="UpdateComment">
                            <input type="hidden" name="commentId" value="<%= c.getCommentId() %>"/>
                            <textarea name="content" class="form-control" rows="3" required><%= c.getContent() %></textarea>
                            <div class="d-flex gap-2 mt-2">
                                <button type="submit" class="btn btn-success btn-sm"><i class="fas fa-save"></i> Lưu</button>
                                <button type="button" class="btn btn-secondary btn-sm" onclick="hideEditComment(<%= c.getCommentId() %>)"><i class="fas fa-times"></i> Hủy</button>
                            </div>
                        </form>
                    </div>
                    <% } %>
                    <div class="comment-actions">
                        <% if (currentUser != null) { %>
                        <button class="action-btn" onclick="toggleReplyForm(<%= c.getCommentId() %>)"><i class="fas fa-reply"></i> Trả lời</button>
                        <% } %>
                    </div>
                    <%-- FORM TRẢ LỜI --%>
                    <% if (currentUser != null) { %>
                    <div class="reply-form" id="reply-form-<%= c.getCommentId() %>">
                        <form method="post" action="AddComment">
                            <input type="hidden" name="postId" value="<%= c.getPostId() %>"/>
                            <input type="hidden" name="parentId" value="<%= c.getCommentId() %>"/>
                            <div class="d-flex gap-3">
                                <div class="comment-avatar"><%= currentUser.getUsername().substring(0, 1).toUpperCase() %></div>
                                <div class="flex-grow-1">
                                    <textarea name="content" class="form-control" rows="2" placeholder="Viết trả lời..." required></textarea>
                                    <div class="d-flex gap-2 mt-2">
                                        <button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-paper-plane"></i> Trả lời</button>
                                        <button type="button" class="btn btn-secondary btn-sm" onclick="hideReplyForm(<%= c.getCommentId() %>)"><i class="fas fa-times"></i> Hủy</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <% } %>
                    <%-- HIỂN THỊ REPLY (lồng tiếp theo cấp 2, 3...) --%>
                    <% if (c.getReplies() != null && !c.getReplies().isEmpty()) { %>
                    <div class="reply-box">
                        <% for (Comment reply : c.getReplies()) { %>
                            <%-- Dùng lại đoạn HTML như trên để hiển thị từng reply, bạn có thể tách ra thành một hàm riêng nếu muốn DRY --%>
                            <div class="comment-box">
                                <div class="comment-header">
                                    <div class="comment-user">
                                        <div class="comment-avatar"><%= reply.getUser().getUsername().substring(0,1).toUpperCase() %></div>
                                        <div>
                                            <div class="comment-username"><%= reply.getUser().getUsername() %></div>
                                            <div class="comment-time"><i class="fas fa-clock"></i> <%= reply.getCreatedAt() %></div>
                                        </div>
                                    </div>
                                    <div class="dropdown">
                                        <button class="more-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="fas fa-ellipsis-h"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <% boolean canEditReply = (currentUser != null && reply.getUser() != null && currentUser.getUser_Id() == reply.getUser().getUser_Id()); %>
                                            <% if (canEditReply) { %>
                                            <li><a class="dropdown-item" href="#" onclick="showEditComment(<%= reply.getCommentId() %>);return false;"><i class="fas fa-edit"></i> Sửa</a></li>
                                            <li><a class="dropdown-item text-danger" href="#" onclick="confirmDeleteComment(<%= reply.getCommentId() %>);return false;"><i class="fas fa-trash"></i> Xóa</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <% } %>
                                            <% if (currentUser != null) { %>
                                            <li><a class="dropdown-item text-warning" href="#" onclick="reportComment(<%= reply.getCommentId() %>);return false;"><i class="fas fa-flag"></i> Báo cáo</a></li>
                                            <% } %>
                                        </ul>
                                    </div>
                                </div>
                                <div class="comment-content" id="comment-content-<%= reply.getCommentId() %>"><%= reply.getContent() %></div>
                                <% if (canEditReply) { %>
                                <div class="edit-form" id="edit-form-<%= reply.getCommentId() %>">
                                    <form method="post" action="UpdateComment">
                                        <input type="hidden" name="commentId" value="<%= reply.getCommentId() %>"/>
                                        <textarea name="content" class="form-control" rows="3" required><%= reply.getContent() %></textarea>
                                        <div class="d-flex gap-2 mt-2">
                                            <button type="submit" class="btn btn-success btn-sm"><i class="fas fa-save"></i> Lưu</button>
                                            <button type="button" class="btn btn-secondary btn-sm" onclick="hideEditComment(<%= reply.getCommentId() %>)"><i class="fas fa-times"></i> Hủy</button>
                                        </div>
                                    </form>
                                </div>
                                <% } %>
                                <div class="comment-actions">
                                    <% if (currentUser != null) { %>
                                    <button class="action-btn" onclick="toggleReplyForm(<%= reply.getCommentId() %>)"><i class="fas fa-reply"></i> Trả lời</button>
                                    <% } %>
                                </div>
                                <% if (currentUser != null) { %>
                                <div class="reply-form" id="reply-form-<%= reply.getCommentId() %>">
                                    <form method="post" action="AddComment">
                                        <input type="hidden" name="postId" value="<%= reply.getPostId() %>"/>
                                        <input type="hidden" name="parentId" value="<%= reply.getCommentId() %>"/>
                                        <div class="d-flex gap-3">
                                            <div class="comment-avatar"><%= currentUser.getUsername().substring(0, 1).toUpperCase() %></div>
                                            <div class="flex-grow-1">
                                                <textarea name="content" class="form-control" rows="2" placeholder="Viết trả lời..." required></textarea>
                                                <div class="d-flex gap-2 mt-2">
                                                    <button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-paper-plane"></i> Trả lời</button>
                                                    <button type="button" class="btn btn-secondary btn-sm" onclick="hideReplyForm(<%= reply.getCommentId() %>)"><i class="fas fa-times"></i> Hủy</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <% } %>
                                <%-- LỒNG TIẾP CẤP 3 (reply của reply) --%>
                                <% if (reply.getReplies() != null && !reply.getReplies().isEmpty()) { %>
                                    <div class="reply-box">
                                        <% for (Comment reply2 : reply.getReplies()) { %>
                                            <%-- Lặp lại code block trên với reply2 nếu muốn đa cấp --%>
                                            <%-- Để gọn code, bạn có thể tách thành file riêng hoặc dùng include --%>
                                            <!-- ... (lặp lại như trên cho cấp sâu hơn nếu muốn) ... -->
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                    <% } %>
                </div>
            <% } %>
        <% } %>
    </div>
</div>

<!-- Report Comment Modal -->
<div class="modal fade report-modal" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reportModalLabel">
                    <i class="fas fa-flag"></i>
                    Báo cáo vi phạm
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="report-warning">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>Báo cáo sai lệch có thể dẫn đến hạn chế tính năng của bạn.</span>
                </div>

                <form id="reportForm">
                    <input type="hidden" id="reportCommentId" name="commentId">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Lý do báo cáo:</label>

                        <div class="report-reason-option" onclick="selectReportReason('spam')">
                            <input type="radio" name="reportReason" value="spam" id="reason-spam">
                            <div>
                                <div class="report-reason-label">Spam hoặc quảng cáo</div>
                                <div class="report-reason-desc">Nội dung quảng cáo, spam, hoặc không liên quan</div>
                            </div>
                        </div>

                        <div class="report-reason-option" onclick="selectReportReason('harassment')">
                            <input type="radio" name="reportReason" value="harassment" id="reason-harassment">
                            <div>
                                <div class="report-reason-label">Quấy rối hoặc bắt nạt</div>
                                <div class="report-reason-desc">Tấn công cá nhân, quấy rối, hoặc bắt nạt</div>
                            </div>
                        </div>

                        <div class="report-reason-option" onclick="selectReportReason('hate')">
                            <input type="radio" name="reportReason" value="hate" id="reason-hate">
                            <div>
                                <div class="report-reason-label">Ngôn từ thù địch</div>
                                <div class="report-reason-desc">Phân biệt đối xử, thù địch dựa trên nhóm</div>
                            </div>
                        </div>

                        <div class="report-reason-option" onclick="selectReportReason('inappropriate')">
                            <input type="radio" name="reportReason" value="inappropriate" id="reason-inappropriate">
                            <div>
                                <div class="report-reason-label">Nội dung không phù hợp</div>
                                <div class="report-reason-desc">Nội dung nhạy cảm, bạo lực, hoặc không phù hợp</div>
                            </div>
                        </div>

                        <div class="report-reason-option" onclick="selectReportReason('misinformation')">
                            <input type="radio" name="reportReason" value="misinformation" id="reason-misinformation">
                            <div>
                                <div class="report-reason-label">Thông tin sai lệch</div>
                                <div class="report-reason-desc">Tin tức giả, thông tin sai lệch có thể gây hại</div>
                            </div>
                        </div>

                        <div class="report-reason-option" onclick="selectReportReason('other')">
                            <input type="radio" name="reportReason" value="other" id="reason-other">
                            <div>
                                <div class="report-reason-label">Khác</div>
                                <div class="report-reason-desc">Lý do khác không nằm trong danh sách trên</div>
                            </div>
                        </div>
                    </div>

                    <div class="report-custom-reason" id="customReasonDiv">
                        <label for="customReason" class="form-label fw-bold">Chi tiết thêm:</label>
                        <textarea class="form-control" id="customReason" name="customReason" 
                                  placeholder="Vui lòng mô tả chi tiết lý do báo cáo của bạn..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i> Hủy
                </button>
                <button type="button" class="btn btn-primary report-submit-btn" id="submitReport" disabled>
                    <i class="fas fa-flag"></i> Gửi báo cáo
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Hiển thị form chỉnh sửa comment
    function showEditComment(commentId) {
        const contentDiv = document.getElementById('comment-content-' + commentId);
        const editForm = document.getElementById('edit-form-' + commentId);

        if (contentDiv && editForm) {
            contentDiv.style.display = 'none';
            editForm.classList.add('active');
        }
    }

    // Ẩn form chỉnh sửa comment
    function hideEditComment(commentId) {
        const contentDiv = document.getElementById('comment-content-' + commentId);
        const editForm = document.getElementById('edit-form-' + commentId);

        if (contentDiv && editForm) {
            contentDiv.style.display = 'block';
            editForm.classList.remove('active');
        }
    }

    // Hiển thị/ẩn form trả lời
    function toggleReplyForm(commentId) {
        const replyForm = document.getElementById('reply-form-' + commentId);
        if (replyForm) {
            replyForm.classList.toggle('active');
            if (replyForm.classList.contains('active')) {
                replyForm.querySelector('textarea').focus();
            }
        }
    }

    // Ẩn form trả lời
    function hideReplyForm(commentId) {
        const replyForm = document.getElementById('reply-form-' + commentId);
        if (replyForm) {
            replyForm.classList.remove('active');
        }
    }

    // Xác nhận xóa comment
    function confirmDeleteComment(commentId) {
        if (confirm('Bạn có chắc chắn muốn xóa bình luận này không? Hành động này không thể hoàn tác.')) {
            // Hiển thị loading
            const button = event.target.closest('.dropdown-item');
            const originalText = button.innerHTML;
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xóa...';

            // Redirect để xóa
            window.location.href = 'DeleteComment?commentId=' + commentId;
        }
    }

    // Báo cáo comment
    function reportComment(commentId) {
        // Reset các field trong modal
        document.getElementById('reportCommentId').value = commentId;
        document.querySelectorAll('input[name="reportReason"]').forEach(e => {
            e.checked = false;
        });
        document.getElementById('customReasonDiv').classList.remove('active');
        document.getElementById('customReason').value = '';
        document.getElementById('submitReport').disabled = true;
        // Hiện modal Bootstrap
        var modal = new bootstrap.Modal(document.getElementById('reportModal'));
        modal.show();
    }

    // Auto-resize textarea
    document.addEventListener('input', function (e) {
        if (e.target.tagName === 'TEXTAREA') {
            e.target.style.height = 'auto';
            e.target.style.height = e.target.scrollHeight + 'px';
        }
    });

    // Đóng dropdown khi click bên ngoài
    document.addEventListener('click', function (e) {
        if (!e.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.classList.remove('show');
            });
        }
    });
    document.getElementById('submitReport').onclick = function () {
        var commentId = document.getElementById('reportCommentId').value;
        var reasonRadio = document.querySelector('input[name="reportReason"]:checked');
        var reasonValue = reasonRadio ? reasonRadio.value : '';
        var customReason = document.getElementById('customReason').value.trim();

        // Lý do cuối cùng để gửi
        var reportReason = (reasonValue === 'other')
                ? (customReason || 'Lý do khác')
                : reasonRadio ? reasonRadio.nextElementSibling.querySelector('.report-reason-label').innerText : '';

        if (!reasonValue) {
            alert('Vui lòng chọn lý do báo cáo!');
            return;
        }
        if (reasonValue === 'other' && !customReason) {
            alert('Vui lòng nhập chi tiết lý do báo cáo!');
            return;
        }

        // Disable nút gửi để tránh spam
        document.getElementById('submitReport').disabled = true;

        fetch('ReportComment', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'commentId=' + commentId + '&reason=' + encodeURIComponent(reportReason)
        })
                .then(response => response.text().then(text => ({status: response.status, text: text})))
                .then(data => {
                    // Ẩn modal
                    var modal = bootstrap.Modal.getInstance(document.getElementById('reportModal'));
                    if (modal)
                        modal.hide();
                    // Thông báo kết quả
                    if (data.status === 200) {
                        alert('Báo cáo đã được gửi thành công. Cảm ơn bạn đã góp phần duy trì môi trường tích cực!');
                    } else {
                        alert('Không thể gửi báo cáo: ' + data.text);
                    }
                })
                .catch(error => {
                    alert('Có lỗi xảy ra khi gửi báo cáo. Vui lòng thử lại.');
                })
                .finally(() => {
                    document.getElementById('submitReport').disabled = false;
                });
    };

    function selectReportReason(value) {
        // Đánh dấu radio được chọn, và highlight lý do
        document.querySelectorAll('input[name="reportReason"]').forEach(e => {
            e.checked = (e.value === value);
            if (e.closest('.report-reason-option')) {
                e.closest('.report-reason-option').classList.toggle('selected', e.checked);
            }
        });
        // Hiện box nhập nếu là "Khác"
        if (value === 'other') {
            document.getElementById('customReasonDiv').classList.add('active');
        } else {
            document.getElementById('customReasonDiv').classList.remove('active');
        }
        // **Kích hoạt nút gửi**
        document.getElementById('submitReport').disabled = false;
    }

</script>