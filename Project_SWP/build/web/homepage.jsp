<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BadmintonCourt - Đặt Sân Cầu Lông Online</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background-color: #f5f5f5;
            }

            /* Header */
            .header {
                background: linear-gradient(135deg, #ff4757, #ff3838);
                color: white;
                padding: 1rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .header-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                display: flex;
                align-items: center;
                font-size: 1.5rem;
                font-weight: bold;
            }

            .logo::before {
                content: "🏸";
                margin-right: 0.5rem;
                font-size: 2rem;
            }

            .search-bar {
                flex: 1;
                max-width: 400px;
                margin: 0 2rem;
                position: relative;
            }

            .search-bar input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: none;
                border-radius: 25px;
                font-size: 1rem;
                outline: none;
            }

            .search-btn {
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

            .header-actions {
                display: flex;
                gap: 1rem;
                align-items: center;
            }

            .header-btn {
                background: rgba(255,255,255,0.2);
                border: 1px solid rgba(255,255,255,0.3);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
            }

            .header-btn:hover {
                background: rgba(255,255,255,0.3);
            }

            /* Navigation */
            .nav {
                background: white;
                padding: 1rem 0;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: center;
                gap: 2rem;
            }

            .nav-item {
                padding: 0.5rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                transition: all 0.3s;
                background: #f8f9fa;
                color: #333;

            }

            .nav-item.active {
                background: #ff4757;
            }

            .nav-item.active a {
                text-decoration: none;
                color: white;
            }

            .nav-item:hover {
                background: #ff6b7a;
                color: white;
            }

            .nav-item a{
                color: black;
                text-decoration: none;
            }

            /* Main Content */
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            /* Hero Banner */
            .hero-banner {
                border-radius: 20px;
                overflow: hidden;
                margin-bottom: 3rem;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .hero-banner img {
                width: 100%;
                height: 400px;
                object-fit: cover;
                display: block;
            }

            .title {
                text-align: center;
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
                margin-bottom: 0.5rem;
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
            }

            .book-btn:hover {
                background: #ff3838;
            }

            /* Footer */
            .footer {
                background: #2d3436;
                color: white;
                padding: 3rem 0 1rem;
                margin-top: 4rem;
            }

            .footer-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 2rem;
            }

            .footer-section h4 {
                margin-bottom: 1rem;
                color: #ff4757;
            }

            .footer-section ul {
                list-style: none;
            }

            .footer-section ul li {
                margin-bottom: 0.5rem;
            }

            .footer-section ul li a {
                color: #b2bec3;
                text-decoration: none;
                transition: color 0.3s;
            }

            .footer-section ul li a:hover {
                color: white;
            }

            .footer-bottom {
                text-align: center;
                padding-top: 2rem;
                border-top: 1px solid #636e72;
                margin-top: 2rem;
                color: #b2bec3;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header-container {
                    flex-direction: column;
                    gap: 1rem;
                }

                .search-bar {
                    order: -1;
                    max-width: 100%;
                    margin: 0;
                }

                .nav-container {
                    flex-wrap: wrap;
                    gap: 1rem;
                }

                .hero-banner {
                    height: 300px;
                }

                .hero-banner img {
                    height: 300px;
                }
            }

            /* Animations */
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

            .hero-banner {
                animation: fadeInUp 0.8s ease-out;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">BadmintonCourt</div>
                <div class="search-bar">
                    <input type="text" placeholder="Tìm sân cầu lông...">
                    <button class="search-btn">Tìm</button>
                </div>
                <div class="header-actions">
                    <a href="login.jsp" class="header-btn">Đăng Nhập</a>
                    <a href="register.jsp" class="header-btn">Đăng Ký</a>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="nav">
            <div class="nav-container">
                <div class="nav-item active"><a href="HomePage">Trang Chủ</a></div>
                <div class="nav-item"><a href="login.jsp">Danh Sách Sân Bãi</a></div>
                <div class="nav-item"><a href="login.jsp">Danh sách đặt sân</a></div>
                <div class="nav-item"><a href="login.jsp">Bài Viết</a></div>
                <div class="nav-item"><a href="login.jsp">Giới Thiệu</a></div>
                <div class="nav-item">Liên Hệ</div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main">

            <!-- Hero Banner -->
            <div class="hero-banner">
                <img src="./images/logo/hinh_nen.jpg" alt="Badminton Court Banner" />
            </div>

            <div class="title">
                <h1>Danh sách khu vực nổi bật</h1>
            </div>
            

            
            <!-- Courts Grid -->
            <div class="courts-grid">
                <c:forEach var="top" items="${listTop3}">
                    <div class="court-card">
                        <div class="logo-san">
                            <img src="images/san/san.jpg" alt="${top.name}" />
                        </div>
                        <div class="court-info">
                            <div class="court-name">${top.name}</div>
                            <div class="court-location">${top.location}</div>
                            <p>Giờ mở cửa: ${top.openTime} - ${top.closeTime}</p>
                            <p>Mô tả: ${top.description}</p>
                            <form action="areaDetail" method="get">
                                <input type="hidden" name="area_id" value="${top.area_id}" />
                                <button type="submit" class="book-btn">Xem chi tiết</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </main>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-container">
                <div class="footer-section">
                    <h4>Về BadmintonCourt</h4>
                    <ul>
                        <li><a href="#">Giới thiệu</a></li>
                        <li><a href="#">Tuyển dụng</a></li>
                        <li><a href="#">Liên hệ</a></li>
                        <li><a href="#">Tin tức</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Dịch vụ</h4>
                    <ul>
                        <li><a href="#">Đặt sân online</a></li>
                        <li><a href="#">Thiết bị cầu lông</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Hỗ trợ</h4>
                    <ul>
                        <li><a href="#">Hướng dẫn đặt sân</a></li>
                        <li><a href="#">Chính sách hoàn tiền</a></li>
                        <li><a href="#">Câu hỏi thường gặp</a></li>
                        <li><a href="#">Hotline: 1900-8386</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Kết nối</h4>
                    <ul>
                        <li><a href="#">📘 Facebook</a></li>
                        <li><a href="#">📷 Instagram</a></li>
                        <li><a href="#">🐦 Twitter</a></li>
                        <li><a href="#">📺 YouTube</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 BadmintonCourt. Thế giới cầu lông.</p>
            </div>
        </footer>

    </body>
</html>