<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân viên (Staff)</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #1da1f2;
            color: white;
        }
        .btn {
            padding: 6px 12px;
            background-color: #1da1f2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #1a91da;
        }
    </style>
</head>
<body>

<h2>Quản lý nhân viên (Staff)</h2>

<table>
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Status</th>
        <th>Full Name</th>
        <th>Gender</th>
        <th>Date of Birth</th>
        <th>Address</th>
        <th>Staff Phone</th>
        <th>ID Card</th>
        <th>Education</th>
        <th>Notes</th>
        <th>Action</th>
    </tr>

    <!-- Duyệt qua danh sách User role=staff -->
    <c:forEach var="u" items="${staffUserList}">
        <!-- Tìm staff ứng với user -->
        <c:set var="staffObj" value="${null}" />
        <c:forEach var="s" items="${staffList}">
            <c:if test="${s.userId.user_Id == u.user_Id}">
                <c:set var="staffObj" value="${s}" />
            </c:if>
        </c:forEach>

        <tr>
            <td>${u.user_Id}</td>
            <td>${u.username}</td>
            <td>${u.email}</td>
            <td>${u.phone_number}</td>
            <td>
                <!-- Form update status -->
                <form action="manager-staff" method="post">
                    <input type="hidden" name="user_id" value="${u.user_Id}">
                    <select name="status">
                        <option value="Active" ${u.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${u.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        <option value="Suspended" ${u.status == 'Suspended' ? 'selected' : ''}>Suspended</option>
                        <option value="Banned" ${u.status == 'Banned' ? 'selected' : ''}>Banned</option>
                    </select>
                    <button type="submit" class="btn">Update</button>
                </form>
            </td>
            <td>${staffObj != null ? staffObj.fullName : ''}</td>
            <td>${staffObj != null ? staffObj.gender : ''}</td>
            <td>${staffObj != null ? staffObj.dateOfBirth : ''}</td>
            <td>${staffObj != null ? staffObj.address : ''}</td>
            <td>${staffObj != null ? staffObj.phoneNumber : ''}</td>
            <td>${staffObj != null ? staffObj.idCardNumber : ''}</td>
            <td>${staffObj != null ? staffObj.educationLevel : ''}</td>
            <td>${staffObj != null ? staffObj.personalNotes : ''}</td>
            <td><!-- Bạn có thể thêm nút Xóa / Sửa ở đây sau --></td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
