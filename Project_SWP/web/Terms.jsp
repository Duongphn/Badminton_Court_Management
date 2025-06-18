<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điều Khoản Sử Dụng - BadmintonCourt</title>
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
            background: linear-gradient(135deg, #e17055, #fdcb6e);
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
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 10s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
            border-left: 5px solid #e17055;
        }

        .content-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        }

        .content-section h2 {
            color: #e17055;
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

        .content-section h4 {
            color: #636e72;
            font-size: 1.2rem;
            margin-bottom: 0.8rem;
            margin-top: 1.5rem;
        }

        .content-section p {
            color: #636e72;
            margin-bottom: 1rem;
            text-align: justify;
        }

        .content-section ul, .content-section ol {
            margin-left: 2rem;
            margin-bottom: 1rem;
        }

        .content-section li {
            color: #636e72;
            margin-bottom: 0.5rem;
        }

        .important-notice {
            background: linear-gradient(135deg, #d63031, #e84393);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 2rem 0;
            text-align: center;
            box-shadow: 0 5px 15px rgba(214, 48, 49, 0.3);
        }

        .important-notice h3 {
            color: white;
            border: none;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .important-notice p {
            color: rgba(255,255,255,0.9);
            margin-bottom: 0;
        }

        .rules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .rule-card {
            background: linear-gradient(135deg, #00b894, #00cec9);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 184, 148, 0.3);
        }

        .rule-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0, 184, 148, 0.4);
        }

        .rule-card h4 {
            color: white;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .rule-card p {
            color: rgba(255,255,255,0.9);
            margin-bottom: 0;
            text-align: center;
        }

        .penalty-table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .penalty-table th {
            background: linear-gradient(135deg, #e17055, #fdcb6e);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: bold;
        }

        .penalty-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            color: #636e72;
        }

        .penalty-table tr:hover {
            background: #f8f9fa;
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

        .contact-section {
            background: linear-gradient(135deg, #a29bfe, #6c5ce7);
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
            background: #fd79a8;
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 2rem;
            font-weight: bold;
        }

        .toc {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            border-left: 5px solid #e17055;
        }

        .toc h3 {
            color: #e17055;
            margin-bottom: 1rem;
        }

        .toc ul {
            list-style: none;
            margin-left: 0;
        }

        .toc li {
            margin-bottom: 0.5rem;
        }

        .toc a {
            color: #636e72;
            text-decoration: none;
            transition: color 0.3s;
        }

        .toc a:hover {
            color: #e17055;
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

            .rules-grid {
                grid-template-columns: 1fr;
            }

            .contact-info {
                grid-template-columns: 1fr;
            }

            .penalty-table {
                font-size: 0.9rem;
            }

            .penalty-table th,
            .penalty-table td {
                padding: 0.5rem;
            }
        }

        .scroll-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #e17055, #fdcb6e);
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
            box-shadow: 0 5px 15px rgba(225, 112, 85, 0.4);
        }

        .section-divider {
            height: 3px;
            background: linear-gradient(135deg, #e17055, #fdcb6e);
            border-radius: 2px;
            margin: 3rem 0;
        }
    </style>
</head>
<body>

    <jsp:include page="homehead.jsp" />
    
    <div class="container">
        <section class="hero-section">
            <h1>📜 Điều Khoản Sử Dụng</h1>
            <p>Quy định về quyền và nghĩa vụ khi sử dụng dịch vụ của chúng tôi</p>
        </section>

        <section class="toc">
            <h3>📑 Mục Lục</h3>
            <ul>
                <li><a href="#general">1. Điều Khoản Chung</a></li>
                <li><a href="#registration">2. Đăng Ký Tài Khoản</a></li>
                <li><a href="#booking">3. Quy Định Đặt Sân</a></li>
                <li><a href="#payment">4. Thanh Toán</a></li>
                <li><a href="#user-rules">5. Quy Tắc Người Dùng</a></li>
                <li><a href="#court-rules">6. Quy Định Sử Dụng Sân</a></li>
                <li><a href="#cancellation">7. Hủy Đặt Sân</a></li>
            </ul>
        </section>

        <section class="content-section" id="general">
            <h2>📋 1. Điều Khoản Chung</h2>
            <p>Chào mừng bạn đến với Hệ thống Quản lý Sân Cầu Lông được phát triển bởi Nhóm 3 SWP391. Bằng việc truy cập và sử dụng dịch vụ của chúng tôi, bạn đồng ý tuân thủ các điều khoản và điều kiện được quy định trong tài liệu này.</p>
            
            <h3>Định Nghĩa</h3>
            <ul>
                <li><strong>"Chúng tôi"</strong> - Nhóm 3 SWP391, nhà phát triển hệ thống</li>
                <li><strong>"Người dùng"</strong> - Bất kỳ cá nhân nào sử dụng dịch vụ của chúng tôi</li>
                <li><strong>"Dịch vụ"</strong> - Hệ thống quản lý và đặt sân cầu lông</li>
                <li><strong>"Sân"</strong> - Các sân cầu lông có trong hệ thống</li>
            </ul>

        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="registration">
            <h2>👤 2. Đăng Ký Tài Khoản</h2>
            
            <h3>Yêu Cầu Đăng Ký</h3>
            <ul>
                <li>Cung cấp thông tin chính xác và đầy đủ</li>
                <li>Sử dụng email và số điện thoại hợp lệ</li>
                <li>Tạo mật khẩu mạnh (tối thiểu 8 ký tự)</li>
            </ul>

            <h3>Trách Nhiệm Tài Khoản</h3>
            <ul>
                <li>Bảo mật thông tin đăng nhập</li>
                <li>Không chia sẻ tài khoản với người khác</li>
                <li>Thông báo ngay khi phát hiện bất thường</li>
                <li>Cập nhật thông tin khi có thay đổi</li>
            </ul>

            <div class="highlight-box">
                <h3>🔐 Bảo Mật Tài Khoản</h3>
                <p>Bạn hoàn toàn chịu trách nhiệm về mọi hoạt động diễn ra dưới tài khoản của mình.</p>
            </div>
        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="booking">
            <h2>🏸 3. Quy Định Đặt Sân</h2>
            
            <h3>Quy Trình Đặt Sân</h3>
            <ol>
                <li>Đăng nhập vào hệ thống</li>
                <li>Chọn sân và thời gian mong muốn</li>
                <li>Xác nhận thông tin đặt sân</li>
                <li>Thanh toán theo quy định</li>
                <li>Nhận xác nhận đặt sân</li>
            </ol>

            <div class="rules-grid">
                <div class="rule-card">
                    <h4>⏰ Đúng Giờ</h4>
                    <p>Có mặt đúng giờ đã đặt. Trễ quá 15 phút sẽ bị hủy đặt sân.</p>
                </div>
                
                <div class="rule-card">
                    <h4>🎫 Xác Nhận</h4>
                    <p>Mang theo mã đặt sân hoặc hiển thị trên điện thoại khi đến sân.</p>
                </div>
                
                <div class="rule-card">
                    <h4>🔄 Gia Hạn</h4>
                    <p>Có thể gia hạn nếu sân còn trống và thanh toán bổ sung.</p>
                </div>
            </div>
        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="payment">
            <h2>💳 4. Thanh Toán</h2>
            
            <h3>Phương Thức Thanh Toán</h3>
            <ul>
                <li>Tiền mặt tại quầy</li>
            </ul>

            <h3>Chính Sách Thanh Toán</h3>
            <ul>
                <li><strong>Hoàn tiền:</strong> Theo chính sách hủy đặt sân</li>
                <li><strong>Phí phạt:</strong> Áp dụng khi vi phạm quy định</li>
                <li><strong>Hóa đơn:</strong> Được cung cấp sau khi thanh toán</li>
            </ul>
        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="user-rules">
            <h2>👤 5. Quy Tắc Người Dùng</h2>
            
            <h3>Hành Vi Được Phép</h3>
            <ul>
                <li>Sử dụng dịch vụ đúng mục đích</li>
                <li>Tuân thủ các quy định của sân</li>
                <li>Tôn trọng nhân viên và người dùng khác</li>
                <li>Giữ gìn vệ sinh và tài sản</li>
            </ul>

            <h3>Hành Vi Bị Cấm</h3>
            <ul>
                <li>Sử dụng ngôn ngữ thô tục, xúc phạm</li>
                <li>Gây rối, ảnh hưởng đến người khác</li>
                <li>Mang đồ ăn, thức uống có cồn vào sân</li>
                <li>Hút thuốc trong khuôn viên</li>
                <li>Sử dụng thiết bị âm thanh to</li>
                <li>Chụp ảnh, quay phim người khác không có sự đồng ý</li>
            </ul>

            <div class="important-notice">
                <h3>🚫 Cảnh Báo</h3>
                <p>Vi phạm nghiêm trọng sẽ dẫn đến việc khóa tài khoản vĩnh viễn và không được hoàn tiền.</p>
            </div>
        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="court-rules">
            <h2>🏟️ 6. Quy Định Sử Dụng Sân</h2>
            
            <h3>Trang Phục & Thiết Bị</h3>
            <ul>
                <li><strong>Giày:</strong> Bắt buộc giày thể thao sạch, đế không đen</li>
                <li><strong>Quần áo:</strong> Trang phục thể thao lịch sự</li>
                <li><strong>Vợt:</strong> Cho phép mang vợt cá nhân hoặc thuê tại sân</li>
                <li><strong>Cầu:</strong> Chỉ sử dụng cầu được phép</li>
            </ul>

            <h3>An Toàn Sân Đấu</h3>
            <ul>
                <li>Khởi động kỹ trước khi chơi</li>
                <li>Không chạy qua sân đang có người chơi</li>
                <li>Báo ngay khi có chấn thương</li>
                <li>Tuân thủ hướng dẫn của nhân viên</li>
            </ul>

            <h3>Vệ Sinh & Bảo Quản</h3>
            <ul>
                <li>Không xả rác bừa bãi</li>
                <li>Lau chân trước khi vào sân</li>
                <li>Không di chuyển thiết bị tùy ý</li>
                <li>Báo hỏng hóc thiết bị ngay lập tức</li>
            </ul>
        </section>

        <div class="section-divider"></div>

        <section class="content-section" id="cancellation">
            <h2>❌ 7. Hủy Đặt Sân</h2>
            
            <h3>Chính Sách Hủy</h3>
            <table class="penalty-table">
                <thead>
                    <tr>
                        <th>Thời Gian Hủy</th>
                        <th>Phí Hủy</th>
                        <th>Hoàn Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Trước 24 giờ</td>
                        <td>Miễn phí</td>
                        <td>100%</td>
                    </tr>
                    <tr>
                        <td>12-24 giờ trước</td>
                        <td>20%</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>2-12 giờ trước</td>
                        <td>50%</td>
                        <td>50%</td>
                    </tr>
                    <tr>
                        <td>Dưới 2 giờ</td>
                        <td>100%</td>
                        <td>0%</td>
                    </tr>
                </tbody>
            </table>

            <h3>Hủy Do Bất Khả Kháng</h3>
            <ul>
                <li>Thời tiết xấu (mưa to, bão)</li>
                <li>Sự cố kỹ thuật nghiêm trọng</li>
                <li>Lệnh cấm của cơ quan chức năng</li>
                <li>Các trường hợp khẩn cấp khác</li>
            </ul>
            <p><em>Trong các trường hợp này, chúng tôi sẽ hoàn tiền 100% hoặc hỗ trợ đổi lịch.</em></p>
        </section>
    </div>    
        <jsp:include page="homefooter.jsp" />