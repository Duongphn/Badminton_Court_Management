<%-- 
    Document   : coach_detail
    Created on : Jul 7, 2025, 5:02:09 PM
    Author     : sang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.Coach, Model.AreaCoach" %>
<%
    Coach coach = (Coach) request.getAttribute("coach");
    AreaCoach area = (AreaCoach) request.getAttribute("area");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thông tin chi tiết HLV Cầu Lông</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            
            .profile-container {
                max-width: 800px;
                margin: 20px auto;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            }
            
            .profile-header {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 40px 30px;
                text-align: center;
                position: relative;
            }
            
            .profile-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="white" opacity="0.1"/><circle cx="80" cy="40" r="1.5" fill="white" opacity="0.1"/><circle cx="40" cy="60" r="1" fill="white" opacity="0.1"/><circle cx="70" cy="80" r="2" fill="white" opacity="0.1"/></svg>');
                opacity: 0.3;
            }
            
            .coach-avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 5px solid rgba(255, 255, 255, 0.2);
                margin: 0 auto 20px;
                display: block;
                position: relative;
                z-index: 1;
            }
            
            .coach-name {
                font-size: 2.2rem;
                font-weight: 700;
                margin-bottom: 10px;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
                position: relative;
                z-index: 1;
            }
            
            .coach-title {
                font-size: 1.1rem;
                opacity: 0.9;
                margin-bottom: 15px;
                position: relative;
                z-index: 1;
            }
            
            .profile-body {
                padding: 40px 30px;
            }
            
            .info-section {
                margin-bottom: 30px;
            }
            
            .section-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .section-title i {
                color: #667eea;
                font-size: 1.2rem;
            }
            
            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .info-card {
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                padding: 20px;
                transition: all 0.3s ease;
            }
            
            .info-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }
            
            .info-card i {
                color: #667eea;
                font-size: 1.3rem;
                margin-bottom: 10px;
            }
            
            .info-label {
                font-weight: 600;
                color: #4a5568;
                margin-bottom: 8px;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .info-value {
                font-size: 1.1rem;
                color: #2d3748;
                line-height: 1.4;
            }
            
            .specialty-tag {
                background: linear-gradient(135deg, #ff6b6b, #ffa500);
                color: white;
                padding: 8px 20px;
                border-radius: 25px;
                font-weight: 600;
                font-size: 1rem;
                display: inline-block;
                box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            }
            
            .description-card {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                color: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 30px;
            }
            
            .description-card h4 {
                margin-bottom: 15px;
                font-weight: 600;
            }
            
            .description-text {
                line-height: 1.6;
                font-size: 1.05rem;
                opacity: 0.95;
            }
            
            .action-buttons {
                display: flex;
                gap: 15px;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .btn-primary-custom {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 25px;
                padding: 12px 30px;
                font-weight: 600;
                font-size: 1rem;
                color: white;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            
            .btn-primary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
                color: white;
            }
            
            .btn-secondary-custom {
                background: transparent;
                border: 2px solid #667eea;
                color: #667eea;
                border-radius: 25px;
                padding: 10px 28px;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            
            .btn-secondary-custom:hover {
                background: #667eea;
                color: white;
                transform: translateY(-2px);
            }
            
            .badminton-icon {
                position: absolute;
                font-size: 2rem;
                opacity: 0.1;
                color: white;
            }
            
            .badminton-icon:nth-child(1) {
                top: 20px;
                left: 30px;
                transform: rotate(-15deg);
            }
            
            .badminton-icon:nth-child(2) {
                top: 30px;
                right: 40px;
                transform: rotate(25deg);
            }
            
            .badminton-icon:nth-child(3) {
                bottom: 20px;
                left: 50px;
                transform: rotate(10deg);
            }
            
            @media (max-width: 768px) {
                .profile-container {
                    margin: 10px;
                    border-radius: 15px;
                }
                
                .profile-header {
                    padding: 30px 20px;
                }
                
                .coach-name {
                    font-size: 1.8rem;
                }
                
                .profile-body {
                    padding: 30px 20px;
                }
                
                .info-grid {
                    grid-template-columns: 1fr;
                }
                
                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <div class="profile-container">
            <% if (coach != null) { %>
            <div class="profile-header">
                <div class="badminton-icon">🏸</div>
                <div class="badminton-icon">🏸</div>
                <div class="badminton-icon">🏸</div>
                
                <img class="coach-avatar" src="<%=coach.getImageUrl()%>" alt="<%=coach.getFullname()%>"/>
                <h1 class="coach-name"><%=coach.getFullname()%></h1>
                <p class="coach-title">Huấn Luyện Viên Cầu Lông Chuyên Nghiệp</p>
            </div>
            
            <div class="profile-body">
                <div class="info-grid">
                    <div class="info-card">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="info-label">Khu vực hoạt động</div>
                        <div class="info-value"><%=area != null ? area.getLocation() : "Chưa cập nhật"%></div>
                    </div>
                    
                    <div class="info-card">
                        <i class="fas fa-trophy"></i>
                        <div class="info-label">Chuyên môn</div>
                        <div class="info-value">
                            <span class="specialty-tag"><%=coach.getSpecialty()%></span>
                        </div>
                    </div>
                    
                    <div class="info-card">
                        <i class="fas fa-envelope"></i>
                        <div class="info-label">Email liên hệ</div>
                        <div class="info-value"><%=coach.getEmail()%></div>
                    </div>
                    
                    <div class="info-card">
                        <i class="fas fa-phone"></i>
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value"><%=coach.getPhone()%></div>
                    </div>
                </div>
                
                <% if (coach.getDescription() != null && !coach.getDescription().trim().isEmpty()) { %>
                <div class="description-card">
                    <h4><i class="fas fa-user-graduate"></i> Giới thiệu về huấn luyện viên</h4>
                    <p class="description-text"><%=coach.getDescription()%></p>
                </div>
                <% } %>
                
                <div class="action-buttons">
                    <a href="HomeCoachList" class="btn-secondary-custom">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                </div>
            </div>
            
            <% } else { %>
            <div class="profile-body text-center">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                    Không tìm thấy thông tin huấn luyện viên!
                </div>
                <a href="HomeCoachList" class="btn-secondary-custom">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại danh sách
                </a>
            </div>
            <% } %>
        </div>
        <jsp:include page="homefooter.jsp" />
    </body>
</html>