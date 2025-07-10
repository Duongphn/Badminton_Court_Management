<%@ page import="java.util.*, Model.Comment, Model.User" %>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Comment> commentList = (List<Comment>) request.getAttribute("commentList");
    User currentUser = (User) session.getAttribute("user");
    int postId = (int) request.getAttribute("postId");
    if (commentList == null) commentList = new ArrayList<>();
%>

<style>
    .comment-box {
        border-bottom: 1px solid #eee;
        padding: 10px 0;
    }

    .reply-box {
        margin-left: 30px;
        border-left: 2px solid #ddd;
        padding-left: 15px;
    }

    .comment-meta {
        font-size: 12px;
        color: #777;
    }

    .reply-form {
        margin-top: 8px;
    }
</style>

<div class="mt-5">
    <h5>💬 Bình luận</h5>

    <!-- Form gửi bình luận gốc -->
    <% if (currentUser != null) { %>
    <form method="post" action="AddComment" class="mb-3">
        <input type="hidden" name="postId" value="<%= postId %>"/>
        <textarea name="content" class="form-control" rows="3" placeholder="Viết bình luận..." required></textarea>
        <button type="submit" class="btn btn-primary mt-2 btn-sm">Gửi</button>
    </form>
    <% } else { %>
    <div class="alert alert-warning">Vui lòng <a href="login.jsp">đăng nhập</a> để bình luận.</div>
    <% } %>

    <!-- Đệ quy hiển thị bình luận -->
    <ul class="list-unstyled">
        <%!
            void renderComment(Comment c, JspWriter out, User currentUser) throws java.io.IOException {
                out.write("<li class='comment-box'>");
                out.write("<strong>" + c.getUser().getUsername() + "</strong>: " + c.getContent());
                out.write("<div class='comment-meta'>" + c.getCreatedAt() + "</div>");

                if (currentUser != null) {
                    out.write("<form method='post' action='AddComment' class='reply-form'>");
                    out.write("<input type='hidden' name='postId' value='" + c.getPostId() + "'/>");
                    out.write("<input type='hidden' name='parentId' value='" + c.getCommentId() + "'/>");
                    out.write("<textarea name='content' class='form-control' rows='2' placeholder='Trả lời...'></textarea>");
                    out.write("<button type='submit' class='btn btn-sm btn-outline-primary mt-1'>Trả lời</button>");
                    out.write("</form>");
                }

                if (c.getReplies() != null && !c.getReplies().isEmpty()) {
                    out.write("<ul class='list-unstyled reply-box'>");
                    for (Comment reply : c.getReplies()) {
                        renderComment(reply, out, currentUser);
                    }
                    out.write("</ul>");
                }

                out.write("</li>");
            }
        %>

        <% for (Comment c : commentList) { renderComment(c, out, currentUser); } %>
    </ul>
</div>
