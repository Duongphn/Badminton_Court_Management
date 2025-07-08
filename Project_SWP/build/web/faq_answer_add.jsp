<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Câu Trả Lời</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
</head>
<body>
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
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp"/>
        </div>
        <div class="col-md-9">
            <div class="container py-4">
                <h2 class="mb-4"><i class="fas fa-comment-dots"></i> Thêm Câu Trả Lời cho: 
                    <span class="text-primary">${question.title}</span>
                </h2>

                <!-- Form thêm/sửa Câu Trả Lời -->
                <form id="answerForm" method="post" action="faq-answer-add" class="card p-4 shadow-sm mb-4">
                    <input type="hidden" name="questionId" value="${question.questionId}"/>
                    <input type="hidden" name="answerId" id="answerId"/>

                    <c:if test="${not empty answerList}">
                        <div class="alert alert-warning">
                            Câu hỏi này đã có câu trả lời. Bạn chỉ có thể thêm một câu trả lời cho mỗi câu hỏi.
                        </div>
                    </c:if>

                    <c:if test="${empty answerList}">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nội dung câu trả lời</label>
                            <textarea id="editor" name="content"></textarea>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-paper-plane"></i> Gửi Câu Trả Lời
                            </button>
                            <!-- Nút Quay lại -->
                            <a href="faq-list" class="btn btn-secondary">Quay lại danh sách câu hỏi</a>
                        </div>
                    </c:if>
                </form>

                <!-- Danh sách các Câu Trả Lời -->
                <h5 class="mt-5 mb-3"><i class="fas fa-list"></i> Các Câu Trả Lời Đã Tồn Tại</h5>
                <c:choose>
                    <c:when test="${not empty answerList}">
                        <ul class="list-group">
                            <c:forEach var="ans" items="${answerList}">
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div style="max-width: 85%;">
                                            <strong>Câu trả lời #${ans.answerId}</strong>
                                            <span class="text-muted ms-2">
                                                <fmt:formatDate value="${ans.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                            <div class="mt-2">
                                                <c:out value="${ans.content}" escapeXml="false"/>
                                            </div>
                                        </div>
                                        <div class="ms-2 d-flex flex-column align-items-end">
                                            <!-- Xóa -->
                                            <form method="post" action="faq-answer-delete" onsubmit="return confirm('Bạn có chắc chắn muốn xoá câu trả lời này?');">
                                                <input type="hidden" name="answerId" value="${ans.answerId}"/>
                                                <input type="hidden" name="questionId" value="${question.questionId}"/>
                                                <button class="btn btn-sm btn-danger mt-1" type="submit">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>

                                          
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning">Chưa có câu trả lời nào cho câu hỏi này.</div>
                    </c:otherwise>
                </c:choose>

                <!-- Nút quay lại sau danh sách câu trả lời -->
                <a href="faq-list" class="btn btn-secondary mt-3">Quay lại danh sách câu hỏi</a>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let editorInstance;

    ClassicEditor
        .create(document.querySelector('#editor'), {
            toolbar: ['bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote']
        })
        .then(editor => {
            editorInstance = editor;

            document.getElementById('answerForm').addEventListener('submit', function (e) {
                const content = editorInstance.getData();
                if (!content.trim()) {
                    e.preventDefault();
                    alert("Nội dung câu trả lời không thể để trống.");
                }
            });
        });

    function handleEditButton(button) {
        const answerId = button.getAttribute('data-id');
        const content = button.getAttribute('data-content');

        editorInstance.setData(content);
        document.getElementById('answerId').value = answerId;

        const submitBtn = document.getElementById('submitBtn');
        submitBtn.innerHTML = '<i class="fas fa-save"></i> Cập nhật Câu Trả Lời';
        submitBtn.classList.remove('btn-primary');
        submitBtn.classList.add('btn-success');

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
</script>

</body>
</html>
