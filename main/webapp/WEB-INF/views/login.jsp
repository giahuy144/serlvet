<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Diễn Đàn Cộng Đồng</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- CSS riêng cho trang login -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/login.css">
</head>
<body>

    <!-- Left side: Slideshow với 5 hình ảnh diễn đàn -->
    <div class="slideshow-container">
        <div class="slideshow">
            <!-- Slide 1: Cộng đồng sôi động -->
            <div class="slide active" style="background-image: url('https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Cộng đồng sôi động</h3>
                    <p>Hơn 50.000 thành viên đang thảo luận sôi nổi mỗi ngày. Tham gia ngay để kết nối với những người cùng đam mê!</p>
                </div>
            </div>
            <!-- Slide 2: Chia sẻ kiến thức -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/5428830/pexels-photo-5428830.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Chia sẻ kiến thức</h3>
                    <p>Hàng ngàn bài viết chất lượng từ các chuyên gia và thành viên giàu kinh nghiệm trong mọi lĩnh vực.</p>
                </div>
            </div>
            <!-- Slide 3: Hỏi đáp nhanh chóng -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/3769021/pexels-photo-3769021.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Hỏi đáp nhanh chóng</h3>
                    <p>Có thắc mắc? Đặt câu hỏi và nhận câu trả lời từ cộng đồng chỉ trong vài phút. Luôn sẵn sàng giúp đỡ!</p>
                </div>
            </div>
            <!-- Slide 4: Giao lưu, kết bạn -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/4050319/pexels-photo-4050319.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Giao lưu, kết bạn</h3>
                    <p>Không chỉ là diễn đàn, đây còn là nơi kết nối những con người, xây dựng những mối quan hệ bền vững.</p>
                </div>
            </div>
            <!-- Slide 5: Sự kiện & hoạt động -->
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/2774556/pexels-photo-2774556.jpeg?auto=compress&cs=tinysrgb&w=1920&h=1080&fit=crop');">
                <div class="slide-content">
                    <h3>Sự kiện & hoạt động</h3>
                    <p>Tham gia các sự kiện online/offline, workshop, talkshow với những diễn giả nổi tiếng hàng tháng.</p>
                </div>
            </div>
        </div>

        <!-- Slide indicators -->
        <div class="indicators">
            <div class="indicator active" onclick="currentSlide(0)"></div>
            <div class="indicator" onclick="currentSlide(1)"></div>
            <div class="indicator" onclick="currentSlide(2)"></div>
            <div class="indicator" onclick="currentSlide(3)"></div>
            <div class="indicator" onclick="currentSlide(4)"></div>
        </div>
    </div>

    <!-- Right side: Login form -->
    <div class="login-wrapper">
        <div class="login-container">
            <div class="brand">
                <div class="logo">
                    <i class="fas fa-comments"></i>
                </div>
                <span class="logo-text">ConnectHub</span>
                <h2>Chào mừng trở lại!</h2>
                <p>Đăng nhập để tham gia thảo luận</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box">
                    ⚠️ <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="login" method="post">
                <div class="input-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập của bạn" required>
                </div>
                
                <div class="input-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit">Đăng Nhập Vào Diễn Đàn</button>
            </form>

            <p class="footer-text">
                Chưa có tài khoản? <a href="#">Đăng ký thành viên</a>
            </p>
        </div>
    </div>

    <!-- JS riêng cho trang login -->
    <script src="${pageContext.request.contextPath}/js/login.js"></script>

    <!-- Ảnh từ Pexels (miễn phí sử dụng) -->
    <div style="display: none;">Photos provided by Pexels</div>

</body>
</html>