<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
             background: #1da1f2;
            margin: 0;
        }

        .forgot-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 320px;
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

        .back-link {
            margin-top: 15px;
            display: inline-block;
            font-size: 14px;
            color: #1da1f2;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="notification-wrapper" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">
        <jsp:include page="notification.jsp"/>
    </div>

    <div class="forgot-container">
        <h2>Quên Mật Khẩu</h2>
        <form action="forgotPassword" method="post">
            <div class="input-group">
                <span class="input-icon">&#128100;</span>
                <input type="text" class="input-field" name="username" placeholder="Username" required />
            </div>
            <div class="input-group">
                <span class="input-icon">&#9993;</span>
                <input type="email" class="input-field" name="email" placeholder="Email" required />
            </div>
            <button type="submit" class="btn">Khôi phục</button>
        </form>
        <a href="login" class="back-link">Quay lại đăng nhập</a>
    </div>

</body>
</html>
