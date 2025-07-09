<%-- 
    Document   : Admin_DashBoard
    Created on : Jun 24, 2025, 8:29:02 AM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Admin Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f6f7fa;
                margin: 0;
            }
            .kpi-boxes {
                display: flex;
                gap: 30px;
                margin-bottom: 32px;
            }
            .kpi {
                flex: 1;
                background: white;
                border-radius: 14px;
                box-shadow: 0 2px 10px #e4e8f1;
                padding: 25px 16px;
                text-align: center;
            }
            .kpi h2 {
                margin: 0 0 10px;
                color: #2196f3;
                font-size: 2.5em;
            }
            .kpi span {
                color: #888;
                font-size: 1.1em;
            }
            .title {
                font-size: 1.7em;
                margin-bottom: 10px;
                color: #23397a;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 14px;
                overflow: hidden;
                box-shadow: 0 2px 10px #e4e8f1;
            }
            th, td {
                padding: 10px 8px;
                text-align: center;
                border-bottom: 1px solid #eee;
            }
            th {
                background: #f2f5f9;
                color: #23397a;
            }
            tr:last-child td {
                border-bottom: none;
            }
            .chart-area {
                margin: 36px 0 12px 0;
            }
            .section-title {
                font-size: 1.2em;
                color: #23397a;
                margin: 18px 0 8px;
            }
            .header {
                margin-left: 250px;
                padding: 10px 20px;
                background-color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ccc;
            }

            .logout-button {
                color: red;
                border: 1px solid red;
                padding: 6px 14px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                transition: 0.3s;
            }

            .logout-button:hover {
                background-color: red;
                color: white;
            }
            .container {
                display: flex;
                min-height: 100vh;
            }
            .sidebar {
                width: 250px;
                background: #f4f4f4;
            }
            .main-content {
                margin-left: 250px;
                padding: 15px;
                flex: 1px;
            }

        </style>
    </head>
    <body>
        <div class="header">
            <h3></h3>
            <a href="login" class="logout-button">Logout</a>
        </div>
        <div class="container">
            <div class="sidebar">
                <jsp:include page="Sidebar.jsp"/>
            </div>

            <div class="main-content">
                <div class="dashboard-container">

                    <div class="title">Báo cáo tổng quan quản lý sân</div>

                    <!-- KPI -->
                    <div class="kpi-boxes">
                        <div class="kpi">
                            <h2>${summary.totalBookings}</h2>
                            <span>Tổng lượt đặt</span>
                        </div>
                        <div class="kpi">
                            <h2>${summary.totalRevenue}</h2>
                            <span>Tổng doanh thu</span>
                        </div>
                        <div class="kpi">
                            <h2>${summary.returningUsers}</h2>
                            <span>User quay lại</span>
                        </div>
                        <div class="kpi">
                            <h2>
                                <c:choose>
                                    <c:when test="${summary.avgRating > 0}">
                                        ${summary.avgRating}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </h2>
                            <span>Đánh giá trung bình</span>
                        </div>
                    </div>

                    <!-- Danh sách báo cáo từng sân -->
                    <div class="section-title">Bảng tổng hợp từng sân</div>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên sân</th>
                                <th>Quản lý</th>
                                <th>Doanh thu</th>
                                <th>Lượt đặt</th>
                                <th>User quay lại</th>
                                <th>Đánh giá TB</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="court" items="${courtReports}">
                                <tr>
                                    <td>${court.courtName}</td>
                                    <td>${court.managerName}</td>
                                    <td>${court.revenue}</td>
                                    <td>${court.bookings}</td>
                                    <td>${court.returningUsers}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${court.avgRating > 0}">
                                                ${court.avgRating}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Top 10 sân -->
                    <div class="section-title">Top 10 sân doanh thu cao nhất</div>
                    <table>
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên sân</th>
                                <th>Quản lý</th>
                                <th>Doanh thu</th>
                                <th>Lượt đặt</th>
                                <th>Đánh giá TB</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="court" items="${topCourts}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${court.courtName}</td>
                                    <td>${court.managerName}</td>
                                    <td>${court.revenue}</td>
                                    <td>${court.bookings}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${court.avgRating > 0}">
                                                ${court.avgRating}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Biểu đồ giả lập (có thể thay bằng chart.js nếu cần) -->
                    <div class="section-title">Biểu đồ doanh thu theo sân (dạng demo)</div>
                    <div class="chart-area">
                        <img src="https://dummyimage.com/700x200/2196f3/fff&text=Revenue+Bar+Chart+Demo" alt="Bar Chart Demo" width="700"/>
                    </div>


                </div>
            </div>
    </body>
</html>
