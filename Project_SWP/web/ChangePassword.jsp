<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
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
        .change-pass-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px;
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
        .error-message {
            color: red;
            margin-bottom: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="change-pass-container">
    <h2>Change Password</h2>

    <c:if test="${not empty error}">
        <div class="error-message">
            <c:choose>
                <c:when test="${error == 'username'}">
                    Username not found. Please try again!
                </c:when>
                <c:when test="${error == 'incorrect'}">
                    Old password is incorrect!
                </c:when>
                <c:when test="${error == 'mismatch'}">
                    New passwords do not match!
                </c:when>
                <c:otherwise>
                    ${error}
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <form action="change-pass" method="post" id="changePassForm">
        <div class="input-group">
            <span class="input-icon">&#128100;</span>
            <input type="text" name="username" class="input-field" placeholder="Username" required>
        </div>
        <div class="input-group">
            <span class="input-icon">&#128274;</span>
            <input type="password" name="old-password" class="input-field" placeholder="Old Password" required>
        </div>
        <div class="input-group">
            <span class="input-icon">&#128274;</span>
            <input type="password" name="new-password" class="input-field" placeholder="New Password" required>
        </div>
        <div class="input-group">
            <span class="input-icon">&#128274;</span>
            <input type="password" name="confirm-password" class="input-field" placeholder="Confirm New Password" required>
        </div>
        <button type="submit" class="btn">Change Password</button>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('changePassForm');
        const newPassword = document.querySelector('input[name="new-password"]');
        const confirmPassword = document.querySelector('input[name="confirm-password"]');

        form.addEventListener('submit', function (e) {
            if (newPassword.value !== confirmPassword.value) {
                e.preventDefault();
                alert("New passwords do not match. Please re-enter.");
            }
        });
    });
</script>

</body>
</html>
