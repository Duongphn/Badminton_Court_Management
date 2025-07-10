<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chính Sách Bảo Mật - BadmintonCourt</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background-color: #f8f9fa;
        }

        .header {
            background: linear-gradient(135deg, #ff6b6b, #ff8e88);
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .logo::before {
            content: "🏸";
            margin-right: 0.5rem;
            font-size: 1.8rem;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-menu a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: background-color 0.3s;
        }

        .nav-menu a:hover {
            background-color: rgba(255,255,255,0.2);
        }

        .nav-menu a.active {
            background-color: rgba(255,255,255,0.3);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .hero-section {
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
            text-align: center;
            padding: 4rem 2rem;
            margin-bottom: 3rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .hero-section p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .content-section {
            background: white;
            margin-bottom: 2rem;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-left: 5px solid #6c5ce7;
        }

        .content-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        }

        .content-section h2 {
            color: #6c5ce7;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .content-section h3 {
            color: #2d3436;
            font-size: 1.4rem;
            margin-bottom: 1rem;
            margin-top: 2rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #ddd;
        }

        .content-section p {
            color: #636e72;
            margin-bottom: 1rem;
            text-align: justify;
        }

        .content-section ul {
            margin-left: 2rem;
            margin-bottom: 1rem;
        }

        .content-section li {
            color: #636e72;
            margin-bottom: 0.5rem;
        }

        .highlight-box {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 2rem 0;
            text-align: center;
            box-shadow: 0 5px 15px rgba(116, 185, 255, 0.3);
        }

        .highlight-box h3 {
            color: white;
            border: none;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .highlight-box p {
            color: rgba(255,255,255,0.9);
            margin-bottom: 0;
        }

        .info-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .info-card {
            background: linear-gradient(135deg, #ffeaa7, #fdcb6e);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(253, 203, 110, 0.3);
        }

        .info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(253, 203, 110, 0.4);
        }

        .info-card h4 {
            color: #2d3436;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .info-card p {
            color: #636e72;
            margin-bottom: 0;
            text-align: center;
        }

        .contact-section {
            background: linear-gradient(135deg, #00b894, #00cec9);
            color: white;
            text-align: center;
            border-radius: 15px;
            padding: 3rem 2rem;
            margin-top: 3rem;
        }

        .contact-section h2 {
            color: white;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
        }

        .contact-section p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .contact-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .contact-card {
            background: rgba(255,255,255,0.15);
            padding: 2rem;
            border-radius: 15px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .contact-card:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-5px);
        }

        .contact-card h4 {
            color: white;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .contact-card p {
            color: rgba(255,255,255,0.9);
            margin-bottom: 0;
        }

        .footer {
            background: #2d3436;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }

        .last-updated {
            background: #e17055;
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 2rem;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .nav-menu {
                flex-direction: column;
                gap: 1rem;
            }

            .hero-section h1 {
                font-size: 2rem;
            }

            .hero-section p {
                font-size: 1rem;
            }

            .content-section {
                padding: 1.5rem;
            }

            .info-cards {
                grid-template-columns: 1fr;
            }

            .contact-info {
                grid-template-columns: 1fr;
            }
        }

        .scroll-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .scroll-to-top:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(108, 92, 231, 0.4);
        }
    </style>
</head>
<body>

    <jsp:include page="homehead.jsp" />
    
    <div class="container">
        <section class="hero-section">
            <h1>🔒 Chính Sách Bảo Mật</h1>
            <p>Cam kết bảo vệ thông tin cá nhân và quyền riêng tư của bạn</p>
        </section>
<!--
        <div class="last-updated">
            <p>📅 Cập nhật lần cuối: 19/06/2025 | Hiệu lực từ: 01/01/2025</p>
        </div>-->

        <section class="content-section">
            <h2>📋 Tổng Quan</h2>
            <p>Chúng tôi - Nhóm 3 SWP391 - cam kết bảo vệ quyền riêng tư và thông tin cá nhân của bạn khi sử dụng Hệ thống Quản lý Sân Cầu Lông. Chính sách này giải thích cách chúng tôi thu thập, sử dụng, lưu trữ và bảo vệ thông tin của bạn.</p>
            
            <div class="highlight-box">
                <h3>🛡️ Cam Kết Của Chúng Tôi</h3>
                <p>Thông tin cá nhân của bạn sẽ được bảo mật tuyệt đối và chỉ được sử dụng cho mục đích cung cấp dịch vụ tốt nhất.</p>
            </div>
        </section>

        <section class="content-section">
            <h2>📊 Thông Tin Chúng Tôi Thu Thập</h2>
            
            <h3>Thông Tin Cá Nhân</h3>
            <ul>
                <li><strong>Thông tin đăng ký:</strong> Họ tên, số điện thoại, email, địa chỉ</li>
                <li><strong>Thông tin thanh toán:</strong> Lịch sử giao dịch</li>
                <li><strong>Thông tin sử dụng dịch vụ:</strong> Lịch sử đặt sân, thời gian sử dụng</li>
            </ul>

        </section>

        <section class="content-section">
            <h2>🎯 Mục Đích Sử Dụng Thông Tin</h2>
            
            <div class="info-cards">
                <div class="info-card">
                    <h4>🏸 Cung Cấp Dịch Vụ</h4>
                    <p>Xử lý đặt sân, quản lý lịch trình, xác nhận thanh toán</p>
                </div>
                
                <div class="info-card">
                    <h4>📞 Liên Lạc</h4>
                    <p>Thông báo về lịch đặt sân, xác nhận, hủy đặt</p>
                </div>
                
                <div class="info-card">
                    <h4>🛡️ Bảo Mật</h4>
                    <p>Ngăn chặn gian lận, bảo vệ tài khoản người dùng</p>
                </div>
            </div>
        </section>

        <section class="content-section">
            <h2>🔐 Cách Chúng Tôi Bảo Vệ Thông Tin</h2>
            
            <h3>Biện Pháp Kỹ Thuật</h3>
            <ul>
                <li><strong>Mã hóa dữ liệu:</strong> để bảo vệ dữ liệu truyền tải</li>
                <li><strong>Mã hóa mật khẩu:</strong> Sử dụng thuật toán băm an toàn</li>
                <li><strong>Firewall:</strong> Bảo vệ máy chủ khỏi các cuộc tấn công</li>
                <li><strong>Sao lưu định kỳ:</strong> Đảm bảo an toàn dữ liệu</li>
            </ul>

            <h3>Biện Pháp Quản Lý</h3>
            <ul>
                <li><strong>Phân quyền truy cập:</strong> Chỉ nhân viên được ủy quyền mới có thể truy cập</li>
                <li><strong>Đào tạo bảo mật:</strong> Nhân viên được đào tạo về bảo mật thông tin</li>
                <li><strong>Kiểm tra định kỳ:</strong> Rà soát và cập nhật biện pháp bảo mật</li>
            </ul>
        </section>

        <section class="content-section">
            <h2>🤝 Chia Sẻ Thông Tin</h2>
            <p>Chúng tôi cam kết <strong>KHÔNG</strong> bán, cho thuê hay chia sẻ thông tin cá nhân của bạn với bên thứ ba, trừ các trường hợp sau:</p>
            
            <ul>
                <li><strong>Khi có sự đồng ý:</strong> Của bạn một cách rõ ràng</li>
                <li><strong>Yêu cầu pháp lý:</strong> Theo quy định của pháp luật Việt Nam</li>
                <li><strong>Đối tác dịch vụ:</strong> Chỉ những thông tin cần thiết để cung cấp dịch vụ</li>
                <li><strong>Tình huống khẩn cấp:</strong> Để bảo vệ an toàn của người dùng</li>
            </ul>
        </section>

        <section class="content-section">
            <h2>⚖️ Quyền Của Người Dùng</h2>
            
            <div class="info-cards">
                <div class="info-card">
                    <h4>👁️ Quyền Truy Cập</h4>
                    <p>Xem thông tin cá nhân mà chúng tôi lưu trữ</p>
                </div>
                
                <div class="info-card">
                    <h4>✏️ Quyền Chỉnh Sửa</h4>
                    <p>Cập nhật, sửa đổi thông tin cá nhân</p>
                </div>

            </div>
        </section>

    </div>

    <button class="scroll-to-top" onclick="scrollToTop()">↑</button>

    <jsp:include page="homefooter.jsp" />

    <script>
        // Smooth scrolling cho các liên kết
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Hiệu ứng animation khi scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Quan sát các content sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'all 0.6s ease';
            observer.observe(section);
        });

        // Quan sát các info cards
        document.querySelectorAll('.info-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = 'all 0.6s ease';
            observer.observe(card);
        });

        // Hiệu ứng hover cho các sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.addEventListener('mouseenter', function() {
                this.style.boxShadow = '0 10px 30px rgba(0,0,0,0.12)';
            });
            
            section.addEventListener('mouseleave', function() {
                this.style.boxShadow = '0 5px 20px rgba(0,0,0,0.08)';
            });
        });

        // Scroll to top button
        const scrollToTopBtn = document.querySelector('.scroll-to-top');

        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                scrollToTopBtn.style.display = 'flex';
            } else {
                scrollToTopBtn.style.display = 'none';
            }
        });

        function scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }

        // Hiệu ứng typing cho hero title
        const heroTitle = document.querySelector('.hero-section h1');
        const titleText = heroTitle.textContent;
        heroTitle.textContent = '';
        
        let i = 0;
        const typingInterval = setInterval(() => {
            heroTitle.textContent += titleText.charAt(i);
            i++;
            if (i > titleText.length) {
                clearInterval(typingInterval);
            }
        }, 100);

        // Hiệu ứng parallax cho hero section
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const parallax = document.querySelector('.hero-section');
            const speed = scrolled * 0.5;
            
            if (parallax) {
                parallax.style.transform = `translateY(${speed}px)`;
            }
        });
    </script>
</body>
</html>