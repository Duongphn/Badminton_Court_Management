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

        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .search-filters {
            display: grid;
            grid-template-columns: 1fr 200px 200px 200px auto;
            gap: 1rem;
            align-items: end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
        }

        .filter-group input,
        .filter-group select {
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
        }

        .search-main-btn {
            background: #ff4757;
            color: white;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .search-main-btn:hover {
            background: #ff3838;
            transform: translateY(-2px);
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

            .search-filters {
                grid-template-columns: 1fr;
            }

            .featured {
                grid-template-columns: 1fr;
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

        .court-card:nth-child(2) { animation-delay: 0.1s; }
        .court-card:nth-child(3) { animation-delay: 0.2s; }
        .court-card:nth-child(4) { animation-delay: 0.3s; }
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
                <!--<button class="header-btn">👤 Tài khoản</button>-->
                <a href="login.jsp" class="header-btn">Đăng Nhập</a>
                <a href="register.jsp" class="header-btn">Đăng Ký</a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="nav">
        <div class="nav-container">
            <div class="nav-item active"><a href="homepage.jsp">Trang Chủ</a></div>
            <div class="nav-item"><a href="#">Danh Sách Sân Bãi</a></div>
            <div class="nav-item"><a href="GioiThieu.jsp">Giới Thiệu</a></div>
            <div class="nav-item"><a href="#">Điều Khoản</a></div>
            <div class="nav-item"><a href="#">Danh Sách Chủ Sân</a></div>
            <div class="nav-item">Liên Hệ</div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main">

        <!-- Search Section -->
        <div class="search-section">
            <div class="search-filters">
                <div class="filter-group">
                    <label>Tìm sân</label>
                    <input type="text" placeholder="Nhập tên sân hoặc địa điểm...">
                </div>
                <div class="filter-group">
                    <label>Khu vực</label>
                    <select>
                        <option>Tất cả</option>
                        <option>Hà Nội</option>
                        <option>TP. Hồ Chí Minh</option>
                        <option>Đà Nẵng</option>
                        <option>Hải Phòng</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label>Mức giá</label>
                    <select>
                        <option>Tất cả</option>
                        <option>50k - 100k</option>
                        <option>100k - 200k</option>
                        <option>200k - 300k</option>
                        <option>Trên 300k</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label>Thời gian</label>
                    <select>
                        <option>Tất cả</option>
                        <option>Sáng (6h-12h)</option>
                        <option>Chiều (12h-18h)</option>
                        <option>Tối (18h-22h)</option>
                    </select>
                </div>
                <div>
                    <button class="search-main-btn">🔍 Tìm sân</button>
                </div>
            </div>
        </div>

        <!-- Featured Section -->
        <div class="featured">
            <div class="featured-card">
                <h3>Có 8.386 Sân cầu lông</h3>
                <p>Đa dạng các sân cầu lông chất lượng cao trên toàn quốc</p>
                <button class="featured-btn">Đăng ký ngay</button>
            </div>
            <div class="featured-card pricing-card">
                <h3>Dụng cụ chất lượng cao</h3>
                <p>Dịch vụ thuê dụng cụ cầu lông chất lượng</p>
                <button class="featured-btn">Thuê ngay</button>
            </div>
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

    <script>
        // Simple interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Nav item click handling
            const navItems = document.querySelectorAll('.nav-item');
            navItems.forEach(item => {
                item.addEventListener('click', function() {
                    navItems.forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Search functionality
            const searchBtn = document.querySelector('.search-btn');
            const mainSearchBtn = document.querySelector('.search-main-btn');
            
            
            searchBtn.addEventListener('click', handleSearch);
            mainSearchBtn.addEventListener('click', handleSearch);

            // Book button functionality
            const bookBtns = document.querySelectorAll('.book-btn');
            bookBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const courtName = this.closest('.court-card').querySelector('.court-name').textContent;
                    alert(`Đang chuyển đến trang đặt sân: ${courtName}`);
                });
            });

            // Featured buttons
            const featuredBtns = document.querySelectorAll('.featured-btn');
            featuredBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const cardTitle = this.closest('.featured-card').querySelector('h3').textContent;
                    alert(`Chức năng: ${cardTitle}`);
                });
            });
        });
    </script>
</body>
</html>