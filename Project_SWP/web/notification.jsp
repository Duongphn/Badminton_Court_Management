<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty requestScope.message or not empty requestScope.error}">
    <div id="popupMessage" class="position-fixed"
         style="top: 20px; right: 20px; max-width: 350px; background-color: ${not empty requestScope.message ? '#28a745' : '#dc3545'};
         color: white; padding: 15px; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); display: none; z-index: 9999;">

        <c:choose>
            <c:when test="${not empty requestScope.message}">✅ ${requestScope.message}</c:when>
            <c:when test="${not empty requestScope.error}">❌ ${requestScope.error}</c:when>
        </c:choose>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let popup = document.getElementById("popupMessage");
            if (popup) {
                popup.style.display = "block";
                popup.style.transition = "opacity 0.5s ease-in-out";

                setTimeout(() => {
                    popup.style.opacity = "0";
                    setTimeout(() => popup.style.display = "none", 500);
                }, 5000);
            }
        });
    </script>
</c:if>

<c:if test="${not empty sessionScope.message or not empty sessionScope.error}">
    <div id="popupMessage1" class="position-fixed"
         style="top: 20px; right: 20px; max-width: 350px; background-color: ${not empty sessionScope.message ? '#28a745' : '#dc3545'};
         color: white; padding: 15px; border-radius: 10px; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); display: none; z-index: 9999;">

        <c:choose>
            <c:when test="${not empty sessionScope.message}">✅ ${sessionScope.message}</c:when>
            <c:when test="${not empty sessionScope.error}">❌ ${sessionScope.error}</c:when>
        </c:choose>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let popup = document.getElementById("popupMessage1");
            if (popup) {
                popup.style.display = "block";
                popup.style.transition = "opacity 0.5s ease-in-out";

                setTimeout(() => {
                    popup.style.opacity = "0";
                    setTimeout(() => popup.style.display = "none", 500);
                }, 5000);
            }
        });
    </script>
</c:if>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let popup = document.getElementById("popupMessage");
        if (popup) {
            popup.style.display = "block";
            popup.style.transition = "opacity 0.5s ease-in-out";

            setTimeout(() => {
                popup.style.opacity = "0";
                setTimeout(() => {
                    popup.style.display = "none";

                    // Gọi controller để xoá message/error sau khi ẩn
                    fetch('<c:url value="/clear-message" />', { method: 'POST' });
                }, 500);
            }, 5000);
        }
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let popup = document.getElementById("popupMessage1");
        if (popup) {
            popup.style.display = "block";
            popup.style.transition = "opacity 0.5s ease-in-out";

            setTimeout(() => {
                popup.style.opacity = "0";
                setTimeout(() => {
                    popup.style.display = "none";

                    // Gọi controller để xoá message/error sau khi ẩn
                    fetch('<c:url value="/clear-message" />', { method: 'POST' });
                }, 500);
            }, 5000);
        }
    });
</script>
