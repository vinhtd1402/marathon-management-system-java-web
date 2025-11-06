<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa tài khoản</title>
        <style>
            form {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                margin-top: 10px;
            }
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
        <h2 style="text-align:center;">Chỉnh sửa tài khoản</h2>

        <form action="${pageContext.request.contextPath}/accountManager" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="uID" value="${account.uID}">

            <label>Họ tên:</label>
            <input type="text" name="fullName" value="${account.fullName}" required>

            <label>Giới tính:</label>
            <select name="gender">
                <option value="Nam" ${account.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                <option value="Nữ" ${account.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
            </select>

            <label>Username:</label>
            <input type="text" name="username" value="${account.username}" required>

            <label>Password:</label>
            <input type="password" name="password" value="${account.password}" required>

            <label>Tuổi:</label>
            <input type="number" name="age" value="${account.age}" required>

            <label>Tình trạng sức khỏe:</label>
            <input type="text" name="healthStatus" value="${account.healthStatus}">

            <label>Email:</label>
            <input type="email" name="email" value="${account.email}" required>

            <label>Số điện thoại:</label>
            <input type="text" name="phone" value="${account.phone}" required>


            <c:choose>
                <c:when test="${account.roleID == 3}">
                    <label>Tổng quãng đường:</label>
                    <input type="number" step="0.01" name="totalDistance" value="${account.totalDistance}">
                </c:when>
                <c:otherwise>
                    <p style="color: gray;">Staff không có tổng quãng đường.</p>
                </c:otherwise>
            </c:choose>
            <input type="submit" value="Cập nhật tài khoản">
            <a href="accountManager" style="text-decoration: none; color: #004aad; font-weight: bold;">← Quay lại danh sách</a>
        </form>
    </body>
</html>
