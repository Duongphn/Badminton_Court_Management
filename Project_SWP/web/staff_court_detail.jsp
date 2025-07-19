<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.AreaDAO,Model.Courts" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Courts c = (Courts) request.getAttribute("court");
    String areaName = null;
    if (c != null) {
        AreaDAO areaDAO = new AreaDAO();
        areaName = areaDAO.getAreaNameById(c.getArea_id());
    }
    request.setAttribute("areaName", areaName);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sân</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            margin-left: 260px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .container {
            padding-top: 30px;
            padding-bottom: 30px;
        }
        
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }
        
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 25px 30px;
            border-radius: 20px 20px 0 0 !important;
        }
        
        .card-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .card-body {
            padding: 0;
        }
        
        .detail-table {
            margin: 0;
            background: transparent;
        }
        
        .detail-table tr {
            border: none;
            transition: all 0.3s ease;
        }
        
        .detail-table tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
        }
        
        .detail-table th {
            background: linear-gradient(135deg, #f8f9ff 0%, #e9ecff 100%);
            color: #4a5568;
            font-weight: 600;
            padding: 20px 25px;
            border: none;
            border-right: 3px solid #667eea;
            width: 200px;
            font-size: 1rem;
            position: relative;
        }
        
        .detail-table th::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .detail-table td {
            padding: 20px 25px;
            border: none;
            color: #2d3748;
            font-size: 1rem;
            line-height: 1.6;
        }
        
        .detail-table tr:not(:last-child) {
            border-bottom: 1px solid #e2e8f0;
        }
        
        .court-image {
            max-width: 100%;
            height: auto;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .court-image:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-active {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }
        
        .status-inactive {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }
        
        .price-display {
            font-size: 1.2rem;
            font-weight: 700;
            color: #667eea;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-back:focus {
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
        }
        
        .icon-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        @media (max-width: 768px) {
            body {
                margin-left: 0;
            }
            
            .container {
                padding: 15px;
            }
            
            .card-header {
                padding: 20px;
            }
            
            .detail-table th,
            .detail-table td {
                padding: 15px 20px;
            }
            
            .detail-table th {
                width: auto;
                font-size: 0.9rem;
            }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card fade-in">
            <div class="card-header">
                <h2>
                    Chi tiết sân
                </h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty court}">
                    <table class="table detail-table">
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-hashtag"></i>
                                    ID
                                </span>
                            </th>
                            <td><strong>${court.court_id}</strong></td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Số sân
                                </span>
                            </th>
                            <td><strong>${court.court_number}</strong></td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-tag"></i>
                                    Loại
                                </span>
                            </th>
                            <td>${court.type}</td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-layer-group"></i>
                                    Chất liệu sàn
                                </span>
                            </th>
                            <td>${court.floor_material}</td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-lightbulb"></i>
                                    Chiếu sáng
                                </span>
                            </th>
                            <td>${court.lighting}</td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-money-bill-wave"></i>
                                    Giá
                                </span>
                            </th>
                            <td><span class="price-display">${court.price}</span></td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-align-left"></i>
                                    Mô tả
                                </span>
                            </th>
                            <td>${court.description}</td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-image"></i>
                                    Ảnh
                                </span>
                            </th>
                            <td>
                                <c:if test='${not empty court.image_url}'>
                                    <img src='${pageContext.request.contextPath}/${court.image_url}' 
                                         class="court-image" 
                                         style="max-width: 300px;" 
                                         alt="Hình ảnh sân"/>
                                </c:if>
                                <c:if test='${empty court.image_url}'>
                                    <span class="text-muted">
                                        <i class="fas fa-image"></i>
                                        Không có hình ảnh
                                    </span>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-info-circle"></i>
                                    Trạng thái
                                </span>
                            </th>
                            <td>
                                <span class="status-badge ${court.status.toLowerCase() == 'hoạt động' || court.status.toLowerCase() == 'available' ? 'status-active' : 'status-inactive'}">
                                    <i class="fas ${court.status.toLowerCase() == 'hoạt động' || court.status.toLowerCase() == 'available' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                    <c:choose>
                                        <c:when test="${court.status eq 'available'}">Còn trống</c:when>
                                        <c:when test="${court.status eq 'maintenance'}">Bảo trì</c:when>
                                        <c:when test="${court.status eq 'booked'}">Đã đặt</c:when>
                                        <c:otherwise>${court.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <span class="icon-label">
                                    <i class="fas fa-map"></i>
                                    Khu Vực
                                </span>
                            </th>
                            <td><strong>${areaName}</strong></td>
                        </tr>
                    </table>
                </c:if>
                
                <c:if test="${empty court}">
                    <div class="empty-state">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h4>Không tìm thấy thông tin sân</h4>
                        <p>Dữ liệu sân không có sẵn hoặc đã bị xóa.</p>
                    </div>
                </c:if>
                
                <div class="text-center mt-4 mb-3">
                    <a href="javascript:history.back()" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>