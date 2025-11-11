<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rạp Chiếu Phim - Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/cinema-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-cinema">
    <div class="container">
        <a class="navbar-brand" href="Main.jsp">
            <i class="fas fa-film me-2"></i>CINEMA
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="Main.jsp"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="SearchMovie.jsp"><i class="fas fa-search me-1"></i>Tìm kiếm Phim</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.currentUser}">
                    <span class="navbar-text text-light me-3">
                        <i class="fas fa-user me-1"></i>Xin chào, ${sessionScope.currentUser.fullName}
                    </span>
                    <form class="d-inline" method="post" action="auth">
                        <input type="hidden" name="action" value="logout">
                        <button class="btn btn-cinema-outline btn-sm" type="submit">
                            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                        </button>
                    </form>
                </c:if>
                <c:if test="${empty sessionScope.currentUser}">
                    <a href="login.jsp" class="btn btn-cinema-outline btn-sm">
                        <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="hero-section">
    <div class="container">
        <h1 class="hero-title">🎬 RẠP CHIẾU PHIM</h1>
        <p class="hero-subtitle">Khám phá thế giới điện ảnh tuyệt vời</p>
        <a href="SearchMovie.jsp" class="btn btn-cinema-primary btn-lg">
            <i class="fas fa-search me-2"></i>Tìm kiếm Phim Ngay
        </a>
    </div>
</div>

<div class="container container-cinema">
    <div class="row mt-5 mb-4">
        <div class="col-12 text-center">
            <h2 class="page-title">Tính Năng Nổi Bật</h2>
        </div>
    </div>
    <div class="row g-4">
        <div class="col-md-6 col-lg-4">
            <div class="movie-card">
                <div class="text-center p-4">
                    <i class="fas fa-search fa-3x mb-3" style="color: var(--cinema-gold);"></i>
                    <h4 class="movie-title">Tìm Kiếm Phim</h4>
                    <p class="movie-info">Tìm kiếm thông tin chi tiết về các bộ phim đang chiếu và sắp chiếu</p>
                    <a href="SearchMovie.jsp" class="btn btn-cinema-primary mt-3">
                        <i class="fas fa-arrow-right me-1"></i>Tìm Ngay
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4">
            <div class="movie-card">
                <div class="text-center p-4">
                    <i class="fas fa-calendar-alt fa-3x mb-3" style="color: var(--cinema-red);"></i>
                    <h4 class="movie-title">Lịch Chiếu</h4>
                    <p class="movie-info">Xem lịch chiếu các bộ phim mới nhất tại rạp của chúng tôi</p>
                    <a href="SearchMovie.jsp" class="btn btn-cinema-primary mt-3">
                        <i class="fas fa-arrow-right me-1"></i>Xem Lịch
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4">
            <div class="movie-card">
                <div class="text-center p-4">
                    <i class="fas fa-star fa-3x mb-3" style="color: var(--cinema-gold);"></i>
                    <h4 class="movie-title">Đánh Giá</h4>
                    <p class="movie-info">Xem đánh giá và điểm số của các bộ phim từ khán giả</p>
                    <a href="SearchMovie.jsp" class="btn btn-cinema-primary mt-3">
                        <i class="fas fa-arrow-right me-1"></i>Xem Đánh Giá
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center py-4 mt-5" style="background: var(--cinema-dark-gray); border-top: 2px solid var(--cinema-red);">
    <div class="container">
        <p class="mb-0" style="color: var(--cinema-text-light);">
            <i class="fas fa-film me-2" style="color: var(--cinema-gold);"></i>
            © 2024 Rạp Chiếu Phim. Tất cả quyền được bảo lưu.
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
