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
        <title>Thanh điều hướng</title>
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #ffffff;
            }
            
            .sidebar {
                width: 280px;
                height: 100vh;
                background: #1a1a1a;
                color: #fff;
                position: fixed;
                top: 0;
                left: 0;
                display: flex;
                flex-direction: column;
                box-shadow: 4px 0 15px rgba(255, 107, 107, 0.3);
                backdrop-filter: blur(10px);
                border-right: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .sidebar-logo {
                text-align: center;
                padding: 25px 20px;
                border-bottom: 2px solid rgba(255, 255, 255, 0.2);
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
            }
            
            .sidebar-logo img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                border: 3px solid rgba(255, 255, 255, 0.3);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
            }
            
            .sidebar-logo img:hover {
                transform: scale(1.05);
            }
            
            .sidebar-logo h3 {
                margin: 15px 0 5px 0;
                font-size: 18px;
                font-weight: 600;
                color: #fff;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            
            .sidebar-logo p {
                margin: 0;
                font-size: 12px;
                color: rgba(255, 255, 255, 0.8);
                font-weight: 300;
            }
            
            .nav-container {
                flex: 1;
                overflow-y: auto;
                padding: 20px 0;
            }
            
            ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            
            .nav-item {
                margin: 8px 15px;
                border-radius: 12px;
                overflow: hidden;
                transition: all 0.3s ease;
            }
            
            .nav-item:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }
            
            .nav-link {
                display: flex;
                align-items: center;
                padding: 15px 20px;
                color: #fff;
                text-decoration: none;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                font-size: 14px;
                font-weight: 500;
                letter-spacing: 0.5px;
            }
            
            .nav-link:hover {
                background: rgba(255, 255, 255, 0.2);
                color: #fff;
                border-color: rgba(255, 255, 255, 0.3);
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            
            .nav-link.active {
                background: rgba(255, 255, 255, 0.25);
                color: #fff;
                border-color: rgba(255, 255, 255, 0.4);
                box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
                font-weight: 600;
            }
            
            .nav-link::before {
                content: '';
                width: 8px;
                height: 8px;
                background: rgba(255, 255, 255, 0.6);
                border-radius: 50%;
                margin-right: 15px;
                transition: all 0.3s ease;
            }
            
            .nav-link:hover::before {
                background: #fff;
                transform: scale(1.2);
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            }
            
            .nav-link.active::before {
                background: #fff;
                transform: scale(1.3);
                box-shadow: 0 0 15px rgba(255, 255, 255, 0.8);
            }
            
            /* Scrollbar styling */
            .nav-container::-webkit-scrollbar {
                width: 6px;
            }
            
            .nav-container::-webkit-scrollbar-track {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 3px;
            }
            
            .nav-container::-webkit-scrollbar-thumb {
                background: rgba(255, 255, 255, 0.3);
                border-radius: 3px;
            }
            
            .nav-container::-webkit-scrollbar-thumb:hover {
                background: rgba(255, 255, 255, 0.5);
            }
            
            /* Responsive adjustments */
            @media (max-width: 768px) {
                .sidebar {
                    width: 260px;
                }
                
                .nav-link {
                    padding: 12px 18px;
                    font-size: 13px;
                }
                
                .sidebar-logo img {
                    width: 70px;
                    height: 70px;
                }
            }
            
            /* Animation for page load */
            @keyframes slideIn {
                from {
                    transform: translateX(-100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            .sidebar {
                animation: slideIn 0.5s ease-out;
            }
            
            .nav-item {
                animation: slideIn 0.5s ease-out;
                animation-fill-mode: both;
            }
            
            .nav-item:nth-child(1) { animation-delay: 0.1s; }
            .nav-item:nth-child(2) { animation-delay: 0.2s; }
            .nav-item:nth-child(3) { animation-delay: 0.3s; }
            .nav-item:nth-child(4) { animation-delay: 0.4s; }
            .nav-item:nth-child(5) { animation-delay: 0.5s; }
            .nav-item:nth-child(6) { animation-delay: 0.6s; }
            .nav-item:nth-child(7) { animation-delay: 0.7s; }
            .nav-item:nth-child(8) { animation-delay: 0.8s; }
            .nav-item:nth-child(9) { animation-delay: 0.9s; }
            .nav-item:nth-child(10) { animation-delay: 1.0s; }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-logo">
                <a href="staff-dashboard">
                    <img src="./uploads/Badminton.jpg" alt="Logo">
                </a>
                <h3>BadmintonCourt</h3>
                <p>Quản lý hệ thống</p>
            </div>
            
            <div class="nav-container">
                <ul>
                    <li class="nav-item">
                        <a class="nav-link" href="staff-dashboard">DASHBOARD</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="courts">QUẢN LÝ SÂN</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manager-booking-schedule">QUẢN LÝ ĐẶT LỊCH</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ViewEquipments">QUẢN LÝ DỊCH VỤ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ViewPostManager">QUẢN LÝ BÀI VIẾT</a>
                    </li>
                    
                     <li class="nav-item">
                        <a class="nav-link" href="Notification1"> THÔNG BÁO</a>
                    </li>
                </ul>
            </div>
        </div>
    </body>
</html>