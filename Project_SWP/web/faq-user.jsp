<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hỏi đáp thường gặp | BadmintonCourt</title>
        <style>
            .main {
                max-width: 100%;
                margin: 2rem auto;
                padding: 0 2rem;
            }
            .faq-container {
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.11);
                padding: 32px 28px;
            }
            .faq-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }
            .faq-header h4 {
                margin: 0;
                color: #222;
                font-weight: bold;
                font-size: 1.3rem;
            }
            /* ======= TABLE BOOTSTRAP CUSTOM ======= */
            .table {
                border-radius: 14px;
                overflow: hidden;
                box-shadow: 0 2px 16px rgba(0,0,0,0.05);
                background: #fff;
            }
            .table thead {
                background: #f8f9fa;
                color: #333;
                font-weight: bold;
            }
            .table th, .table td {
                vertical-align: middle;
                font-size: 1rem;
                border-color: #ececec;
            }
            .table th {
                background: #fafafa;
                border-bottom: 2px solid #eee;
                font-weight: bold;
            }
            .table-hover tbody tr:hover {
                background: #ffeaea;
                transition: background 0.18s;
            }
            /* ======= BADGE/ TAG ======= */
            .badge.bg-info {
                background: #ff4757 !important;
                color: #fff !important;
                padding: 4px 14px;
                border-radius: 7px;
                font-size: 0.97rem;
                font-weight: 500;
            }
            /* ======= BUTTON FIX ======= */
            .btn {
                font-size: 0.97rem;
                border-radius: 7px;
            }
            /* ======= CARD (BOX) ======= */
            .card.shadow-sm {
                border-radius: 14px;
                box-shadow: 0 3px 20px rgba(0,0,0,0.08);
                border: none;
                margin-top: 20px;
            }
            .card-footer.bg-white {
                border-radius: 0 0 14px 14px;
                background: #fafafa !important;
            }
            /* ======= PAGINATION ======= */
            .pagination .page-item .page-link {
                border-radius: 7px !important;
                color: #ff4757;
                font-weight: 500;
                border: none;
                margin: 0 2px;
                transition: background .18s;
            }
            .pagination .active .page-link,
            .pagination .page-link.active {
                background: #ff4757;
                color: #fff !important;
                pointer-events: none;
            }
            .pagination .page-link:hover {
                background: #ffb3b3;
                color: #fff;
            }
            @media (max-width: 768px) {
                .main {
                    margin: 15px 0;
                    padding: 0 5px;
                }
                .faq-container {
                    padding: 15px 4px;
                    border-radius: 8px;
                }
                .table th, .table td {
                    font-size: 0.98rem;
                    padding: 8px 7px;
                }
            }
        </style>

    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <main class="main">
            <div class="faq-container">
                <div class="faq-header">
                    <h4><i class="fas fa-question-circle" style="color:#ff4757;"></i> Câu hỏi thường gặp</h4>
                </div>

                <c:choose>
                    <c:when test="${empty faqList}">
                        <div class="no-faq">
                            <i class="fas fa-inbox fa-2x mb-2"></i>
                            <p>Không có câu hỏi phù hợp.</p>
                        </div>
                    </c:when>
                    <c:otherwise>


                        <div class="card shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover mb-0 align-middle text-center">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Tiêu đề</th>
                                                <th>Tag</th>
                                                <th>Ngày tạo</th>
                                                <th>Ngày cập nhật</th>
                                                <th>Thao tác</th>
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
                                                        <a href="faq-answer?id=${q.questionId}" class="btn btn-outline-primary">
                                                            <i class="fas fa-comment-dots"></i>Xem câu trả lời
                                                        </a>
                                                       
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Phân trang -->
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
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    </body>
</html>
