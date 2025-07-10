<%-- 
    Document   : coach_list_user
    Created on : Jul 7, 2025, 5:07:30 PM
    Author     : sang
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, Model.Coach, Model.AreaCoach" %>
<%
    List<Coach> coaches = (List<Coach>)request.getAttribute("coaches");
    List<AreaCoach> areas = (List<AreaCoach>)request.getAttribute("areas");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Huấn luyện viên Cầu lông</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #ff6b35;
                --secondary-color: #004e92;
                --accent-color: #ffa726;
                --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --card-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
                --hover-shadow: 0 16px 48px rgba(0, 0, 0, 0.2);
            }

            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .header-section {
                background: var(--bg-gradient);
                padding: 60px 0;
                margin-bottom: 50px;
                position: relative;
                overflow: hidden;
            }

            .header-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="shuttlecock" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23shuttlecock)"/></svg>');
                opacity: 0.3;
            }

            .header-content {
                position: relative;
                z-index: 2;
                text-align: center;
                color: white;
            }

            .main-title {
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 15px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 20px;
            }

            .badminton-icon {
                font-size: 2.5rem;
                color: var(--accent-color);
                animation: bounce 2s infinite;
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% {
                    transform: translateY(0);
                }
                40% {
                    transform: translateY(-10px);
                }
                60% {
                    transform: translateY(-5px);
                }
            }

            .subtitle {
                font-size: 1.2rem;
                opacity: 0.9;
                font-weight: 300;
            }

            .coach-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 30px;
                padding: 0 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .coach-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: var(--card-shadow);
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                position: relative;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .coach-card:hover {
                transform: translateY(-8px);
                box-shadow: var(--hover-shadow);
            }

            .coach-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            }

            .coach-header {
                padding: 30px 25px 20px;
                text-align: center;
                background: linear-gradient(135deg, #f8f9ff 0%, #e8f2ff 100%);
                position: relative;
            }

            .coach-avatar {
                width: 90px;
                height: 90px;
                border-radius: 50%;
                object-fit: cover;
                margin: 0 auto 15px;
                border: 4px solid white;
                box-shadow: 0 4px 16px rgba(0,0,0,0.15);
                transition: transform 0.3s ease;
            }

            .coach-card:hover .coach-avatar {
                transform: scale(1.1);
            }

            .coach-name {
                font-size: 1.3rem;
                font-weight: 700;
                color: var(--secondary-color);
                margin-bottom: 8px;
                line-height: 1.3;
            }

            .coach-area {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                font-size: 1rem;
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 10px;
            }

            .area-icon {
                font-size: 1.1rem;
            }

            .coach-body {
                padding: 25px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .coach-stats {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
                padding: 15px 0;
                background: #f8f9fa;
                border-radius: 12px;
            }

            .stat-item {
                text-align: center;
            }

            .stat-number {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
                display: block;
            }

            .stat-label {
                font-size: 0.8rem;
                color: #6c757d;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-detail {
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                font-size: 1rem;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s ease;
                width: 100%;
                text-align: center;
            }

            .btn-detail:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(255, 107, 53, 0.4);
                color: white;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 20px;
                opacity: 0.5;
            }

            .search-filter {
                background: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 40px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .search-input {
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 12px 20px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
            }

            @media (max-width: 768px) {
                .main-title {
                    font-size: 2rem;
                }

                .coach-grid {
                    grid-template-columns: 1fr;
                    padding: 0 15px;
                }

                .header-section {
                    padding: 40px 0;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <main class="main">
            <div class="header-section">
                <div class="header-content">
                    <h1 class="main-title">
                        <i class="fas fa-table-tennis badminton-icon"></i>
                        Huấn luyện viên Cầu lông
                        <i class="fas fa-table-tennis badminton-icon"></i>
                    </h1>
                    <p class="subtitle">Tìm kiếm huấn luyện viên chuyên nghiệp phù hợp với bạn</p>
                </div>
            </div>

            <div class="container">
<!--                <div class="search-filter">
                    <div class="input-group">
                        <span class="input-group-text bg-transparent border-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control search-input border-0" placeholder="Tìm kiếm huấn luyện viên theo tên hoặc khu vực..." id="searchCoach">
                    </div>
                </div>-->

                <div class="coach-grid" id="coachGrid">
                    <% 
                    int activeCoachCount = 0;
                    for (Coach c : coaches) {
                        if (!"active".equalsIgnoreCase(c.getStatus())) continue;
                        activeCoachCount++;
                    %>
                    <div class="coach-card" data-name="<%=c.getFullname().toLowerCase()%>" data-area="<%
                        for (AreaCoach a : areas) {
                            if (a.getAreaId() == c.getAreaId()) { 
                                out.print(a.getLocation().toLowerCase()); 
                                break; 
                            }
                        }
                         %>">
                        <div class="coach-header">
                            <img class="coach-avatar" src="<%=c.getImageUrl()%>" alt="<%=c.getFullname()%>" onerror="this.src='https://via.placeholder.com/90x90/667eea/white?text=<%=c.getFullname().charAt(0)%>'"/>
                            <div class="coach-name"><%=c.getFullname()%></div>
                            <div class="coach-area">
                                <i class="fas fa-map-marker-alt area-icon"></i>
                                <span>
                                    <% for (AreaCoach a : areas) {
                                        if (a.getAreaId() == c.getAreaId()) { 
                                            out.print(a.getLocation()); 
                                            break; 
                                        }
                                    }%>
                                </span>
                            </div>
                        </div>

                        <div class="coach-body">                       
                            <a class="btn-detail" href="CoachDetail?coach_id=<%=c.getCoachId()%>">
                                <i class="fas fa-info-circle"></i>
                                Xem chi tiết
                            </a>
                        </div>
                    </div>
                    <% } %>
                </div>

                <% if (activeCoachCount == 0) { %>
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <h3>Chưa có huấn luyện viên nào</h3>
                    <p>Hiện tại chưa có huấn luyện viên nào đang hoạt động trong hệ thống.</p>
                </div>
                <% } %>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Tìm kiếm huấn luyện viên
                document.getElementById('searchCoach').addEventListener('input', function () {
                    const searchTerm = this.value.toLowerCase();
                    const coachCards = document.querySelectorAll('.coach-card');

                    coachCards.forEach(card => {
                        const name = card.getAttribute('data-name');
                        const area = card.getAttribute('data-area');

                        if (name.includes(searchTerm) || area.includes(searchTerm)) {
                            card.style.display = 'flex';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });

                // Thêm hiệu ứng loading cho hình ảnh
                document.querySelectorAll('.coach-avatar').forEach(img => {
                    img.addEventListener('load', function () {
                        this.style.opacity = '1';
                    });
                });
            </script>
        </main>
        <jsp:include page="homefooter.jsp" />
    </body>
</html>