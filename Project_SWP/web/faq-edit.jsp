<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Câu Hỏi FAQ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quản lý</a>
        <div class="d-flex">
            <a class="nav-link text-light" href="login">Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp" />
        </div>

        <!-- Nội dung chính -->
        <div class="col-md-9">
            <div class="container py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0"><i class="fas fa-edit"></i> Sửa Câu Hỏi FAQ</h2>
                    <a href="faq-list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách câu hỏi
                    </a>
                </div>

                <!-- Form Sửa Câu Hỏi -->
                <form action="faq-edit" method="post" class="card shadow-sm p-4">
                    <input type="hidden" name="id" value="${question.questionId}" />

                    <div class="mb-3">
                        <label class="form-label">Câu hỏi</label>
                        <input type="text" name="title" value="${question.title}" class="form-control" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Chủ đề</label>
                       <select name="tagId" class="form-select" required>
                            <c:forEach var="tag" items="${tagList}">
                                <c:set var="selected" value="" />
                                <c:if test="${not empty question.tag and tag.tagId == question.tag.tagId}">
                                    <c:set var="selected" value="selected" />
                                </c:if>
                                <option value="${tag.tagId}" ${selected}>${tag.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
