<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* Animated background elements */
        body::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(220, 53, 69, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(220, 53, 69, 0.2) 0%, transparent 50%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .notification-wrapper {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        .reset-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 40px 35px;
            border-radius: 20px;
            box-shadow: 
                0 8px 32px rgba(31, 38, 135, 0.37),
                0 4px 16px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.18);
            position: relative;
            z-index: 1;
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

        .reset-header {
            margin-bottom: 30px;
        }

        .reset-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #dc3545, #e3342f);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 24px;
            color: white;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
        }

        h2 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #666;
            font-size: 14px;
            margin-bottom: 0;
        }

        .form-container {
            margin-bottom: 25px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-field {
            width: 100%;
            padding: 16px 16px 16px 50px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
            outline: none;
        }

        .input-field:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            background: white;
        }

        .input-field::placeholder {
            color: #999;
            font-weight: 400;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #dc3545;
            z-index: 2;
        }

        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 16px;
            transition: color 0.3s ease;
            z-index: 2;
        }

        .password-toggle:hover {
            color: #dc3545;
        }

        .btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #dc3545 0%, #e3342f 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.6);
        }

        .btn:active {
            transform: translateY(0);
        }

        .divider {
            margin: 25px 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e1e5e9;
        }

        .login-link {
            display: inline-flex;
            align-items: center;
            color: #dc3545;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .login-link:hover {
            background: rgba(220, 53, 69, 0.1);
            transform: translateX(-3px);
        }

        .login-link::before {
            content: '←';
            margin-right: 8px;
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .login-link:hover::before {
            transform: translateX(-3px);
        }

        /* Password strength indicator */
        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e1e5e9;
            border-radius: 2px;
            overflow: hidden;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .password-strength.show {
            opacity: 1;
        }

        .strength-bar {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .strength-weak { background: #ff4757; width: 33%; }
        .strength-medium { background: #ffa726; width: 66%; }
        .strength-strong { background: #2ed573; width: 100%; }

        /* Responsive design */
        @media (max-width: 480px) {
            .reset-container {
                padding: 30px 25px;
                margin: 10px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            .input-field {
                padding: 14px 14px 14px 45px;
            }
            
            .btn {
                padding: 14px;
            }
        }

        /* Loading state */
        .btn.loading {
            pointer-events: none;
            opacity: 0.7;
        }

        .btn.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            margin: auto;
            border: 2px solid transparent;
            border-top-color: white;
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
    <div class="notification-wrapper">
        <c:import url="notification.jsp" />
    </div>
    
    <div class="reset-container">
        <div class="reset-header">
            <div class="reset-icon">🔐</div>
            <h2>Đặt Lại Mật Khẩu</h2>
            <p class="subtitle">Nhập mật khẩu mới của bạn bên dưới</p>
        </div>
        
        <form action="resetPassword" method="post" class="form-container" id="resetForm">
            <input type="hidden" name="token" value="${token}" />
            
            <div class="input-group">
                <span class="input-icon">🔒</span>
                <input type="password" class="input-field" name="password" id="password" 
                       placeholder="Mật khẩu mới" required autocomplete="new-password" />
                <span class="password-toggle" onclick="togglePassword('password', this)">👁️</span>
                <div class="password-strength" id="passwordStrength">
                    <div class="strength-bar" id="strengthBar"></div>
                </div>
            </div>
            
            <div class="input-group">
                <span class="input-icon">🔒</span>
                <input type="password" class="input-field" name="confirm_password" id="confirmPassword"
                       placeholder="Xác nhận mật khẩu mới" required autocomplete="new-password" />
                <span class="password-toggle" onclick="togglePassword('confirmPassword', this)">👁️</span>
            </div>
            
            <button type="submit" class="btn" id="submitBtn">
                Cập Nhật Mật Khẩu
            </button>
        </form>
        
        <div class="divider"></div>
        
        <a href="login" class="login-link">Quay về Đăng nhập</a>
    </div>

    <script>
        // Toggle password visibility
        function togglePassword(fieldId, toggleIcon) {
            const field = document.getElementById(fieldId);
            const type = field.getAttribute('type') === 'password' ? 'text' : 'password';
            field.setAttribute('type', type);
            toggleIcon.textContent = type === 'password' ? '👁️' : '🙈';
        }

        // Password strength checker
        function checkPasswordStrength(password) {
            const strength = document.getElementById('passwordStrength');
            const bar = document.getElementById('strengthBar');
            
            if (password.length === 0) {
                strength.classList.remove('show');
                return;
            }
            
            strength.classList.add('show');
            
            let score = 0;
            if (password.length >= 8) score++;
            if (/[a-z]/.test(password)) score++;
            if (/[A-Z]/.test(password)) score++;
            if (/[0-9]/.test(password)) score++;
            if (/[^A-Za-z0-9]/.test(password)) score++;
            
            bar.className = 'strength-bar';
            if (score < 3) {
                bar.classList.add('strength-weak');
            } else if (score < 5) {
                bar.classList.add('strength-medium');
            } else {
                bar.classList.add('strength-strong');
            }
        }

        // Form validation
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Mật khẩu không khớp!');
                return false;
            }
            
            if (password.length < 6) {
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
            
            return true;
        }

        // Event listeners
        document.getElementById('password').addEventListener('input', function() {
            checkPasswordStrength(this.value);
        });

        document.getElementById('resetForm').addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
                return;
            }
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.textContent = 'Đang cập nhật...';
        });

        // Add smooth focus animations
        document.querySelectorAll('.input-field').forEach(field => {
            field.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            field.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>
