<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận tham gia sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .confirm-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
        }
        .confirm-header {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .confirm-body {
            padding: 40px;
        }
        .event-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }
        .btn-confirm {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }
        .btn-cancel {
            background: #6c757d;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="confirm-card">
        <div class="confirm-header">
            <h1><i class="fas fa-calendar-check"></i> Xác nhận tham gia sự kiện</h1>
            <p class="mb-0">Bạn có chắc chắn muốn tham gia sự kiện này không?</p>
        </div>
        
        <div class="confirm-body">
            <div class="text-center mb-4">
                <h4>Xin chào, <span class="text-primary">${user.fullname}</span>!</h4>
                <p class="text-muted">Bạn đã được mời tham gia sự kiện sau:</p>
            </div>
            
            <div class="event-info">
                <h5 class="text-center mb-3">
                    <i class="fas fa-star text-warning"></i> 
                    ${event.name}
                </h5>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <strong><i class="fas fa-align-left"></i> Tiêu đề:</strong>
                        <p class="mb-0">${event.title}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong><i class="fas fa-map-marker-alt"></i> Địa điểm:</strong>
                        <p class="mb-0">
                            <c:choose>
                                <c:when test="${not empty areaName}">
                                    ${areaName}
                                </c:when>
                                <c:otherwise>
                                    Chưa xác định
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong><i class="fas fa-clock"></i> Bắt đầu:</strong>
                        <p class="mb-0">
                            <fmt:formatDate value="${event.startDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong><i class="fas fa-clock"></i> Kết thúc:</strong>
                        <p class="mb-0">
                            <fmt:formatDate value="${event.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <form action="join-event?action=confirm" method="post" style="display: inline;">
                    <input type="hidden" name="token" value="${token}">
                    <button type="submit" class="btn btn-confirm text-white me-3">
                        <i class="fas fa-check"></i> Xác nhận tham gia
                    </button>
                </form>
                
                <a href="HomePage" class="btn btn-cancel text-white">
                    <i class="fas fa-times"></i> Hủy bỏ
                </a>
            </div>
            
            <div class="text-center mt-4">
                <small class="text-muted">
                    <i class="fas fa-info-circle"></i> 
                    Sau khi xác nhận, bạn sẽ được chuyển về trang chủ với thông báo thành công.
                </small>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 