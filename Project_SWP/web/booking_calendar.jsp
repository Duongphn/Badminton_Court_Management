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
</div>
<jsp:include page="homefooter.jsp" />
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek' },
            events: [
                <c:forEach var="b" items="${bookings}" varStatus="loop">
                {
                    title: 'Sân ${b.court_id} - ${b.status}',
                    start: '${b.date}T${fn:substring(b.start_time,0,5)}',
                    end: '${b.date}T${fn:substring(b.end_time,0,5)}'
                }<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ]
        });
        calendar.render();
    });
</script>
</body>
</html>
