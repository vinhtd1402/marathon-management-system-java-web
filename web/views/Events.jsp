<%-- 
    Document   : Events.jsp
    Created on : Nov 10, 2025, 10:06:23 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="models.MarathonEvent, java.util.List" %>
<%
    List<MarathonEvent> events = (List<MarathonEvent>) request.getAttribute("events");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Các giải Marathon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/styles.css" />
    <style>
        /* Bổ sung nhẹ cho thanh filter và lưới hiển thị */
        .page-wrap { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .filter-bar {
            display: grid; grid-template-columns: repeat(6, 1fr); gap: 10px;
            background: rgba(255,255,255,.85); padding: 12px; border-radius: 10px; backdrop-filter: blur(6px);
            margin-bottom: 16px;
        }
        .filter-bar input, .filter-bar select { width: 100%; padding: 8px; border-radius: 8px; border: 1px solid #ddd; }
        .filter-actions { display: flex; gap: 10px; align-items: center; }
        .btn-primary { background: #004aad; color: #fff; border: none; padding: 8px 14px; border-radius: 8px; cursor: pointer; }
        .btn-secondary { background: #eee; color: #333; border: none; padding: 8px 14px; border-radius: 8px; cursor: pointer; }
        .events-grid { display: flex; flex-wrap: wrap; gap: 20px; }
        .event-card { width: 280px; } /* dùng sẵn style .event-card của bạn; chỉ đặt width */
        .pill-group { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 8px; }
        .pill { padding: 6px 10px; border-radius: 999px; border: 1px solid #ddd; background: #fff; cursor: pointer; }
        .pill.active { border-color: #004aad; color: #004aad; font-weight: 600; }
        .hint { font-size: 12px; opacity: .75; }
    </style>
</head>
<body>
    <!-- HEADER tái sử dụng layout trang chủ -->
    <header>
        <div class="logo">🏃‍♂️ Hệ thống Marathon</div>
        <nav>
            <ul>
                <li><a href="Home">Trang chủ</a></li>
                <li><a href="Events">Các giải chạy</a></li>
                <li><a href="Comments">Bình luận</a></li>
                <li><a href="About">Giới thiệu</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <c:if test="${sessionScope.account != null}">
                <a href="infor">👋 Xin chào, <b>${sessionScope.account.fullName}</b></a>
                <a href="Logout">Đăng xuất</a>
            </c:if>
            <c:if test="${sessionScope.account == null}">
                <a href="Login">Đăng nhập</a>
                <a href="Signup">Đăng ký</a>
            </c:if>
        </div>
    </header>

    <main class="page-wrap">
        <h2 style="color:#004aad;margin:10px 0 14px">Tất cả các giải</h2>

        <!-- FILTER -->
        <form class="filter-bar" method="get" action="${pageContext.request.contextPath}/Events">
            <input type="text" name="q" value="${param.q}" placeholder="Tìm theo tên/địa điểm..." />

            <select name="typeId">
                <option value="">-- Loại giải --</option>
                <c:forEach items="${requestScope.types}" var="t">
                    <option value="${t.typeID}" ${param.typeId == t.typeID ? 'selected' : ''}>
                        ${t.typeName} (${t.distance} km)
                    </option>
                </c:forEach>
            </select>

            <input type="text" name="location" value="${param.location}" placeholder="Địa điểm" />
            <input type="date" name="fromDate" value="${param.fromDate}" />
            <input type="date" name="toDate" value="${param.toDate}" />
            <div class="filter-actions">
                <button class="btn-primary" type="submit">Lọc</button>
                <a class="btn-secondary" href="${pageContext.request.contextPath}/Events">Reset</a>
            </div>

            <input type="number" step="0.01" min="0" name="minFee" value="${param.minFee}" placeholder="Phí tối thiểu" />
            <input type="number" step="0.01" min="0" name="maxFee" value="${param.maxFee}" placeholder="Phí tối đa" />

            <!-- TÌM THEO KHOẢNG CÁCH -->
            <input type="number" step="0.1" min="0" name="minDist" value="${param.minDist}" placeholder="Km tối thiểu" />
            <input type="number" step="0.1" min="0" name="maxDist" value="${param.maxDist}" placeholder="Km tối đa" />

         
          
        </form>

        <!-- LIST -->
        <div class="events-grid">
            <c:if test="${empty events}">
                <p>Không có giải nào khớp bộ lọc.</p>
            </c:if>

            <c:forEach items="${events}" var="e">
                <div class="event-card">
                    <img src="${e.imagePath}" alt="${e.eventName}" style="width:100%;height:160px;object-fit:cover;border-radius:10px">
                    <h4>${e.eventName}</h4>
                    <div>${e.location}</div>
                    <div>Ngày: <b><fmt:formatDate value="${e.startDate}" pattern="dd/MM/yyyy"/></b></div>
                    <div>Khoảng cách: <b>${e.type.distance} km</b> (${e.type.typeName})</div>
                    <div>Phí: <b><fmt:formatNumber value="${e.fee}" type="currency" currencySymbol="₫"/></b></div>
                    <a class="btn-primary" style="display:inline-block;margin-top:10px;text-decoration:none"
                       href="${pageContext.request.contextPath}/eventDetail?id=${e.eventID}">
                        Xem chi tiết
                    </a>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer>© 2025 Marathon Management System - All rights reserved.</footer>
</body>
</html>
