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

            .hero-banner {
                border-radius: 20px;
                overflow: hidden;
                margin-bottom: 3rem;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .hero-banner img {
                width: 100%;
                height: 400px;
                object-fit: cover;
                display: block;
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
            .notification-main {
                max-width: 700px;
                margin: 40px auto;
                padding: 0 10px;
            }
            .notification-container {
                background-color: #fff;
                padding: 32px 24px;
                border-radius: 18px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.11);
            }
            .notification-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 28px;
            }
            .notification-header h4 {
                margin: 0;
                font-size: 1.25rem;
                color: #222;
                font-weight: bold;
            }
            .notification-item {
                display: flex;
                align-items: flex-start;
                gap: 16px;
                border-bottom: 1px solid #eee;
                padding: 18px 0;
                position: relative;
            }
            .notification-item:last-child {
                border-bottom: none;
            }
            .notification-img {
                width: 54px;
                height: 54px;
                object-fit: cover;
                border-radius: 12px;
                background: #f5f6fa;
            }
            .notification-content {
                flex: 1;
            }
            .notification-content strong {
                font-size: 1.07rem;
                color: #222;
            }
            .notification-content p {
                margin: 2px 0 4px;
                color: #444;
            }
            .notification-time {
                font-size: 0.93rem;
                color: #888;
            }
            .dot-unread {
                width: 12px;
                height: 12px;
                background: #0d6efd;
                border-radius: 50%;
                margin-top: 5px;
            }
            .notification-item.unread {
                background-color: #f3f8ff;
            }
            .no-notification {
                text-align: center;
                padding: 40px 0 30px;
                color: #bbb;
                font-size: 1.1rem;
            }
            .no-notification i {
                color: #ff4757;
                margin-bottom: 10px;
            }
            @media (max-width: 768px) {
                .notification-main {
                    margin: 20px 0;
                    padding: 0 5px;
                }
                .notification-container {
                    padding: 18px 6px;
                    border-radius: 9px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <main class="main">
            <div class="notification-container">
                <div class="notification-header">
                    <h4><i class="fas fa-bell"></i> Thông báo của bạn</h4>
                    <a href="notifications?for=user" class="btn btn-outline-secondary btn-sm"><i class="fas fa-rotate-right"></i> Tải lại</a>
                </div>
                <c:choose>
                    <c:when test="${empty allNotifications}">
                        <div class="no-notification">
                            <i class="fas fa-inbox fa-2x mb-2"></i>
                            <p>Bạn chưa có thông báo nào.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${allNotifications}">
                            <div class="notification-item ${item.isRead ? '' : 'unread'}">
                                <img class="notification-img" src="${item.notificationId.imageUrl != null ? item.notificationId.imageUrl : 'images/notification-default.png'}" alt="Ảnh thông báo">
                                <div class="notification-content">
                                   <a href="notificationDetail?notificationId=${item.notificationId.notificationId}" class="notification-title-link">
    <strong>${item.notificationId.title}</strong>
</a>

                                    <div class="notification-time">
                                        ${item.notificationId.scheduledTime}
                                    </div>
                                </div>
             </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>


</html>
