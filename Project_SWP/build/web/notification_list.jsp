<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Notification List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
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

<!-- Layout -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp"/>
        </div>

        <!-- Content -->
        <div class="col-md-8">
            <div class="container py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0"><i class="bi bi-bell"></i> Notification List</h2>
                    <a href="${pageContext.request.contextPath}/create-notification" class="btn btn-success">
                        <i class="bi bi-plus-circle"></i> Create Notification
                    </a>
                </div>

                <!-- Search Form -->
                <form class="mb-3 d-flex" method="get" action="notification_list">
                    <input type="text" name="keyword" value="${keyword}" class="form-control me-2" placeholder="Search by title...">
                    <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                </form>

                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0 align-middle">
                                <thead class="table-light text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Attachment</th>
                                    <th>Schedule</th>
                                    <th>Sent</th>
                                    <th>Status</th>
                                    <th>Created At</th>
                                    <th>Action</th>
                                    <th>Send</th>

                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="n" items="${notifications}">
                                    <tr class="text-center">
                                        <td>${n.notificationId}</td>
                                        <td class="text-start">${n.title}</td>
                                        <td>
                                            <c:if test="${not empty n.imageUrl}">
                                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#previewModal_${n.notificationId}">
                                                    <i class="bi bi-eye"></i> View
                                                </button>
                                            </c:if>
                                        </td>
                                        <td>${n.scheduledTime}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty n.sentTime}">${n.sentTime}</c:when>
                                                <c:otherwise><span class="text-muted">Not Sent</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${n.status eq 'scheduled'}">
                                                    <span class="badge bg-warning text-dark">Scheduled</span>
                                                </c:when>
                                                <c:when test="${n.status eq 'sent'}">
                                                    <span class="badge bg-success">Sent</span>
                                                </c:when>
                                                <c:when test="${n.status eq 'draft'}">
                                                    <span class="badge bg-secondary">Draft</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-dark">${n.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${n.createdAt}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/edit-notification?id=${n.notificationId}" class="btn btn-warning btn-sm">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </a>
                                        </td>
                                       <td>
    <a href="${pageContext.request.contextPath}/send-notification?nId=${n.notificationId}" 
       class="btn btn-primary btn-sm"
       onclick="return confirm('Are you sure you want to send this notification?');">
        <i class="bi bi-send"></i> Send
    </a>
</td>

                                    </tr>

                                    <!-- Modal Preview -->
                                    <div class="modal fade" id="previewModal_${n.notificationId}" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-xl modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Preview Notification Image</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body text-center">
                                                    <img src="${fn:replace(fn:escapeXml(n.imageUrl), ' ', '%20')}"
                                                         class="img-fluid" alt="Preview" style="max-height:600px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-center bg-white">
                        <span class="text-muted">Total: ${fn:length(notifications)} notifications</span>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="mt-3 d-flex justify-content-center">
                    <ul class="pagination">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="notification_list?page=${i}&keyword=${fn:escapeXml(keyword)}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
