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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

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
            
            .nav-dropdown a {
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

                    <form action="SearchUser" method="POST" class="form-inline mb-4">
                        <input type="text" name="searchInput" value="${searchKeyword}" placeholder="Tìm khu vực sân cầu lông...">
                        <button class="search-btn" type="submit" >Tìm</button>
                    </form>

                </div>
                <div class="header-actions" style="position: relative; display: flex; align-items: center;">
                    <div class="profile-dropdown" style="position: relative; margin-right: 10px;">
                        <a href="viewprofile.jsp" class="header-btn profile-btn" 
                           style="display: flex; align-items: center; gap: 6px; cursor: pointer;">
                            <% if (user != null) { %>
                            <span style="font-weight: bold;"><%=user.getFirstname()%> <%=user.getLastname()%></span>
                            <% } %>
                            
                            <!-- Có thể thêm icon avatar hoặc mũi tên ▼ -->
                            <!--<img src="avatar.png" style="width:30px; height:30px; border-radius:50%; margin-left:4px;" />-->
                            <span style="font-size: 13px; margin-left:4px;">▼</span>
                        </a>
                        <div class="dropdown-content" 
                             style="display: none; position: absolute; right: 0; top: 36px; background: #fff; min-width: 180px; box-shadow: 0 2px 8px rgba(0,0,0,0.18); border-radius: 10px; z-index: 100;">
                            <a class="nav-item" href="viewprofile.jsp" style="padding: 12px; display: block; text-decoration: none; color: #222;">Thông tin cá nhân</a>

                            <a class="nav-item" href="notifications?for=user" style="padding: 12px; display: block; text-decoration: none; color: #222;">Thông báo</a>
                        </div>
                    </div>
                    <a href="HomePage" class="header-btn">Thoát</a>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="nav">
            <div class="nav-container">
                <div class="nav-item "><a href="HomePageUser">Trang Chủ</a></div>
                <div class="nav-dropdown" style="position: relative; display: inline-block;">
                    <a class="nav-item" style="padding:10px 18px; cursor:pointer; display:inline-block;">
                        Danh sách <span style="font-size:13px;">▼</span>
                    </a>
                    <div class="dropdown-content" style="
                         display: none; position: absolute; left: 0; background: #fff; min-width: 210px;
                         box-shadow: 0 2px 8px rgba(0,0,0,0.16); border-radius: 10px; z-index: 10;
                         ">
                        <a class="nav-item" href="listBranch" style="padding: 12px; display: block; text-decoration: none; color: #222;">Danh Sách Sân Bãi</a>
                        <a class="nav-item" href="booking-list" style="padding: 12px; display: block; text-decoration: none; color: #222;">Danh sách đặt sân</a>
                        <a class="nav-item" href="booking-calendar" style="padding: 12px; display: block; text-decoration: none; color: #222;">Lịch đặt sân</a>
                        <a class="nav-item" href="HomeCoachList" style="padding: 12px; display: block; text-decoration: none; color: #222;">Danh sách huấn luyện viên</a>
                    </div>
                </div>
                <div class="nav-item"><a href="PostView.jsp">Bài Viết</a></div>
                <div class="nav-item"><a href="AboutUs.jsp">Giới Thiệu</a></div>                
                               <div class="nav-item"> <a href="faq-list?for=user">FAQ</a></div>




            </div>
        </nav>

            </div>
        </nav>
    </body>
    <script>
// Hiện dropdown khi hover vào profile-btn hoặc menu
        const dropdown = document.querySelector('.profile-dropdown');
        const dropdownContent = dropdown.querySelector('.dropdown-content');
        const navDropdown = document.querySelector('.nav-dropdown');
        const navDropdownContent = navDropdown.querySelector('.dropdown-content');

        dropdown.addEventListener('mouseenter', function () {
            dropdownContent.style.display = 'block';
        });
        dropdown.addEventListener('mouseleave', function () {
            dropdownContent.style.display = 'none';
        });
        navDropdown.addEventListener('mouseenter', function () {
            navDropdownContent.style.display = 'block';
        });
        navDropdown.addEventListener('mouseleave', function () {
            navDropdownContent.style.display = 'none';
        });
    </script>
</html>
