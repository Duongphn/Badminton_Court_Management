<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BadmintonCourt - Đặt Sân Cầu Lông Online</title>
        <style>

            /*             Main Content */
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }


            .search-section {
                max-width: 1200px;
                margin: 0 auto 30px;
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                padding: 40px;
                position: relative;
                overflow: hidden;
            }

            .search-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #3498db, #2ecc71, #f39c12, #e74c3c);
            }

            .search-section h2 {
                text-align: center;
                color: #2c3e50;
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .search-section .subtitle {
                text-align: center;
                color: #7f8c8d;
                font-size: 16px;
                margin-bottom: 35px;
            }

            .search-filters {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 25px;
                align-items: end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .filter-group label {
                font-weight: 600;
                color: #34495e;
                font-size: 15px;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-group label::before {
                font-size: 16px;
            }

            .filter-group:nth-child(1) label::before {
                content: "🏢";
            }

            .filter-group:nth-child(2) label::before {
                content: "📍";
            }

            .filter-group:nth-child(3) label::before {
                content: "⏰";
            }

            .filter-group input,
            .filter-group select {
                width: 100%;
                padding: 14px 18px;
                border: 2px solid #e8ecef;
                border-radius: 12px;
                font-size: 15px;
                color: #2c3e50;
                background: white;
                transition: all 0.3s ease;
                font-family: inherit;
            }

            .filter-group input {
                background-image: none;
            }

            .filter-group input::placeholder {
                color: #95a5a6;
                font-style: italic;
            }

            .filter-group select {
                cursor: pointer;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 15px center;
                background-repeat: no-repeat;
                background-size: 18px;
                padding-right: 45px;
            }

            .filter-group input:focus,
            .filter-group select:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            }

            .filter-group input:hover,
            .filter-group select:hover {
                border-color: #bdc3c7;
            }

            .search-button {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                background: #ff4757;
                border: none;
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                cursor: pointer;
            }

            /* Featured Section */
            .featured {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 2rem;
                margin-bottom: 3rem;
            }

            .featured-card {
                background: linear-gradient(135deg, #ffd700, #ffed4e);
                padding: 2rem;
                border-radius: 15px;
                position: relative;
                overflow: hidden;
            }

            .featured-card::after {
                content: "🏸";
                position: absolute;
                right: -10px;
                top: -10px;
                font-size: 8rem;
                opacity: 0.1;
            }

            .featured-card h3 {
                font-size: 1.5rem;
                margin-bottom: 1rem;
                color: #333;
            }

            .featured-card p {
                font-size: 1.1rem;
                color: #666;
                margin-bottom: 1.5rem;
            }

            .featured-btn {
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
            }

            .featured-btn:hover {
                background: #ff3838;
                transform: translateY(-2px);
            }

            .pricing-card {
                background: linear-gradient(135deg, #74b9ff, #0984e3);
                color: white;
            }

            .pricing-card::after {
                content: "💰";
            }

            /* Courts Grid */
            .courts-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 2rem;
                margin-top: 2rem;
            }

            .court-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transition: all 0.3s;
            }

            .court-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }

            .logo-san img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .court-info {
                padding: 1.5rem;
            }

            .court-info p{
                margin-bottom: 1.5rem;
            }

            .court-name {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .court-location {
                color: #666;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .court-location::before {
                content: "📍";
                margin-right: 0.5rem;
            }

            .book-btn {
                width: 100%;
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
                text-decoration: none;
            }

            .book-btn:hover {
                background: #ff3838;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header-container {
                    flex-direction: column;
                    gap: 1rem;
                }

                .nav-container {
                    flex-wrap: wrap;
                    gap: 1rem;
                }
            }

            .court-card {
                animation: fadeInUp 0.6s ease-out;
            }

            .court-card:nth-child(2) {
                animation-delay: 0.1s;
            }
            .court-card:nth-child(3) {
                animation-delay: 0.2s;
            }
            .court-card:nth-child(4) {
                animation-delay: 0.3s;
            }
        </style>
    </head>
    <body>

        <jsp:include page="homehead.jsp" />

        <!-- Main Content -->
        <main class="main">

            <!-- Search Section -->
            <div class="search-section">
                <form method="get" action="SearchUser">
                    <div class="search-filters">
                        <div class="filter-group">
                            <label>Khu vực</label>
                            <input type="text" name="areaName" value="${areaName != null ? areaName : ''}" placeholder="Tên khu vực">
                        </div>
                        <div class="filter-group">
                            <label>Địa điểm</label>
                            <select name="location">
                                <option value="Tất cả" ${location == 'Tất cả' || location == null ? 'selected' : ''}>Tất cả</option>
                                <c:forEach items="${locations}" var="loc">
                                    <option value="${loc}" ${loc == location ? 'selected' : ''}>${loc}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Thời gian</label>
                            <select name="timePeriod">
                                <option ${timePeriod == 'Tất cả' || timePeriod == null ? 'selected' : ''}>Tất cả</option>
                                <option ${timePeriod == 'Sáng (6h-12h)' ? 'selected' : ''}>Sáng (6h-12h)</option>
                                <option ${timePeriod == 'Chiều (12h-18h)' ? 'selected' : ''}>Chiều (12h-18h)</option>
                                <option ${timePeriod == 'Tối (18h-22h)' ? 'selected' : ''}>Tối (18h-22h)</option>
                            </select>
                        </div>
                        <div class="search">    
                            <button type="submit" class="featured-btn">Tìm kiếm</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Featured Section -->
            <div class="featured">
                <div class="featured-card">
                    <h3>Có ${areaList.size()} Khu vực sân cầu lông</h3>
                    <p>Đa dạng các sân cầu lông chất lượng cao trên toàn quốc</p>
                    <button class="featured-btn">Đăng ký ngay</button>
                </div>
                <div class="featured-card pricing-card">
                    <h3>Dụng cụ chất lượng cao</h3>
                    <p>Dịch vụ thuê dụng cụ cầu lông chất lượng</p>
                    <button class="featured-btn">Thuê ngay</button>
                </div>
            </div>


            <div class="courts-grid">
                <c:forEach var="area" items="${areaList}">
                    <div class="court-card">
                        <div class="court-images">
                            <c:forEach var="img" items="${areaImagesMap[area.area_id]}">
                                <div class="logo-san">
                                    <img src="${pageContext.request.contextPath}/${img.imageURL}" alt="Image ${img.image_id}" />
                                </div>
                            </c:forEach>
                        </div>
                        <div class="court-info">
                            <div class="court-name">${area.name}</div>
                            <div class="court-location">${area.location}</div>
                            <p>Giờ mở cửa: ${area.openTime} - ${area.closeTime}</p>
                            <p>Mô tả: ${area.description}</p>
                            <a href="AreaDetail?area_id=${area.area_id}" class="book-btn btn">Xem chi tiết</a>
                        </div>            
                    </div>
                </c:forEach>
            </div>    
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>