<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Sponsor" %>
<%@ page import="models.MarathonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    List<Sponsor> sponsors = (List<Sponsor>) request.getAttribute("sponsors");
    List<MarathonType> types = (List<MarathonType>) request.getAttribute("types");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Marathon Event</title>
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
            <h2>Thêm Marathon Event Mới</h2>

            <form action="addEvent" method="post">
                <label for="eventName">Tên sự kiện:</label>
                <input type="text" id="eventName" name="eventName" required>

                <label for="location">Địa điểm:</label>
                <input type="text" id="location" name="location" required>

                <label for="startDate">Ngày bắt đầu:</label>
                <input type="date" id="startDate" name="startDate" required>

                <label for="fee">Phí tham gia (VND):</label>
                <input type="number" id="fee" name="fee" step="0.01" required>
                
                 <label for="description">Mô tả sự kiện:</label>
                <textarea id="description" name="description" placeholder="Nhập mô tả ngắn gọn về sự kiện..."></textarea>

                <label for="healthRequirement">Yêu cầu sức khỏe:</label>
                <textarea id="healthRequirement" name="healthRequirement" placeholder="Ví dụ: Không mắc bệnh tim mạch, trên 18 tuổi..."></textarea>


                <label for="imagePath">Link hình ảnh:</label>
                <input type="text" id="imagePath" name="imagePath">

                <label for="typeId">Loại sự kiện:</label>
                <select id="typeId" name="typeId" required>
                    <c:forEach var="t" items="${types}">
                        <option value="${t.typeID}">${t.typeName} - ${t.distance} km</option>
                    </c:forEach>
                </select>

                <label for="sponsorId">Nhà tài trợ:</label>
                <select id="sponsorId" name="sponsorId" required>
                    <c:forEach var="s" items="${sponsors}">
                        <option value="${s.sponsorId}">${s.sponsorName}</option>
                    </c:forEach>
                </select>

                <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                    <input type="submit" value="Thêm sự kiện" style="padding: 12px 25px; border-radius: 6px; border: none; background-color: #004aad; color: white; cursor: pointer;">
                    <a href="list" style="text-decoration: none; color: #004aad; font-weight: bold;">← Quay lại danh sách</a>
                </div>


            </form>
        </main>

      
    </body>
</html>
