<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }

        .reset-container {
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
            text-align: left;
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

        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #1da1f2;
            text-decoration: none;
        }

        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="notification-wrapper" style="
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;">
        <c:import url="notification.jsp" />
    </div>

    <div class="reset-container">
        <h2>Reset Password</h2>
       <form action="resetPassword" method="post">
    <input type="hidden" name="token" value="${token}" />

    <div class="input-group">
        <span class="input-icon">&#128274;</span>
        <input type="password" class="input-field" name="password" placeholder="New Password" required />
    </div>

    <div class="input-group">
        <span class="input-icon">&#128274;</span>
        <input type="password" class="input-field" name="confirm_password" placeholder="Confirm New Password" required />
    </div>

    <button type="submit" class="btn">Update Password</button>
</form>

        <a href="login" class="login-link">Back to Login</a>
    </div>
</body>
</html>
