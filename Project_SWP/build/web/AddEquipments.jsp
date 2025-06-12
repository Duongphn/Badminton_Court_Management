<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm dịch vụ</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #eef2f3;
                padding: 40px;
            }

            .form-container {
                background-color: #fff;
                padding: 30px;
                max-width: 400px;
                margin: auto;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .btn-submit {
                margin-top: 20px;
                width: 100%;
                padding: 12px;
                background-color: #28a745;
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .btn-submit:hover {
                background-color: #218838;
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #007bff;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="form-container">
            <h2>Thêm dịch vụ mới</h2>
            <form action="${pageContext.request.contextPath}/AddService" method="post">

                <label for="name">Tên dịch vụ:</label>
                <input type="text" name="name" required>

                <label for="price">Giá (VND):</label>
                <input type="number" name="price" required>

                <button type="submit" class="btn-submit">Thêm</button>
            </form>
            <a class="back-link" href="EquipmentsView.jsp">← Quay lại danh sách</a>
        </div>

    </body>
</html>
