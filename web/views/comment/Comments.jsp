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
            background-color: #f3f6fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #004aad, #007bff);
            color: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header .logo {
            font-size: 22px;
            font-weight: bold;
        }

        header nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 25px;
        }

        header nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 14px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        header nav ul li a:hover, 
        header nav ul li a.active {
            background: #ff6600;
        }

        main {
            padding: 40px 20px;
        }

        .comment-box {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 25px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #004aad;
            margin-bottom: 25px;
        }

        .comment {
            background: #f9fbff;
            border-left: 5px solid #004aad;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .comment:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .comment strong {
            color: #004aad;
            font-size: 1.05em;
        }

        .comment em {
            display: block;
            color: gray;
            font-size: 0.9em;
            margin-bottom: 8px;
        }

        form {
            margin-top: 25px;
            background: #f6f9ff;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #d9e3f5;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input:focus, textarea:focus {
            border-color: #004aad;
            outline: none;
        }

        button {
            background: linear-gradient(90deg, #004aad, #007bff);
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }

        button:hover {
            background: #ff6600;
            transform: translateY(-1px);
        }

        .error {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-top: 15px;
        }

        footer {
            margin-top: 60px;
            text-align: center;
            padding: 15px 0;
            background: #004aad;
            color: white;
            font-size: 14px;
        }

        footer a {
            color: #ffcc80;
            text-decoration: none;
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
        <div class="comment-box">
            <h2>💬 Lời khuyên từ cộng đồng</h2>

            <c:choose>
                <c:when test="${not empty advices}">
                    <c:forEach var="ad" items="${advices}">
                        <div class="comment">
                            <strong>${ad.account.fullName}</strong>
                            <em>${ad.createdAt}</em>
                            <p><b>${ad.title}</b></p>
                            <p>${ad.message}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align:center; color: gray;">Chưa có lời khuyên nào được đăng.</p>
                </c:otherwise>
            </c:choose>

            <hr style="margin: 25px 0; border: none; border-top: 2px dashed #ccc;">

            <c:if test="${not empty sessionScope.account}">
                <h3 style="color:#004aad;">📝 Gửi lời khuyên mới</h3>
                <form action="Comments" method="post">
                    <label for="title">Tiêu đề</label>
                    <input type="text" id="title" name="title" placeholder="Nhập tiêu đề..." required>
                    <label for="message">Nội dung</label>
                    <textarea id="message" name="message" rows="4" placeholder="Nhập nội dung..." required></textarea>
                    <button type="submit">Đăng</button>
                </form>
            </c:if>

            <c:if test="${empty sessionScope.account}">
                <p style="text-align:center; color:#004aad;">Vui lòng <a href="Login" style="color:#ff6600; font-weight:bold;">đăng nhập</a> để gửi lời khuyên.</p>
            </c:if>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
        </div>
    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 Marathon Management System — Designed with ❤️ by Team Marathon
    </footer>

</body>
</html>
