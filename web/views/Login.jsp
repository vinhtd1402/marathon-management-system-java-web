<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css">
    <style>
        .login-container {
            max-width: 400px;
            background: white;
            margin: 80px auto;
            padding: 35px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }
        .login-container h2 {
            text-align: center;
            color: #004aad;
            margin-bottom: 25px;
        }
        .login-container input[type=text], .login-container input[type=password] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .login-container button {
            width: 100%;
            background-color: #004aad;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }
        .login-container button:hover {
            background-color: #ff6600;
        }
        .message {
            color: red;
            text-align: center;
            font-size: 14px;
            margin-top: 10px;
        }
        .signup-link { text-align: center; margin-top: 15px; }
        .signup-link a { color: #004aad; font-weight: bold; text-decoration: none; }
        .signup-link a:hover { color: #ff6600; }
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
        <a href="Login">Đăng nhập</a>
        <a href="Signup">Đăng ký</a>
    </div>
</header>

<div class="login-container">
    <h2>Đăng nhập</h2>
    <form action="Login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <button type="submit">Đăng nhập</button>
    </form>
    <div class="message">
        <% String msg = (String) request.getAttribute("message");
           if (msg != null) { out.print(msg); } %>
    </div>
    <div class="signup-link">
        Chưa có tài khoản? <a href="Signup">Đăng ký ngay</a>
    </div>
</div>

<footer>© 2025 Marathon Management System - All rights reserved.</footer>
</body>
</html>
