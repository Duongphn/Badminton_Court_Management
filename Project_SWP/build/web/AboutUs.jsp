<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về Chúng Tôi - BadmintonCourt</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
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
            background: linear-gradient(rgba(255,107,107,0.9), rgba(255,142,136,0.9)), url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><rect fill="%23ff6b6b" width="1200" height="600"/><circle fill="%23ff8e88" cx="300" cy="150" r="100" opacity="0.7"/><circle fill="%23ffa8a8" cx="900" cy="450" r="150" opacity="0.5"/></svg>');
            background-size: cover;
            color: white;
            text-align: center;
            padding: 4rem 2rem;
            margin-bottom: 3rem;
            border-radius: 15px;
        }

        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero-section p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .content-section {
            background: white;
            margin-bottom: 2rem;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .content-section:hover {
            transform: translateY(-5px);
        }

        .content-section h2 {
            color: #ff6b6b;
            font-size: 2rem;
            margin-bottom: 1rem;
            border-bottom: 3px solid #ff6b6b;
            padding-bottom: 0.5rem;
        }

        .mission-goals {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .mission-card, .goal-card {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .mission-card:hover, .goal-card:hover {
            transform: scale(1.05);
        }

        .mission-card h3, .goal-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .status-badge {
            display: inline-block;
            padding: 0.2rem 0.5rem;
            border-radius: 10px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-left: 0.5rem;
        }

        .status-completed {
            background: #d4edda;
            color: #155724;
        }

        .status-progress {
            background: #fff3cd;
            color: #856404;
        }

        .status-pending {
            background: #e2e3e5;
            color: #383d41;   
            position: relative;
            margin-bottom: 2rem;
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-left: 2rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .team-member {
            background: linear-gradient(135deg, #ffeaa7, #fab1a0);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .team-member:hover {
            transform: translateY(-10px);
        }

        .team-member .avatar {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #ff6b6b, #667eea);
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
        }

        .team-member h4 {
            color: #2d3436;
            margin-bottom: 0.5rem;
        }

        .team-member p {
            color: #636e72;
            font-size: 0.9rem;
        }

        .links-section {
            background: linear-gradient(135deg, #2d3436, #636e72);
            color: white;
            text-align: center;
        }

        .links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .link-card {
            background: rgba(255,255,255,0.1);
            padding: 2rem;
            border-radius: 15px;
            transition: all 0.3s ease;
            text-decoration: none;
            color: white;
            display: block;
        }

        .link-card:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-5px);
        }

        .link-card h4 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .footer {
            background: #2d3436;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }

        @media (max-width: 768px) {
            .nav-menu {
                flex-direction: column;
                gap: 1rem;
            }

            .hero-section h1 {
                font-size: 2rem;
            }

            .mission-goals {
                grid-template-columns: 1fr;
            }

        }
    </style>
</head>
<body>

    <jsp:include page="homehead.jsp" />
    
    <div class="container">
        <section class="hero-section">
            <h1>Hệ Thống Quản Lý Sân Cầu Lông</h1>
        </section>

        <div class="mission-goals">
            <div class="mission-card">
                <h3>🎯 Sứ Mệnh</h3>
                <p>Phát triển một hệ thống quản lý sân cầu lông hiện đại và hiệu quả trong khuôn khổ môn học SWP391. Chúng em cam kết tạo ra sản phẩm chất lượng cao, áp dụng các kiến thức đã học để giải quyết bài toán thực tế trong quản lý sân thể thao.</p>
            </div>
            
            <div class="goal-card">
                <h3>🚀 Mục Tiêu</h3>
                <p>Xây dựng thành công hệ thống quản lý sân cầu lông với đầy đủ tính năng: đăng ký, đặt sân, quản lý. Tạo ra sản phẩm có thể ứng dụng thực tế.</p>
            </div>
        </div>

        <section class="content-section">
            <h2>👥 Đội Ngũ Phát Triển (Nhóm 3 SWP391)</h2>
            <div class="team-grid">
                
                <div class="team-member">
                    <div class="avatar">👨‍💻</div>
                    <h4>Hoàng Tân Bảo</h4>
                    <p><strong>Leader Developer (Java)</strong></p>
                    <p>Chuyên gia Java với 20+ năm kinh nghiệm. Chịu trách nhiệm phát triển backend và kiến trúc hệ thống.</p>
                </div>
                
                <div class="team-member">
                    <div class="avatar">👨‍💻</div>
                    <h4>Nguyễn Văn Nghĩa</h4>
                    <p><strong>Developer (Java)</strong></p>
                    <p>Chuyên gia Java với 20+ năm kinh nghiệm. Chịu trách nhiệm phát triển backend và kiến trúc hệ thống.</p>
                </div>

                <div class="team-member">
                    <div class="avatar">👨‍💻</div>
                    <h4>Phan Hoàng Dương</h4>
                    <p><strong>Developer (Java)</strong></p>
                    <p>Chuyên gia Java với 20+ năm kinh nghiệm. Chịu trách nhiệm phát triển backend và kiến trúc hệ thống.</p>
                </div>

                <div class="team-member">
                    <div class="avatar">👨‍💻</div>
                    <h4>Hoàng Duy Anh</h4>
                    <p><strong>Developer (Java)</strong></p>
                    <p>Chuyên gia Java với 20+ năm kinh nghiệm. Chịu trách nhiệm phát triển backend và kiến trúc hệ thống.</p>
                </div>
                
                <div class="team-member">
                    <div class="avatar">👨‍💻</div>
                    <h4>Nguyễn Văn Sáng</h4>
                    <p><strong>Frontend Developer</strong></p>
                    <p>Chuyên gia UI/UX với kỹ năng CSS. Tạo ra những giao diện đẹp mắt và thân thiện với người dùng.</p>
                </div>
                
                
            </div>
        </section>

        <section class="content-section links-section">
            <h2>📋 Thông Tin Pháp Lý</h2>
            <p>Để đảm bảo quyền lợi và trải nghiệm tốt nhất cho người dùng trong dự án SWP391, vui lòng tham khảo các chính sách của nhóm chúng em:</p>
            
            <div class="links-grid">
                <a href="#privacy-policy" class="link-card">
                    <h4>🔒 Chính Sách Bảo Mật</h4>
                    <p>Cam kết bảo vệ thông tin cá nhân và dữ liệu của người dùng</p>
                </a>
                
                <a href="#terms-of-service" class="link-card">
                    <h4>📜 Điều Khoản Sử Dụng</h4>
                    <p>Quy định về quyền và nghĩa vụ của người dùng khi sử dụng dịch vụ</p>
                </a>
                
                <a href="#support" class="link-card">
                    <h4>🎧 Hỗ Trợ Khách Hàng</h4>
                    <p>Liên hệ với đội ngũ hỗ trợ 24/7 của chúng tôi</p>
                </a>
            </div>
        </section>
    </div>
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

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);


        // Quan sát các team members
        document.querySelectorAll('.team-member').forEach(member => {
            member.style.opacity = '0';
            member.style.transform = 'translateY(30px)';
            member.style.transition = 'all 0.6s ease';
            observer.observe(member);
        });

        // Hiệu ứng hover cho các card
        document.querySelectorAll('.content-section').forEach(section => {
            section.addEventListener('mouseenter', function() {
                this.style.boxShadow = '0 10px 25px rgba(0,0,0,0.15)';
            });
            
            section.addEventListener('mouseleave', function() {
                this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
            });
        });
    </script>
</body>
</html>