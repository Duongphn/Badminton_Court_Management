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


                        <div class="container mt-4 mb-5">
                            <a href="faq-list" class="btn btn-link mb-3"><i class="fas fa-arrow-left"></i> Quay lại danh sách câu hỏi</a>
                            <div class="card shadow">
                                <div class="card-header bg-danger text-white">
                                    <i class="fas fa-question-circle"></i> <b>${question.title}</b>
                                </div>
                                <div class="card-body">
                                    <p class="mb-2"><b>Tag:</b> <span class="badge bg-info">${question.tag.name}</span></p>
                                    <h6 class="mb-3">Danh sách câu trả lời:</h6>
                                    <c:choose>
                                        <c:when test="${empty answerList}">
                                            <div class="alert alert-info mb-0">Chưa có câu trả lời nào cho câu hỏi này.</div>
                                        </c:when>
                                        <c:otherwise>
                                            <ul class="list-group">
                                                <c:forEach var="ans" items="${answerList}">
                                                    <li class="list-group-item">
                                                        <div><i class="fas fa-comment-dots text-danger"></i> ${ans.content}</div>
                                                        <div class="small text-muted text-end">
                                                   ${ans.createdAt}
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:otherwise>
                                    </c:choose>
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
