<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - Sân Cầu Lông</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        /* Animated court background */
        .court-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                linear-gradient(90deg, transparent 49%, #dc3545 49%, #dc3545 51%, transparent 51%),
                linear-gradient(0deg, transparent 49%, #dc3545 49%, #dc3545 51%, transparent 51%),
                radial-gradient(circle at 25% 25%, rgba(220, 53, 69, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(220, 53, 69, 0.1) 0%, transparent 50%),
                linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            animation: courtGlow 4s ease-in-out infinite alternate;
        }

        @keyframes courtGlow {
            0% { opacity: 0.3; }
            100% { opacity: 0.5; }
        }

        /* Floating elements */
        .court-bg::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="rgba(220,53,69,0.1)"/></svg>') repeat;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            100% { transform: translate(-50px, -50px); }
        }

        .notification-wrapper {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .forgot-container {
            background: #ffffff;
            border-radius: 20px;
            padding: 50px 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            border: 1px solid #e9ecef;
            position: relative;
            z-index: 2;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .forgot-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .forgot-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #dc3545 0%, #e3342f 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 30px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .forgot-title {
            font-size: 32px;
            font-weight: 600;
            color: #212529;
            margin-bottom: 10px;
        }

        .forgot-subtitle {
            font-size: 16px;
            color: #6c757d;
            font-weight: 400;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #495057;
            margin-bottom: 8px;
            transition: color 0.3s ease;
        }

        .input-container {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid #dee2e6;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 400;
            background: #ffffff;
            color: #212529;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-input:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            transform: translateY(-2px);
        }

        .form-input:focus + .input-icon {
            color: #dc3545;
            transform: translateY(-50%) scale(1.1);
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .forgot-button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #dc3545 0%, #e3342f 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .forgot-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(220, 53, 69, 0.2);
        }

        .forgot-button:active {
            transform: translateY(0);
        }

        .forgot-button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.3s ease;
        }

        .forgot-button:hover::before {
            width: 300px;
            height: 300px;
        }

        .back-link-container {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #dc3545;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .back-link:hover {
            background: rgba(220, 53, 69, 0.1);
            transform: translateX(-5px);
        }

        .info-box {
            background: linear-gradient(135deg, rgba(220, 53, 69, 0.1) 0%, rgba(32, 201, 151, 0.1) 100%);
            border: 1px solid rgba(220, 53, 69, 0.2);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 30px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .info-icon {
            color: #dc3545;
            font-size: 18px;
            margin-top: 2px;
        }

        .info-text {
            font-size: 14px;
            color: #495057;
            line-height: 1.4;
        }

        /* Loading state */
        .loading {
            position: relative;
            color: transparent;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 480px) {
            body {
                padding: 20px;
            }
            
            .forgot-container {
                padding: 40px 30px;
            }
            
            .forgot-title {
                font-size: 28px;
            }
            
            .forgot-subtitle {
                font-size: 14px;
            }
        }

        /* Success animation */
        .success-animation {
            animation: success 0.6s ease-out;
        }

        @keyframes success {
            0% {
                transform: scale(1);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 25px 50px rgba(220, 53, 69, 0.2);
            }
            100% {
                transform: scale(1);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            }
        }
    </style>
</head>
<body>
    <div class="court-bg"></div>
    
    <div class="notification-wrapper">
        <jsp:include page="notification.jsp"/>
    </div>

    <div class="forgot-container">
        <div class="forgot-header">
            <div class="forgot-icon">
                <i class="fas fa-key"></i>
            </div>
            <h2 class="forgot-title">Quên Mật Khẩu?</h2>
            <p class="forgot-subtitle">Đừng lo lắng! Chúng tôi sẽ giúp bạn khôi phục tài khoản</p>
        </div>

        <div class="info-box">
            <i class="fas fa-info-circle info-icon"></i>
            <div class="info-text">
                Nhập tên đăng nhập và email của bạn. Chúng tôi sẽ gửi hướng dẫn khôi phục mật khẩu đến email của bạn.
            </div>
        </div>

        <form action="forgotPassword" method="post" id="forgotForm">
            <div class="form-group">
                <label class="form-label" for="username">Tên đăng nhập</label>
                <div class="input-container">
                    <input type="text" class="form-input" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <div class="input-container">
                    <input type="email" class="form-input" id="email" name="email" placeholder="Nhập địa chỉ email của bạn" required>
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>

            <button type="submit" class="forgot-button" id="forgotBtn">
                <i class="fas fa-paper-plane" style="margin-right: 8px;"></i>
                Gửi Yêu Cầu Khôi Phục
            </button>
        </form>

        <div class="back-link-container">
            <a href="login" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Quay lại đăng nhập
            </a>
        </div>
    </div>

    <script>
        // Form submission with loading state
        document.getElementById('forgotForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('forgotBtn');
            const container = document.querySelector('.forgot-container');
            
            btn.classList.add('loading');
            btn.disabled = true;
            container.classList.add('success-animation');
            
            setTimeout(() => {
                btn.classList.remove('loading');
                btn.disabled = false;
                container.classList.remove('success-animation');
            }, 3000);
        });

        // Enhanced input interactions
        document.querySelectorAll('.form-input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.parentElement.querySelector('.form-label').style.color = '#dc3545';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.parentElement.querySelector('.form-label').style.color = '#495057';
            });

            // Add floating label effect
            input.addEventListener('input', function() {
                if (this.value) {
                    this.style.borderColor = '#dc3545';
                } else {
                    this.style.borderColor = '#dee2e6';
                }
            });
        });

        // Smooth hover effects
        document.querySelector('.back-link').addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(-5px)';
        });

        document.querySelector('.back-link').addEventListener('mouseleave', function() {
            this.style.transform = 'translateX(0)';
        });

        // Add ripple effect to button
        document.querySelector('.forgot-button').addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: scale(0);
                animation: ripple 0.6s ease-out;
                pointer-events: none;
            `;
            
            this.appendChild(ripple);
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });

        // Add CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
