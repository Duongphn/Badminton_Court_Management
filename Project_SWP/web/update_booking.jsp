<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3 class="mb-3">Update Booking</h3>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form action="update-booking" method="post" class="row g-3">
        <input type="hidden" name="bookingId" value="${booking.booking_id}" />
        <div class="col-md-6">
            <label class="form-label">Court</label>
            <input type="text" class="form-control" value="${court.court_number}" disabled>
        </div>
        <div class="col-md-6">
            <label class="form-label">Customer</label>
            <input type="text" class="form-control" value="${customer.username}" disabled>
        </div>
        <div class="col-md-4">
            <label class="form-label">Date</label>
            <input type="date" name="date" class="form-control" value="${booking.date}" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Start Time</label>
            <input type="time" name="startTime" class="form-control" value="${booking.start_time}" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">End Time</label>
            <input type="time" name="endTime" class="form-control" value="${booking.end_time}" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Status</label>
            <select name="status" class="form-select">
                <option value="pending" <c:if test="${booking.status eq 'pending'}">selected</c:if>>Pending</option>
                <option value="confirmed" <c:if test="${booking.status eq 'confirmed'}">selected</c:if>>Confirmed</option>
                <option value="cancelled" <c:if test="${booking.status eq 'cancelled'}">selected</c:if>>Cancelled</option>
            </select>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="manager-booking-schedule" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
