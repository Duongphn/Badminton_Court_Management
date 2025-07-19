<%@ page import="java.util.List, Model.CommentReport" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<CommentReport> reportList = (List<CommentReport>) request.getAttribute("reportList");
    if (reportList == null) reportList = new java.util.ArrayList<>();
    int currentPage = (request.getAttribute("currentPage") != null) ? (int) request.getAttribute("currentPage") : 1;
    int totalPages = (request.getAttribute("totalPages") != null) ? (int) request.getAttribute("totalPages") : 1;
    String search = (request.getAttribute("search") != null) ? (String) request.getAttribute("search") : "";
    String reason = (request.getAttribute("reason") != null) ? (String) request.getAttribute("reason") : "";
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý báo cáo bình luận vi phạm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #e74c3c;
                --success-color: #27ae60;
                --warning-color: #f39c12;
                --info-color: #3498db;
                --light-bg: #f8f9fa;
                --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                --border-radius: 8px;
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .header {
                position: fixed;
                top: 0;
                left: 280px;
                right: 0;
                z-index: 999;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                box-shadow: var(--shadow);
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h3 {
                color: var(--primary-color);
                font-weight: 600;
                margin: 0;
            }

            .logout-button {
                background: linear-gradient(135deg, var(--accent-color), #c0392b);
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(231, 76, 60, 0.3);
            }
.logout-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4);
                color: white;
            }

            .main-content {
                margin-left: 250px;
                margin-top: 80px;
                padding: 30px;
                min-height: calc(100vh - 80px);
            }

            .content-card {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                padding: 30px;
                margin-bottom: 30px;
            }

            .page-title {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 30px;
                position: relative;
                padding-bottom: 15px;
            }

            .page-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 3px;
                background: linear-gradient(135deg, var(--accent-color), #c0392b);
                border-radius: 2px;
            }

            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                border-radius: var(--border-radius);
                padding: 25px;
                text-align: center;
                box-shadow: var(--shadow);
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-card.danger {
                border-left: 4px solid var(--accent-color);
            }

            .stat-card.info {
                border-left: 4px solid var(--info-color);
            }

            .stat-icon {
                font-size: 2.5rem;
                margin-bottom: 15px;
            }

            .stat-card.danger .stat-icon {
                color: var(--accent-color);
            }

            .stat-card.info .stat-icon {
                color: var(--info-color);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: bold;
                color: var(--primary-color);
            }

            .stat-label {
                color: #6c757d;
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .table-container {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                overflow: hidden;
            }

            .table {
                margin-bottom: 0;
            }

            .table thead th {
background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                font-weight: 600;
                border: none;
                padding: 15px;
                text-align: center;
                vertical-align: middle;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background-color: rgba(52, 152, 219, 0.1);
                transform: scale(1.01);
            }

            .table td {
                padding: 15px;
                vertical-align: middle;
                border-color: rgba(0, 0, 0, 0.1);
            }

            .comment-content {
                max-width: 250px;
                word-wrap: break-word;
                font-style: italic;
                color: #495057;
            }

            .username {
                font-weight: 600;
                color: var(--primary-color);
            }

            .reason-badge {
                background: linear-gradient(135deg, var(--warning-color), #e67e22);
                color: white;
                padding: 5px 12px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .timestamp {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .action-btn {
                margin: 2px;
                border-radius: 20px;
                padding: 8px 16px;
                font-size: 0.8rem;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                text-decoration: none;
                display: inline-block;
            }

            .btn-view {
                background: linear-gradient(135deg, var(--info-color), #2980b9);
                color: white;
            }

            .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.4);
                color: white;
            }

            .btn-delete {
                background: linear-gradient(135deg, var(--accent-color), #c0392b);
                color: white;
            }

            .btn-delete:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4);
                color: white;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: var(--info-color);
            }

            .empty-state h4 {
                margin-bottom: 10px;
                color: var(--primary-color);
            }

            .loading-spinner {
                display: none;
text-align: center;
                padding: 40px;
            }

            .spinner-border {
                width: 3rem;
                height: 3rem;
                color: var(--primary-color);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header {
                    left: 0;
                    padding: 10px 15px;
                }

                .main-content {
                    margin-left: 0;
                    margin-top: 70px;
                    padding: 15px;
                }

                .content-card {
                    padding: 20px;
                }

                .stats-cards {
                    grid-template-columns: 1fr;
                }

                .table-container {
                    overflow-x: auto;
                }

                .table {
                    min-width: 800px;
                }

                .comment-content {
                    max-width: 200px;
                }
            }

            /* Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .content-card {
                animation: fadeInUp 0.6s ease;
            }

            .stat-card {
                animation: fadeInUp 0.6s ease;
            }

            .table tbody tr {
                animation: fadeInUp 0.6s ease;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h3><i class="fas fa-shield-alt"></i> Quản lý báo cáo</h3>
            <a href="login" class="logout-button">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <div class="sidebar">
            <c:choose>
                <c:when test="${sessionScope.user.role eq 'staff'}">
                    <jsp:include page="Sidebar_Staff.jsp"/>
                </c:when>
                <c:otherwise>
                    <jsp:include page="Sidebar.jsp"/>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="main-content">
            <!-- Statistics Cards -->
            <div class="stats-cards">
                <div class="stat-card danger">
                    <div class="stat-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="stat-number"><%= reportList.size() %></div>
                    <div class="stat-label">Tổng báo cáo trang này</div>
                </div>
                <div class="stat-card info">
                    <div class="stat-icon">
                        <i class="fas fa-comments"></i>
                    </div>
<div class="stat-number"><%= reportList.size() %></div>
                    <div class="stat-label">Bình luận vi phạm</div>
                </div>
            </div>

            <div class="content-card">
                <h2 class="page-title">
                    <i class="fas fa-flag"></i> Báo cáo bình luận vi phạm
                </h2>

                <!-- Form tìm kiếm, filter -->
                <form method="get" action="AdminCommentReport" class="mb-4 d-flex flex-wrap gap-2 align-items-center">
                    <input type="text" name="search" value="<%= search %>" placeholder="Tìm kiếm bình luận, người dùng, lý do..." class="form-control" style="width: 250px;">
                    <select name="reason" class="form-select" style="width: 180px;">
                        <option value="">-- Lọc theo lý do --</option>
                        <option value="Spam hoặc quảng cáo" <%= "Spam hoặc quảng cáo".equals(reason) ? "selected" : "" %>>Spam hoặc quảng cáo</option>
                        <option value="Quấy rối hoặc bắt nạt" <%= "Quấy rối hoặc bắt nạt".equals(reason) ? "selected" : "" %>>Quấy rối hoặc bắt nạt</option>
                        <option value="Ngôn từ thù địch" <%= "Ngôn từ thù địch".equals(reason) ? "selected" : "" %>>Ngôn từ thù địch</option>
                        <option value="Nội dung không phù hợp" <%= "Nội dung không phù hợp".equals(reason) ? "selected" : "" %>>Nội dung không phù hợp</option>
                        <option value="Thông tin sai lệch" <%= "Thông tin sai lệch".equals(reason) ? "selected" : "" %>>Thông tin sai lệch</option>
                        <option value="Khác" <%= "Khác".equals(reason) ? "selected" : "" %>>Khác</option>
                    </select>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
                    <a href="AdminCommentReport" class="btn btn-secondary">Đặt lại</a>
                </form>

                <div class="loading-spinner" id="loadingSpinner">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-3">Đang tải dữ liệu...</p>
                </div>

                <% if (!reportList.isEmpty()) { %>
                <div class="table-container">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th width="5%">#</th>
                                <th width="25%">Nội dung bình luận</th>
                                <th width="15%">Người bị báo cáo</th>
                                <th width="15%">Người báo cáo</th>
                                <th width="12%">Lý do</th>
<th width="13%">Thời gian</th>
                                <th width="8%">Xem bài</th>
                                <th width="7%">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int i = 1 + (currentPage - 1) * 10; 
                                for (CommentReport r : reportList) {
                            %>
                            <tr>
                                <td class="text-center"><strong><%= i++ %></strong></td>
                                <td>
                                    <div class="comment-content">
                                        <%= r.getCommentContent() %>
                                    </div>
                                </td>
                                <td>
                                    <div class="username">
                                        <i class="fas fa-user"></i> <%= r.getCommentedUsername() %>
                                    </div>
                                </td>
                                <td>
                                    <div class="username">
                                        <i class="fas fa-user-shield"></i> <%= r.getReporterUsername() %>
                                    </div>
                                </td>
                                <td>
                                    <span class="reason-badge"><%= r.getReason() %></span>
                                </td>
                                <td>
                                    <div class="timestamp">
                                        <i class="fas fa-clock"></i> <%= r.getCreatedAt() %>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <a href="PostDetail?id=<%= r.getPostId() %>#comment-<%= r.getCommentId() %>"
                                       target="_blank"
                                       class="action-btn btn-view"
                                       title="Xem bài viết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="HidenComment?commentId=<%= r.getCommentId() %>"
                                       class="action-btn btn-delete"
                                       title="Xóa bình luận"
                                       onclick="return confirm('⚠️ Bạn chắc chắn muốn xóa bình luận này? Hành động này không thể hoàn tác!');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
<%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- Phân trang -->
                <% if (totalPages > 1) { %>
                <nav>
                    <ul class="pagination justify-content-center mt-4">
                        <% for (int iPage = 1; iPage <= totalPages; iPage++) { %>
                        <li class="page-item <%= (iPage == currentPage ? "active" : "") %>">
                            <a class="page-link"
                               href="AdminCommentReport?page=<%=iPage%>&search=<%=search%>&reason=<%=reason%>"><%=iPage%></a>
                        </li>
                        <% } %>
                    </ul>
                </nav>
                <% } %>

                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-clipboard-check"></i>
                    <h4>Không có báo cáo nào</h4>
                    <p>Hiện tại chưa có báo cáo bình luận vi phạm nào trong hệ thống.</p>
                </div>
                <% } %>
            </div>
        </div>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>