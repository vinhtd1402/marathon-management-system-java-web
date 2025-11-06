<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Sponsor" %>
<%@ page import="models.MarathonType" %>
<%@ page import="models.MarathonEvent" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    MarathonEvent event = (MarathonEvent) request.getAttribute("event");
    List<Sponsor> sponsors = (List<Sponsor>) request.getAttribute("sponsors");
    List<MarathonType> types = (List<MarathonType>) request.getAttribute("types");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa Marathon Event</title>
        <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css" />
        <style>
            main {
                padding: 80px 20px;
                text-align: center;
                min-height: 70vh;
                background: #f9f9f9;
            }
            form {
                max-width: 600px;
                margin: 0 auto;
                text-align: left;
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
            }
            input[type="text"], input[type="date"], input[type="number"], select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }
            input[type="submit"] {
                margin-top: 20px;
                background-color: #004aad;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #ff6600;
            }
        </style>
    </head>
    <body>

        <header>
            <div class="logo">🏃‍♂️ Marathon System</div>
            <nav>
                <ul>
                    <li><a href="Home">Trang chủ</a></li>
                    <li><a href="Events">Các giải</a></li>
                    <li><a href="list">Quản lý giải chạy</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Chỉnh sửa Marathon Event</h2>

            <form action="editEvent" method="post">
                <input type="hidden" name="eventID" value="${event.eventID}" />

                <label for="eventName">Tên sự kiện:</label>
                <input type="text" id="eventName" name="eventName" value="${event.eventName}" required>

                <label for="location">Địa điểm:</label>
                <input type="text" id="location" name="location" value="${event.location}" required>

                <label for="startDate">Ngày bắt đầu:</label>
                <input type="date" id="startDate" name="startDate" value="${event.startDate}" required>

                <label for="fee">Phí tham gia (VND):</label>
                <input type="number" id="fee" name="fee" step="0.01" value="${event.fee}" required>

                <label for="description">Mô tả sự kiện:</label>
                <textarea id="description" name="description" placeholder="Nhập mô tả ngắn gọn về sự kiện...">${event.description}</textarea>

                <label for="healthRequirement">Yêu cầu sức khỏe:</label>
                <textarea id="healthRequirement" name="healthRequirement" placeholder="Ví dụ: Không mắc bệnh tim mạch, trên 18 tuổi...">${event.healthRequirement}</textarea>


                <label for="imagePath">Link hình ảnh:</label>
                <input type="text" id="imagePath" name="imagePath" value="${event.imagePath}">

                <label for="typeId">Loại sự kiện:</label>
                <select id="typeId" name="typeId" required>
                    <c:forEach var="t" items="${types}">
                        <option value="${t.typeID}" <c:if test="${event.type.typeID == t.typeID}">selected</c:if>>
                            ${t.typeName} - ${t.distance} km
                        </option>
                    </c:forEach>
                </select>

                <label for="sponsorId">Nhà tài trợ:</label>
                <select id="sponsorId" name="sponsorId" required>
                    <c:forEach var="s" items="${sponsors}">
                        <option value="${s.sponsorId}" <c:if test="${event.sponsor.sponsorId == s.sponsorId}">selected</c:if>>
                            ${s.sponsorName}
                        </option>
                    </c:forEach>
                </select>

                <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                    <input type="submit" value="Cập nhật sự kiện">
                    <a href="list" style="text-decoration: none; color: #004aad; font-weight: bold;">← Quay lại danh sách</a>
                </div>
            </form>
        </main>



    </body>
</html>
