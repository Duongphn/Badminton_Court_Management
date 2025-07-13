<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
        
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }
        
        .container {
            max-width: 800px;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(220, 53, 69, 0.3);
            backdrop-filter: blur(10px);
            animation: slideUp 0.6s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .card-header {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border-radius: 20px 20px 0 0;
            padding: 25px;
            border: none;
            text-align: center;
        }
        
        .card-header h3 {
            color: white;
            margin: 0;
            font-weight: 600;
            font-size: 1.8rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .card-header i {
            margin-right: 10px;
            font-size: 1.6rem;
        }
        
        .card-body {
            padding: 40px;
        }
        
        .form-label {
            font-weight: 600;
            color: #dc3545;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #f8d7da;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            background: white;
        }
        
        .form-control:hover, .form-select:hover {
            border-color: #dc3545;
            background: white;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            border-radius: 12px;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.6);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            border: none;
            border-radius: 12px;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.4);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268, #495057);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(108, 117, 125, 0.6);
        }
        
        .mb-3 {
            margin-bottom: 2rem !important;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #dc3545;
            z-index: 10;
            pointer-events: none;
        }
        
        .btn-container {
            text-align: center;
            margin-top: 30px;
            gap: 15px;
            display: flex;
            justify-content: center;
        }
        
        .floating-particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }
        
        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }
        
        .required-asterisk {
            color: #dc3545;
            font-weight: bold;
        }
        
        @media (max-width: 768px) {
            .card-body {
                padding: 20px;
            }
            
            .btn-container {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-container .btn {
                width: 100%;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="floating-particles">
        <div class="particle" style="left: 10%; top: 20%; width: 6px; height: 6px; animation-delay: 0s;"></div>
        <div class="particle" style="left: 20%; top: 80%; width: 8px; height: 8px; animation-delay: 2s;"></div>
        <div class="particle" style="left: 60%; top: 30%; width: 4px; height: 4px; animation-delay: 4s;"></div>
        <div class="particle" style="left: 80%; top: 70%; width: 6px; height: 6px; animation-delay: 1s;"></div>
        <div class="particle" style="left: 40%; top: 10%; width: 5px; height: 5px; animation-delay: 3s;"></div>
    </div>

    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header">
                <h3><i class="fas fa-plus-circle"></i> Thêm Sự kiện mới</h3>
            </div>
            <div class="card-body">
                <form action="manage-event?action=create" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="name" class="form-label">Tên sự kiện <span class="required-asterisk">*</span></label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="name" name="name" required>
                            <i class="fas fa-calendar-alt input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="title" class="form-label">Tiêu đề <span class="required-asterisk">*</span></label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="title" name="title" required>
                            <i class="fas fa-heading input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="imageUrl" class="form-label">Hình ảnh</label>
                        <div class="input-group">
                            <input type="file" class="form-control" id="imageUrl" name="imageUrl">
                            <i class="fas fa-image input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="areaId" class="form-label">Khu vực <span class="required-asterisk">*</span></label>
                        <div class="input-group">
                            <select class="form-select" id="areaId" name="areaId" required>
                                <option value="">-- Chọn khu vực --</option>
                                <c:forEach var="area" items="${areaList}">
                                    <option value="${area.area_id}">${area.name} - ${area.location}</option>
                                </c:forEach>
                            </select>
                            <i class="fas fa-map-marker-alt input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="startDate" class="form-label">Ngày bắt đầu <span class="required-asterisk">*</span></label>
                            <div class="input-group">
                                <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                                <i class="fas fa-calendar-check input-icon"></i>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="endDate" class="form-label">Ngày kết thúc <span class="required-asterisk">*</span></label>
                            <div class="input-group">
                                <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                                <i class="fas fa-calendar-times input-icon"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <div class="input-group">
                            <select class="form-select" id="status" name="status">
                                <option value="true">Hoạt động</option>
                                <option value="false">Không hoạt động</option>
                            </select>
                            <i class="fas fa-toggle-on input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu
                        </button>
                        <a href="manage-event" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>