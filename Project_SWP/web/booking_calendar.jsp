<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css' rel='stylesheet' />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --shadow: 0 4px 20px rgba(0,0,0,0.1);
            --shadow-hover: 0 8px 30px rgba(0,0,0,0.15);
            --border-radius: 12px;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin: 2rem auto;
            padding: 2rem;
            max-width: 1200px;
            transition: all 0.3s ease;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            font-weight: 400;
        }

        /* Calendar Styling */
        #calendar {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            transition: all 0.3s ease;
        }

        #calendar:hover {
            box-shadow: var(--shadow-hover);
        }

        .fc-header-toolbar {
            margin-bottom: 1.5rem !important;
        }

        .fc-button-primary {
            background: linear-gradient(135deg, var(--secondary-color), #5dade2) !important;
            border: none !important;
            border-radius: 8px !important;
            padding: 0.5rem 1rem !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
        }

        .fc-button-primary:hover {
            background: linear-gradient(135deg, #2980b9, var(--secondary-color)) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3) !important;
        }

        .fc-button-primary:not(:disabled).fc-button-active {
            background: linear-gradient(135deg, var(--primary-color), #34495e) !important;
        }

        .fc-event {
            border: none !important;
            border-radius: 6px !important;
            font-weight: 500 !important;
            transition: all 0.3s ease !important;
            cursor: pointer !important;
        }

        .fc-event:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2) !important;
        }

        .fc-daygrid-event {
            margin: 2px !important;
        }

        /* Custom Popup Styling */
        .booking-popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0);
            width: 450px;
            max-width: 90vw;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            z-index: 9999;
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            opacity: 0;
        }

        .booking-popup.show {
            transform: translate(-50%, -50%) scale(1);
            opacity: 1;
        }

        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(5px);
            z-index: 9998;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .popup-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .popup-header {
            background: linear-gradient(135deg, var(--secondary-color), #5dade2);
            color: white;
            padding: 1.5rem;
            border-radius: 20px 20px 0 0;
            position: relative;
            text-align: center;
        }

        .popup-title {
            margin: 0;
            font-size: 1.4rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .popup-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .popup-close:hover {
            background: rgba(255,255,255,0.3);
            transform: rotate(90deg);
        }

        .popup-body {
            padding: 2rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 12px;
            border-left: 4px solid var(--secondary-color);
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }

        .detail-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--secondary-color), #5dade2);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.1rem;
        }

        .detail-content h6 {
            margin: 0;
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-content p {
            margin: 0;
            color: #495057;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .status-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-confirmed {
            background: linear-gradient(135deg, var(--success-color), #2ecc71);
            color: white;
        }

        .status-pending {
            background: linear-gradient(135deg, var(--warning-color), #f1c40f);
            color: white;
        }

        .status-cancelled {
            background: linear-gradient(135deg, var(--accent-color), #e67e22);
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .booking-popup {
                width: 95vw;
            }

            .popup-body {
                padding: 1.5rem;
            }
        }

        /* Animation Classes */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>

<jsp:include page="homehead.jsp" />

<div class="container">
    <div class="main-container fade-in-up">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-calendar-alt"></i>
                Lịch đặt sân của bạn
            </h1>
            <p class="page-subtitle">Quản lý và theo dõi các lịch đặt sân của bạn</p>
        </div>
        
        <div id='calendar'></div>
    </div>
</div>

<!-- Custom Popup -->
<div class="popup-overlay" id="popupOverlay"></div>
<div class="booking-popup" id="bookingPopup">
    <div class="popup-header">
        <h5 class="popup-title">
            <i class="fas fa-info-circle"></i>
            Chi tiết đặt sân
        </h5>
        <button class="popup-close" id="popupClose">
            <i class="fas fa-times"></i>
        </button>
    </div>
    <div class="popup-body">
        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-futbol"></i>
            </div>
            <div class="detail-content">
                <h6>Sân</h6>
                <p id="detailCourt"></p>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-calendar"></i>
            </div>
            <div class="detail-content">
                <h6>Ngày</h6>
                <p id="detailDate"></p>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="detail-content">
                <h6>Thời gian</h6>
                <p id="detailTime"></p>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-flag"></i>
            </div>
            <div class="detail-content">
                <h6>Trạng thái</h6>
                <p><span class="status-badge" id="detailStatus"></span></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="homefooter.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var popup = document.getElementById('bookingPopup');
        var overlay = document.getElementById('popupOverlay');
        var closeBtn = document.getElementById('popupClose');
        
        var detailCourt = document.getElementById('detailCourt');
        var detailDate = document.getElementById('detailDate');
        var detailTime = document.getElementById('detailTime');
        var detailStatus = document.getElementById('detailStatus');

        // Function to show popup
        function showPopup() {
            overlay.classList.add('show');
            popup.classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        // Function to hide popup
        function hidePopup() {
            overlay.classList.remove('show');
            popup.classList.remove('show');
            document.body.style.overflow = 'auto';
        }

        // Event listeners for closing popup
        closeBtn.addEventListener('click', hidePopup);
        overlay.addEventListener('click', hidePopup);

        // Close popup with Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                hidePopup();
            }
        });

        // Function to get status class
        function getStatusClass(status) {
            switch(status.toLowerCase()) {
                case 'confirmed':
                case 'đã xác nhận':
                    return 'status-confirmed';
                case 'pending':
                case 'chờ xác nhận':
                    return 'status-pending';
                case 'cancelled':
                case 'đã hủy':
                    return 'status-cancelled';
                default:
                    return 'status-pending';
            }
        }

        // Function to format date
        function formatDate(dateStr) {
            const date = new Date(dateStr);
            return date.toLocaleDateString('vi-VN', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'vi',
            headerToolbar: { 
                left: 'prev,next today', 
                center: 'title', 
                right: 'dayGridMonth,timeGridWeek' 
            },
            height: 'auto',
            eventClick: function(info) {
                var ev = info.event;
                
                // Populate popup with data
                detailCourt.textContent = 'Sân số ' + ev.extendedProps.courtId;
                detailDate.textContent = formatDate(ev.startStr);
                detailTime.textContent = ev.startStr.substring(11,16) + ' - ' + ev.endStr.substring(11,16);
                
                // Set status with appropriate styling
                detailStatus.textContent = ev.extendedProps.status;
                detailStatus.className = 'status-badge ' + getStatusClass(ev.extendedProps.status);
                
                // Show popup
                showPopup();
            },
            eventSources: [
                [
                    <c:forEach var="b" items="${bookings}" varStatus="loop">
                    {
                        id: '${b.booking_id}',
                        title: 'Sân ${b.court_id}',
                        start: '${b.date}T${fn:substring(b.start_time,0,5)}',
                        end: '${b.date}T${fn:substring(b.end_time,0,5)}',
                        backgroundColor: '${b.status == "confirmed" || b.status == "đã xác nhận" ? "#27ae60" : (b.status == "pending" || b.status == "chờ xác nhận" ? "#f39c12" : "#e74c3c")}',
                        borderColor: '${b.status == "confirmed" || b.status == "đã xác nhận" ? "#27ae60" : (b.status == "pending" || b.status == "chờ xác nhận" ? "#f39c12" : "#e74c3c")}',
                        extendedProps: { 
                            courtId: '${b.court_id}', 
                            status: '${b.status}' 
                        }
                    }<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ]
            ]
        });

        calendar.render();

        // Add loading effect
        setTimeout(function() {
            calendarEl.style.opacity = '1';
        }, 100);
    });
</script>

</body>
</html>