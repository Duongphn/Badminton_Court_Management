<%@ page import="java.util.List" %>
<%@ page import="Model.Equipments" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>🏙 Danh sách thiết bị</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #1e1e2f;
            color: white;
            padding-top: 20px;
        }

        .sidebar a {
            padding: 12px 20px;
            display: block;
            color: white;
            text-decoration: none;
        }

        .sidebar a:hover {
            background-color: #333;
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
    List<Equipments> equipments = (List<Equipments>) request.getAttribute("equipments");
    if (equipments == null) equipments = java.util.Collections.emptyList();
    String status = (String) request.getAttribute("status");
%>

<div class="header">
    <h3>Trang quản lý thiết bị</h3>
    <a href="login" class="logout-button">Logout</a>
</div>

<div class="main-content">
    <div class="card">
        <h2>Danh sách thiết bị</h2>

        <% if ("success".equals(status)) { %>
            <p class="status-message success">✔ Thiết bị đã được thêm thành công!</p>
        <% } else if ("fail".equals(status)) { %>
            <p class="status-message fail">✘ Thêm thiết bị thất bại. Vui lòng thử lại.</p>
        <% } else if ("duplicate".equals(status)) { %>
            <p class="status-message duplicate">⚠ Thiết bị đã tồn tại!</p>
        <% } %>

        <!-- Tìm kiếm -->
        <form class="search-bar" method="get" action="searchEquipments">
            <input type="text" name="keyword" placeholder="🔍 Tìm kiếm tên thiết bị...">
            <button type="submit">Tìm</button>
        </form>

        <!-- Bảng -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên thiết bị</th>
                    <th>Giá</th>
                    <th style="width: 180px;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <% for (Equipments eq : equipments) { %>
                    <tr>
                        <td><%= eq.getEquipment_id() %></td>
                        <td><%= eq.getName() %></td>
                        <td><%= eq.getPrice() %> VNĐ</td>
                        <td class="action-buttons">
                            <a href="UpdateEquipments.jsp?id=<%= eq.getEquipment_id() %>" class="btn btn-warning">Sửa</a>
                            <a href="deleteEquipment?id=<%= eq.getEquipment_id() %>" class="btn btn-danger"
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

        <a href="AddEquipments.jsp" class="btn-green">+ Thêm thiết bị mới</a>
    </div>
</div>

</body>
</html>
