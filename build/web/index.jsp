<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Account" %>
<%@ page import="models.MarathonEvent" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    
    List<MarathonEvent> events = (List<MarathonEvent>) request.getAttribute("events");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Marathon Management System</title>
        <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css" />
        <style>
            /* === THÊM CUỘN NGANG === */
            .event-scroll {
                display: flex;
                overflow-x: auto;
                gap: 25px;
                padding: 20px;
                scroll-behavior: smooth;
            }

            .event-scroll::-webkit-scrollbar {
                height: 10px;
            }
            .event-scroll::-webkit-scrollbar-thumb {
                background: #004aad;
                border-radius: 5px;
            }
            .event-scroll::-webkit-scrollbar-thumb:hover {
                background: #ff6600;
            }
        </style>
    </head>
    <body>

        <!-- HEADER -->
        <header>
            <div class="logo">🏃‍♂️ Marathon System</div>
            <nav>
                <ul>
                    <li><a href="Home">Trang chủ</a></li>
                    <li><a href="Events">Các giải</a></li>
                    <li><a href="Comments">Bình luận</a></li>
                    <li><a href="About">Thông tin khác</a></li>
                        <c:if test="${sessionScope.account.roleID == 1 }">
                        <li><a href="list">Quản lý giải chạy</a></li> 
                        </c:if>             
                        <c:if test="${sessionScope.account.roleID == 2 }">
                        <li><a href="list">Quản lý giải chạy</a></li> 
                        </c:if> 
                        <c:if test="${sessionScope.account.roleID == 1 }">
                        <li><a href="accountManager">Quản lý runner</a></li> 
                        </c:if>  
                         <c:if test="${sessionScope.account.roleID == 2 }">
                        <li><a href="staffManager">Duyệt đơn</a></li> 
                        </c:if>  
                        <c:if test="${sessionScope.account.roleID == 1 }">
                        <li><a href="staffManager">Duyệt đơn</a></li> 
                        </c:if> 
                        
                        
                        
                </ul>
            </nav>
            <div class="auth-buttons">
                <c:if test="${sessionScope.account != null}">
                    <span>👋 Xin chào, <b>${sessionScope.account.fullName}</b></span>
                    <a href="Logout" class="logout-btn">Đăng xuất</a>
                </c:if>
                <c:if test="${sessionScope.account == null}">
                    <a href="Login">Đăng nhập</a>
                    <a href="Signup">Đăng ký</a>
                </c:if>
            </div>
        </header>

        <!-- MAIN -->
        <main>
            <h2>Chào mừng bạn đến với hệ thống Marathon</h2>
            <p>Khám phá, đăng ký và tham gia các giải chạy cùng cộng đồng yêu chạy bộ!</p>

            <a href="Home" class="btn">Khám phá các giải chạy</a>

            <hr/>

            <h3>🏅 Các giải nổi bật</h3>
            <% if (events != null && !events.isEmpty()) { %>
            <div class="event-scroll">
                <% for (MarathonEvent e : events) { %>
                <div class="event-card">
                    <img src="<%= e.getImagePath() %>" alt="Ảnh giải chạy" class="event-img">
                    <h4><%= e.getEventName() %></h4>
                    <p>📍 <%= e.getLocation() %></p>
                    <p>🗓️ <%= e.getStartDate() %></p>
                    <p>💰 <%= e.getFee() %> VND</p>
                    <a href="eventDetail?id=<%= e.getEventID() %>" class="btn">Xem chi tiết</a>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <p>Chưa có giải chạy nào được đăng.</p>
            <% } %>
        </main>

        <!-- FOOTER -->
        <footer>
            © 2025 Marathon Management System - All rights reserved.
        </footer>

    </body>
</html>
