<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Thông báo cá nhân</title>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
        <style>
            .notification-container {
                background-color: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 0 12px rgba(0, 0, 0, 0.08);
                margin-top: 30px;
            }

            .notification-item {
                display: flex;
                align-items: center;
                gap: 15px;
                border-bottom: 1px solid #eee;
                padding: 15px 0;
            }

            .notification-item:last-child {
                border-bottom: none;
            }

            .notification-item img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
            }

            .notification-content {
                flex: 1;
            }

            .notification-content strong {
                font-size: 1rem;
                color: #333;
            }

            .notification-time {
                font-size: 0.875rem;
                color: #777;
            }

            .dot-unread {
                width: 10px;
                height: 10px;
                background: #0d6efd;
                border-radius: 50%;
            }
        </style>
    </head>
    <body class="bg-light">

<!--         Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Thông báo</a>
                <div class="d-flex">
                    <a class="nav-link text-light" href="login">Đăng xuất</a>
                </div>
            </div>
        </nav>

<!--         Layout -->
        <div class="container-fluid mt-4">
  
            <div class="row">
<!--                 Sidebar -->
                <div class="col-md-3">
                    <jsp:include page="Sidebar.jsp"/>
                </div>

                <!-- Nội dung -->
                <div class="col-md-8">
                    <div class="container">
                        <div class="notification-container">
                            <div class="notification-header">
                                <h4><i class="fas fa-bell"></i> Thông báo của bạn</h4>
                                <a href="Notification1" class="btn btn-outline-secondary btn-sm"><i class="fas fa-rotate-right"></i> Tải lại</a>
                            </div>

                            <c:choose>
                                <c:when test="${empty allNotifications}">
                                    <div class="no-notification">
                                        <i class="fas fa-inbox fa-2x mb-3"></i>
                                        <p>Bạn chưa có thông báo nào.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                     <c:forEach var="item" items="${allNotifications}">
                            <div class="notification-item ${item.isRead ? '' : 'unread'}">
                                <img class="notification-img" src="${item.notificationId.imageUrl != null ? item.notificationId.imageUrl : 'images/notification-default.png'}" alt="Ảnh thông báo">
                                <div class="notification-content">
                                   <a href="NotificationStaff?notificationId=${item.notificationId.notificationId}" class="notification-title-link">
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
                    </div>


                </div>
            </div>
        </div>
             

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
