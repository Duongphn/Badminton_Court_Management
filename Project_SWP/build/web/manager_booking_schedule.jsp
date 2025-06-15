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
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-9">
            <h3 class="mb-3">Booking Schedule</h3>
            <table class="table table-bordered">
                <thead>
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
                    <tr>
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
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
