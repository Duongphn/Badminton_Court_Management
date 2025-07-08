<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng Nhập - Sân Cầu Lông</title>
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
                position: relative;
                overflow: hidden;
                 overflow-y: auto;
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

            /* Left side - Branding */
            .left-panel {
                flex: 1;
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 50%, #e9ecef 100%);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 60px 40px;
                position: relative;
                overflow: hidden;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }

            .left-panel::before {
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

            .brand-content {
                text-align: center;
                color: #333333;
                z-index: 2;
                position: relative;
            }

            .brand-logo {
                font-size: 80px;
                margin-bottom: 20px;
                color: #dc3545;
                text-shadow: 0 0 30px rgba(220, 53, 69, 0.3);
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.1); }
            }

            .brand-title {
                font-size: 42px;
                font-weight: 700;
                margin-bottom: 15px;
                color: #dc3545;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            }

            .brand-subtitle {
                font-size: 18px;
                font-weight: 300;
                margin-bottom: 40px;
                color: #6c757d;
            }

            .features {
                display: flex;
                gap: 30px;
                margin-top: 40px;
            }

            .feature {
                text-align: center;
                color: #495057;
            }

            .feature-icon {
                font-size: 24px;
                margin-bottom: 10px;
                color: #dc3545;
            }

            .feature-text {
                font-size: 14px;
                font-weight: 400;
            }

            /* Right side - Login form */
            .right-panel {
                flex: 1;
                background: #ffffff;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 60px 40px;
                position: relative;
            }

            .login-container {
                width: 100%;
                max-width: 400px;
                background: #ffffff;
                border-radius: 16px;
                padding: 40px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                border: 1px solid #e9ecef;
            }

            .login-header {
                text-align: center;
                margin-bottom: 40px;
            }

            .login-title {
                font-size: 32px;
                font-weight: 600;
                color: #212529;
                margin-bottom: 8px;
            }

            .login-subtitle {
                font-size: 16px;
                color: #6c757d;
                font-weight: 400;
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
                border-radius: 8px;
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
            }

            .form-input:focus + .input-icon {
                color: #dc3545;
            }

            .input-icon {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                font-size: 18px;
                transition: color 0.3s ease;
            }

            /* CAPTCHA Styles */
            .captcha-container {
                margin-bottom: 25px;
            }

            .captcha-display {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 15px;
            }

            .captcha-box {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                border: 2px solid #dee2e6;
                border-radius: 8px;
                padding: 15px 20px;
                font-family: 'Courier New', monospace;
                font-size: 20px;
                font-weight: bold;
                color: #495057;
                letter-spacing: 3px;
                user-select: none;
                position: relative;
                overflow: hidden;
                min-width: 120px;
                text-align: center;
                background-image: 
                    repeating-linear-gradient(45deg, transparent, transparent 2px, rgba(220, 53, 69, 0.1) 2px, rgba(220, 53, 69, 0.1) 4px),
                    repeating-linear-gradient(-45deg, transparent, transparent 2px, rgba(220, 53, 69, 0.05) 2px, rgba(220, 53, 69, 0.05) 4px);
            }

            .captcha-refresh {
                background: #dc3545;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 16px;
            }

            .captcha-refresh:hover {
                background: #c82333;
                transform: rotate(180deg);
            }

            .captcha-input {
                width: 100%;
                padding: 16px 20px 16px 50px;
                border: 2px solid #dee2e6;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 400;
                background: #ffffff;
                color: #212529;
                transition: all 0.3s ease;
                outline: none;
                text-transform: uppercase;
                letter-spacing: 2px;
            }

            .captcha-input:focus {
                border-color: #dc3545;
                box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            }

            .captcha-error {
                color: #dc3545;
                font-size: 12px;
                margin-top: 5px;
                display: none;
            }

            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                font-size: 14px;
                color: #495057;
            }

            .remember-wrapper {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .checkbox {
                width: 18px;
                height: 18px;
                accent-color: #dc3545;
            }

            .forgot-password {
                color: #dc3545;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .forgot-password:hover {
                color: #c82333;
            }

            .login-button {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #dc3545 0%, #e3342f 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                margin-bottom: 20px;
            }

            .login-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(220, 53, 69, 0.2);
            }

            .login-button:active {
                transform: translateY(0);
            }

            .login-button:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 10px 0;
                color: #6c757d;
                font-size: 14px;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: #dee2e6;
            }

            .divider span {
                padding: 0 15px;
                background: #ffffff;
            }

            .google-button {
                width: 100%;
                padding: 16px;
                background: #ffffff;
                border: 2px solid #dee2e6;
                border-radius: 8px;
                color: #495057;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                margin-bottom: 30px;
            }

            .google-button:hover {
                border-color: #adb5bd;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                background: #f8f9fa;
            }

            .google-icon {
                width: 20px;
                height: 20px;
                background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTIyLjU2IDEyLjI1QzIyLjU2IDExLjQ3IDIyLjQ5IDEwLjcyIDIyLjM2IDEwSDE3VjE0LjI2SDIwLjE5QzE5LjkzIDE1LjYgMTkuMTQgMTYuNzQgMTcuOTYgMTcuNVYyMC4wNkgyMC40MkMyMS43MiAxOC44NyAyMi41NiAxNS43OSAyMi41NiAxMi4yNVoiIGZpbGw9IiM0Mjg1RjQiLz4KPHBhdGggZD0iTTEyIDIyQzE1LjI0IDIyIDE3LjkyIDIwLjk1IDE5LjQyIDIwLjA2TDE2Lj96IDE3LjVDMTYuMTMgMTguMDIgMTQuMjMgMTguNTMgMTIgMTguNTNDOC45IDE4LjUzIDYuMjYgMTYuNzYgNS40IDE0LjI4SDMuNzlWMTUuOTdDNS4zOCAxOS4wOSA4LjM5IDIyIDEyIDIyWiIgZmlsbD0iIzM0QTg1MyIvPgo8cGF0aCBkPSJNNS40IDE0LjI4QzUuMTYgMTMuNzYgNSAxMy4xNCA1IDEyQzUgMTAuODYgNS4xNiAxMC4yNCA1LjQgOS43MlY4LjAzSDMuNzlDMy4xOSA5LjIyIDIuODcgMTAuNTcgMi44NyAxMkMyLjg3IDEzLjQzIDMuMTkgMTQuNzggMy43OSAxNS45N0w1LjQgMTQuMjhaIiBmaWxsPSIjRkJCQzAiLz4KPHBhdGggZD0iTTEyIDUuNDA3QzE0LjMgNS40NyAxNi4yMyA2LjMzIDE3Ljc0IDcuNzlMMjAuMDEgNS41MkMxNy45MiAzLjU5IDE1LjI0IDIuNTQgMTIgMi41NEM4LjM5IDIuNTQgNS4zOCA1LjQ1IDMuNzkgOC41M0w1LjQgMTAuMjJDNi4yNiA3Ljc0IDguOSA1Ljk3IDEyIDUuOTdaIiBmaWxsPSIjRUE0MzM1Ii8+Cjwvc3ZnPgo=') no-repeat center;
                background-size: contain;
            }

            .register-text {
                text-align: center;
                color: #6c757d;
                font-size: 14px;
            }

            .register-link {
                color: #dc3545;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .register-link:hover {
                color: #c82333;
            }

            .notification-wrapper {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
            }

            /* Responsive */
            @media (max-width: 768px) {
                body {
                    flex-direction: column;
                }
                
                .left-panel {
                    flex: none;
                    min-height: 300px;
                    padding: 40px 20px;
                }
                
                .brand-logo {
                    font-size: 60px;
                }
                
                .brand-title {
                    font-size: 28px;
                }
                
                .features {
                    flex-direction: column;
                    gap: 20px;
                }
                
                .right-panel {
                    padding: 40px 20px;
                }
                
                .login-title {
                    font-size: 24px;
                }

                .captcha-display {
                    flex-direction: column;
                    align-items: stretch;
                }

                .captcha-box {
                    min-width: auto;
                    margin-bottom: 10px;
                }
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
        </style>
    </head>
    <body>
        <div class="court-bg"></div>
        
        <div class="notification-wrapper">
            <c:import url="notification.jsp" />
        </div>

        <!-- Left Panel - Branding -->
        <div class="left-panel">
            <div class="brand-content">
                <div class="brand-logo">
                    <svg viewBox="0 0 100 100" style="width: 80px; height: 80px; fill: #dc3545;">
                        <!-- Cầu lông (shuttlecock) -->
                        <circle cx="50" cy="75" r="8" fill="#dc3545"/>
                        <path d="M50 67 L42 20 L45 18 L50 25 L55 18 L58 20 Z" fill="#dc3545"/>
                        <path d="M42 20 L35 15 L40 12 L45 18" fill="#dc3545" opacity="0.8"/>
                        <path d="M58 20 L65 15 L60 12 L55 18" fill="#dc3545" opacity="0.8"/>
                        <path d="M45 18 L38 10 L42 8 L47 15" fill="#dc3545" opacity="0.6"/>
                        <path d="M55 18 L62 10 L58 8 L53 15" fill="#dc3545" opacity="0.6"/>
                        <!-- Vợt cầu lông -->
                        <ellipse cx="20" cy="35" rx="12" ry="18" fill="none" stroke="#dc3545" stroke-width="3"/>
                        <line x1="20" y1="53" x2="20" y2="80" stroke="#dc3545" stroke-width="4"/>
                        <rect x="18" y="78" width="4" height="8" fill="#dc3545"/>
                        <!-- Lưới vợt -->
                        <line x1="12" y1="25" x2="28" y2="25" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="12" y1="30" x2="28" y2="30" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="12" y1="35" x2="28" y2="35" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="12" y1="40" x2="28" y2="40" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="12" y1="45" x2="28" y2="45" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="15" y1="20" x2="15" y2="50" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="20" y1="17" x2="20" y2="53" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                        <line x1="25" y1="20" x2="25" y2="50" stroke="#dc3545" stroke-width="1" opacity="0.6"/>
                    </svg>
                </div>
                <h1 class="brand-title">CourtBooking</h1>
                <p class="brand-subtitle">Đặt sân cầu lông dễ dàng, nhanh chóng</p>
                
                <div class="features">
                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="feature-text">Đặt sân 24/7</div>
                    </div>
                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="feature-text">Bảo mật tuyệt đối</div>
                    </div>
                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="feature-text">Dịch vụ tốt nhất</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Panel - Login Form -->
        <div class="right-panel">
            <div class="login-container">
                <div class="login-header">
                    <h2 class="login-title">Chào mừng trở lại!</h2>
                    <p class="login-subtitle">Đăng nhập vào tài khoản của bạn</p>
                </div>

                <form action="login" method="post" id="loginForm">
                    <div class="form-group">
                        <label class="form-label" for="username">Tên đăng nhập</label>
                        <div class="input-container">
                            <input type="text" class="form-input" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required>
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <div class="input-container">
                            <input type="password" class="form-input" id="password" name="password" placeholder="Nhập mật khẩu của bạn" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                    </div>

                    <!-- CAPTCHA Section -->
                    <div class="form-group captcha-container">
                        <label class="form-label">Xác nhận bảo mật</label>
                        <div class="captcha-display">
                            <div class="captcha-box" id="captchaCode">ABC123</div>
                            <button type="button" class="captcha-refresh" id="refreshCaptcha" title="Làm mới mã xác nhận">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </div>
                        <div class="input-container">
                            <input type="text" class="captcha-input" id="captchaInput" name="captcha" placeholder="Nhập mã xác nhận" required maxlength="6">
                            <i class="fas fa-shield-alt input-icon"></i>
                        </div>
                        <div class="captcha-error" id="captchaError">Mã xác nhận không đúng!</div>
                    </div>

                    <div class="form-options">
                        <label class="remember-wrapper">
                            <input type="checkbox" class="checkbox" name="rememberMe" id="remember">
                            <span>Ghi nhớ tôi</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-password">Quên mật khẩu?</a>
                    </div>

                    <button type="submit" class="login-button" id="loginBtn">
                        Đăng nhập
                    </button>
                </form>

                <div class="divider">
                    <span>hoặc</span>
                </div>

                <!-- Google Sign-In -->
                <script src="https://accounts.google.com/gsi/client" async defer></script>
                
                <div id="g_id_onload"
                     data-client_id="857502113791-0i40c794o3g4h9hped4lhjb77t7h7mn3.apps.googleusercontent.com"
                     data-context="signin"
                     data-ux_mode="redirect"
                     data-login_uri="http://localhost:8080/Project_SWP_2/oauth2handler"
                     data-auto_prompt="false">
                </div>

                <div class="g_id_signin"
                     data-type="standard"
                     data-size="large"
                     data-theme="outline"
                     data-text="sign_in_with"
                     data-shape="rectangular"
                     data-logo_alignment="left">
                </div>
                <br>

                <p class="register-text">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="register-link">Đăng ký ngay</a>
                </p>
            </div>
        </div>

        <script>
            // CAPTCHA functionality
            let currentCaptcha = '';
            
            function generateCaptcha() {
                const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                let result = '';
                for (let i = 0; i < 6; i++) {
                    result += chars.charAt(Math.floor(Math.random() * chars.length));
                }
                return result;
            }
            
            function updateCaptcha() {
                currentCaptcha = generateCaptcha();
                document.getElementById('captchaCode').textContent = currentCaptcha;
                document.getElementById('captchaInput').value = '';
                document.getElementById('captchaError').style.display = 'none';
                document.getElementById('captchaInput').style.borderColor = '#dee2e6';
            }
            
            function validateCaptcha() {
                const userInput = document.getElementById('captchaInput').value.toUpperCase();
                return userInput === currentCaptcha;
            }
            
            // Initialize CAPTCHA
            updateCaptcha();
            
            // Refresh CAPTCHA button
            document.getElementById('refreshCaptcha').addEventListener('click', function() {
                updateCaptcha();
                this.style.transform = 'rotate(360deg)';
                setTimeout(() => {
                    this.style.transform = 'rotate(0deg)';
                }, 300);
            });
            
            // CAPTCHA input validation
            document.getElementById('captchaInput').addEventListener('input', function() {
                this.value = this.value.toUpperCase();
                if (this.value.length === 6) {
                    if (validateCaptcha()) {
                        this.style.borderColor = '#28a745';
                        document.getElementById('captchaError').style.display = 'none';
                    } else {
                        this.style.borderColor = '#dc3545';
                        document.getElementById('captchaError').style.display = 'block';
                    }
                } else {
                    this.style.borderColor = '#dee2e6';
                    document.getElementById('captchaError').style.display = 'none';
                }
            });
            
            // Form submission with CAPTCHA validation
            document.getElementById('loginForm').addEventListener('submit', function(e) {
                if (!validateCaptcha()) {
                    e.preventDefault();
                    document.getElementById('captchaError').style.display = 'block';
                    document.getElementById('captchaInput').style.borderColor = '#dc3545';
                    document.getElementById('captchaInput').focus();
                    return false;
                }
                
                const btn = document.getElementById('loginBtn');
                btn.classList.add('loading');
                btn.disabled = true;
                
                // Add captcha value to form data
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'captchaCode';
                hiddenInput.value = currentCaptcha;
                this.appendChild(hiddenInput);
                
                setTimeout(() => {
                    btn.classList.remove('loading');
                    btn.disabled = false;
                }, 3000);
            });

            // Enhanced input interactions
            document.querySelectorAll('.form-input, .captcha-input').forEach(input => {
                input.addEventListener('focus', function() {
                    const label = this.closest('.form-group').querySelector('.form-label');
                    if (label) {
                        label.style.color = '#dc3545';
                    }
                });
                
                input.addEventListener('blur', function() {
                    const label = this.closest('.form-group').querySelector('.form-label');
                    if (label) {
                        label.style.color = '#495057';
                    }
                });
            });

            // Auto-refresh CAPTCHA every 5 minutes for security
            setInterval(updateCaptcha, 300000);
            
            // Prevent right-click on CAPTCHA
            document.getElementById('captchaCode').addEventListener('contextmenu', function(e) {
                e.preventDefault();
            });
            
            // Prevent text selection on CAPTCHA
            document.getElementById('captchaCode').addEventListener('selectstart', function(e) {
                e.preventDefault();
            });
        </script>
    </body>
</html>