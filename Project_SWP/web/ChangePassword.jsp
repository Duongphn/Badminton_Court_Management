<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="UTF-8">
        <title>Đổi mật khẩu</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            .container {
                max-width: 1500px;
                margin: 30px auto;
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 30px;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
                overflow: hidden;
            }
            .sidebar {
                background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
                padding: 30px 25px;
                color: white;
            }
            .user-info {
                text-align: center;
                margin-bottom: 40px;
                padding-bottom: 25px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }
            .user-info img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                border: 3px solid rgba(255, 255, 255, 0.3);
                margin-bottom: 15px;
                object-fit: cover;
            }
            .user-info span {
                display: block;
                font-size: 18px;
                font-weight: 600;
                color: white;
            }
            .menu {
                list-style: none;
            }
            .menu li {
                margin-bottom: 15px;
            }
            .menu li strong {
                display: block;
                font-size: 16px;
                color: #fff;
                margin-bottom: 10px;
                padding-bottom: 8px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }
            .menu li a {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                font-size: 14px;
                padding: 8px 15px;
                border-radius: 8px;
                display: block;
                transition: all 0.3s;
            }
            .menu li a:hover {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                transform: translateX(5px);
            }
            .main-content {
                padding: 40px;
            }
            .main-content h1 {
                color: #333;
                font-size: 28px;
                margin-bottom: 30px;
                font-weight: 600;
                position: relative;
            }
            .main-content h1::after {
                content: '';
                width: 60px;
                height: 3px;
                background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
                display: block;
                margin-top: 10px;
                border-radius: 2px;
            }
            .changepass-box {
                background: white;
                max-width: 480px;
                margin: 0 auto;
                padding: 35px 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
                border: 1px solid rgba(0,0,0,0.05);
            }
            .changepass-box form {
                margin-top: 18px;
            }
            .input-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 20px;
            }
            .input-group label {
                font-weight: 600;
                color: #555;
                margin-bottom: 7px;
                font-size: 14px;
            }
            .input-field {
                padding: 14px 15px;
                font-size: 15px;
                border-radius: 9px;
                border: 1.5px solid #e9ecef;
                background: #f8f9fa;
                transition: border-color 0.2s;
            }
            .input-field:focus {
                outline: none;
                border-color: #667eea;
                background: #fff;
            }
            .btn {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 10px;
                box-shadow: 0 4px 15px rgba(102,126,234,0.15);
            }
            .btn:hover {
                background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
                transform: translateY(-2px);
            }
            .btn:active {
                transform: translateY(0);
            }
            .form-footer {
                margin-top: 26px;
                text-align: center;
            }
            .form-footer a {
                color: #667eea;
                text-decoration: none;
                font-size: 14px;
                font-weight: 600;
                transition: color 0.2s;
            }
            .form-footer a:hover {
                color: #764ba2;
            }
            .error-message, .success-message {
                background: #ffeded;
                color: #d8000c;
                border-left: 5px solid #d8000c;
                padding: 13px 16px;
                border-radius: 8px;
                font-size: 14px;
                margin-bottom: 18px;
            }
            .success-message {
                background: #f3fff5;
                color: #267a39;
                border-left: 5px solid #267a39;
            }
            .password-strength {
                margin-top: 6px;
                height: 7px;
                background: #e9ecef;
                border-radius: 3px;
                overflow: hidden;
            }
            .password-strength-bar {
                height: 100%;
                width: 0%;
                transition: all 0.3s;
                border-radius: 3px;
            }
            .strength-weak {
                background: #ff6b6b;
                width: 25%;
            }
            .strength-fair {
                background: #ffb84d;
                width: 50%;
            }
            .strength-good {
                background: #66bb6a;
                width: 75%;
            }
            .strength-strong {
                background: #667eea;
                width: 100%;
            }
            @media (max-width: 900px) {
                .container {
                    grid-template-columns: 1fr;
                }
                .sidebar {
                    border-radius: 20px 20px 0 0;
                }
                .main-content {
                    padding: 20px;
                }
            }
            @media (max-width: 600px) {
                .container {
                    margin: 12px 0;
                }
                .sidebar {
                    display: none;
                }
                .main-content {
                    padding: 12px;
                }
                .changepass-box {
                    padding: 15px 4vw;
                }
            }
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
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <div class="container">
            <div class="sidebar">
                <div class="user-info">
                    <img src="./uploads/avt.jpg" alt="avt" />
                    <span>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <b>${sessionScope.user.firstname} ${sessionScope.user.lastname}</b>
                            </c:when>
                            <c:otherwise>
                                Tài khoản của bạn
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <ul class="menu">
                    <li><strong>Tài khoản của tôi</strong></li>
                    <li><a href="viewprofile.jsp">Thông tin tài khoản</a></li>
                    <li><a href="change-pass">Đổi mật khẩu</a></li>
                    <li><strong>Danh sách lịch của tôi</strong></li>
                    <li><a href="#">Lịch đã đặt</a></li>
                </ul>
            </div>
            <div class="main-content">
                <h1>Đổi mật khẩu</h1>
                <div class="changepass-box">
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <c:choose>
                                <c:when test="${error == 'username'}">
                                    Không tìm thấy tài khoản! Vui lòng thử lại.
                                </c:when>
                                <c:when test="${error == 'incorrect'}">
                                    Mật khẩu cũ không đúng! Vui lòng kiểm tra lại.
                                </c:when>
                                
                                <c:otherwise>
                                    ${error}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="success-message">
                            ${success}
                        </div>
                    </c:if>

                    <form action="change-pass" method="post" id="changePassForm">
                        <div class="input-group">
                            <label for="username">Tên đăng nhập</label>
                            <input type="text" name="username" class="input-field" placeholder="Tên đăng nhập" required>
                        </div>
                        <div class="input-group">
                            <label for="old-password">Mật khẩu hiện tại</label>
                            <input type="password" name="old-password" class="input-field" placeholder="Mật khẩu hiện tại" required>
                        </div>
                        <div class="input-group">
                            <label for="new-password">Mật khẩu mới</label>
                            <input type="password" name="new-password" class="input-field" placeholder="Mật khẩu mới" required id="newPassword">
                            <div class="password-strength">
                                <div class="password-strength-bar" id="strengthBar"></div>
                            </div>
                        </div>
                        <div class="input-group">
                            <label for="confirm-password">Xác nhận mật khẩu mới</label>
                            <input type="password" name="confirm-password" class="input-field" placeholder="Xác nhận mật khẩu mới" required id="confirmPassword">
                        </div>

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

                            </div>
                            <div class="captcha-error" id="captchaError">Mã xác nhận không đúng!</div>
                        </div>
                        <button type="submit" class="btn" id="submitBtn">Đổi mật khẩu</button>
                        <div class="form-footer">
                            <a href="login.jsp">Quay lại đăng nhập</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="homefooter.jsp" />
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.getElementById('changePassForm');
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');
                const strengthBar = document.getElementById('strengthBar');
                const submitBtn = document.getElementById('submitBtn');
                function checkPasswordStrength(password) {
                    let strength = 0;
                    if (password.length >= 8)
                        strength++;
                    if (password.match(/[a-z]/))
                        strength++;
                    if (password.match(/[A-Z]/))
                        strength++;
                    if (password.match(/[0-9]/))
                        strength++;
                    if (password.match(/[^a-zA-Z0-9]/))
                        strength++;
                    return strength;
                }
                newPassword.addEventListener('input', function () {
                    const strength = checkPasswordStrength(this.value);
                    strengthBar.className = 'password-strength-bar';
                    if (strength <= 2) {
                        strengthBar.classList.add('strength-weak');
                    } else if (strength === 3) {
                        strengthBar.classList.add('strength-fair');
                    } else if (strength === 4) {
                        strengthBar.classList.add('strength-good');
                    } else {
                        strengthBar.classList.add('strength-strong');
                    }
                });
              
            });
        </script>
        <script>

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


            updateCaptcha();


            document.getElementById('refreshCaptcha').addEventListener('click', function () {
                updateCaptcha();
                this.style.transform = 'rotate(360deg)';
                setTimeout(() => {
                    this.style.transform = 'rotate(0deg)';
                }, 300);
            });


            document.getElementById('captchaInput').addEventListener('input', function () {
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


            document.getElementById('loginForm').addEventListener('submit', function (e) {
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


            document.querySelectorAll('.form-input, .captcha-input').forEach(input => {
                input.addEventListener('focus', function () {
                    const label = this.closest('.form-group').querySelector('.form-label');
                    if (label) {
                        label.style.color = '#dc3545';
                    }
                });

                input.addEventListener('blur', function () {
                    const label = this.closest('.form-group').querySelector('.form-label');
                    if (label) {
                        label.style.color = '#495057';
                    }
                });
            });


            setInterval(updateCaptcha, 300000);


            document.getElementById('captchaCode').addEventListener('contextmenu', function (e) {
                e.preventDefault();
            });


            document.getElementById('captchaCode').addEventListener('selectstart', function (e) {
                e.preventDefault();
            });
        </script>
    </body>

</html>
