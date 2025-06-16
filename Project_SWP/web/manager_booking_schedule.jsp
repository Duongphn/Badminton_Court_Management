<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Schedule</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="notification-wrapper" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">
    <jsp:include page="notification.jsp"/>
</div>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-9">
            <h3 class="mb-3">Booking Schedule</h3>
            <div class="d-flex justify-content-between mb-3">
                <form class="row g-2" method="get" action="manager-booking-schedule">
                    <div class="col-auto">
                        <select name="areaId" class="form-select">
                            <option value="">All Areas</option>
                            <c:forEach var="a" items="${areas}">
                                <option value="${a.area_id}" <c:if test="${areaId == a.area_id}">selected</c:if>>${a.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
                        <input type="date" name="startDate" value="${startDate}" class="form-control" />
                    </div>
                    <div class="col-auto">
                        <input type="date" name="endDate" value="${endDate}" class="form-control" />
                    </div>
                    <div class="col-auto">
                        <select name="status" class="form-select">
                            <option value="">All Status</option>
                            <option value="pending" <c:if test="${status eq 'pending'}">selected</c:if>>Pending</option>
                            <option value="confirmed" <c:if test="${status eq 'confirmed'}">selected</c:if>>Confirmed</option>
                            <option value="cancelled" <c:if test="${status eq 'cancelled'}">selected</c:if>>Cancelled</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </div>
                </form>
                <a href="add-booking" class="btn btn-success">Add Booking</a>
            </div>
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mb-0">
                            <thead class="table-light text-center">
                            <tr>
                                <th>ID</th>
                                <th>Court</th>
                                <th>Area</th>
                                <th>Customer</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="b" items="${bookings}">
                                <tr class="text-center">
                                    <td>${b.booking_id}</td>
                                    <td>${b.courtNumber}</td>
                                    <td>${b.areaName}</td>
                                    <td>${b.customerName}</td>
                                    <td>${b.date}</td>
                                    <td>${b.start_time} - ${b.end_time}</td>
                                    <td>${b.status}</td>
                                    <td>
                                        <c:if test="${b.status eq 'pending'}">
                                            <form action="confirm-booking-manager" method="post" style="display:inline-block">
                                                <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                <input type="hidden" name="action" value="confirm" />
                                                <button type="submit" class="btn btn-success btn-sm">Confirm</button>
                                            </form>
                                            <form action="confirm-booking-manager" method="post" style="display:inline-block;margin-left:5px;">
                                                <input type="hidden" name="bookingId" value="${b.booking_id}" />
                                                <input type="hidden" name="action" value="cancel" />
                                                <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
                                            </form>
                                        </c:if>
                                        <a href="update-booking?bookingId=${b.booking_id}" class="btn btn-primary btn-sm" style="margin-left:5px;">Edit</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
