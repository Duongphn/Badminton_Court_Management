<%-- 
    Document   : Sidebar
    Created on : May 21, 2025, 8:05:58 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sidebar</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }

            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #1e1e2f;
                color: #fff;
                position: fixed;
                top: 0;
                left: 0;
                display: flex;
                flex-direction: column;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            }

            .sidebar-logo {
                text-align: center;
                padding: 20px;
                border-bottom: 1px solid #444;
            }

            .sidebar-logo img {
                width: 100px;
                height: auto;
                border-radius: 50%;
            }

            ul {
                list-style: none;
                padding: 0;
                margin: 0;
                flex: 1;
            }

            .nav-item {
                border-bottom: 1px solid #333;
            }

            .nav-link {
                display: block;
                padding: 15px 20px;
                color: #ddd;
                text-decoration: none;
                transition: background 0.3s ease;
            }

            .nav-link:hover, .nav-link.active {
                background-color: #343454;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-logo" >
                <a href="host_dashboard.jsp">
                    <img src="badminton.jpg" alt="Logo" >
                </a> 
            </div>
            <ul>
                <li class="nav-item">
                    <a class="nav-link " href="view-region">REGION MANAGEMENT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ViewService">SERVICE MANAGEMENT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manage-request">COURT REQUEST</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manager-booking-schedule">BOOKING SCHEDULE</a>
                </li>
            </ul>
        </div>
    </body>
</html>
