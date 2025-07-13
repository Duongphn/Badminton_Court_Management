<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header">
            <h3><i class="fas fa-edit"></i> Chỉnh sửa Sự kiện</h3>
        </div>
        <div class="card-body">
            <form action="manage-event?action=update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="eventId" value="${event.eventId}">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên sự kiện</label>
                    <input type="text" class="form-control" id="name" name="name" value="${event.name}" required>
                </div>
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" id="title" name="title" value="${event.title}" required>
                </div>
                <div class="mb-3">
                    <label for="imageUrl" class="form-label">Hình ảnh</label>
                    <input type="file" class="form-control" id="imageUrl" name="imageUrl">
                    <c:if test="${not empty event.imageUrl}">
                        <img src="${event.imageUrl}" alt="Event Image" width="100" class="mt-2">
                    </c:if>
                </div>
                <div class="mb-3">
                    <label for="areaId" class="form-label">Khu vực</label>
                    <select class="form-select" id="areaId" name="areaId" required>
                        <option value="">-- Chọn khu vực --</option>
                        <c:forEach var="area" items="${areaList}">
                            <option value="${area.area_id}" <c:if test="${area.area_id == event.areaId}">selected</c:if>>
                                ${area.name} - ${area.location}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="startDate" class="form-label">Ngày bắt đầu</label>
                        <input type="datetime-local" class="form-control" id="startDate" name="startDate" value="<fmt:formatDate value='${event.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="endDate" class="form-label">Ngày kết thúc</label>
                        <input type="datetime-local" class="form-control" id="endDate" name="endDate" value="<fmt:formatDate value='${event.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Trạng thái</label>
                    <select class="form-select" id="status" name="status">
                        <option value="true" <c:if test="${event.status}">selected</c:if>>Hoạt động</option>
                        <option value="false" <c:if test="${!event.status}">selected</c:if>>Không hoạt động</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                <a href="manage-event" class="btn btn-secondary">Hủy</a>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>