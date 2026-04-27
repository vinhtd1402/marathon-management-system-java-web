<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 0;
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
            font-size: 20px;
            font-weight: bold;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
        }
        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        nav a:hover {
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

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }
        h1 {
            color: #004aad;
            margin-bottom: 10px;
            text-align: center;
        }
        p.subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        .card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .card h2 {
            color: #004aad;
            margin-bottom: 1rem;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 8px;
        }
        .card p {
            margin: 8px 0;
            line-height: 1.5;
        }
        .card strong {
            display: inline-block;
            width: 130px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #f1f1f1;
        }
    </style>
</head>

<body>
    <!-- 🔹 HEADER -->
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

    <!-- 🔹 MAIN CONTENT -->
    <div class="container">
        <h1>Bảng điều khiển Marathon</h1>
        <p class="subtitle">Theo dõi tiến trình và quản lý các giải chạy của bạn</p>

        <!-- Lưới hiển thị -->
        <div class="grid">
            <!-- Thông tin cá nhân -->
            <div class="card">
                <h2>👤 Thông tin cá nhân</h2>
                <p><strong>Họ và tên:</strong> ${sessionScope.account.fullName}</p>
                <p><strong>Giới tính:</strong> ${sessionScope.account.gender}</p>
                <p><strong>Tuổi:</strong> ${sessionScope.account.age}</p>
                <p><strong>Email:</strong> ${sessionScope.account.email}</p>
                <p><strong>Số điện thoại:</strong> ${sessionScope.account.phone}</p>
                <p><strong>Tình trạng sức khỏe:</strong> ${sessionScope.account.healthStatus}</p>
                <p><strong>Ngày tham gia:</strong> 
                    <fmt:formatDate value="${sessionScope.account.createdAt}" pattern="dd/MM/yyyy"/>
                </p>
            </div>

            <!-- Tổng quãng đường -->
            <div class="card">
                <h2>🏃‍♂️ Tổng quãng đường</h2>
                <p style="font-size:22px; font-weight:bold; text-align:center;">
                    <fmt:formatNumber value="${sessionScope.account.totalDistance}" type="number" maxFractionDigits="2"/> km
                </p>
            </div>
        </div>

        <!-- Các sự kiện đã tham gia -->
        <div class="card" style="margin-top: 1.5rem;">
            <h2>🎟️ Các sự kiện đã tham gia</h2>
            <c:if test="${empty regList}">
                <p>Bạn chưa tham gia giải chạy nào.</p>
            </c:if>
            <c:if test="${not empty regList}">
                <table>
                    <tr>
                        <th>Tên giải chạy</th>
                        <th>Lệ phí (VND)</th>
                        <th>Ngày đăng ký</th>
                        <th>Trạng thái thanh toán</th>
                    </tr>
                    <c:forEach var="r" items="${regList}">
                        <tr>
                            <td>${r.event.eventName}</td>
                            <td><fmt:formatNumber value="${r.event.fee}" type="number" groupingUsed="true"/></td>
                            <td><fmt:formatDate value="${r.registerDate}" pattern="dd/MM/yyyy"/></td>
                            <td>${r.paymentStatus}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>
