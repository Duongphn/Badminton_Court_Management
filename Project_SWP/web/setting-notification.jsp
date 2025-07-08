<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, Model.User" %>
<%
    Boolean sendMail = (Boolean) request.getAttribute("sendMail");
    String message = (String) request.getAttribute("message");
    if (sendMail == null && session.getAttribute("user") != null) {
        sendMail = ((User)session.getAttribute("user")).isSendMail();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cài đặt nhận thông báo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
        <style>
            body {
                background: #f4f6f8;
            }
            .setting-main {
                max-width: 700px;
                margin: 48px auto;
                padding: 0 10px;
            }
            .setting-container {
                background: #fff;
                padding: 36px 28px 34px 28px;
                border-radius: 20px;
                box-shadow: 0 6px 28px rgba(0,0,0,0.11);
            }
            .setting-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 24px;
            }
            .setting-header h4 {
                margin: 0;
                font-size: 1.28rem;
                color: #1a1a1a;
                font-weight: bold;
                letter-spacing: 0.5px;
            }
            .setting-icon {
                font-size: 1.5rem;
                color: #0d6efd;
                background: #e8f0fe;
                border-radius: 10px;
                width: 46px;
                height: 46px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .setting-divider {
                border: none;
                border-top: 1px solid #eee;
                margin: 0 0 28px 0;
            }
            .setting-message {
                margin-bottom: 22px;
            }
            @media (max-width: 700px) {
                .setting-main {
                    max-width: 100%;
                    padding: 0 5px;
                }
                .setting-container {
                    padding: 16px 5px 22px 5px;
                    border-radius: 10px;
                }
                .setting-header h4 {
                    font-size: 1.1rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="homehead.jsp" />

        <main class="setting-main">
            <div class="setting-container">
                <div class="setting-header">
                    <span class="setting-icon"><i class="fas fa-envelope-open-text"></i></span>
                    <h4>Cài đặt nhận thông báo qua Email</h4>
                </div>
                <hr class="setting-divider"/>
                <% if (message != null) { %>
                <div class="alert alert-success setting-message"><i class="fas fa-check-circle"></i> <%= message %></div>
                <% } %>
                <form method="post" action="setting-notification">
                    <div class="form-check form-switch mb-4" style="font-size: 1.05rem;">
                        <input class="form-check-input" type="checkbox" name="sendMail" id="sendMail"
                               <%= (sendMail != null && sendMail) ? "checked" : "" %>>
                        <label class="form-check-label ms-2" for="sendMail" style="cursor:pointer;">
                            Nhận thông báo qua Email từ hệ thống
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 py-2 shadow-sm">
                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                    </button>
                </form>
            </div>
        </main>

        <jsp:include page="homefooter.jsp" />
    </body>
</html>
