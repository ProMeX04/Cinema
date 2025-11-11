<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Lý - Rạp Chiếu Phim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/cinema-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-cinema">
    <div class="container">
        <a class="navbar-brand" href="MainManager.jsp">
            <i class="fas fa-user-shield me-2"></i>CINEMA MANAGER
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="MainManager.jsp"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="showtimes"><i class="fas fa-calendar-alt me-1"></i>Quản lý lịch chiếu</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.currentUser}">
                    <span class="navbar-text text-light me-3">
                        <i class="fas fa-user-tie me-1"></i>${sessionScope.currentUser.fullName} (Quản lý)
                    </span>
                    <form class="d-inline" method="post" action="auth">
                        <input type="hidden" name="action" value="logout">
                        <button class="btn btn-cinema-outline btn-sm" type="submit">
                            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="container container-cinema">
    <div class="row mt-5 mb-4">
        <div class="col-12 text-center">
            <h1 class="page-title">
                <i class="fas fa-tachometer-alt me-2"></i>Bảng Điều Khiển Quản Lý
            </h1>
            <p style="color: var(--cinema-text-light); font-size: 1.2rem;">Quản lý hệ thống rạp chiếu phim</p>
        </div>
    </div>
    
    <div class="row g-4">
        <div class="col-md-12">
            <div class="movie-card">
                <div class="movie-card-body text-center p-5">
                    <i class="fas fa-calendar-check fa-4x mb-4" style="color: var(--cinema-red);"></i>
                    <h3 class="movie-title mb-3">Quản Lý Lịch Chiếu</h3>
                    <p class="movie-info mb-4" style="font-size: 1.1rem;">
                        Quản lý các lịch chiếu hiện tại, tạo lịch chiếu mới và theo dõi các suất chiếu
                    </p>
                    <a href="showtimes" class="btn btn-cinema-primary btn-lg">
                        <i class="fas fa-arrow-right me-2"></i>Vào Quản Lý Lịch Chiếu
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
            © 2024 Rạp Chiếu Phim - Hệ Thống Quản Lý
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
