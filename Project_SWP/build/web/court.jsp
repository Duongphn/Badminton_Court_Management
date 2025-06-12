<%@ page import="java.util.*, model.Court" %>
<%
    List<Court> courtList = (List<Court>) request.getAttribute("courts");
    if (courtList == null) {
        courtList = new ArrayList<>();
    }
%>
<html>
<head><title>Danh sách sân</title></head>
<body>
    <h2>Danh sách sân</h2>
    <table border="1">
        <tr><th>ID</th><th>Tên sân</th><th>Hành động</th></tr>
        <%
            for (Court court : courtList) {
        %>
            <tr>
                <td><%= court.getId() %></td>
                <td><%= court.getName() %></td>
                <td>
                    <a href="editCourt.jsp?id=<%= court.getId() %>">Sửa</a> |
                    <a href="deleteCourt?id=<%= court.getId() %>">Xóa</a>
                </td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>