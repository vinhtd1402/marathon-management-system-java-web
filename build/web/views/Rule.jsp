<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%@page import="models.Sponsor"%>
<%@page import="dal.SponsorDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quy Tắc và Điều Lệ</title>
    <link rel="stylesheet" href="/ASS-Marathon/static/css/styles.css">
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

    <div class="container">
        <h1>QUY TẮC & ĐIỀU LỆ</h1>

            <h2>ĐIỀU KIỆN THAM DỰ GIẢI:</h2>
            <p>Người tham dự phải có khả năng hoàn thành đường đua, từ vạch xuất phát đến vạch về đích, trong thời gian quy định cho những cự ly tương ứng dưới đây:</p>
            <ul>
                <li><strong>Marathon/ (42.195km)</strong> – 6 giờ 30 phút sau đợt xuất phát cuối cùng</li>
                <li><strong>Bán Marathon (21.1km)</strong> – 4 giờ sau đợt xuất phát cuối cùng</li>
                <li><strong>10KM</strong> – 2 giờ sau đợt xuất phát cuối cùng</li>
                <li><strong>5KM</strong> – 1 giờ sau đợt xuất phát cuối cùng</li>
            </ul>
            <p><strong>Chú ý:</strong> Sẽ có một số thay đổi hoặc điều chỉnh về các điểm thời gian hoàn thành (địa điểm cố định trên đường đua VĐV phải vượt qua trong thời gian nhất định) tại một số chặng của cuộc đua. Thông tin chi tiết sẽ được thông báo sát với ngày thi đấu.</p>
            <p>Vì lý do an toàn và tránh các trường hợp bị tắc nghẽn tại các nút giao thông, vận động viên phải tuyệt đối nghe theo sự hướng dẫn của Ban tổ chức, bất kì hành vi nào vi phạm sẽ bị hủy bỏ quyền thi đấu ngay lập tức.</p>

            <h3>Yêu cầu về độ tuổi:</h3>
            <p>Những người tham dự phải đáp ứng được những yêu cầu về độ tuổi tương ứng với các cự ly đăng ký:</p>
            <ul>
                <li>Tất cả vận động viên tham gia cự ly <strong>Marathon – 42.195km</strong> phải từ 18 tuổi trở lên tính trong năm 2025.</li>
                <li>Tất cả vận động viên tham gia cự ly <strong>Bán Marathon – 21.1km</strong> phải từ 16 tuổi trở lên tính trong năm 2025.</li>
                <li>Tất cả vận động viên tham gia cự ly <strong>10km</strong> phải từ 14 tuổi trở lên tính trong năm 2025.</li>
                <li>Tất cả vận động viên tham gia cự ly <strong>5km</strong> phải từ 10 tuổi trở lên tính trong năm 2025.</li>
            </ul>
            <p>Tất cả các vận động viên tham gia dưới 18 tuổi tính trong năm 2025 đều phải có sự xác nhận của người bảo hộ hợp pháp hoặc cha mẹ. Người bảo hộ hợp pháp hoặc cha mẹ phải ký vào đơn kê khai đăng ký trước khi diễn ra cuộc đua.</p>
            <p>Ban tổ chức Công ty TNHH MTV Sự kiện Sunrise Việt Nam có quyền từ chối quyền thi đấu đối với các vận động viên chưa hoàn thành đơn xác nhận có chữ ký của người bảo hộ hợp pháp hoặc cha mẹ.</p>
            <p>Mỗi người tham dự phải ký tên vào <strong>giấy miễn trừ trách nhiệm</strong> và <strong>cam kết đua</strong> trước khi tham gia, đây là 1 phần của quy trình đăng ký.</p>
            <p>Vé tham dự và vật dụng kèm theo không được hoàn lại tiền trong bất kì trường hợp nào.</p>
            <p>Mã số BIB dành riêng cho mỗi người tham dự và không thể thay đổi, hoặc bán cho người khác.</p>
            <p>Việc mua bán vé tham dự/BIB bị nghiêm cấm, kết quả sẽ bị không xác nhận và/hoặc cấm các cá nhân liên quan tham dự các sự kiện trong tương lai.</p>
                <h2>ĐIỀU KIỆN HỦY VÀ THAY ĐỔI:</h2>
            <ul>
                <li>Sau khi hoàn thành việc đăng ký, vận động viên sẽ không được hoàn lại phí đăng ký nếu không thể tham gia sự kiện “Giải Marathon Quốc tế Hà Nội Techcombank” với bất kì lý do gì.</li>
                <li>Người tham dự có thể thay đổi hình thức thi đấu. Người tham dự cần gửi email yêu cầu đến Bộ phận phụ trách đăng ký qua email ban tổ chức tại marathontcbhn@sunriseevents.com.vn cùng với phí thay đổi tương ứng.</li>
            </ul>

            <h2>GIẢI CHẠY THIẾU NHI (KIDS RUN):</h2>
            <ul>
                <li>Hạng mục Giải Chạy Thiếu nhi không phải là hạng mục thi đấu tranh giải, vì vậy các vận động viên sẽ không được cấp thiết bị đo thời gian. Ban tổ chức sẽ không ghi nhớ hay lưu giữ thời gian hoàn thành cuộc thi ở hạng mục KIDS RUN.</li>
                <li>Sẽ có 2 mốc thời gian bắt đầu ở KIDS RUN phân theo lứa tuổi:
                    <ul>
                        <li>Từ 5 – 10 tuổi*: 1.5 km</li>
                        <li>Từ 7 – 14 tuổi*: 3 km</li>
                    </ul>
                </li>
                <li>*Tuổi tính trong năm 2025</li>
                <li>Vận động viên tham gia phải đủ 5 tuổi tính trong năm 2025 để tham gia vào hạng mục KIDS RUN. Phụ huynh hoặc người bảo hộ hợp pháp phải điền <strong>giấy miễn trừ trách nghiệm</strong> và <strong>ký cam kết</strong> theo mẫu đơn đăng ký trực tuyến. Ban tổ chức có quyền hủy bỏ thi đấu đối với vận động viên chưa hoàn thành các yêu cầu đưa ra.</li>
                <li>Vì các lý do an toàn, đối với các vận động viên từ 5-6 tuổi, một người phụ huynh hoặc người bảo hộ hợp pháp bắt buộc phải tham gia cùng trong suốt thời gian diễn ra chương trình. Thẻ ghi số báo danh và thông tin sẽ do Ban tổ chức cung cấp. Ban tổ chức có quyền hủy bỏ đối với các cá nhân không đủ điều kiện tham gia chương trình. Chỉ có 01 người (cha/mẹ) hoặc người bảo hộ hợp pháp có thể đi cùng với các vận động viên trong khu vực chạy.</li>
                <li>Phụ huynh/người bảo hộ không được phép vào khu vực chạy đối với trẻ lớn hơn 6 tuổi.</li>
            </ul>

            <h2>GÓI DOANH NGHIỆP:</h2>
            <p>Vui lòng xem thông tin chi tiết tại trang Thử Thách Doanh Nghiệp: https://marathonhn.com/vi/thu-thach-doanh-nghiep/</p>

            <h2>ĐĂNG KÝ GIỮ VẬT DỤNG:</h2>
            <p>Ban tổ chức sẽ không chịu trách nhiệm cho những mất mát hoặc hư hỏng các vật dụng cá nhân tại khu vực cất giữ vật dụng tư trang. Ban tổ chức có quyền kiểm tra túi xách và các vật dụng cá nhân cất giữ tại khu vực đồ dùng cá nhân vì các lý do an toàn.</p>

            <h2>NGÀY THI TRƯỜNG HỢP NGOẠI LỆ:</h2>
            <p>Bất kỳ cá nhân nào không đồng ý với bất kì điều khoản nào của các quy định trên phải gửi yêu cầu trước 30 ngày trước ngày diễn ra sự kiện và phải nêu rõ lý do yêu cầu.</p>

            <h2>PHỤ LỤC:</h2>
            <ul>
                <li>Ban tổ chức sự kiện có quyền thay đổi, bổ sung, hoặc bãi bỏ tất cả hoặc một phần quy định của sự kiện.</li>
                <li>Người tham dự sẽ bị ràng buộc bởi những thay đổi hoặc bổ sung quy định trước ngày diễn ra sự kiện.</li>
                <li>Không tuân thủ các quy định của sự kiện, kể cả những quy định thay đổi, sẽ bị hủy bỏ kết quả, hủy bỏ các giải thưởng và kết quả chính thức.</li>
            </ul>
            <p><em>(*) Các quy tắc & Luật lệ có thể thay đổi theo quyết định từ Ban tổ chức.</em></p>



<div class="sponsor-container">
    <%
        List<Sponsor> list = (List<Sponsor>) request.getAttribute("list");
        if (list != null && !list.isEmpty()) {
            for (Sponsor s : list) {
    %>
        <div class="sponsor-card" title="<%= s.getContactInfo() == null ? "" : s.getContactInfo() %>">
            <img src="<%= s.getImagePath() %>" alt="Logo Nhà Tài Trợ">
            <p><%= s.getSponsorName() %></p>
        </div>
    <%
            }
        } else {
    %>
        <p style="text-align:center;">Hiện chưa có thông tin nhà tài trợ.</p>
    <%
        }
    %>
</div>
    </div>
</body>
</html>
