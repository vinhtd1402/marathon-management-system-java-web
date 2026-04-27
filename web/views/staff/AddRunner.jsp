<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Runner mới</title>
    <style>
        form {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        label { display: block; margin-top: 10px; font-weight: 500; }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            margin-top: 20px;
            background-color: #004aad;
            color: white;
            cursor: pointer;
            border: none;
            font-weight: bold;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        a.back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
            color: #004aad;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Thêm tài khoản Runner mới</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="addRunner" method="post">
        <label>Họ tên:</label>
        <input type="text" name="fullName" required>

        <label>Giới tính:</label>
        <select name="gender" required>
            <option value="Nam">Nam</option>
            <option value="Nữ">Nữ</option>
        </select>

        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Tuổi:</label>
        <input type="number" name="age" required>

        <label>Tình trạng sức khỏe:</label>
        <input type="text" name="healthStatus">

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Số điện thoại:</label>
        <input type="text" name="phone" required>

        <input type="submit" value="Thêm tài khoản">
    </form>

    <a href="accountRunner" class="back-link">← Quay lại danh sách Runner</a>
</body>
</html>
