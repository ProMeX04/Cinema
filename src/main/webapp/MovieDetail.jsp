<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie.title} - Chi Tiết Phim</title>
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
                <li class="nav-item"><a class="nav-link" href="Main.jsp"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
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

<div class="container container-cinema">
    <c:if test="${not empty movie}">
        <div class="movie-detail-container mt-4">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <c:if test="${not empty movie.poster}">
                        <img src="${movie.poster}" class="movie-detail-poster img-fluid" alt="Poster ${movie.title}"
                             onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 300 400%22><rect fill=%22%231a1a1a%22 width=%22300%22 height=%22400%22/><text x=%2250%25%22 y=%2250%25%22 fill=%22%23ffc107%22 font-size=%2220%22 text-anchor=%22middle%22 dy=%22.3em%22>${movie.title}</text></svg>'">
                    </c:if>
                    <c:if test="${empty movie.poster}">
                        <div class="movie-detail-poster d-flex align-items-center justify-content-center" 
                             style="background: var(--cinema-light-gray); color: var(--cinema-gold); font-size: 2rem; font-weight: bold; min-height: 500px;">
                            ${movie.title}
                        </div>
                    </c:if>
                </div>
                <div class="col-md-8">
                    <h1 class="movie-detail-title">${movie.title}</h1>
                    
                    <div class="mb-3">
                        <span class="movie-status ${movie.status == 'Now Showing' ? 'status-now-showing' : 'status-coming-soon'}">
                            <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>${movie.status}
                        </span>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <p class="movie-detail-info">
                                <span class="movie-detail-label"><i class="fas fa-star me-1"></i>Đánh giá:</span>
                                <span class="movie-rating">${movie.rating}</span>/10
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="movie-detail-info">
                                <span class="movie-detail-label"><i class="fas fa-clock me-1"></i>Thời lượng:</span>
                                ${movie.duration} phút
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="movie-detail-info">
                                <span class="movie-detail-label"><i class="fas fa-tags me-1"></i>Thể loại:</span>
                                <c:choose>
                                    <c:when test="${not empty movie.genres}">
                                        <c:forEach items="${movie.genres}" var="genre" varStatus="loop">
                                            <span class="badge bg-cinema-gold text-dark me-1">${genre.name}</span>
                                            <c:if test="${!loop.last}"></c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: var(--cinema-text-light);">Chưa có thông tin</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="movie-detail-info">
                                <span class="movie-detail-label"><i class="fas fa-language me-1"></i>Ngôn ngữ:</span>
                                ${movie.language}
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="movie-detail-info">
                                <span class="movie-detail-label"><i class="fas fa-calendar me-1"></i>Ngày khởi chiếu:</span>
                                <fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/>
                            </p>
                        </div>
                    </div>

                    <div class="movie-description">
                        <h4 style="color: var(--cinema-gold); margin-bottom: 1rem;">
                            <i class="fas fa-info-circle me-2"></i>Nội Dung Phim
                        </h4>
                        <p>${movie.description}</p>
                    </div>

                    <div class="mt-4">
                        <c:if test="${not empty movie.trailer}">
                            <a class="btn btn-cinema-primary me-2" href="${movie.trailer}" target="_blank">
                                <i class="fas fa-play-circle me-1"></i>Xem Trailer
                            </a>
                        </c:if>
                        <a href="SearchMovie.jsp" class="btn btn-cinema-outline">
                            <i class="fas fa-arrow-left me-1"></i>Quay Lại
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
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
