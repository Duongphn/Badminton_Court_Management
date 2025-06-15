<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Answer</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
        <div class="col-md-9">
            <div class="container py-4">
                <h2 class="mb-4"><i class="fas fa-comment-dots"></i> Add Answer for: 
                    <span class="text-primary">${question.title}</span>
                </h2>

                <!-- Form thêm/sửa Answer -->
                <form id="answerForm" method="post" action="faq-answer-add" class="card p-4 shadow-sm mb-4">
                    <input type="hidden" name="questionId" value="${question.questionId}"/>
                    <input type="hidden" name="answerId" id="answerId"/>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Answer Content</label>
                        <textarea id="editor" name="content"></textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <i class="fas fa-paper-plane"></i> Submit Answer
                        </button>
                        <a href="faq-list" class="btn btn-secondary">Back</a>
                    </div>
                </form>

                <!-- Danh sách các Answer -->
                <h5 class="mt-5 mb-3"><i class="fas fa-list"></i> Existing Answers</h5>
                <c:choose>
                    <c:when test="${not empty answerList}">
                        <ul class="list-group">
                            <c:forEach var="ans" items="${answerList}">
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div style="max-width: 85%;">
                                            <strong>Answer #${ans.answerId}</strong>
                                            <span class="text-muted ms-2">
                                                <fmt:formatDate value="${ans.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                            <div class="mt-2">
                                                <c:out value="${ans.content}" escapeXml="false"/>
                                            </div>
                                        </div>
                                        <div class="ms-2 d-flex flex-column align-items-end">
                                            <!-- Xóa -->
                                            <form method="post" action="faq-answer-delete" onsubmit="return confirm('Are you sure you want to delete this answer?');">
                                                <input type="hidden" name="answerId" value="${ans.answerId}"/>
                                                <input type="hidden" name="questionId" value="${question.questionId}"/>
                                                <button class="btn btn-sm btn-danger mt-1" type="submit">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>

                                            <!-- Sửa -->
                                           <button type="button"
        class="btn btn-sm btn-warning mt-1"
        data-id="${ans.answerId}"
        data-content="${fn:escapeXml(ans.content)}"
        onclick="handleEditButton(this)">
    <i class="fas fa-edit"></i>
</button>

                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning">No answers yet for this question.</div>
                    </c:otherwise>
                </c:choose>
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
                    alert("Answer content cannot be empty.");
                }
            });
        });

    function handleEditButton(button) {
        const answerId = button.getAttribute('data-id');
        const content = button.getAttribute('data-content');

        editorInstance.setData(content);
        document.getElementById('answerId').value = answerId;

        const submitBtn = document.getElementById('submitBtn');
        submitBtn.innerHTML = '<i class="fas fa-save"></i> Update Answer';
        submitBtn.classList.remove('btn-primary');
        submitBtn.classList.add('btn-success');

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
</script>

</body>
</html>
