<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký sự kiện</title>
    <style>
        /* Reset một số style cơ bản */
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            background: linear-gradient(to right, #e0f0ff, #f8faff);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .form-container {
            background-color: #fff;
            max-width: 500px;
            width: 90%;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
        }

        h2 {
            margin-bottom: 25px;
            color: #004aad;
            font-size: 1.8em;
        }

        .error-message {
            color: #d8000c;
            background-color: #ffbaba;
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        p {
            font-size: 1.1em;
        }

        input[type="submit"], .btn-back {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"] {
            background-color: #004aad;
            color: #fff;
        }

        input[type="submit"]:hover {
            background-color: #0066ff;
        }

        .btn-back {
            background-color: #ccc;
            color: #333;
            text-decoration: none;
            display: inline-block;
        }

        .btn-back:hover {
            background-color: #aaa;
            color: #fff;
        }

        a.btn-back {
            display: block;
            margin-top: 10px;
            padding: 12px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đăng ký tham gia sự kiện</h2>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/registerEvent" method="post">
            <input type="hidden" name="eventID" value="${eventID}">
            <p>Bạn có chắc muốn đăng ký tham gia sự kiện <strong>${event.eventName}</strong> không?</p>
            <input type="submit" value="Xác nhận đăng ký">
            <a class="btn-back" href="eventDetail?id=${eventID}">Quay về</a>
        </form>
    </div>
</body>
</html>
