<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Schedule</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .booking-block { padding:2px; margin-bottom:2px; color:white; border-radius:4px; font-size:0.8rem; }
        .booking-confirmed { background-color:#28a745; }
        .booking-pending { background-color:#fd7e14; }
        .booking-cancelled { background-color:#dc3545; }
    </style>
</head>
<body>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="Sidebar.jsp" />
        </div>
        <div class="col-md-10">
            <h3 class="mb-3">Booking Schedule</h3>
            <form class="row g-2 mb-3" method="get" action="manager-booking-schedule">
                <div class="col-auto">
                    <select name="areaId" class="form-select">
                        <option value="">All Areas</option>
                        <c:forEach var="a" items="${areas}">
                            <option value="${a.area_id}" ${param.areaId == a.area_id ? 'selected' : ''}>${a.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-auto">
                    <input type="date" name="start" class="form-control" value="${start}">
                </div>
                <div class="col-auto">
                    <select name="status" class="form-select">
                        <option value="">All Status</option>
                        <option value="confirmed" ${param.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary">Filter</button>
                </div>
            </form>
            <table class="table table-bordered text-center">
                <thead class="table-light">
                    <tr>
                        <th>Time</th>
                        <c:forEach var="d" items="${weekDays}">
                            <th>${d}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                <c:forEach begin="6" end="15" var="h">
                    <tr>
                        <th>${h}:00</th>
                        <c:forEach var="d" items="${weekDays}">
                            <td>
                                <c:forEach var="b" items="${schedule[d.toString()][h]}">
                                    <div class="booking-block booking-${b.status}">
                                        ${b.customerName} - ${b.status}
                                    </div>
                                </c:forEach>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
