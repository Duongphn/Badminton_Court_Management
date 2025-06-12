<%-- 
    Document   : homepageUser
    Created on : May 26, 2025, 10:48:19 PM
    Author     : sangn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hệ thống tìm kiếm sân bãi</title>
        <style>
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

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
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
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
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <main class="main">

            <div class="hero-banner">
                <img src="./images/logo/hinh_nen.jpg" alt="Badminton Court Banner" />
            </div>

            <div class="title">
                <h1>Danh sách sân nổi bật</h1>
            </div>

            <!-- Courts Grid -->
            <div class="courts-grid">
                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">Sân cầu lông Hoàng Gia</div>
                        <div class="court-location">Quận Ba Đình, Hà Nội</div>   
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>

                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">CLB Cầu lông Thăng Long</div>
                        <div class="court-location">Quận Cầu Giấy, Hà Nội</div>
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>

                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">Sân cầu lông Vinasport</div>
                        <div class="court-location">Quận Hai Bà Trưng, Hà Nội</div>
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>

                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">Trung tâm cầu lông Hà Đông</div>
                        <div class="court-location">Quận Hà Đông, Hà Nội</div>
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>

                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">Sân cầu lông Olympic</div>
                        <div class="court-location">Quần Thanh Xuân, Hà Nội</div>
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>

                <div class="court-card">
                    <div class="logo-san">
                        <img src="./images/san/san.jpg" alt="Sân A" />
                    </div>
                    <div class="court-info">
                        <div class="court-name">CLB Cầu lông Thể Thao</div>
                        <div class="court-location">Quận Long Biên, Hà Nội</div>
                        <button class="book-btn">Đặt sân ngay</button>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>
