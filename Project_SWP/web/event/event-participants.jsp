<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách người tham gia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
           
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin: 2rem auto;
            max-width: 1200px;
        }
        
        .card-header {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border-radius: 20px 20px 0 0;
            padding: 2rem;
            border: none;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: rotate(45deg);
        }
        
        .card-header h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            position: relative;
            z-index: 1;
        }
        
        .card-header i {
            margin-right: 15px;
            font-size: 2rem;
            color: #fecaca;
        }
        
        .card-body {
            padding: 2.5rem;
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(220, 38, 38, 0.1);
            overflow: hidden;
            border: 2px solid #fecaca;
        }
        
        .table {
            margin: 0;
        }
        
        .table thead th {
            background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%);
            color: #7f1d1d;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1.2rem;
            border: none;
            font-size: 0.9rem;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.1);
        }
        
        .table tbody td {
            padding: 1.2rem;
            vertical-align: middle;
            border-color: #fecaca;
            font-weight: 500;
            color: #374151;
        }
        
        .table tbody td:first-child {
            font-weight: 700;
            color: #dc2626;
            font-size: 1.1rem;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
            font-style: italic;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #fca5a5;
            margin-bottom: 1rem;
            display: block;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.3);
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(220, 38, 38, 0.4);
            color: white;
        }
        
        .btn-back i {
            font-size: 1.1rem;
        }
        
        .stats-badge {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 1rem;
            box-shadow: 0 3px 10px rgba(220, 38, 38, 0.3);
        }
        
        .event-name {
            
            font-weight: 700;
            text-decoration: none;
        }
        
        .participant-count {
            float: right;
            background: rgba(220, 38, 38, 0.1);
            color: #dc2626;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .card-header {
                padding: 1.5rem;
            }
            
            .card-header h3 {
                font-size: 1.4rem;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .table-responsive {
                border-radius: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid py-4">
    <div class="main-container">
        <div class="card shadow-lg border-0">
            <div class="card-header">
                <h3>
                    <i class="fas fa-users"></i> 
                    Người tham gia sự kiện: <span class="event-name">${event.name}</span>
                    <span class="participant-count">
                        <i class="fas fa-user-check"></i> ${participants.size()} người
                    </span>
                </h3>
            </div>
            <div class="card-body">
                <div class="stats-badge">
                    <i class="fas fa-chart-line"></i> 
                    Tổng số người đăng ký: ${participants.size()}
                </div>
                
                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-id-card"></i> ID Người dùng</th>
                                    <th><i class="fas fa-user"></i> Tên người dùng</th>
                                    <th><i class="fas fa-clock"></i> Thời gian đăng ký</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${participants}" varStatus="status">
                                    <tr>
                                        <td>
                                            <i class="fas fa-hashtag"></i> ${p.user.user_Id}
                                        </td>
                                        <td>
                                            <i class="fas fa-user-circle text-danger"></i> 
                                            ${p.user.fullname}
                                        </td>
                                        <td>
                                            <i class="fas fa-calendar-alt text-danger"></i> 
                                            <fmt:formatDate value="${p.registeredAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty participants}">
                                    <tr>
                                        <td colspan="3" class="empty-state">
                                            <i class="fas fa-users-slash"></i>
                                            <div>Chưa có ai đăng ký tham gia sự kiện này.</div>
                                            <small class="text-muted">Hãy chia sẻ sự kiện để có thêm người tham gia!</small>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="mt-4 d-flex justify-content-between align-items-center">
                    <a href="manage-event" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                    
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-danger" onclick="window.print()">
                            <i class="fas fa-print"></i> In danh sách
                        </button>
                        <button class="btn btn-outline-danger" onclick="exportToCSV()">
                            <i class="fas fa-file-csv"></i> Xuất CSV
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function exportToCSV() {
        const table = document.querySelector('.table');
        const rows = Array.from(table.querySelectorAll('tr'));
        
        const csvContent = rows.map(row => {
            const cols = Array.from(row.querySelectorAll('th, td'));
            return cols.map(col => col.textContent.trim()).join(',');
        }).join('\n');
        
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', 'danh_sach_nguoi_tham_gia.csv');
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
    
    // Hiệu ứng fade in khi load trang
    document.addEventListener('DOMContentLoaded', function() {
        const mainContainer = document.querySelector('.main-container');
        mainContainer.style.opacity = '0';
        mainContainer.style.transform = 'translateY(30px)';
        
        setTimeout(() => {
            mainContainer.style.transition = 'all 0.6s ease';
            mainContainer.style.opacity = '1';
            mainContainer.style.transform = 'translateY(0)';
        }, 100);
    });
</script>
</body>
</html>