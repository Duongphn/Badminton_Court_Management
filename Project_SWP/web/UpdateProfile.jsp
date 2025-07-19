<%-- 
    Document   : viewprofile
    Created on : May 24, 2025, 10:02:07 AM
    Author     : sangn
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Container layout */
            .container {
                max-width: 1500px;
                margin: 30px auto;
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 30px;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
                overflow: hidden;
            }

            /* Sidebar styling */
            .sidebar {
                background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
                padding: 30px 25px;
                color: white;
            }

            .user-info {
                text-align: center;
                padding: 0 30px 30px;
                border-bottom: 1px solid #4a5568;
                margin-bottom: 30px;
            }

            .user-info img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                border: 4px solid #667eea;
                margin-bottom: 15px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .user-info img:hover {
                transform: scale(1.05);
            }

            .user-info span {
                display: block;
                font-size: 18px;
                font-weight: 600;
                color: #ecf0f1;
            }

            /* Menu styling */
            .menu {
                list-style: none;
                padding: 0 20px;
            }

            .menu li {
                margin-bottom: 12px;
            }

            .menu li strong {
                display: block;
                color: #bdc3c7;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 10px;
                margin-top: 20px;
                padding-left: 10px;
                border-left: 3px solid #667eea;
            }

            .menu li:first-child strong {
                margin-top: 0;
            }

            .menu li a {
                display: block;
                color: #ecf0f1;
                text-decoration: none;
                padding: 12px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .menu li a:hover {
                background: rgba(102, 126, 234, 0.2);
                transform: translateX(5px);
                color: #667eea;
            }

            .menu li a::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 3px;
                background: #667eea;
                transform: scaleY(0);
                transition: transform 0.3s ease;
            }

            .menu li a:hover::before {
                transform: scaleY(1);
            }

            /* Main content styling */
            .main-content {
                flex: 1;
                padding: 40px;
                background: #f8f9fa;
            }

            .main-content h1 {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 30px;
                position: relative;
                padding-bottom: 15px;
            }

            .main-content h1::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 4px;
                background: linear-gradient(90deg, #667eea, #764ba2);
                border-radius: 2px;
            }

            /* Info box styling */
            .info-box {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 40px;
                background: white;
                border-radius: 16px;
                padding: 40px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
                border: 1px solid #e2e8f0;
            }

            /* Form styling */
            #form-1 {
                display: flex;
                flex-direction: column;
                gap: 25px;
            }

            .info-row {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .info-row label {
                font-weight: 600;
                color: #4a5568;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-row input,
            .info-row select {
                padding: 15px 18px;
                border: 2px solid #e2e8f0;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: white;
                color: #2d3748;
            }

            .info-row input:focus,
            .info-row select:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                transform: translateY(-2px);
            }

            .info-row input[readonly] {
                background-color: #f7fafc;
                color: #718096;
                cursor: not-allowed;
            }

            .info-row input:hover:not([readonly]),
            .info-row select:hover {
                border-color: #cbd5e0;
            }

            /* Button styling */
            .edit-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 16px 32px;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
                margin-top: 10px;
            }

            .edit-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .edit-btn:active {
                transform: translateY(-1px);
            }

            /* Avatar section styling */
            .avt-view-profile {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .avt-view-profile img {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 4px solid #e9ecef;
                object-fit: cover;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }

            .avt-view-profile img:hover {
                transform: scale(1.05);
            }

            /* Responsive design */
            @media (max-width: 1024px) {
                .info-box {
                    grid-template-columns: 1fr;
                    gap: 30px;
                }

                .avt-view-profile {
                    order: -1;
                }

                .avt-view-profile img {
                    width: 120px;
                    height: 120px;
                }
            }

            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                    padding: 20px 0;
                }

                .user-info {
                    padding: 0 20px 20px;
                    margin-bottom: 20px;
                }

                .user-info img {
                    width: 60px;
                    height: 60px;
                }

                .menu {
                    padding: 0 15px;
                }

                .main-content {
                    padding: 30px 20px;
                }

                .main-content h1 {
                    font-size: 28px;
                }

                .info-box {
                    padding: 30px 20px;
                }
            }

            @media (max-width: 480px) {
                .main-content {
                    padding: 20px 15px;
                }

                .info-box {
                    padding: 25px 15px;
                }

                .main-content h1 {
                    font-size: 24px;
                }

                .avt-view-profile img {
                    width: 100px;
                    height: 100px;
                }
            }

            /* Custom scrollbar for webkit browsers */
            ::-webkit-scrollbar {
                width: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, #667eea, #764ba2);
                border-radius: 4px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: linear-gradient(135deg, #5a67d8, #6b46c1);
            }

            /* Loading animation for form submission */
            .edit-btn.loading {
                position: relative;
                color: transparent;
            }

            .edit-btn.loading::after {
                content: '';
                position: absolute;
                width: 20px;
                height: 20px;
                top: 50%;
                left: 50%;
                margin-left: -10px;
                margin-top: -10px;
                border: 2px solid #ffffff;
                border-radius: 50%;
                border-top-color: transparent;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            /* Success/Error message styling */
            .message {
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-weight: 500;
            }

            .message.success {
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
            }

            .message.error {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }

            /* Form validation styles */
            .info-row input:invalid:not(:focus):not(:placeholder-shown) {
                border-color: #e53e3e;
                background-color: #fed7d7;
            }

            .info-row input:valid:not(:focus):not(:placeholder-shown):not([readonly]) {
                border-color: #38a169;
                background-color: #f0fff4;
            }

        </style>

    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <jsp:include page="homehead.jsp" />

        <div class="container">
            <div class="sidebar">
                <div class="user-info">
                    <img src="./uploads/avt.jpg" alt="avt" />
                    <!--                    <p class="userName">Sáng Nguyễn</p>-->
                    <span><b><%=user.getFirstname()%> <%=user.getLastname()%></b></span>
                </div>
                <ul class="menu">
                    <li><strong>Tài khoản của tôi</strong></li>
                    <li><a href="viewprofile.jsp">Thông tin tài khoản</a></li>
                    <li><a href="change-pass">Đổi mật khẩu</a></li>
                    <li><strong>Danh sách lịch của tôi</strong></li>
                    <li><a href="#">Lịch đã đặt</a></li>
                </ul>
            </div>
            <div class="main-content">
                <h1>Thông tin cá nhân</h1>
                <c:if test="${not empty error}">
        <div style="color:red;">${error}</div>
</c:if>
                <div class="info-box">
                    <div>
                        <form id="form-1" action="updateprofile" method="post">
                            <input type="hidden" name="user_id" value="<%=user.getUser_Id()%>">
                            <div class="info-row">
                                <label>Username</label>
                                <input type="text" name="username" value="<%=user.getUsername()%>" readonly>
                            </div>
                            <div class="info-row">
                                <label>Họ</label>
                                <input type="text" name="firstname" value="<%=user.getFirstname()%>" required>
                            </div>
                            <div class="info-row">
                                <label>Tên</label>
                                <input type="text" name="lastname" value="<%=user.getLastname()%>" required>
                            </div>
                            <div class="info-row">
                                <label>Email</label>
                                <input type="email" name="email" value="<%=user.getEmail()%>" readonly>
                            </div>
                            <div class="info-row">
                                <label>Phone</label>
                                <input type="tel" name="phoneNumber" value="<%=user.getPhone_number()%>" pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số">
                            </div>
                            <div class="info-row">
                                <label>Giới tính</label>
                                <select name="gender">
                                    <option value="Nam" <%= "Nam".equals(user.getGender()) ? "selected" : "" %>>Nam</option>
                                    <option value="Nữ" <%= "Nữ".equals(user.getGender()) ? "selected" : "" %>>Nữ</option>
                                    <option value="Khác" <%= "Khác".equals(user.getGender()) ? "selected" : "" %>>Khác</option>
                                </select>
                            </div>
                            <div class="info-row">
                                <label>Ngày sinh</label>
                                <input type="date" name="date_of_birth" value="<%=user.getDateOfBirth() != null ? user.getDateOfBirth().toString() : ""%>">
                            </div>
                            <div>
                                <button type="submit" class="edit-btn">Cập Nhật</button>
                            </div>
                        </form>
                    </div>
                    <div class="avt-view-profile">
                        <img src="./uploads/avt.jpg" alt="avt" />
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="homefooter.jsp" />
    </body>
</html>
