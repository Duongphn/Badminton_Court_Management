<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng Ký - Sân Cầu Lông</title>
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

            /* Right side - Register form */
            .right-panel {
                flex: 1;
                background: #ffffff;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 60px 40px;
                position: relative;
            }

            .register-container {
                width: 100%;
                max-width: 450px;
                background: #ffffff;
                border-radius: 16px;
                padding: 40px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                border: 1px solid #e9ecef;
                max-height: 90vh;
                overflow-y: auto;
            }

            .register-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .register-title {
                font-size: 32px;
                font-weight: 600;
                color: #212529;
                margin-bottom: 8px;
            }

            .register-subtitle {
                font-size: 16px;
                color: #6c757d;
                font-weight: 400;
            }

            .form-group {
                margin-bottom: 20px;
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

            .form-select {
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
                cursor: pointer;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 12px center;
                background-repeat: no-repeat;
                background-size: 16px;
            }

            .form-input:focus, .form-select:focus {
                border-color: #dc3545;
                box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            }

            .form-input:focus + .input-icon, .form-select:focus + .input-icon {
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
                pointer-events: none;
                z-index: 1;
            }

            .form-row {
                display: flex;
                gap: 15px;
            }

            .form-row .form-group {
                flex: 1;
            }

            .terms-wrapper {
                display: flex;
                align-items: flex-start;
                gap: 10px;
                margin-bottom: 25px;
                font-size: 14px;
                color: #495057;
                line-height: 1.5;
            }

            .checkbox {
                width: 18px;
                height: 18px;
                accent-color: #dc3545;
                margin-top: 2px;
                flex-shrink: 0;
            }

            .terms-link {
                color: #dc3545;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .terms-link:hover {
                color: #c82333;
            }

            .register-button {
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

            .register-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(220, 53, 69, 0.2);
            }

            .register-button:active {
                transform: translateY(0);
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 25px 0;
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
                margin-bottom: 25px;
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

            .login-text {
                text-align: center;
                color: #6c757d;
                font-size: 14px;
            }

            .login-link {
                color: #dc3545;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .login-link:hover {
                color: #c82333;
            }

            .notification-wrapper {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
            }

            /* Password strength indicator */
            .password-strength {
                margin-top: 8px;
                font-size: 12px;
            }

            .strength-bar {
                width: 100%;
                height: 4px;
                background: #dee2e6;
                border-radius: 2px;
                margin: 5px 0;
                overflow: hidden;
            }

            .strength-fill {
                height: 100%;
                width: 0%;
                transition: all 0.3s ease;
                border-radius: 2px;
            }

            .strength-weak .strength-fill {
                width: 33%;
                background: #dc3545;
            }

            .strength-medium .strength-fill {
                width: 66%;
                background: #fd7e14;
            }

            .strength-strong .strength-fill {
                width: 100%;
                background: #28a745;
            }

            /* Error styles */
            .form-input.error, .form-select.error {
                border-color: #dc3545;
                box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            }

            .error-message {
                color: #dc3545;
                font-size: 12px;
                margin-top: 5px;
                display: none;
            }

            .error-message.show {
                display: block;
            }

            
            /* Modal Styles */
.terms-modal {
    display: none;
    position: fixed;
    z-index: 9999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, rgba(0, 0, 0, 0.8), rgba(30, 30, 30, 0.9));
    backdrop-filter: blur(5px);
    overflow: auto;
    animation: fadeIn 0.3s ease-out;
}

.terms-modal-content {
    background: linear-gradient(145deg, #ffffff, #f8f9fa);
    margin: 3% auto;
    padding: 40px;
    border: none;
    width: 85%;
    max-width: 700px;
    border-radius: 20px;
    box-shadow: 
        0 25px 50px rgba(0, 0, 0, 0.25),
        0 10px 20px rgba(0, 0, 0, 0.1),
        inset 0 1px 0 rgba(255, 255, 255, 0.2);
    position: relative;
    transform: translateY(-20px);
    animation: slideIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    overflow: hidden;
}

.terms-modal-content::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2, #f093fb, #f5576c);
    background-size: 300% 100%;
    animation: gradientShift 3s ease infinite;
}

.close {
    color: #888;
    font-size: 32px;
    font-weight: 300;
    position: absolute;
    top: 15px;
    right: 25px;
    transition: all 0.3s ease;
    cursor: pointer;
    z-index: 10;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background: rgba(0, 0, 0, 0.05);
}

.close:hover,
.close:focus {
    color: #e74c3c;
    background: rgba(231, 76, 60, 0.1);
    transform: rotate(90deg) scale(1.1);
}

.close-btn {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 12px 30px;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 
        0 8px 20px rgba(102, 126, 234, 0.3),
        0 2px 4px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
    margin-top: 20px;
}

.close-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

.close-btn:hover {
    transform: translateY(-2px);
    box-shadow: 
        0 12px 25px rgba(102, 126, 234, 0.4),
        0 4px 8px rgba(0, 0, 0, 0.15);
}

.close-btn:hover::before {
    left: 100%;
}

.close-btn:active {
    transform: translateY(0);
    box-shadow: 
        0 4px 10px rgba(102, 126, 234, 0.3),
        0 1px 2px rgba(0, 0, 0, 0.1);
}

/* Enhanced modal title styling */
.terms-modal-content h2 {
    color: #2c3e50;
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e9ecef;
    position: relative;
}

.terms-modal-content h2::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 60px;
    height: 2px;
    background: linear-gradient(90deg, #667eea, #764ba2);
    border-radius: 2px;
}

/* Enhanced content styling */
.terms-modal-content p {
    color: #555;
    line-height: 1.7;
    font-size: 16px;
    margin-bottom: 15px;
}

/* Responsive design */
@media (max-width: 768px) {
    .terms-modal-content {
        width: 95%;
        margin: 5% auto;
        padding: 30px 20px;
        border-radius: 15px;
    }
    
    .close {
        top: 10px;
        right: 15px;
        font-size: 28px;
    }
    
    .close-btn {
        width: 100%;
        padding: 15px;
        font-size: 14px;
    }
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-50px) scale(0.9);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

@keyframes gradientShift {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
    .terms-modal {
        background: linear-gradient(135deg, rgba(0, 0, 0, 0.9), rgba(15, 15, 15, 0.95));
    }
    
    .terms-modal-content {
        background: linear-gradient(145deg, #2c2c2c, #1a1a1a);
        color: #e0e0e0;
    }
    
    .terms-modal-content h2 {
        color: #f0f0f0;
        border-bottom-color: #444;
    }
    
    .terms-modal-content p {
        color: #ccc;
    }
    
    .close {
        color: #bbb;
        background: rgba(255, 255, 255, 0.1);
    }
    
    .close:hover {
        color: #ff6b6b;
        background: rgba(255, 107, 107, 0.2);
    }
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
                
                .register-title {
                    font-size: 24px;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .register-container {
                    max-height: none;
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

        <!-- Right Panel - Register Form -->
        <div class="right-panel">
            <div class="register-container">
                <div class="register-header">
                    <h2 class="register-title">Tạo tài khoản mới</h2>
                    <p class="register-subtitle">Đăng ký để bắt đầu đặt sân cầu lông</p>
                </div>

                <form action="register" method="post" id="registerForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="firstName">Họ</label>
                            <div class="input-container">
                                <input type="text" class="form-input" id="firstName" name="firstname" placeholder="Nhập họ của bạn" required>
                                <i class="fas fa-user input-icon"></i>
                            </div>
                            <div class="error-message" id="firstNameError">Vui lòng nhập họ</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="lastName">Tên</label>
                            <div class="input-container">
                                <input type="text" class="form-input" id="lastName" name="lastname" placeholder="Nhập tên của bạn" required>
                                <i class="fas fa-user input-icon"></i>
                            </div>
                            <div class="error-message" id="lastNameError">Vui lòng nhập tên</div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="gender">Giới tính</label>
                            <div class="input-container">
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="">Chọn giới tính</option>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                    <option value="Khác">Khác</option>
                                </select>
                                <i class="fas fa-venus-mars input-icon"></i>
                            </div>
                            <div class="error-message" id="genderError">Vui lòng chọn giới tính</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="birthDate">Ngày sinh</label>
                            <div class="input-container">
                                <input type="date" class="form-input" id="birthDate" name="date_of_birth" required>
                                <i class="fas fa-calendar input-icon"></i>
                            </div>
                            <div class="error-message" id="birthDateError">Vui lòng chọn ngày sinh</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="username">Tên đăng nhập</label>
                        <div class="input-container">
                            <input type="text" class="form-input" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
                            <i class="fas fa-user-circle input-icon"></i>
                        </div>
                        <div class="error-message" id="usernameError">Tên đăng nhập phải có ít nhất 3 ký tự</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email</label>
                        <div class="input-container">
                            <input type="email" class="form-input" id="email" name="email" placeholder="Nhập địa chỉ email của bạn" required>
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                        <div class="error-message" id="emailError">Vui lòng nhập email hợp lệ</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="phone">Số điện thoại</label>
                        <div class="input-container">
                            <input type="tel" class="form-input" id="phone" name="phone_number" placeholder="Nhập số điện thoại của bạn" required>
                            <i class="fas fa-phone input-icon"></i>
                        </div>
                        <div class="error-message" id="phoneError">Vui lòng nhập số điện thoại hợp lệ</div>
                    </div>


                    <div class="form-group">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <div class="input-container">
                            <input type="password" class="form-input" id="password" name="password" placeholder="Tạo mật khẩu mạnh" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                        <div class="password-strength" id="passwordStrength">
                            <div class="strength-bar">
                                <div class="strength-fill"></div>
                            </div>
                            <span class="strength-text">Mật khẩu phải có ít nhất 8 ký tự</span>
                        </div>
                        <div class="error-message" id="passwordError">Mật khẩu phải có ít nhất 8 ký tự</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu</label>
                        <div class="input-container">
                            <input type="password" class="form-input" id="confirmPassword" name="confirm_password" placeholder="Nhập lại mật khẩu" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                        <div class="error-message" id="confirmPasswordError">Mật khẩu xác nhận không khớp</div>
                    </div>

     <div class="terms-wrapper">
    <input type="checkbox" class="checkbox" name="agreeTerms" id="agreeTerms" required>
    <label for="agreeTerms">
        Tôi đã đọc và đồng ý với 
        <a href="#" class="terms-link" onclick="showTerms()">Điều khoản sử dụng</a> và 
        <a href="#" class="terms-link">Chính sách bảo mật</a> của CourtBooking
    </label>
</div>

<!-- Modal for Terms of Use -->
<div id="termsModal" class="terms-modal">
    <div class="terms-modal-content">
        <span class="close" onclick="closeTerms()">&times;</span>
        <h2>Điều khoản sử dụng</h2>
        <p><strong>Điều khoản 1: Quyền lợi người chơi</strong></p>
        <p>1. Người chơi có quyền đặt sân cầu lông qua hệ thống của CourtBooking vào bất kỳ thời gian nào.</p>
        <p>2. Người chơi có quyền yêu cầu hoàn tiền trong trường hợp sân không đáp ứng yêu cầu về chất lượng.</p>
        
        <p><strong>Điều khoản 2: Trách nhiệm của người chơi</strong></p>
        <p>1. Người chơi phải đảm bảo thực hiện đúng quy định về thời gian và việc hủy sân.</p>
        <p>2. Người chơi không được phép sử dụng sân với mục đích vi phạm pháp luật hoặc gây phiền hà cho người khác.</p>

        <p><strong>Điều khoản 3: Quy định về thanh toán</strong></p>
        <p>1. Người chơi phải thanh toán đầy đủ qua các cổng thanh toán đã được hệ thống CourtBooking hỗ trợ.</p>
        <p>2. Phí đặt sân có thể thay đổi tùy theo chính sách giá của CourtBooking và thông báo trên trang web.</p>
        
        <p><strong>Điều khoản 4: Chính sách bảo mật</strong></p>
        <p>1. CourtBooking cam kết bảo mật thông tin cá nhân của người chơi và không chia sẻ thông tin này cho bất kỳ bên thứ ba nào mà không có sự đồng ý của người chơi.</p>
        <p>2. CourtBooking sẽ chỉ sử dụng thông tin của người chơi vào mục đích cung cấp dịch vụ và nâng cao trải nghiệm người dùng.</p>

        <button class="close-btn" onclick="closeTerms()">Đóng</button>
    </div>
</div>

                    <button type="submit" class="register-button" id="registerBtn">
                        Tạo tài khoản
                    </button>
                </form>

                <div class="divider">
                    <span>hoặc</span>
                </div>

                <!-- Google Sign-In -->
                                <script src="https://accounts.google.com/gsi/client" async defer></script>
                
                <div id="g_id_onload"
                     data-client_id="857502113791-0i40c794o3g4h9hped4lhjb77t7h7mn3.apps.googleusercontent.com"
                     data-context="signup"
                     data-ux_mode="redirect"
                     data-login_uri="http://localhost:8080/Project_SWP_2/oauth2handler"
                     data-auto_prompt="false">
                </div>

                

                <div class="g_id_signin" style="display: none;"
                     data-type="standard"
                     data-size="large"
                     data-theme="outline"
                     data-text="signup_with"
                     data-shape="rectangular"
                     data-logo_alignment="left">
                </div>

                <p class="login-text">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="login-link">Đăng nhập ngay</a>
                </p>
            </div>
        </div>

        <script>
            // Form validation
            const form = document.getElementById('registerForm');
            const inputs = {
                firstName: document.getElementById('firstName'),
                lastName: document.getElementById('lastName'),
                username: document.getElementById('username'),
                email: document.getElementById('email'),
                phone: document.getElementById('phone'),
                password: document.getElementById('password'),
                confirmPassword: document.getElementById('confirmPassword')
            };

            // Validation functions
            function validateEmail(email) {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }

            function validatePhone(phone) {
                const re = /^[0-9]{10,11}$/;
                return re.test(phone);
            }

            function checkPasswordStrength(password) {
                const strength = document.getElementById('passwordStrength');
                const bar = strength.querySelector('.strength-bar');
                const text = strength.querySelector('.strength-text');
                
                if (password.length === 0) {
                    bar.className = 'strength-bar';
                    text.textContent = 'Mật khẩu phải có ít nhất 8 ký tự';
                    return;
                }
                
                let score = 0;
                if (password.length >= 8) score++;
                if (/[a-z]/.test(password)) score++;
                if (/[A-Z]/.test(password)) score++;
                if (/[0-9]/.test(password)) score++;
                if (/[^A-Za-z0-9]/.test(password)) score++;
                
                bar.className = 'strength-bar';
                if (score < 3) {
                    bar.classList.add('strength-weak');
                    text.textContent = 'Mật khẩu yếu';
                } else if (score < 5) {
                    bar.classList.add('strength-medium');
                    text.textContent = 'Mật khẩu trung bình';
                } else {
                    bar.classList.add('strength-strong');
                    text.textContent = 'Mật khẩu mạnh';
                }
            }

            // Event listener for form submission
            form.addEventListener('submit', function (e) {
                let isValid = true;

                // Check username
                if (inputs.username.value.trim().length < 3) {
                    document.getElementById('usernameError').classList.add('show');
                    isValid = false;
                } else {
                    document.getElementById('usernameError').classList.remove('show');
                }

                // Check email
                if (!validateEmail(inputs.email.value)) {
                    document.getElementById('emailError').classList.add('show');
                    isValid = false;
                } else {
                    document.getElementById('emailError').classList.remove('show');
                }

               

                // Check password
                if (inputs.password.value.length < 8) {
                    document.getElementById('passwordError').classList.add('show');
                    isValid = false;
                } else {
                    document.getElementById('passwordError').classList.remove('show');
                }

                // Check password confirmation
                if (inputs.password.value !== inputs.confirmPassword.value) {
                    document.getElementById('confirmPasswordError').classList.add('show');
                    isValid = false;
                } else {
                    document.getElementById('confirmPasswordError').classList.remove('show');
                }

                // If form is not valid, prevent submission
                if (!isValid) {
                    e.preventDefault();
                }
            });

            // Check password strength
            inputs.password.addEventListener('input', function() {
                checkPasswordStrength(this.value);
            });
            
            // Function to show the Terms modal
function showTerms() {
    document.getElementById('termsModal').style.display = 'block';
}

// Function to close the Terms modal
function closeTerms() {
    document.getElementById('termsModal').style.display = 'none';
}

// Close the modal if the user clicks outside of the modal content
window.onclick = function(event) {
    const modal = document.getElementById('termsModal');
    if (event.target === modal) {
        modal.style.display = "none";
    }
}


        </script>
    </body>
</html>
