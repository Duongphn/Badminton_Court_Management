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

            .sidebar {
                background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
                padding: 30px 25px;
                color: white;
            }

            .user-info {
                text-align: center;
                margin-bottom: 40px;
                padding-bottom: 25px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }

            .user-info img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                border: 3px solid rgba(255, 255, 255, 0.3);
                margin-bottom: 15px;
                object-fit: cover;
            }

            .user-info span {
                display: block;
                font-size: 18px;
                font-weight: 600;
                color: white;
            }

            .menu {
                list-style: none;
            }

            .menu li {
                margin-bottom: 15px;
            }

            .menu li strong {
                display: block;
                font-size: 16px;
                color: #fff;
                margin-bottom: 10px;
                padding-bottom: 8px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }

            .menu li a {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                font-size: 14px;
                padding: 8px 15px;
                border-radius: 8px;
                display: block;
                transition: all 0.3s ease;
            }

            .menu li a:hover {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                transform: translateX(5px);
            }

            .main-content {
                padding: 40px;
            }

            .main-content h1 {
                color: #333;
                font-size: 28px;
                margin-bottom: 30px;
                font-weight: 600;
                position: relative;
            }

            .main-content h1::after {
                content: '';
                width: 60px;
                height: 3px;
                background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
                display: block;
                margin-top: 10px;
                border-radius: 2px;
            }

            .info-box {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 40px;
                background: white;
                padding: 35px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .info-row {
                display: grid;
                grid-template-columns: 150px 1fr;
                gap: 20px;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-row label {
                font-weight: 600;
                color: #555;
                font-size: 14px;
            }

            .info-row p {
                color: #333;
                font-size: 15px;
                padding: 8px 15px;
                background: #f8f9fa;
                border-radius: 8px;
                border: 1px solid #e9ecef;
            }
            
            .sumit a{
                text-decoration: none;
            }
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

            .edit-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 25px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
                margin-top: 20px;
            }

            .edit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .edit-btn:active {
                transform: translateY(0);
            }

            /* Badge styles for badminton theme */
            .badge {
                display: inline-block;
                background: linear-gradient(45deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                padding: 4px 12px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
                margin-left: 10px;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .container {
                    grid-template-columns: 1fr;
                    margin: 20px;
                    gap: 0;
                }

                .sidebar {
                    order: 2;
                    padding: 20px;
                }

                .main-content {
                    order: 1;
                    padding: 20px;
                }

                .info-box {
                    grid-template-columns: 1fr;
                    gap: 20px;
                    padding: 20px;
                }

                .info-row {
                    grid-template-columns: 1fr;
                    gap: 8px;
                }

                .avt-view-profile img {
                    width: 120px;
                    height: 120px;
                }
            }

            /* Animation for smooth loading */
            .container {
                animation: fadeInUp 0.6s ease;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Hover effects for info rows */
            .info-row:hover {
                background: rgba(79, 172, 254, 0.02);
                border-radius: 8px;
                transition: all 0.3s ease;
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
                <div class="info-box">
                    <div>

                        <div class="info-row">
                            <label>Tên đăng nhập</label>
                            <p><%=user.getUsername()%></p>
                        </div>
                        <div class="info-row">
                            <label>Họ và tên</label>
                            <p><%=user.getFirstname()%> <%=user.getLastname()%></p>
                        </div>
                        <div class="info-row">
                            <label>Họ</label>
                            <p><%=user.getFirstname()%></p>
                        </div>
                        <div class="info-row">
                            <label>Tên</label>
                            <p><%=user.getLastname()%></p>
                        </div>
                        <div class="info-row">
                            <label>Email</label>
                            <p><%=user.getEmail()%></p>
                        </div>
                        <div class="info-row">
                            <label>Số điện thoại</label>
                            <p><%=user.getPhone_number()%></p>
                        </div>
                        <div class="info-row">
                            <label>Giới tính</label>
                            <p><%=user.getGender()%></p>
                        </div>
                        <div class="info-row">
                            <label>Ngày sinh</label>
                            <p><%=user.getDateOfBirth()%></p>
                        </div>
                        <div class="sumit">
                            <a href="UpdateProfile.jsp" class="edit-btn">Sửa</a>
                        </div>

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
