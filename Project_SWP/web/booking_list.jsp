<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách đặt sân</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f5f5;
            }
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }
            .title {
                text-align: center;
                margin-top: 2rem;
            }
            .table {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .table th {
                background-color: #ff4757;
                color: white;
            }
            .nav {
                background: white;
                padding: 1rem 0;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                gap: 2rem;
            }

            .nav-item {
                padding: 0.5rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                transition: all 0.3s;
                background: #f8f9fa;
                color: #333;

            }

            .nav-item.active {
                background: #ff4757;
            }

            .nav-item.active a {
                text-decoration: none;
                color: white;
            }

            .nav-item:hover {
                background: #ff6b7a;
                color: white;
            }

            .nav-item a{
                color: black;
                text-decoration: none;
            }

            .star-rating {
                direction: rtl;
                display: inline-flex;
                font-size: 1.5rem;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-rating label {
                color: #ccc;
                cursor: pointer;
            }

            .star-rating input[type="radio"]:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #ffca08;
            }

        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <!-- Main -->
        <main class="main">
            <div class="title">
                <h2>Đơn đặt sân của bạn</h2>
            </div>

            <div class="table-responsive mt-4">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Sân</th>
                            <th>Ngày</th>
                            <th>Thời gian</th>
                            <th>Trạng thái</th>
                            <th>Đánh giá</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>${booking.court_id}</td>
                                <td>${booking.date}</td>
                                <td>${booking.start_time} - ${booking.end_time}</td>
                                <td>
                            <c:choose>
                                <c:when test="${booking.status eq 'confirmed'}">
                                    <span class="badge bg-success">Đã xác nhận</span>
                                </c:when>
                                <c:when test="${booking.status eq 'cancelled'}">
                                    <span class="badge bg-secondary">Đã hủy</span>
                                </c:when>
                                <c:when test="${booking.status eq 'pending'}">
                                    <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-light text-dark">${booking.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.status eq 'completed'}">
                                            <c:choose>
                                                <c:when test="${booking.rating == 0}">
                                                    <button type="button" class="btn btn-primary btn-sm open-rating-modal"
                                                            data-bs-toggle="modal" data-bs-target="#ratingModal"
                                                            data-booking="${booking.booking_id}"
                                                            data-court="${booking.court_id}"
                                                            data-date="${booking.date}"
                                                            data-time="${booking.start_time} - ${booking.end_time}">
                                                        Đánh giá
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    ${booking.rating}★
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${booking.rating}★"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${booking.status eq 'confirmed'}">
                                        <form action="cancel_booking" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy?');">
                                            <input type="hidden" name="bookingId" value="${booking.booking_id}">
                                            <button type="submit" class="btn btn-danger btn-sm">Hủy</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${not empty sessionScope.cancelMessage}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        ${sessionScope.cancelMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="cancelMessage" scope="session"/>
                </c:if>
            </div>
            <!-- Rating Modal -->
            <div class="modal fade" id="ratingModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <form class="modal-content" action="submit-rating" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Đánh giá sân</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p id="courtInfo" class="fw-bold mb-1"></p>
                            <p id="dateInfo" class="mb-3"></p>
                            <input type="hidden" name="bookingId" id="bookingIdInput" />
                            <div class="star-rating mb-3">
                                <input type="radio" id="star5" name="rating" value="5"/><label for="star5">★</label>
                                <input type="radio" id="star4" name="rating" value="4"/><label for="star4">★</label>
                                <input type="radio" id="star3" name="rating" value="3"/><label for="star3">★</label>
                                <input type="radio" id="star2" name="rating" value="2"/><label for="star2">★</label>
                                <input type="radio" id="star1" name="rating" value="1"/><label for="star1">★</label>
                            </div>
                            <textarea name="comment" class="form-control" placeholder="Nhận xét của bạn"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                        </div>
                    </form>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                var ratingModal = document.getElementById('ratingModal');
                ratingModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    document.getElementById('courtInfo').textContent = 'Sân: ' + button.getAttribute('data-court');
                    document.getElementById('dateInfo').textContent = 'Ngày: ' + button.getAttribute('data-date') + ' (' + button.getAttribute('data-time') + ')';
                    document.getElementById('bookingIdInput').value = button.getAttribute('data-booking');
                });
            </script>
        </main>

        <jsp:include page="homefooter.jsp" />

    </body>
</html>
