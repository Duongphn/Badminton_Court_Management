<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }
        .forgot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        input {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #1da1f2;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
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
            <input type="text" name="username" placeholder="Username" required />
            <input type="email" name="email" placeholder="Email" required />
            <button type="submit">Khôi phục</button>
        </form>
        <p style="text-align:center; margin-top:10px;">
            <a href="login">Quay lại đăng nhập</a>
        </p>
    </div>
</body>
</html>
