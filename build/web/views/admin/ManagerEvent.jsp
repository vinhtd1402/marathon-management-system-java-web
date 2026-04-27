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
    <title>🏁 Quản lý giải chạy - Marathon System</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css" />
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            color: #333;
        }
        header {
            background: #004aad;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header .logo {
            font-size: 22px;
            font-weight: bold;
        }
        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }
        nav a:hover {
            text-decoration: underline;
        }
        .auth-buttons {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logout-btn {
            background: #ff5252;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }
        .logout-btn:hover {
            background: #e03b3b;
        }

        main {
            padding: 30px 50px;
        }
        h2 {
            text-align: center;
            color: #004aad;
            margin-bottom: 25px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .top-bar input[type="text"] {
            padding: 8px 10px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .top-bar button {
            padding: 8px 12px;
            background: #007bff;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .top-bar button:hover {
            background: #0056b3;
        }
        .btn {
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-size: 14px;
            transition: 0.3s;
        }
        .btn-primary { background: #007bff; }
        .btn-primary:hover { background: #0056b3; }
        .btn-danger { background: #e74c3c; }
        .btn-danger:hover { background: #c0392b; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 10px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background: #004aad;
            color: white;
            font-weight: 600;
        }
        tr:hover { background: #f1f7ff; }

        img {
            border-radius: 5px;
            box-shadow: 0 0 3px rgba(0,0,0,0.1);
        }

        footer {
            background: #004aad;
            color: white;
            text-align: center;
            padding: 12px 0;
            margin-top: 40px;
            font-size: 14px;
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
                        <li><a href="accountManager">Quản lý Account</a></li> 
                        </c:if>  
                        <c:if test="${sessionScope.account.roleID == 2 }">
                        <li><a href="accountRunner">Quản lý runner</a></li> 
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
        <h2>🏁 Quản lý Giải Chạy</h2>

        <div class="top-bar">
            <form action="list" method="post" style="display: flex; gap: 10px;">
                <input type="text" name="search" placeholder="🔍 Tìm kiếm sự kiện..." value="${search != null ? search : ''}" />
                <button type="submit">Tìm</button>
            </form>
            <a href="addEvent" class="btn btn-primary">+ Thêm sự kiện mới</a>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Tên Giải</th>
                <th>Địa điểm</th>
                <th>Ngày bắt đầu</th>
                <th>Phí</th>
                <th>Loại giải</th>
                <th>Nhà tài trợ</th>
                <th>Ảnh</th>
                <th>Hành động</th>
            </tr>

            <c:forEach var="e" items="${events}">
                <tr>
                    <td>${e.eventID}</td>
                    <td>${e.eventName}</td>
                    <td>${e.location}</td>
                    <td>${e.startDate}</td>
                    <td>${e.fee}</td>
                    <td>${e.type != null ? e.type.typeName : 'Không có'}</td>
                    <td>${e.sponsor != null ? e.sponsor.sponsorName : 'Không có'}</td>
                    <td>
                        <c:if test="${not empty e.imagePath}">
                            <img src="${e.imagePath}" alt="Ảnh" width="100">
                        </c:if>
                    </td>
                    <td>
                        <a href="editEvent?id=${e.eventID}" class="btn btn-primary">Sửa</a>
                        <a href="deleteEvent?id=${e.eventID}" class="btn btn-danger" 
                           onclick="return confirm('Bạn có chắc muốn xóa sự kiện này không?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 Marathon Management System — Designed by Hung 🏃‍♂️
    </footer>
</body>
</html>
