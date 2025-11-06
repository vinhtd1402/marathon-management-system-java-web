<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm tài khoản mới</title>
    <style>
        form {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        label { display: block; margin-top: 10px; }
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
        }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Thêm tài khoản mới</h2>

    <form action="${pageContext.request.contextPath}/accountManager" method="post">
        <input type="hidden" name="action" value="add">

        <label>Họ tên:</label>
        <input type="text" name="fullName" required>

        <label>Giới tính:</label>
        <select name="gender">
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
        <a href="accountManager" style="text-decoration: none; color: #004aad; font-weight: bold;">← Quay lại danh sách</a>
    </form>
</body>
</html>
