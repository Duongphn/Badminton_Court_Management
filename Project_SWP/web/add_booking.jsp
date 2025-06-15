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
<div class="container mt-4">
    <h3 class="mb-3">Add Booking</h3>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form action="add-booking" method="post" class="row g-3">
        <div class="col-md-6">
            <label class="form-label">Customer</label>
            <select name="userId" class="form-select" required>
                <c:forEach var="c" items="${customers}">
                    <option value="${c.user_Id}">${c.username}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <label class="form-label">Court</label>
            <select name="courtId" class="form-select" required>
                <c:forEach var="co" items="${courts}">
                    <option value="${co.court_id}">${co.court_number}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <label class="form-label">Date</label>
            <input type="date" name="date" class="form-control" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Start Time</label>
            <input type="time" name="startTime" class="form-control" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">End Time</label>
            <input type="time" name="endTime" class="form-control" required>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="manager-booking-schedule" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
