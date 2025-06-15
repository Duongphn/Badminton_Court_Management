<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Chỉnh Sửa Thông Báo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Manager</a>
    <div class="d-flex">
      <a class="nav-link text-light" href="login">Logout</a>
    </div>
  </div>
</nav>

<div class="container-fluid mt-4">
  <div class="row">
    <div class="col-md-3">
      <jsp:include page="Sidebar.jsp"/>
    </div>
    <div class="col-md-8">
      <div class="container py-4">
        <h2 class="mb-4"><i class="bi bi-pencil-square"></i> Chỉnh Sửa Thông Báo</h2>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/edit-notification"
              enctype="multipart/form-data"
              id="notificationForm">

          <input type="hidden" name="id" value="${notification.notificationId}" />

          <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="title" value="${notification.title}" class="form-control" required maxlength="255"/>
          </div>

          <div class="mb-3">
            <label class="form-label">Nội dung</label>
            <textarea name="content" id="hiddenContent" style="display:none;">${notification.content}</textarea>
            <div id="editor"></div>
          </div>

          <div class="mb-3">
            <label class="form-label">File đính kèm (ảnh, PDF, Word)</label>
            <c:if test="${not empty notification.imageUrl}">
              <p>
                <strong>Ảnh hiện tại:</strong><br>
                <img src="${notification.imageUrl}" class="img-fluid mb-2" style="max-width: 300px; border: 1px solid #ccc;"/>
              </p>
            </c:if>
            <input type="file" name="file" class="form-control" accept=".jpg,.jpeg,.png,.pdf,.doc,.docx"/>
          </div>

          <div class="mb-3">
            <label class="form-label">Thời gian dự kiến gửi</label>
            <input type="datetime-local" name="scheduledTime"
                   value="${notification.scheduledTime.toString().replace('T', ' ').substring(0, 16)}"
                   class="form-control" required/>
          </div>

          <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Cập Nhật</button>
          <a href="${pageContext.request.contextPath}/notification_list" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Quay lại
          </a>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- CKEditor Script -->
<script>
  let editorInstance;

  window.addEventListener('DOMContentLoaded', () => {
    ClassicEditor
      .create(document.querySelector('#editor'))
      .then(editor => {
        editorInstance = editor;
        editor.setData(document.getElementById("hiddenContent").value);
      })
      .catch(error => {
        console.error(error);
      });

    document.getElementById("notificationForm").addEventListener("submit", function () {
      if (editorInstance) {
        const content = editorInstance.getData();
        document.getElementById("hiddenContent").value = content;
      }
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
