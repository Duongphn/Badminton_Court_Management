<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu - Sân Cầu Lông</title>
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
            overflow-x: hidden;
        }

        /* Badminton court background pattern */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px),
                linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            opacity: 0.3;
            z-index: 0;
        }

        .floating-shuttlecock {
            position: absolute;
            font-size: 30px;
            opacity: 0.2;
            animation: float 6s ease-in-out infinite;
            z-index: 1;
        }

        .shuttlecock-1 { top: 10%; left: 10%; animation-delay: 0s; }
        .shuttlecock-2 { top: 20%; right: 15%; animation-delay: 2s; }
        .shuttlecock-3 { bottom: 30%; left: 20%; animation-delay: 4s; }
        .shuttlecock-4 { bottom: 15%; right: 10%; animation-delay: 1s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        .change-pass-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 420px;
            text-align: center;
            position: relative;
            overflow: hidden;
            z-index: 10;
            border: 3px solid rgba(255, 255, 255, 0.3);
        }

        .change-pass-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #B22222, #FF6347, #DC143C);
        }

        .header-section {
            margin-bottom: 35px;
        }

        .badminton-logo {
            font-size: 50px;
            margin-bottom: 15px;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }

        h2 {
            color: #B22222;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        .input-group {
            position: relative;
            margin-bottom: 25px;
            text-align: left;
        }

        .input-field {
            width: 100%;
            padding: 16px 16px 16px 55px;
            border: 2px solid #e1e5e9;
            border-radius: 15px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .input-field:focus {
            outline: none;
            border-color: #FF6347;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(255, 99, 71, 0.1);
            transform: translateY(-2px);
        }

        .input-field:valid {
            border-color: #B22222;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
            transition: all 0.3s ease;
            z-index: 2;
        }

        .input-field:focus + .input-icon {
            transform: translateY(-50%) scale(1.1);
        }

        .btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #B22222 0%, #FF6347 50%, #DC143C 100%);
            color: #fff;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 700;
            transition: all 0.3s ease;
            margin-top: 15px;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(178, 34, 34, 0.4);
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:active {
            transform: translateY(-1px);
        }

        .error-message {
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
            animation: slideInShake 0.5s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .success-message {
            background: linear-gradient(135deg, #51cf66, #40c057);
            color: white;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 8px 25px rgba(81, 207, 102, 0.3);
            animation: slideInSuccess 0.5s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        @keyframes slideInShake {
            0% { opacity: 0; transform: translateX(-20px); }
            50% { opacity: 1; transform: translateX(5px); }
            100% { opacity: 1; transform: translateX(0); }
        }

        @keyframes slideInSuccess {
            0% { opacity: 0; transform: translateY(-20px) scale(0.8); }
            50% { transform: translateY(5px) scale(1.05); }
            100% { opacity: 1; transform: translateY(0) scale(1); }
        }

        .password-strength {
            margin-top: 8px;
            height: 6px;
            background: #e1e5e9;
            border-radius: 3px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.4s ease;
            border-radius: 3px;
        }

        .strength-weak { background: linear-gradient(90deg, #ff6b6b, #ff5252); width: 25%; }
        .strength-fair { background: linear-gradient(90deg, #ffa726, #ff9800); width: 50%; }
        .strength-good { background: linear-gradient(90deg, #66bb6a, #4caf50); width: 75%; }
        .strength-strong { background: linear-gradient(90deg, #B22222, #FF6347); width: 100%; }

        .form-footer {
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px solid #e1e5e9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .back-link {
            color: #B22222;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .back-link:hover {
            color: #DC143C;
            transform: translateX(-3px);
        }

        .court-info {
            font-size: 12px;
            color: #666;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        @media (max-width: 480px) {
            .change-pass-container {
                padding: 30px 25px;
                margin: 15px;
            }
            
            h2 {
                font-size: 22px;
            }

            .badminton-logo {
                font-size: 40px;
            }

            .form-footer {
                flex-direction: column;
                gap: 15px;
            }
        }

        .loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .loading .btn {
            background: #ccc;
        }

        /* Racket animation for loading */
        .racket-spin {
            display: inline-block;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<!-- Floating shuttlecocks -->
<div class="floating-shuttlecock shuttlecock-1">🏸</div>
<div class="floating-shuttlecock shuttlecock-2">🏸</div>
<div class="floating-shuttlecock shuttlecock-3">🏸</div>
<div class="floating-shuttlecock shuttlecock-4">🏸</div>

<div class="change-pass-container">
    <div class="header-section">
        <div class="badminton-logo">🏸</div>
        <h2>Đổi Mật Khẩu</h2>
        <div class="subtitle">Hệ thống quản lý sân cầu lông</div>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            <span>⚠️</span>
            <div>
                <c:choose>
                    <c:when test="${error == 'username'}">
                        Không tìm thấy tài khoản! Vui lòng thử lại.
                    </c:when>
                    <c:when test="${error == 'incorrect'}">
                        Mật khẩu cũ không đúng! Vui lòng kiểm tra lại.
                    </c:when>
                    <c:when test="${error == 'mismatch'}">
                        Mật khẩu mới không khớp! Vui lòng nhập lại.
                    </c:when>
                    <c:otherwise>
                        ${error}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-message">
            <span>🎉</span>
            <div>Đổi mật khẩu thành công! Chúc bạn chơi cầu lông vui vẻ!</div>
        </div>
    </c:if>

    <form action="change-pass" method="post" id="changePassForm">
        <div class="input-group">
            <input type="text" name="username" class="input-field" placeholder="Tên đăng nhập" required>
            <span class="input-icon">👤</span>
        </div>
        
        <div class="input-group">
            <input type="password" name="old-password" class="input-field" placeholder="Mật khẩu hiện tại" required>
            <span class="input-icon">🔐</span>
        </div>
        
        <div class="input-group">
            <input type="password" name="new-password" class="input-field" placeholder="Mật khẩu mới" required id="newPassword">
            <span class="input-icon">🗝️</span>
            <div class="password-strength">
                <div class="password-strength-bar" id="strengthBar"></div>
            </div>
        </div>
        
        <div class="input-group">
            <input type="password" name="confirm-password" class="input-field" placeholder="Xác nhận mật khẩu mới" required id="confirmPassword">
            <span class="input-icon">✅</span>
        </div>
        
        <button type="submit" class="btn" id="submitBtn">
            🏸 Đổi Mật Khẩu
        </button>
        
        <div class="form-footer">
            <a href="login.jsp" class="back-link">
                <span>🏃‍♂️</span> Quay lại đăng nhập
            </a>
            <div class="court-info">
                <span>🏟️</span> Sân cầu lông
            </div>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('changePassForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('strengthBar');
        const submitBtn = document.getElementById('submitBtn');

        // Password strength checker
        function checkPasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            return strength;
        }

        newPassword.addEventListener('input', function() {
            const strength = checkPasswordStrength(this.value);
            const strengthBar = document.getElementById('strengthBar');
            
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

        // Real-time password match validation
        function validatePasswordMatch() {
            if (confirmPassword.value && newPassword.value !== confirmPassword.value) {
                confirmPassword.style.borderColor = '#dc3545';
                return false;
            } else if (confirmPassword.value) {
                confirmPassword.style.borderColor = '#B22222';
                return true;
            }
            return true;
        }

        confirmPassword.addEventListener('input', validatePasswordMatch);
        newPassword.addEventListener('input', validatePasswordMatch);

        form.addEventListener('submit', function (e) {
            if (newPassword.value !== confirmPassword.value) {
                e.preventDefault();
                
                // Add shake animation
                form.style.animation = 'shake 0.6s';
                setTimeout(() => form.style.animation = '', 600);
                
                // Show error styling
                confirmPassword.style.borderColor = '#dc3545';
                confirmPassword.focus();
                
                return false;
            }

            // Add loading state with badminton theme
            form.classList.add('loading');
            submitBtn.innerHTML = '<span class="racket-spin">🏸</span> Đang xử lý...';
        });

        // Add shake animation
        const style = document.createElement('style');
        style.textContent = `

            @keyframes shake {
                0%, 20%, 40%, 60%, 80% { transform: translateX(0); }
                10%, 30%, 50%, 70%, 90% { transform: translateX(-8px); }
            }
        `;
        document.head.appendChild(style);

        // Add some fun interactions
        const logo = document.querySelector('.badminton-logo');
        logo.addEventListener('click', function() {
            this.style.animation = 'none';
            setTimeout(() => {
                this.style.animation = 'bounce 0.6s ease-in-out';
            }, 10);
        });
    });
</script>

</body>
</html>
