<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.MarathonEvent" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    MarathonEvent event = (MarathonEvent) request.getAttribute("event");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${event.eventName}</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #004aad;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 50px;
        }
        header .logo {
            font-size: 22px;
            font-weight: bold;
        }
        header nav ul {
            list-style: none;
            display: flex;
            gap: 25px;
            margin: 0;
            padding: 0;
        }
        header nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }
        header nav a:hover {
            color: #ffcc00;
        }
        .auth-buttons a {
            color: white;
            margin-left: 15px;
            text-decoration: none;
            font-weight: bold;
        }
        .auth-buttons a:hover {
            color: #ff6600;
        }

        footer {
            text-align: center;
            background: #004aad;
            color: white;
            padding: 15px 0;
            margin-top: 40px;
        }

        /* Bố cục chính */
        .container {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            gap: 25px;
            padding: 0 20px;
        }

        /* Cột trái */
        .left-panel {
            flex: 2;
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .left-panel h2 {
            color: #004aad;
            margin-bottom: 5px;
        }
        .left-panel img.main-img {
            width: 100%;
            border-radius: 10px;
            max-height: 350px;
            object-fit: cover;
            margin: 20px 0;
        }
        .event-info p {
            margin: 5px 0;
            color: #333;
        }

        /* Quy định sự kiện */
        .rules {
            margin-top: 25px;
        }
        .rules h3 {
            color: #004aad;
            margin-bottom: 10px;
        }
        .rule-box {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .rule-item {
            background: #f2f4ff;
            flex: 1 1 calc(25% - 10px);
            border-radius: 10px;
            padding: 15px;
            border-left: 4px solid #004aad;
        }
        .rule-item h4 {
            margin: 0 0 5px 0;
            color: #004aad;
        }

        /* Cột phải */
        .right-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .box {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .countdown {
            text-align: center;
            color: #004aad;
            font-weight: bold;
        }
        .register-btn {
            display: block;
            background: #004aad;
            color: white;
            text-align: center;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            margin-top: 15px;
            font-weight: bold;
        }
        .register-btn:hover {
            background-color: #ff6600;
        }

        /* Nhà tài trợ */
        .sponsor-box {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .sponsor-box img {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 3px solid #004aad;
            object-fit: cover;
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
            <li><a href="Comments">Bình luận</a></li>
            <li><a href="About">Thông tin khác</a></li>
        </ul>
    </nav>
     <div class="auth-buttons">
                <c:if test="${sessionScope.account != null}">
                   <a href="infor" > <span>👋 Xin chào, <b>${sessionScope.account.fullName}</b></span></a>
                    <a href="Logout" class="logout-btn">Đăng xuất</a>
                </c:if>
                <c:if test="${sessionScope.account == null}">
                    <a href="Login">Đăng nhập</a>
                    <a href="Signup">Đăng ký</a>
                </c:if>
            </div>
</header>

<div class="container">

    <!-- Cột trái -->
    <div class="left-panel">
        <h2>${event.eventName}</h2>
        <p><b>🗓️ Thời gian diễn ra:</b> ${event.startDate}</p>
        <p><b>📍 Địa điểm:</b> ${event.location}</p>

        <h3 style="margin-top: 30px; color: #004aad;">📋 Quy định sự kiện</h3>
<div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-top: 10px;">

    <div style="background: #f8f9ff; border-left: 4px solid #004aad; padding: 15px; border-radius: 8px; text-align: center;">
        <h4>🏁 Loại giải</h4>
        <p style="margin:0;">${event.type.typeName}</p>
    </div>

    <div style="background: #f8f9ff; border-left: 4px solid #004aad; padding: 15px; border-radius: 8px; text-align: center;">
        <h4>📏 Cự ly</h4>
        <p style="margin:0;">${event.type.distance} km</p>
    </div>

    <div style="background: #f8f9ff; border-left: 4px solid #004aad; padding: 15px; border-radius: 8px; text-align: center;">
        <h4>💰 Phí tham gia</h4>
        <p style="margin:0;">${event.fee} VND</p>
    </div>

    <div style="background: #f8f9ff; border-left: 4px solid #004aad; padding: 15px; border-radius: 8px; text-align: center;">
        <h4>🩺 Quy định sức khỏe</h4>
        <p style="margin:0;">${event.healthRequirement}</p>
    </div>

</div>

        
        <img src="${event.imagePath}" class="main-img" alt="Ảnh giải chạy">

       

        <div style="margin-top: 25px;">
            <h3>📝 Mô tả</h3>
            <p>${event.description}</p>
        </div>

        <div style="margin-top: 30px;">
            <h3>🏢 Nhà tài trợ</h3>
            <div class="sponsor-box">
                <img src="${event.sponsor.imagePath}" alt="Sponsor Logo">
                <p><b>${event.sponsor.sponsorName}</b></p>
            </div>
        </div>
    </div>

    <!-- Cột phải -->
    <div class="right-panel">
        <div class="box countdown">
          
            <%
    java.time.LocalDate today = java.time.LocalDate.now();
    java.time.LocalDate startDate = java.time.LocalDate.parse(event.getStartDate().toString());
    boolean expired = startDate.isBefore(today);
%>

<c:choose>
    <c:when test="<%= expired %>">
        <a class="register-btn" style="background: gray; cursor: not-allowed; pointer-events: none;">
            Đã hết hạn đăng ký
        </a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/registerEvent?eventID=${event.eventID}" class="register-btn">
            Đăng ký ngay
        </a>
    </c:otherwise>
</c:choose>

        </div>

        <div class="box">
            <h3>ℹ️ Thông tin giải đấu</h3>
            <p>${event.description}</p>
        </div>

        <div class="box">
    <h3>🏢 Đơn vị tổ chức</h3>
    <div style="display: flex; align-items: center; gap: 15px;">
        <img src="${event.sponsor.imagePath}" 
             alt="Logo sponsor" 
             style="width:150px; height:auto; object-fit:contain;">
        <p style="font-weight:bold; color:#333; margin:0;">${event.sponsor.sponsorName}</p>
    </div>
</div>

    </div>

</div>

<footer>
    © 2025 Marathon Management System - All rights reserved.
</footer>

</body>
</html>
