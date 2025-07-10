<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --dark-bg: #343a40;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --shadow-soft: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 8px 15px rgba(0, 0, 0, 0.1);
            --shadow-hard: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: var(--gradient-primary) !important;
            box-shadow: var(--shadow-medium);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
        }

        .nav-link {
            font-weight: 500;
            transition: all 0.3s ease;
            border-radius: 20px;
            padding: 8px 16px !important;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: var(--shadow-hard);
            margin-top: 2rem;
            overflow: hidden;
        }

        .page-header {
            background: var(--gradient-secondary);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>');
            background-size: 50px 50px;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { transform: translateX(0px) translateY(0px); }
            100% { transform: translateX(-50px) translateY(-50px); }
        }

        .page-header h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .page-header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-top: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .form-container {
            padding: 3rem;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-floating > .form-control,
        .form-floating > .form-select {
            height: 3.5rem;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-floating > .form-control:focus,
        .form-floating > .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }

        .form-floating > label {
            color: #6c757d;
            font-weight: 500;
        }

        .service-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-soft);
        }

        .service-section h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .service-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .service-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
            border-color: var(--secondary-color);
        }

        .service-card.selected {
            border-color: var(--success-color);
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        }

        .form-check-input {
            width: 1.5rem;
            height: 1.5rem;
            border-radius: 6px;
            border: 2px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .form-check-input:checked {
            background-color: var(--success-color);
            border-color: var(--success-color);
        }

        .form-check-label {
            font-weight: 500;
            margin-left: 0.5rem;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-medium);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hard);
            background: var(--gradient-secondary);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-medium);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hard);
            background: #5a6268;
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
        }

        .alert-info {
            background: linear-gradient(135deg, #d1ecf1 0%, #b3d4fc 100%);
            color: #0c5460;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #e9ecef;
        }

        .icon-input {
            position: relative;
        }

        .icon-input i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 3;
        }

        .icon-input .form-control,
        .icon-input .form-select {
            padding-left: 45px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 2rem 1rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .page-header h3 {
                font-size: 2rem;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .button-group {
                flex-direction: column;
                align-items: stretch;
            }
        }

        /* Loading Animation */
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid var(--secondary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-user-tie me-2"></i>Manager
            </a>
            <div class="d-flex">
                <a class="nav-link text-light" href="login">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3">
                <jsp:include page="Sidebar.jsp" />
            </div>
            <div class="col-md-9">
                <div class="main-container">
                    <!-- Page Header -->
                    <div class="page-header">
                        <h3><i class="fas fa-calendar-plus me-3"></i>Thêm Đặt Lịch</h3>
                        <p class="subtitle">Tạo lịch đặt sân mới cho khách hàng</p>
                    </div>

                    <!-- Form Container -->
                    <div class="form-container">
                        <!-- Error Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                            </div>
                        </c:if>

                        <c:if test="${not empty courtMessage}">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>${courtMessage}
                            </div>
                        </c:if>

                        <form action="add-booking" method="post" id="bookingForm">
                            <!-- Customer and Court Information -->
                            <div class="form-row">
                                <div class="form-floating icon-input">
                                    <i class="fas fa-user"></i>
                                    <input type="text" name="username" class="form-control" id="username" placeholder="Tên khách hàng" required>
                                    <label for="username">Tên khách hàng</label>
                                </div>
                                <div class="form-floating icon-input">
                                    <i class="fas fa-basketball-ball"></i>
                                    <select name="courtId" id="courtSelect" class="form-select" required>
                                        <c:forEach var="co" items="${courts}">
                                            <option value="${co.court_id}">Sân ${co.court_number}</option>
                                        </c:forEach>
                                    </select>
                                    <label for="courtSelect">Sân</label>
                                </div>
                            </div>

                            <!-- Date and Shift Information -->
                            <div class="form-row">
                                <div class="form-floating icon-input">
                                    <i class="fas fa-calendar-day"></i>
                                    <input type="date" name="date" class="form-control" id="date" min="<%= java.time.LocalDate.now().toString() %>" required>
                                    <label for="date">Ngày</label>
                                </div>
                                <div class="form-floating icon-input">
                                    <i class="fas fa-clock"></i>
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
                                    <label for="shiftSelect">Ca chơi</label>
                                </div>
                            </div>

                            <!-- Services Section -->
                            <div class="service-section">
                                <h5>
                                    <i class="fas fa-concierge-bell"></i>
                                    Dịch vụ
                                </h5>
                                <div class="row">
                                    <c:forEach var="s" items="${services}">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="service-card" onclick="toggleService(this, 'service${s.service_id}')">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="selectedServices" value="${s.service_id}" id="service${s.service_id}">
                                                    <label class="form-check-label" for="service${s.service_id}">
                                                        <strong>${s.name}</strong>
                                                        <br>
                                                        <span class="text-muted">${s.price}</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Submit Buttons -->
                            <div class="button-group">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-check me-2"></i>Đặt sân
                                </button>
                                <a href="manager-booking-schedule" class="btn btn-secondary btn-lg">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const courtSelect = document.getElementById('courtSelect');
        const shiftSelect = document.getElementById('shiftSelect');
        const form = document.getElementById('bookingForm');

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

        function toggleService(card, checkboxId) {
            const checkbox = document.getElementById(checkboxId);
            checkbox.checked = !checkbox.checked;
            
            if (checkbox.checked) {
                card.classList.add('selected');
            } else {
                card.classList.remove('selected');
            }
        }

        // Add loading animation on form submit
        form.addEventListener('submit', function(e) {
            const submitBtn = form.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
            submitBtn.disabled = true;
            form.classList.add('loading');
        });

        // Initialize
        courtSelect.addEventListener('change', updateShifts);
        updateShifts();

        // Add smooth scroll to errors
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.scrollIntoView({ behavior: 'smooth', block: 'center' });
            });
        });

        // Add form validation feedback
        const inputs = document.querySelectorAll('input[required], select[required]');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim() === '') {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        });
    </script>
</body>
</html>