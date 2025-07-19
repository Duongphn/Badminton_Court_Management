<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        #calendar {
            max-width: 900px;
            margin: 40px auto;
        }
    </style>
</head>
<body>
<jsp:include page="homehead.jsp" />
<div class="container mt-4">
    <h2 class="mb-3">Lịch đặt sân của bạn</h2>
    <form class="row g-3" method="get" action="booking-calendar">
        <div class="col-md-3">
            <label class="form-label">Từ ngày</label>
            <input type="date" class="form-control" name="fromDate" value="${fromDate}">
        </div>
        <div class="col-md-3">
            <label class="form-label">Đến ngày</label>
            <input type="date" class="form-control" name="toDate" value="${toDate}">
        </div>
        <div class="col-md-3">
            <label class="form-label">Trạng thái</label>
            <select class="form-select" name="status">
                <option value="" ${empty status ? 'selected' : ''}>Tất cả</option>
                <option value="pending" ${status=='pending'? 'selected':''}>Chờ xử lý</option>
                <option value="confirmed" ${status=='confirmed'? 'selected':''}>Đã xác nhận</option>
                <option value="cancelled" ${status=='cancelled'? 'selected':''}>Đã hủy</option>
                <option value="completed" ${status=='completed'? 'selected':''}>Hoàn thành</option>
            </select>
        </div>
        <div class="col-md-3 align-self-end">
            <button type="submit" class="btn btn-primary w-100">Lọc</button>
        </div>
    </form>
    <div id='calendar'></div>

    <!-- Booking Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="bookingForm" action="calendar-booking" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Đặt sân</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="bookingId" id="bookingId">
                        <div class="mb-3">
                            <label class="form-label">Ngày</label>
                            <input type="date" class="form-control" name="date" id="bookingDate" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Bắt đầu</label>
                            <input type="time" class="form-control" name="startTime" id="startTime" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Kết thúc</label>
                            <input type="time" class="form-control" name="endTime" id="endTime" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Sân</label>
                            <select class="form-select" name="courtId" id="courtId" required>
                                <c:forEach var="c" items="${courts}">
                                    <option value="${c.court_id}">Sân ${c.court_number}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Người đặt</label>
                            <input type="text" class="form-control" name="username" value="${sessionScope.user.username}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="status" id="status">
                                <option value="pending">Chờ xử lý</option>
                                <option value="confirmed">Đã xác nhận</option>
                                <option value="cancelled">Đã hủy</option>
                                <option value="completed">Hoàn thành</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="homefooter.jsp" />
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var bookingModal = new bootstrap.Modal(document.getElementById('bookingModal'));
        var bookingForm = document.getElementById('bookingForm');
        var bookingIdField = document.getElementById('bookingId');
        var bookingDate = document.getElementById('bookingDate');
        var startTime = document.getElementById('startTime');
        var endTime = document.getElementById('endTime');
        var courtId = document.getElementById('courtId');
        var statusSelect = document.getElementById('status');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek' },
            dateClick: function(info) {
                bookingForm.reset();
                bookingIdField.value = '';
                bookingDate.value = info.dateStr;
                bookingModal.show();
            },
            eventClick: function(info) {
                var ev = info.event;
                bookingForm.reset();
                bookingIdField.value = ev.id;
                bookingDate.value = ev.startStr.substring(0,10);
                startTime.value = ev.startStr.substring(11,16);
                endTime.value = ev.endStr.substring(11,16);
                courtId.value = ev.extendedProps.courtId;
                statusSelect.value = ev.extendedProps.status;
                bookingModal.show();
            },
            events: [
                <c:forEach var="b" items="${bookings}" varStatus="loop">
                {
                    id: '${b.booking_id}',
                    title: 'Sân ${b.court_id} - ${b.status}',
                    start: '${b.date}T${fn:substring(b.start_time,0,5)}',
                    end: '${b.date}T${fn:substring(b.end_time,0,5)}',
                    extendedProps: { courtId: ${b.court_id}, status: '${b.status}' }
                }<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ]
        });
        calendar.render();
    });
</script>
</body>
</html>
