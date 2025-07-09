<%-- 
    Document   : homepageUser
    Created on : May 26, 2025, 10:48:19 PM
    Author     : sangn
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hệ thống tìm kiếm sân bãi</title>
        <style>
            .main {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .banner-slider {
                position: relative;
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
            }
            .banner-slide {
                display: none;
                position: absolute;
                width: 100%;
            }
            .banner-slide.active {
                display: block;
            }

            .banner-caption {
                position: absolute;
                bottom: 20px;
                left: 30px;
                background: rgba(0,0,0,0.4);
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
            }


            .title {
                text-align: center;
            }

            /* Courts Grid */
            .courts-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 2rem;
                margin-top: 2rem;
            }

            .court-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transition: all 0.3s;
            }

            .court-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }

            .logo-san img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .court-info p{
                margin-bottom: 0.5rem;
            }

            .court-info {
                padding: 1.5rem;
            }

            .court-name {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .court-location {
                color: #666;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .court-location::before {
                content: "📍";
                margin-right: 0.5rem;
            }

            .book-btn {
                width: 100%;
                background: #ff4757;
                color: white;
                border: none;
                padding: 0.75rem;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s;
            }

            .book-btn:hover {
                background: #ff3838;
            }
            #chatbot-toggle {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 60px;
                height: 60px;
                background: #2980b9;
                border-radius: 50%;
                color: white;
                font-size: 30px;
                text-align: center;
                line-height: 60px;
                cursor: pointer;
                z-index: 1001;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                transition: background 0.3s;
            }

            #chatbot-toggle:hover {
                background: #1f6390;
            }

            #chatbot-container {
                display: none; /* Ẩn mặc định */
                position: fixed;
                bottom: 90px;
                right: 20px;
                width: 300px;
                z-index: 1000;
                font-family: sans-serif;
            }

            #chatbox {
                height: 350px;
                background: #fff;
                border: 1px solid #ccc;
                border-radius: 10px;
                overflow-y: auto;
                padding: 10px;
                font-size: 14px;
                line-height: 1.5;
                word-wrap: break-word;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

            .msg-user, .msg-bot {
                margin: 5px 0;
                display: flex;
                width: 100%;
            }

            .msg-user span {
                background: #dfe6e9;
                padding: 8px 12px;
                border-radius: 10px 0 10px 10px;
                margin-left: auto;
                max-width: 80%;
                word-break: break-word;
            }

            .msg-bot span {
                background: #74b9ff;
                color: white;
                padding: 8px 12px;
                border-radius: 0 10px 10px 10px;
                margin-right: auto;
                max-width: 80%;
                word-break: break-word;
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />
        <div id="chatbot-toggle" onclick="toggleChatbot()">💬</div>

        <!-- Chatbot Panel -->
        <div id="chatbot-container">
            <div id="chatbox"></div>
            <div style="display: flex; margin-top: 5px;">
                <input type="text" id="userMessage" placeholder="Nhập tin nhắn..."
                       style="flex: 1; padding: 8px; border-radius: 6px 0 0 6px; border: 1px solid #ccc; outline: none;">
                <button onclick="sendMessage()"
                        style="padding: 8px 12px; border: none; background-color: #2980b9; color: white; border-radius: 0 6px 6px 0; cursor: pointer;">
                    Gửi
                </button>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script>
                    function toggleChatbot() {
                        const panel = document.getElementById("chatbot-container");
                        panel.style.display = (panel.style.display === "none" || panel.style.display === "") ? "block" : "none";
                    }

                    function sendMessage() {
                        var msg = $("#userMessage").val().trim();
                        if (msg === "")
                            return;

                        $("#chatbox").append('<div class="msg-user"><span>' + escapeHTML(msg) + '</span></div>');
                        $("#userMessage").val("");

                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/chatbot",
                            data: {message: msg},
                            dataType: "text",
                            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                            success: function (response) {
                                $("#chatbox").append('<div class="msg-bot"><span>' + escapeHTML(response) + '</span></div>');
                                $("#chatbox").scrollTop($("#chatbox")[0].scrollHeight);
                            },
                            error: function () {
                                $("#chatbox").append('<div class="msg-bot"><span style="color:red;">Lỗi phản hồi từ chatbot</span></div>');
                            }
                        });
                    }

                    function escapeHTML(str) {
                        return str.replace(/&/g, "&amp;")
                                .replace(/</g, "&lt;")
                                .replace(/>/g, "&gt;");
                    }
        </script>
        <main class="main">

            <div class="banner-slider" style="height: 400px;">
                <c:forEach var="banner" items="${bannerList}">
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/${banner.imageUrl}" alt="${banner.title}" style="width:100%;height:400px;object-fit:cover;">
                        <div class="banner-caption">
                            <h2>${banner.title}</h2>
                            <p>${banner.caption}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="title">
                <h1>Danh sách khu vực nổi bật</h1>
            </div>

            <!-- Courts Grid -->
            <div class="courts-grid">
                <c:forEach var="top" items="${listTop3}">
                    <div class="court-card">
                        <div class="court-images">
                            <c:forEach var="img" items="${areaImagesMap[top.area_id]}">
                                <div class="logo-san">
                                    <img src="${pageContext.request.contextPath}/${img.imageURL}" alt="Image ${img.image_id}" />
                                </div>
                            </c:forEach>
                        </div>
                        <div class="court-info">
                            <div class="court-name">${top.name}</div>
                            <div class="court-location">${top.location}</div>
                            <p>Giờ mở cửa: ${top.openTime} - ${top.closeTime}</p>
                            <p>Mô tả: ${top.description}</p>
                            <form action="AreaDetail" method="get">
                                <input type="hidden" name="area_id" value="${top.area_id}" />
                                <button type="submit" class="book-btn">Xem chi tiết</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
    <script>
        // JS chuyển slide đơn giản
        window.onload = function () {
            let slides = document.querySelectorAll('.banner-slide');
            let idx = 0;
            if (slides.length > 0)
                slides[0].classList.add('active');
            setInterval(function () {
                slides[idx].classList.remove('active');
                idx = (idx + 1) % slides.length;
                slides[idx].classList.add('active');
            }, 4000);
        }
    </script>
</html>
