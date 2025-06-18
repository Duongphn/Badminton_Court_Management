<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Xác nhận đặt sân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }
            .title {
                text-align: center;
                margin-bottom: 2rem;
            }
            .court-card {
                background: white;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                padding: 2rem;
                animation: fadeInUp 0.6s ease-out;
            }
            .court-info {
                margin-bottom: 1.5rem;
            }
            .court-name {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #333;
            }
            .book-btn {
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem 1.25rem;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
            }
            .book-btn:hover {
                background: #ff3838;
            }
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
                padding-left: 0;
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
        </style>
    </head>
    <body>

        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">BadmintonCourt</div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main">
            <div class="title">
                <h1>Xác nhận đặt sân</h1>
            </div>

            <div class="court-card">
                <!-- Thông tin đặt sân -->
                <div class="court-info">
                    <h5 class="court-name">Thông tin đặt sân</h5>
                    <div><strong>Sân:</strong> ${court.court_number}</div>
                    <div><strong>Khu vực:</strong> ${court.area_id}</div>
                    <div><strong>Ngày:</strong> ${date}</div>
                    <div><strong>Giờ bắt đầu:</strong> ${startTime}</div>
                    <div><strong>Giờ kết thúc:</strong> ${endTime}</div>
                    <div><strong>Tổng tiền:</strong> ${totalPrice}</div>
                    
                    
                </div>
          
                <!-- Form xác nhận -->
                <form action="confirm-booking" method="post" class="p-2">
                    <!-- Hidden Inputs -->
                    <input type="hidden" name="courtId" value="${court.court_id}">
                    <input type="hidden" name="areaId" value="${court.area_id}">
                    <input type="hidden" name="date" value="${date}">
                    <input type="hidden" name="startTime" value="${startTime}">
                    <input type="hidden" name="endTime" value="${endTime}">
                    <input type="hidden" name="totalPrice" value="${totalPrice}">


                    <div class="court-info">
                        <h5 class="court-name">Dịch vụ đi kèm</h5>
                        <div class="form-group">
                            <c:forEach var="service" items="${availableServices}">
                              
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox"
                                           name="selectedServices"
                                           value="${service.service.service_id}"
                                           id="service${service.service_id}">
                                    <label class="form-check-label" for="service${service.service_id}">
                                        ${service.service.name} - ${service.service.price} VNĐ
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <button type="submit" class="book-btn">Xác nhận đặt sân</button>
                </form>
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
