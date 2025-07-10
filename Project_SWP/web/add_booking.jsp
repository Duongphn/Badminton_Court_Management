<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-9">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="mb-3">Thêm Đặt Lịch</h3>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <form action="add-booking" method="post" class="row g-3">
        <div class="col-md-6">
            <label class="form-label">Khách Hàng</label>
            <select name="userId" class="form-select" required>
                <c:forEach var="c" items="${customers}">
                    <option value="${c.user_Id}">${c.username}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <label class="form-label">Sân</label>
            <c:if test="${not empty courtMessage}">
                <div class="alert alert-info" role="alert">${courtMessage}</div>
            </c:if>
            <select name="courtId" id="courtSelect" class="form-select" required>
                <c:forEach var="co" items="${courts}">
                    <option value="${co.court_id}">${co.court_number}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <label class="form-label">Ngày</label>
            <input type="date" name="date" class="form-control" min="<%= java.time.LocalDate.now().toString() %>" required>
        </div>
        <div class="col-md-6">
            <label class="form-label">Ca chơi</label>
            <c:set var="defaultCourt" value="${not empty courts ? courts[0].court_id : -1}" />
            <select name="shiftId" id="shiftSelect" class="form-select" required>
                <c:forEach var="entry" items="${courtShifts}">
                    <c:set var="cId" value="${entry.key}" />
                    <c:forEach var="sh" items="${entry.value}">
                        <option value="${sh.shiftId}" data-court="${cId}" <c:if test='${cId ne defaultCourt}'>style="display:none"</c:if>>
                            ${sh.shiftName} (${sh.startTime} - ${sh.endTime})
                        </option>
                    </c:forEach>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-12">
            <label class="form-label">Dịch vụ</label>
            <c:forEach var="s" items="${services}">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="selectedServices" value="${s.service_id}" id="service${s.service_id}">
                    <label class="form-check-label" for="service${s.service_id}">${s.name} - ${s.price}</label>
                </div>
            </c:forEach>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Đặt sân</button>
            <a href="manager-booking-schedule" class="btn btn-secondary">Hủy</a>
        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const courtSelect = document.getElementById('courtSelect');
    const shiftSelect = document.getElementById('shiftSelect');
    function updateShifts() {
        const cid = courtSelect.value;
        Array.from(shiftSelect.options).forEach(o => {
            if (o.dataset.court === cid) {
                o.style.display = 'block';
            } else {
                o.style.display = 'none';
            }
        });
        const visible = Array.from(shiftSelect.options).find(o => o.style.display !== 'none');
        if (visible) shiftSelect.value = visible.value;
    }
    courtSelect.addEventListener('change', updateShifts);
    updateShifts();
</script>
</body>
</html>
