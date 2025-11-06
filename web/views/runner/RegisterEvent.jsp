<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký sự kiện</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            background-color: #fff;
        }
        h2 { text-align: center; color: #004aad; }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        input[type=submit] {
            background: #004aad;
            color: white;
            cursor: pointer;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đăng ký tham gia sự kiện</h2>
        <form action="${pageContext.request.contextPath}/registerEvent" method="post">
            <input type="hidden" name="eventID" value="${eventID}">
            
            <p>Bạn có chắc muốn đăng ký tham gia sự kiện <strong> ${event.eventName}</strong> không?</p>
            <input type="submit" value="Xác nhận đăng ký">
        </form>
    </div>
</body>
</html>
