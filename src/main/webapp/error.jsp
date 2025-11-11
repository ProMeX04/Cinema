<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi Hệ Thống - Rạp Chiếu Phim</title>
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
    </div>
</nav>

<div class="container container-cinema">
    <div class="row mt-5">
        <div class="col-md-8 offset-md-2">
            <div class="movie-detail-container text-center">
                <div class="empty-state-icon mb-4">
                    <i class="fas fa-exclamation-triangle" style="color: var(--cinema-red); font-size: 5rem;"></i>
                </div>
                <h1 class="page-title" style="color: var(--cinema-red);">Đã Xảy Ra Lỗi!</h1>
                <div class="alert alert-cinema-danger mt-4">
                    <i class="fas fa-info-circle me-2"></i>
                    <c:out value="${errorMessage}" default="Có lỗi không mong muốn. Vui lòng thử lại sau."/>
                </div>
                <div class="mt-4">
                    <a href="Main.jsp" class="btn btn-cinema-primary me-2">
                        <i class="fas fa-home me-1"></i>Quay Lại Trang Chủ
                    </a>
                    <a href="SearchMovie.jsp" class="btn btn-cinema-outline">
                        <i class="fas fa-search me-1"></i>Tìm Kiếm Phim
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
