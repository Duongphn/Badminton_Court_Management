<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Post" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:include page="homehead.jsp" />

<div style="max-width:900px;margin:auto;padding:32px 0 32px 0;">
    <h2 style="color:#e63946;text-align:center;font-weight:700;margin-bottom:36px;letter-spacing:1px;">BÀI VIẾT CỦA TÔI</h2>
    <div style="margin-bottom: 12px;">
        <a href="PostView" style="
           display: inline-flex;
           align-items: center;
           gap: 7px;
           color: #e63946;
           font-size: 18px;
           font-weight: 600;
           text-decoration: none;
           transition: color 0.15s;
           " onmouseover="this.style.color = '#111'" onmouseout="this.style.color = '#e63946'">
            &#8592; <!-- Mũi tên trái Unicode -->
            Quay lại danh sách bài viết
        </a>
    </div>
    <form method="get" action="MyPosts" style="margin-bottom:32px;display:flex;justify-content:space-between;align-items:center;gap:20px;">
        <div>
            <select name="type" style="padding:8px 18px;border-radius:8px;font-size:16px;">
                <option value="">Tất cả loại</option>
                <option value="news" <%= "news".equals(request.getParameter("type"))?"selected":"" %>>Tin tức</option>
                <option value="partner" <%= "partner".equals(request.getParameter("type"))?"selected":"" %>>Tìm đối</option>
                <option value="common" <%= "common".equals(request.getParameter("type"))?"selected":"" %>>Phổ thông</option>
            </select>
            <input type="submit" value="Lọc" style="padding:8px 16px; margin-left:8px; border:none; background:#aaa; color:white; border-radius:8px;font-size:16px;">
        </div>
        <div>
            <input type="text" name="search" placeholder="Tìm tiêu đề..." style="padding:8px 16px; border-radius:8px; border:1px solid #ccc;font-size:16px;"
                   value="<%= request.getParameter("search")!=null?request.getParameter("search"):"" %>">
            <input type="submit" value="Tìm kiếm" style="padding:8px 16px; margin-left:8px; border:none; background:#aaa; color:white; border-radius:8px;font-size:16px;">
        </div>
    </form>
    <%
        List<Post> myPosts = (List<Post>)request.getAttribute("myPosts");
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    %>
    <% if (myPosts != null && !myPosts.isEmpty()) {
        for (Post p : myPosts) { %>
    <div class="card shadow-lg" style="border-radius:14px; margin-bottom:38px; background:#fff;">
        <div class="card-body" style="padding:32px 30px 26px 34px; position:relative;">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                <div style="width:80%;">
                    <h3 style="margin:0 0 13px 0; color:#e63946; font-weight:700;letter-spacing:.5px;">
                        <a href="PostDetail?id=<%= p.getPostId() %>" style="color:#e63946;text-decoration:none;"><%= p.getTitle() %></a>
                    </h3>
                    <div style="font-size:15px;color:#6c757d;margin-bottom:12px;">
                        <span style="margin-right:18px;">📅 <%= df.format(p.getCreatedAt()) %></span>
                        <span>🏷️ <%= p.getType() %></span>
                    </div>
                    <div style="color:#222; margin-bottom:12px;font-size:16px;">
                        <%= p.getContent().length()>150?p.getContent().substring(0,150)+"..." : p.getContent() %>
                    </div>
                    <a href="PostDetail?id=<%= p.getPostId() %>" style="color:#e63946;font-weight:bold;font-size:16px;text-decoration:underline;">Xem chi tiết</a>
                </div>
                <div style="width:20%;display:flex;justify-content:flex-end;align-items:flex-start;">
                    <% if ("approved".equals(p.getStatus())) { %>
                    <span class="badge" style="background:#28a745;color:white;font-size:1.1em;padding:12px 28px;border-radius:9px;">Đã duyệt</span>
                    <% } else if ("pending".equals(p.getStatus())) { %>
                    <span class="badge" style="background:#fd7e14;color:white;font-size:1.1em;padding:12px 28px;border-radius:9px;">Chờ duyệt</span>
                    <% } else if ("rejected".equals(p.getStatus())) { %>
                    <span class="badge" style="background:#dc3545;color:white;font-size:1.1em;padding:12px 28px;border-radius:9px;">Đã từ chối</span>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    <% }
        } else { %>
    <div style="color:#888;text-align:center;font-size:18px;">Bạn chưa có bài viết nào.</div>
    <% } %>
</div>

<%-- PHÂN TRANG --%>
<%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    String typeParam = request.getParameter("type")!=null?"&type="+request.getParameter("type"):"";
    String searchParam = request.getParameter("search")!=null?"&search="+request.getParameter("search"):"";
%>
<div style="text-align: center; margin-top: 30px;">
    <div class="pagination justify-content-center" style="display:inline-flex;">
        <% for (int i = 1; i <= totalPages; i++) { 
            String pageUrl = "MyPost?page=" + i + typeParam + searchParam;
            if(i == 1) pageUrl = "MyPost?" + (typeParam.length()>0?typeParam.substring(1):"") + (searchParam.length()>0?searchParam:"");
        %>
        <a
            href="<%= pageUrl %>"
            style="
            display:inline-flex;justify-content:center;align-items:center;
            width:48px;height:40px;
            font-size:20px;font-weight:500;
            border:<%= (i==currentPage)?"none":"1.5px solid #e3e3e3" %>;
            border-radius:11px 11px 11px 11px;
            margin-right:5px;
            background:<%= (i==currentPage)?"#1877f2":"#fff" %>;
            color:<%= (i==currentPage)?"#fff":"#1877f2" %>;
            box-shadow:<%= (i==currentPage)?"0 3px 8px #1877f21c":"none" %>;
            transition:.18s;
            text-decoration:none;
            "
            ><%= i %></a>
        <% } %>
    </div>
</div>
<jsp:include page="homefooter.jsp" />
