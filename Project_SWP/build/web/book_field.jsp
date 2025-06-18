<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .booking-container {
            max-width: 600px;
            background: #fff;
            padding: 2rem;
            margin: 3rem auto;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
        .booking-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #2f3542;
            margin-bottom: 1.5rem;
        }
        label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #34495e;
        }
        .form-control {
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #ff4757;
            border-color: #ff4757;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #ff6b81;
            border-color: #ff6b81;
        }
    </style>
</head>
<body>
<jsp:include page="homehead.jsp" />
<div class="container booking-container">
    <h2 class="booking-title">Đặt sân: ${court.court_number}</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-danger">${message}</div>
    </c:if>

    <form action="book-field" method="post">
        <input type="hidden" name="courtId" value="${court.court_id}" />
        <input type="hidden" name="areaId" value="${court.area_id}" />

        <div class="mb-3">
            <label for="date">Chọn ngày</label>
            <input type="date" name="date" value="${selectedDate}" min="<%= java.time.LocalDate.now() %>" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Chọn ca chơi:</label>
            <div class="d-flex flex-wrap gap-2" id="slotContainer"></div>
            <input type="hidden" name="startTime" id="slotStart" required />
            <input type="hidden" name="endTime" id="slotEnd" required />
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Kiểm tra & Xác nhận</button>
        </div>
    </form>
</div>
<jsp:include page="homefooter.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const slots = ${slots != null ? slots : '[]'};
        const slotContainer = document.getElementById('slotContainer');
        const slotStartInput = document.getElementById('slotStart');
        const slotEndInput = document.getElementById('slotEnd');

        slots.forEach(slot => {
            const button = document.createElement('button');
            button.type = 'button';
            button.className = `btn ${slot.available ? 'btn-success' : 'btn-secondary'} btn-sm m-1`;
            button.textContent = `${slot.start} - ${slot.end}`;
            button.disabled = !slot.available;

            button.addEventListener('click', () => {
                document.querySelectorAll('#slotContainer button').forEach(b => b.classList.remove('active'));
                button.classList.add('active');
                slotStartInput.value = slot.start;
                slotEndInput.value = slot.end;
            });

            slotContainer.appendChild(button);
        });
    });
</script>

</body>
</html>