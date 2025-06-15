<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>FAQ Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Navbar -->
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
                <!-- Sidebar -->
                <div class="col-md-3">
                    <jsp:include page="Sidebar.jsp" />
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="container py-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="mb-0"><i class="fas fa-question-circle"></i> FAQ Management</h2>
                            <div class="btn-group">
                                <a href="faq-add" class="btn btn-success">
                                    <i class="fas fa-plus-circle"></i> Add Question
                                </a>

                            </div>
                        </div>

                        <!-- Filter/Search -->
                        <form method="get" class="row mb-3 g-2">
                            <div class="col-md-5">
                                <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Search by title...">
                            </div>
                            <div class="col-md-4">
                                <select name="tagId" class="form-select">
                                    <option value="">-- All tags --</option>
                                    <c:forEach var="tag" items="${tagList}">
                                        <option value="${tag.tagId}" ${param.tagId == tag.tagId ? 'selected' : ''}>${tag.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search"></i> Filter</button>
                            </div>
                        </form>

                        <div class="card shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover mb-0 align-middle text-center">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Tag</th>
                                                <th>Created At</th>
                                                <th>Updated At</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="q" items="${faqList}">
                                                <tr>
                                                    <td>${q.questionId}</td>
                                                    <td class="text-start">${q.title}</td>
                                                    <td><span class="badge bg-info">${q.tag.name}</span></td>
                                                    <td>${q.createdAt}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty q.updatedAt}">${q.updatedAt}</c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="faq-answer-add?id=${q.questionId}" class="btn btn-outline-primary">
                                                            <i class="fas fa-comment-dots"></i> Add Answer
                                                        </a>
                                                        <a href="faq-edit?id=${q.questionId}" class="btn btn-warning btn-sm">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </a>
                                                        <a href="faq-delete?id=${q.questionId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this question?')">
                                                            <i class="fas fa-trash"></i> Delete
                                                        </a>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-white">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="faq-list?page=${currentPage - 1}&keyword=${param.keyword}&tagId=${param.tagId}">&laquo;</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="faq-list?page=${i}&keyword=${param.keyword}&tagId=${param.tagId}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="faq-list?page=${currentPage + 1}&keyword=${param.keyword}&tagId=${param.tagId}">&raquo;</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
