<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
    <head>
        <title></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
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

            .main-content {
                margin-left: 250px;
                padding: 30px;
            }

            .card {
                background-color: white;
                padding: 30px;
                border-radius: 16px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .card h2 {
                color: #007bff;
                display: flex;
                align-items: center;
            }

            .card h2::before {
                content: "🛠️";
                margin-right: 10px;
            }

            .status-message {
                font-weight: bold;
                padding: 10px;
            }

            .success {
                color: green;
            }

            .fail {
                color: red;
            }

            .duplicate {
                color: orange;
            }

            .table-container {
                margin-top: 20px;
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background-color: #2c2f36;
                color: white;
                padding: 12px;
                text-align: left;
            }

            td {
                padding: 12px;
                background-color: #fff;
                border-bottom: 1px solid #ddd;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 6px 12px;
                border-radius: 6px;
                font-weight: bold;
                text-decoration: none;
                display: inline-block;
            }

            .btn-warning {
                background-color: orange;
                color: white;
            }

            .btn-danger {
                background-color: red;
                color: white;
            }

            .btn-green {
                background-color: #28a745;
                color: white;
                padding: 10px 18px;
                border-radius: 8px;
                margin-top: 20px;
                display: inline-block;
                font-weight: bold;
                border: none;
                text-decoration: none;
            }

            .btn-green:hover {
                background-color: #218838;
            }

            .search-bar {
                margin-top: 20px;
                display: flex;
            }

            .search-bar input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px 0 0 8px;
                outline: none;
            }

            .search-bar button {
                padding: 10px 16px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 0 8px 8px 0;
                cursor: pointer;
            }

            .search-bar button:hover {
                background-color: #0056b3;
            }

            .btn-pagination {
                padding: 6px 14px;
                margin: 0 4px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #fff;
                color: #333;
                text-decoration: none;
                font-size: 14px;
                display: inline-block;
                transition: background-color 0.2s;
            }

            .btn-pagination:hover {
                background-color: #e9ecef;
            }

            .btn-pagination.disabled {
                pointer-events: none;
                opacity: 0.5;
            }

            .btn-pagination.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Sidebar.jsp" />
        <%
            List<Service> service = (List<Service>) request.getAttribute("service");
            if (service == null) service = java.util.Collections.emptyList();
           String status = request.getParameter("status");
        %>

        <div class="header">
            <h3></h3>
            <a href="login" class="logout-button">Logout</a>
        </div>

        <div class="main-content">
            <div class="card">
                <h2>Danh sách dịch vụ</h2>

                <% if ("success".equals(status)) { %>
                <p class="status-message success">✔ Dịch vụ đã được thêm thành công!</p>
                <% } else if ("fail".equals(status)) { %>
                <p class="status-message fail">✘ Thêm dịch vụ thất bại. Vui lòng thử lại.</p>
                <% } else if ("duplicate".equals(status)) { %>
                <p class="status-message duplicate">⚠ Dịch vụ đã tồn tại!</p>
                <% } else if ("updated".equals(status)) { %>
                <p class="status-message success">✔ Dịch vụ đã được cập nhật!</p>
                <% } %>

                <!-- Tìm kiếm -->
                <form class="search-bar" method="get" action="ViewEquipments">
                    <input type="text" name="keyword" placeholder="🔍 Tìm kiếm tên dịch vụ...">
                    <button type="submit">Tìm</button>
                </form>

                <!-- Bảng -->
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên dịch vụ</th>
                                <th>Giá</th>
                                <th style="width: 180px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Service eq : service) { %>
                            <tr>
                                <td><%= eq.getService_id() %></td>
                                <td><%= eq.getName() %></td>
                                <td><%= eq.getPrice() %> VNĐ</td>
                                <td class="action-buttons">
                                    <a href="UpdateService.jsp?id=<%= eq.getService_id() %>" class="btn btn-warning">Sửa</a>
                                    <a href="DeleteService?id=<%= eq.getService_id() %>" class="btn btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa thiết bị này?');">Xóa</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Phân trang -->
                <div style="text-align: center; margin-top: 20px;">
                    <c:if test="${currentPage > 1}">
                        <a href="view-equipment?page=${currentPage - 1}" class="btn-pagination">Previous</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${numberOfPages}">
                        <a href="view-equipment?page=${i}" class="btn-pagination ${currentPage == i ? 'active' : ''}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < numberOfPages}">
                        <a href="view-equipment?page=${currentPage + 1}" class="btn-pagination">Next</a>
                    </c:if>
                </div>

                <div style="margin-top: 20px; text-align: left;">
                    <button class="btn-green" data-bs-toggle="modal" data-bs-target="#addServiceModal">+ Thêm dịch vụ</button>
                </div>
            </div>
        </div>

    </body>
    <!-- Modal thêm dịch vụ -->
    <div class="modal fade" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="AddService" method="post">

                    <div class="modal-header" style="background-color: #007bff; color: white;">
                        <h5 class="modal-title" id="addServiceLabel">Add Service</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>

                    <div class="modal-body" style="padding: 20px 30px;">
                        <div style="margin-bottom: 12px;">
                            <label style="display: block; margin-bottom: 6px;">Tên dịch vụ</label>
                            <input type="text" name="name" class="form-control" required />
                        </div>

                        <div style="margin-bottom: 12px;">
                            <label style="display: block; margin-bottom: 6px;">Giá</label>
                            <input type="number" name="price" class="form-control" required />
                        </div>

                        <div style="margin-bottom: 12px;">
                            <label style="display: block; margin-bottom: 6px;">Link ảnh (URL)</label>
                            <input type="text" name="image_url" class="form-control" />
                        </div>

                        <div style="margin-bottom: 12px;">
                            <label style="display: block; margin-bottom: 6px;">Mô tả</label>
                            <textarea name="description" class="form-control" rows="2"></textarea>
                        </div>

                        <div style="margin-bottom: 12px;">
                            <label style="display: block; margin-bottom: 6px;">Trạng thái:</label>
                            <div style="display: flex; gap: 30px;">
                                <label><input type="radio" name="status" value="Active" checked> Active</label>
                                <label><input type="radio" name="status" value="Inactive"> Inactive</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Thêm</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</html>
