<%-- 
    Document   : homehead
    Created on : May 24, 2025, 2:35:17 AM
    Author     : sangn
--%>

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

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background-color: #f5f5f5;
            }

            /* Header */
            .header {
                background: linear-gradient(135deg, #ff4757, #ff3838);
                color: white;
                padding: 1rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .header-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                display: flex;
                align-items: center;
                font-size: 1.5rem;
                font-weight: bold;
            }

            .logo::before {
                content: "🏸";
                margin-right: 0.5rem;
                font-size: 2rem;
            }

            .search-bar {
                flex: 1;
                max-width: 400px;
                margin: 0 2rem;
                position: relative;
            }

            .search-bar input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: none;
                border-radius: 25px;
                font-size: 1rem;
                outline: none;
            }

            .search-btn {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                background: #ff4757;
                border: none;
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                cursor: pointer;
            }

            .header-actions {
                display: flex;
                gap: 1rem;
                align-items: center;
            }
            
            
            .header-btn {
                background: rgba(255,255,255,0.2);
                border: 1px solid rgba(255,255,255,0.3);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
            }

            .header-btn:hover {
                background: rgba(255,255,255,0.3);
            }

            /* Navigation */
            .nav {
                background: white;
                padding: 1rem 0;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: center;
                gap: 2rem;
            }

            .nav-item {
                padding: 0.5rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                transition: all 0.3s;
                background: #f8f9fa;
                color: #333;

            }

            .nav-item.active {
                background: #ff4757;
            }

            .nav-item.active a {
                text-decoration: none;
                color: white;
            }

            .nav-item:hover {
                background: #ff6b7a;
                color: white;
            }

            .nav-item a{
                color: black;
                text-decoration: none;
            }

        </style>
    </head>

    <body>
        <%
        User user = (User) session.getAttribute("user");
        %>
        <header class="header">
            <div class="header-container">
                <div class="logo">BadmintonCourt</div>
                <div class="search-bar">
                    <input type="text" placeholder="Tìm sân cầu lông...">
                    <button class="search-btn">Tìm</button>
                </div>
                <div class="header-actions">
                    
                    <span>
                        <a href="viewprofile.jsp" class="header-btn"><%=user.getUsername()%></a>
                    </span>
                    <a href="HomePage" class="header-btn">Thoát</a>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="nav">
            <div class="nav-container">
                <div class="nav-item "><a href="HomePageUser">Trang Chủ</a></div>

                <div class="nav-item"><a href="listBranch">Danh Sách Sân Bãi</a></div>
                <div class="nav-item"><a href="booking-list">Danh sách đặt sân</a></div>
                <div class="nav-item"><a href="PostView.jsp">Bài Viết</a></div>
                <div class="nav-item"><a href="AboutUs.jsp">Giới Thiệu</a></div>
                <div class="nav-item">Liên Hệ</div>
            </div>
        </nav>
    </body>
</html>
