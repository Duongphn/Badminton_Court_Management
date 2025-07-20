<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân</title>
   <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>
<body>

<jsp:include page="homehead.jsp" />
<div class="container mt-4">
    <h2 class="mb-3">Lịch đặt sân của bạn</h2>
    <div id='calendar'></div>

    <!-- Booking Detail Modal -->
    <div class="modal fade" id="bookingDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết đặt sân</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Sân</label>
                        <input type="text" class="form-control" id="detailCourt" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày</label>
                        <input type="text" class="form-control" id="detailDate" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thời gian</label>
                        <input type="text" class="form-control" id="detailTime" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <input type="text" class="form-control" id="detailStatus" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="homefooter.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.js'></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var detailModal = new bootstrap.Modal(document.getElementById('bookingDetailModal'));
        var detailCourt = document.getElementById('detailCourt');
        var detailDate = document.getElementById('detailDate');
        var detailTime = document.getElementById('detailTime');
        var detailStatus = document.getElementById('detailStatus');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek' },
            eventClick: function(info) {
                var ev = info.event;
                detailCourt.value = ev.extendedProps.courtId;
                detailDate.value = ev.startStr.substring(0,10);
                detailTime.value = ev.startStr.substring(11,16) + ' - ' + ev.endStr.substring(11,16);
                detailStatus.value = ev.extendedProps.status;
                detailModal.show();
            },
            eventSources: [
                [
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
            ]
        });
        calendar.render();
    });
</script>
</body>
</html>
