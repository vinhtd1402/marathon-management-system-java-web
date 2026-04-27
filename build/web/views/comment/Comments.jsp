<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lời khuyên & Bình luận</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }

        /* Thanh menu */
        .navbar {
            background-color: #333;
            overflow: hidden;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #04AA6D;
            color: white;
        }

        /* Nội dung */
    .container {
    padding: 30px;
    background: white;
    margin: 40px auto;
    width: 80%;
    border-radius: 10px;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
}

/* CSS nhà tài trợ */
.sponsor-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 25px;
    margin-top: 20px;
}

.sponsor-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    padding: 15px;
    width: 140px;
    text-align: center;
    transition: all 0.3s ease;
}

.sponsor-card img {
    width: 100%;
    height: 80px;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.sponsor-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 15px rgba(0,0,0,0.15);
}

.sponsor-card:hover img {
    transform: scale(1.08);
}

.sponsor-card p {
    font-size: 14px;
    color: #333;
    margin-top: 10px;
    font-weight: bold;
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
    <div class="comment-box">
        <h2 style="text-align:center; color:#004aad; margin-bottom:25px;">💬 Lời khuyên từ cộng đồng</h2>

        <c:choose>
            <c:when test="${not empty advices}">
                <c:forEach var="ad" items="${advices}">
                    <div class="comment" style="
                        background:#f9f9ff;
                        border-left:5px solid #004aad;
                        padding:15px 20px;
                        margin-bottom:20px;
                        border-radius:8px;
                        box-shadow:0 2px 5px rgba(0,0,0,0.05);
                        transition: transform 0.2s ease;">
                        <strong style="color:#004aad;">${ad.account.fullName}</strong>
                        <em style="float:right; color:#777; font-size:13px;">${ad.createdAt}</em>
                        <p style="margin-top:8px; font-weight:bold; color:#333;">${ad.title}</p>
                        <p style="margin-top:5px; color:#555;">${ad.message}</p>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="text-align:center; color: gray;">Chưa có lời khuyên nào được đăng.</p>
            </c:otherwise>
        </c:choose>

        <hr style="margin: 25px 0; border: none; border-top: 2px dashed #ccc;">

        <c:if test="${not empty sessionScope.account}">
            <h3 style="color:#004aad; margin-bottom:10px;">📝 Gửi lời khuyên mới</h3>
            <form action="Comments" method="post" style="
                background:#f0f6ff;
                padding:20px;
                border-radius:10px;
                box-shadow:0 2px 8px rgba(0,0,0,0.05);
            ">
                <label for="title" style="font-weight:bold; color:#004aad;">Tiêu đề</label>
                <input type="text" id="title" name="title" placeholder="Nhập tiêu đề..." required
                    style="width:100%; padding:10px; margin:10px 0 15px 0; border:1px solid #ccc; border-radius:6px;">

                <label for="message" style="font-weight:bold; color:#004aad;">Nội dung</label>
                <textarea id="message" name="message" rows="4" placeholder="Nhập nội dung..." required
                    style="width:100%; padding:10px; margin:10px 0 15px 0; border:1px solid #ccc; border-radius:6px; resize: vertical;"></textarea>

                <button type="submit" style="
                    background:#004aad;
                    color:white;
                    border:none;
                    padding:10px 20px;
                    border-radius:6px;
                    cursor:pointer;
                    font-weight:bold;
                    transition: background 0.3s ease;">
                    Đăng
                </button>
            </form>
        </c:if>

        <c:if test="${empty sessionScope.account}">
            <p style="text-align:center; color:#004aad;">
                Vui lòng <a href="Login" style="color:#ff6600; font-weight:bold;">đăng nhập</a> để gửi lời khuyên.
            </p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="error" style="color:red; text-align:center; font-weight:bold;">${error}</p>
        </c:if>
    </div>
</main>

    <!-- FOOTER -->
    <footer>
        © 2025 Marathon Management System — Designed with ❤️ by Team Marathon
    </footer>

</body>
</html>
