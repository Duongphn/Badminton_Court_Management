 <%-- 

    Document   : homepageUser
    Created on : May 26, 2025, 10:48:19 PM
    Author     : sangn
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<<<<<<< HEAD
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
=======
>>>>>>> 01cf337edfd47836872828a5f0e8a855ccc69a1f
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

            /* Event Popup Styles */
            .event-popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                animation: fadeIn 0.3s ease;
            }

            .event-popup {
                background: white;
                border-radius: 20px;
                max-width: 500px;
                width: 90%;
                max-height: 90vh;
                overflow-y: auto;
                position: relative;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                animation: slideIn 0.3s ease;
            }

            .event-popup-header {
                position: relative;
                height: 200px;
                border-radius: 20px 20px 0 0;
                overflow: hidden;
            }

            .event-popup-header img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .event-popup-close {
                position: absolute;
                top: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.9);
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                color: #333;
                transition: all 0.3s;
            }

            .event-popup-close:hover {
                background: white;
                transform: scale(1.1);
            }

            .event-popup-content {
                padding: 30px;
            }

            .event-popup-title {
                font-size: 24px;
                font-weight: bold;
                color: #ff4757;
                margin-bottom: 10px;
            }

            .event-popup-subtitle {
                font-size: 18px;
                color: #333;
                margin-bottom: 20px;
                line-height: 1.4;
            }

            .event-popup-info {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 20px;
            }

            .event-popup-info h4 {
                color: #ff4757;
                margin-bottom: 15px;
                font-size: 16px;
            }

            .event-info-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                font-size: 14px;
                color: #666;
            }

            .event-info-item i {
                width: 20px;
                margin-right: 10px;
                color: #ff4757;
            }

            .event-popup-actions {
                display: flex;
                gap: 15px;
                margin-top: 25px;
            }

            .event-popup-btn {
                flex: 1;
                padding: 12px 20px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
                text-align: center;
                display: inline-block;
            }

            .event-popup-btn.primary {
                background: linear-gradient(135deg, #ff4757, #ff3838);
                color: white;
            }

            .event-popup-btn.primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 71, 87, 0.3);
            }

            .event-popup-btn.secondary {
                background: #e9ecef;
                color: #495057;
            }

            .event-popup-btn.secondary:hover {
                background: #dee2e6;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-50px) scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            /* Responsive */
            @media (max-width: 768px) {
                .event-popup {
                    max-width: 95%;
                }

                .event-popup-content {
                    padding: 20px;
                }

                .event-popup-actions {
                    flex-direction: column;
                }
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

            </style>
        </head>
        <body>
            <jsp:include page="homehead.jsp" />
            <div id="chatbot-toggle" onclick="toggleChatbot()">💬</div>


            <!-- Chatbot Panel -->
            <div id="chatbot-container">
                <div id="chatbox"></div>
                <div style="display: flex;
                     margin-top: 5px;">
                    <input type="text" id="userMessage" placeholder="Nhập tin nhắn..."
                           style="flex: 1;
                           padding: 8px;
                           border-radius: 6px 0 0 6px;
                           border: 1px solid #ccc;
                           outline: none;">
                    <button onclick="sendMessage()"
                            style="padding: 8px 12px;
                            border: none;
                            background-color: #2980b9;
                            color: white;
                            border-radius: 0 6px 6px 0;
                            cursor: pointer;">
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

                <!-- Thông báo thành công/lỗi -->
                <c:if test="${not empty joinEventSuccess}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin-bottom: 20px;
                         padding: 15px;
                         background-color: #d4edda;
                         border: 1px solid #c3e6cb;
                         border-radius: 8px;
                         color: #155724;">
                        <i class="fas fa-check-circle"></i> <strong>Thành công!</strong> ${joinEventSuccess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="float: right;
                                background: none;
                                border: none;
                                font-size: 20px;
                                cursor: pointer;" onclick="this.parentElement.style.display = 'none'">&times;</button>
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-bottom: 20px;
                         padding: 15px;
                         background-color: #f8d7da;
                         border: 1px solid #f5c6cb;
                         border-radius: 8px;
                         color: #721c24;">
                        <i class="fas fa-exclamation-circle"></i> <strong>Lỗi!</strong> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="float: right;
                                background: none;
                                border: none;
                                font-size: 20px;
                                cursor: pointer;" onclick="this.parentElement.style.display = 'none'">&times;</button>
                    </div>
                </c:if>

                <c:if test="${not empty infoMessage}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert" style="margin-bottom: 20px;
                         padding: 15px;
                         background-color: #d1ecf1;
                         border: 1px solid #bee5eb;
                         border-radius: 8px;
                         color: #0c5460;">
                        <i class="fas fa-info-circle"></i> <strong>Thông tin!</strong> ${infoMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="float: right;
                                background: none;
                                border: none;
                                font-size: 20px;
                                cursor: pointer;" onclick="this.parentElement.style.display = 'none'">&times;</button>
                    </div>
                </c:if>

                <!--Banner-->
                <div class="banner-slider" style="height: 400px;">
                    <c:forEach var="banner" items="${bannerList}">
                        <div class="banner-slide">
                            <img src="${pageContext.request.contextPath}/${banner.imageUrl}" alt="${banner.title}" style="width:100%;
                                 height:400px;
                                 object-fit:cover;">
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

            <!-- Event Popup -->
            <c:if test="${not empty latestEvent}">
                <div id="eventPopup" class="event-popup-overlay">
                    <div class="event-popup">
                        <div class="event-popup-header">
                            <c:choose>
                                <c:when test="${not empty latestEvent.imageUrl}">
                                    <img src="${latestEvent.imageUrl}" alt="${latestEvent.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="./uploads/hinh_nen.jpg" alt="Event Default">
                                </c:otherwise>
                            </c:choose>
                            <button class="event-popup-close" onclick="closeEventPopup()">&times;</button>
                        </div>
                        <div class="event-popup-content">
                            <div class="event-popup-title">${latestEvent.name}</div>
                            <div class="event-popup-subtitle">${latestEvent.title}</div>

                            <div class="event-popup-info">
                                <h4>🏸 Thông tin sự kiện</h4>
                                <div class="event-info-item">
                                    <i>📅</i>
                                    <span>Bắt đầu: <fmt:formatDate value="${latestEvent.startDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <div class="event-info-item">
                                    <i>⏰</i>
                                    <span>Kết thúc: <fmt:formatDate value="${latestEvent.endDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <c:if test="${not empty latestEvent.areaName}">
                                    <div class="event-info-item">
                                        <i>📍</i>
                                        <span>Địa điểm: ${latestEvent.areaName}</span>
                                    </div>
                                </c:if>
                            </div>

                            <div class="event-popup-actions">
                                <a href="join-event?action=joinFromPopup&eventId=${latestEvent.eventId}" class="event-popup-btn primary">Tham gia ngay!</a>
                                <button class="event-popup-btn secondary" onclick="closeEventPopup()">Để sau</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <script>
                // Hiển thị popup khi trang load xong (sau 2 giây)
                window.addEventListener('load', function () {
                    var popup = document.getElementById('eventPopup');
                    if (popup) {
                        setTimeout(function () {
                            popup.style.display = 'flex';
                        }, 2000);
                    }
                });

                // Đóng popup
                function closeEventPopup() {
                    var popup = document.getElementById('eventPopup');
                    if (popup) {
                        popup.style.display = 'none';
                        // Lưu vào localStorage để không hiển thị lại trong session này
                        localStorage.setItem('eventPopupClosed', 'true');
                    }
                }

                // Click overlay để đóng popup
                document.addEventListener('click', function (e) {
                    var popup = document.getElementById('eventPopup');
                    if (popup && e.target === popup) {
                        closeEventPopup();
                    }
                });

                // Kiểm tra nếu user đã đóng popup trong session này
                window.addEventListener('load', function () {
                    if (localStorage.getItem('eventPopupClosed') === 'true') {
                        var popup = document.getElementById('eventPopup');
                        if (popup) {
                            popup.style.display = 'none';
                        }
                    }
                });

                // Xóa localStorage khi user rời khỏi trang
                window.addEventListener('beforeunload', function () {
                    localStorage.removeItem('eventPopupClosed');
                });
            </script>
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
        </body>
    </html>