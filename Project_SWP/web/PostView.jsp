<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Post" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Danh sách bài viết</title>
</head>
<body>
<h2>Danh sách bài viết</h2>

<form method="get">
    <input type="text" name="search" placeholder="Tìm tiêu đề..." value="${param.search}" />
    <select name="type">
        <option value="">Tất cả</option>
        <option value="admin" ${param.type == 'admin' ? 'selected' : ''}>Tin tức</option>
        <option value="partner" ${param.type == 'partner' ? 'selected' : ''}>Tìm đối</option>
    </select>
    <button type="submit">Lọc</button>
</form>

<table border="1">
    <tr>
        <th>Tiêu đề</th>
        <th>Loại</th>
        <th>Ngày đăng</th>
    </tr>
    <%
        List<Post> posts = (List<Post>) request.getAttribute("posts");
        for (Post p : posts) {
    %>
        <tr>
            <td><%= p.getTitle() %></td>
            <td><%= p.getPostType() %></td>
            <td><%= p.getCreatedAt() %></td>
        </tr>
    <% } %>
</table>
</body>
</html>