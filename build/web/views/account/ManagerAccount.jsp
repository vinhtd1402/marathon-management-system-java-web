<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Account" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>👥 Quản lý Tài khoản - Marathon System</title>
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
            .btn-primary {
                background: #007bff;
            }
            .btn-primary:hover {
                background: #0056b3;
            }
            .btn-danger {
                background: #e74c3c;
            }
            .btn-danger:hover {
                background: #c0392b;
            }

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
            tr:hover {
                background: #f1f7ff;
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
            <h2>👥 Quản lý Tài Khoản</h2>

            <div class="top-bar">
                <form action="${pageContext.request.contextPath}/accountManager?action=search" method="post" style="display: flex; gap: 10px;">
                    <input type="text" name="search" placeholder="🔍 Tìm kiếm tài khoản..." value="${search != null ? search : ''}" />
                    <button type="submit">Tìm</button>
                </form>
                <a href="${pageContext.request.contextPath}/accountManager?action=add" class="btn btn-primary">+ Thêm tài khoản mới cho staff</a>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Họ tên</th>
                    <th>Giới tính</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Điện thoại</th>
                    <th>Vai trò</th>
                    <th>Tuổi</th>
                    <th>Tình trạng sức khỏe</th>
                    <th>Tổng quãng đường</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>

                <c:forEach var="a" items="${accounts}">
                    <tr>    
                        <td>${a.uID}</td>
                        <td>${a.fullName}</td>
                        <td>${a.gender}</td>
                        <td>${a.username}</td>
                        <td>${a.email}</td>
                        <td>${a.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.roleID == 1}">Admin</c:when>
                                <c:when test="${a.roleID == 2}">Staff</c:when>
                                 <c:when test="${a.roleID == 3}">Runner</c:when>
                            </c:choose>
                        </td>
                        <td>${a.age}</td>
                        <td>${a.healthStatus}</td>
                        <td>${a.totalDistance}</td>
                        <td>${a.createdAt}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/accountManager?action=edit&id=${a.uID}" class="btn btn-primary">Sửa</a>
                            <a href="${pageContext.request.contextPath}/accountManager?action=delete&id=${a.uID}" 
                               class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa tài khoản này không?');">Xóa</a>

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
