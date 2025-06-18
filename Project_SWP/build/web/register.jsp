<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background: #1da1f2;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
            width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 28px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
            text-align: left;
        }

        .input-field {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #ccc;
            border-radius: 25px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-field:focus {
            outline: none;
            border-color: #1da1f2;
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 16px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #1da1f2;
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #1a91da;
        }

        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #1da1f2;
            text-decoration: none;
            display: inline-block;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Register</h2>

    <form action="register" method="post">
        <!-- Username -->
        <div class="input-group">
            <span class="input-icon">&#128100;</span>
            <input type="text" class="input-field" name="username" placeholder="Username" required>
        </div>

        <!-- Password -->
        <div class="input-group">
            <span class="input-icon">&#128274;</span>
            <input type="password" class="input-field" name="password" placeholder="Password" required>
        </div>

        <!-- Confirm Password -->
        <div class="input-group">
            <span class="input-icon">&#128274;</span>
            <input type="password" class="input-field" name="confirm_password" placeholder="Confirm Password" required>
        </div>

        <!-- Email -->
        <div class="input-group">
            <span class="input-icon">&#9993;</span>
            <input type="email" class="input-field" name="email" placeholder="Email" required>
        </div>

        <!-- Phone -->
        <div class="input-group">
            <span class="input-icon">&#128222;</span>
            <input type="text" class="input-field" name="phone_number" placeholder="Phone Number" required>
        </div>

        <!-- Hidden role -->
        <input type="hidden" name="role" value="user"/>

        <!-- Submit -->
        <button type="submit" class="btn">Register</button>
    </form>

    <!-- Error message -->
    <c:if test="${not empty error}">
        <span class="error-message">${error}</span>
    </c:if>

    <!-- Login -->
    <a href="login" class="login-link">Login here</a>
</div>

</body>
</html>
