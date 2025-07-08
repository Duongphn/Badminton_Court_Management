<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Area List</title>
    </head>
    <body>
        <h2>Danh sách Khu vực</h2>
        <form action="AreaController" method="get">
            Tên khu vực: <input type="text" name="name" /><br/>
            Địa chỉ: <input type="text" name="location" /><br/>
            Giờ mở cửa: <input type="time" name="openTime" /><br/>
            Giờ đóng cửa: <input type="time" name="closeTime" /><br/>
            <input type="submit" value="Lọc" />
        </form>

        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Địa chỉ</th>
                    <th>Giờ mở cửa</th>
                    <th>Giờ đóng cửa</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${areaList}" var="area">
                    <tr>
                        <td>${area.areaId}</td>
                        <td>${area.name}</td>
                        <td>${area.location}</td>
                        <td>${area.openTime}</td>
                        <td>${area.closeTime}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>