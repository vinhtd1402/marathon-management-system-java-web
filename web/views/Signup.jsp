<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css">
    <style>
        .register-container {
            max-width: 420px;
            background: white;
            margin: 80px auto;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }
        .register-container h2 {
            text-align: center;
            color: #004aad;
            margin-bottom: 20px;
        }
        .register-container input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .register-container input[type=submit] {
            background-color: #004aad;
            color: white;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }
        .register-container input[type=submit]:hover {
            background-color: #ff6600;
        }
        .message { color: red; text-align: center; font-size: 14px; margin-top: 10px; }
        .login-link { text-align: center; margin-top: 15px; }
        .login-link a { color: #004aad; font-weight: bold; text-decoration: none; }
        .login-link a:hover { color: #ff6600; }
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

<div class="register-container">
    <h2>Đăng ký tài khoản</h2>
    <form action="Signup" method="post">
        <input type="text" name="fullname" placeholder="Họ và tên" required>
        <select name="gender" required>
            <option value="">-- Chọn giới tính --</option>
            <option value="Nam">Nam</option>
            <option value="Nữ">Nữ</option>
        </select>
        <input type="text" name="username" placeholder="Tên đăng nhập" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <input type="number" name="age" placeholder="Tuổi" required>
        <input type="text" name="healthStatus" placeholder="Tình trạng sức khỏe" required>
        <input type="text" name="email" placeholder="Email">
        <input type="text" name="phone" placeholder="Số điện thoại">
        <input type="submit" value="Đăng ký">
    </form>
    <div class="message">
        <% String msg = (String) request.getAttribute("message");
           if (msg != null) { out.print(msg); } %>
    </div>
    <div class="login-link">
        Đã có tài khoản? <a href="Login">Đăng nhập</a>
    </div>
</div>

<footer>© 2025 Marathon Management System - All rights reserved.</footer>
</body>
</html>
