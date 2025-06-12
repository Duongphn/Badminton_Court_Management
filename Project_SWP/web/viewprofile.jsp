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
            .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #fafafa;
                /*                gap: 0px;                */
                padding-left:150px;
                padding-right: 150px;

            }

            .sidebar {
                width: 250px;
                /*background-color: #ffffff;*/
                padding: 20px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 30px;
            }

            .user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }

            .userName {
                font-weight: bold;
            }

            .menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .menu li {
                margin: 10px 0;
                cursor: pointer;
            }

            .menu li a {
                text-decoration: none;
                color: black;
            }

            .main-content {
                flex-grow: 1;
                padding: 40px;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            .info-box {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
                max-width: 600px;
            }

            .avt-view-profile img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px solid #eee;
                gap: 40px;
            }

            .edit-btn {
                margin-top: 20px;
                background-color: #003b95;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
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
                    <img src="./images/avt/avt.jpg" alt="avt" />
<!--                    <p class="userName">Sáng Nguyễn</p>-->
                    <span><b><%=user.getUsername()%></b></span>
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
                        <form id="form-1" action="updateprofile" method="post" >
                            <div class="info-row">
                                <label>Username</label>
                                <input type="text" name="username" value="<%=user.getUsername()%>">
                            </div>
                            <div class="info-row">
                                <label>Email</label>
                                <input type="text" name="email" value="<%=user.getEmail()%>">
                            </div>
                            <div class="info-row">
                                <label>Phone</label>
                                <input type="text" name="phoneNumber" value="<%=user.getPhone_number()%>">
                            </div>
                            <div >
                                <button type="submit" class="edit-btn">Update</button>
<!--                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>-->
                            </div>
                        </form>
                    </div>
                    <div class="avt-view-profile">
                        <img src="./images/avt/avt.jpg" alt="avt" />
                    </div>
                </div>
            </div>
        </div>
                               <jsp:include page="homefooter.jsp" />
    </body>
</html>
