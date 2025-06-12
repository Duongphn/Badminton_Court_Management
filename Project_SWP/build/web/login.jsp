<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
                background: #1da1f2;
                background-size: cover;
                backdrop-filter: blur(5px);
                -webkit-backdrop-filter: blur(5px);
            }
            .login-container {
                background: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                width: 300px;
                text-align: center;
            }
            h2 {
                margin-bottom: 20px;
                color: #333;
                font-size: 24px;
            }
            .input-group {
                position: relative;
                margin-bottom: 15px;
            }
            .input-field {
                width: 100%;
                padding: 10px 10px 10px 40px;
                border: 1px solid #ccc;
                border-radius: 25px;
                box-sizing: border-box;
                font-size: 14px;
            }
            .input-field:focus {
                outline: none;
                border-color: #1da1f2;
            }
            .input-icon {
                position: absolute;
                left: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
                font-size: 16px;
            }
            .remember-me {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                margin: 10px 0;
                font-size: 14px;
            }
            .btn {
                width: 100%;
                padding: 10px;
                background-color: #1da1f2;
                color: #fff;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
            }
            .btn:hover {
                background-color: #1a91da;
            }
            .forgot-password, .register {
                display: block;
                margin-top: 10px;
                color: #1da1f2;
                text-decoration: none;
                font-size: 14px;
            }
            .forgot-password:hover, .register:hover {
                text-decoration: underline;
            }
            .g-divider {
                text-align: center;
                margin: 15px 0;
                position: relative;
            }
            .g-divider::before, .g-divider::after {
                content: "";
                position: absolute;
                top: 50%;
                width: 40%;
                height: 1px;
                background-color: #ccc;
            }
            .g-divider::before {
                left: 0;
            }
            .g-divider::after {
                right: 0;
            }
        </style>
    </head>
    <body>

        <div class="notification-wrapper" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">
            <c:import url="notification.jsp" />
        </div>

        <div class="login-container">
            <h2>Login</h2>

            <form action="login" method="post">
                <div class="input-group">
                    <span class="input-icon">&#128100;</span>
                    <input type="text" class="input-field" name="username" placeholder="Username">
                </div>
                <div class="input-group">
                    <span class="input-icon">&#128274;</span>
                    <input type="password" class="input-field" name="password" placeholder="Password">
                </div>
                <div class="remember-me">
                    <input type="checkbox" name="rememberMe" id="remember">
                    <label for="remember">Remember Me</label>
                </div>
                <button type="submit" class="btn">Submit</button>
            </form>

            <div class="g-divider">hoặc</div>

            <!-- Google Sign-In script -->
            <script src="https://accounts.google.com/gsi/client" async defer></script>

            <!-- Google Sign-In Button -->
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

            <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-password">Forgot Password?</a>
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register" class="register">Register</a></p>
        </div>

    </body>
</html>
