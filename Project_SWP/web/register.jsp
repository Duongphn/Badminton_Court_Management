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
            width: 600px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 28px;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px 20px;
            margin-bottom: 15px;
        }
        .input-group {
            position: relative;
            text-align: left;
        }
        .input-field, select, textarea {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #ccc;
            border-radius: 25px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        .input-field:focus, select:focus, textarea:focus {
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
        .role-group {
            text-align: left;
            margin-bottom: 20px;
        }
        .role-group label {
            font-size: 14px;
            margin-right: 20px;
        }
        .staff-fields {
            display: none; /* Mặc định ẩn */
            margin-top: 10px;
            animation: fadeIn 0.3s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Register</h2>

    <form action="register" method="post">
        <!-- Grid 2 cột -->
        <div class="form-grid">

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

            <!-- Phone Number -->
            <div class="input-group">
                <span class="input-icon">&#128222;</span>
                <input type="text" class="input-field" name="phone_number" placeholder="Phone Number" required>
            </div>

            <!-- Role -->
            <div class="role-group" style="grid-column: span 2;">
                <label><input type="radio" name="role" value="user" checked onclick="toggleStaffFields()"> User</label>
                <label><input type="radio" name="role" value="staff" onclick="toggleStaffFields()"> Staff</label>
            </div>
        </div>

        <!-- Staff fields (full width dưới) -->
        <div class="staff-fields" id="staffFields">
            <div class="form-grid">

                <div class="input-group">
                    <span class="input-icon">&#128100;</span>
                    <input type="text" class="input-field" name="full_name" placeholder="Full Name">
                </div>

                <div class="input-group">
                    <span class="input-icon">&#9794;&#9792;</span>
                    <select name="gender" class="input-field">
                        <option value="">Select Gender</option>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>

                <div class="input-group">
                    <span class="input-icon">&#128197;</span>
                    <input type="date" class="input-field" name="date_of_birth" placeholder="Date of Birth">
                </div>

                <div class="input-group">
                    <span class="input-icon">&#127968;</span>
                    <input type="text" class="input-field" name="address" placeholder="Address">
                </div>

                <div class="input-group">
                    <span class="input-icon">&#128179;</span>
                    <input type="text" class="input-field" name="id_card_number" placeholder="ID Card Number">
                </div>

                <div class="input-group">
                    <span class="input-icon">&#127891;</span>
                    <input type="text" class="input-field" name="education_level" placeholder="Education Level">
                </div>

                <div class="input-group" style="grid-column: span 2;">
                    <span class="input-icon">&#9998;</span>
                    <textarea name="personal_notes" class="input-field" placeholder="Personal Notes" rows="3" style="resize: none; padding-left: 12px;"></textarea>
                </div>

            </div>
        </div>

        <!-- Button -->
        <button type="submit" class="btn">Register</button>
    </form>

    <a href="login" class="login-link">Login here</a>
</div>

<script>
    function toggleStaffFields() {
        var staffFields = document.getElementById("staffFields");
        var roleStaff = document.querySelector('input[name="role"][value="staff"]').checked;

        if (roleStaff) {
            staffFields.style.display = "block";
        } else {
            staffFields.style.display = "none";
        }
    }
</script>

</body>
</html>
