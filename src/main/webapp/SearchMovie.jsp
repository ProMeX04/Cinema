<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm Phim - Rạp Chiếu Phim</title>
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
                <li class="nav-item"><a class="nav-link active" href="SearchMovie.jsp"><i class="fas fa-search me-1"></i>Tìm kiếm Phim</a></li>
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
    <div class="row mt-4 mb-4">
        <div class="col-12">
            <h1 class="page-title">
                <i class="fas fa-search me-2"></i>Tìm Kiếm Phim
            </h1>
        </div>
    </div>

    <div class="search-section">
        <form method="post" action="movies" class="row g-3">
            <div class="col-md-10">
                <div class="input-group">
                    <span class="input-group-text" style="background: var(--cinema-dark); border-color: var(--cinema-light-gray); color: var(--cinema-gold);">
                        <i class="fas fa-search"></i>
                    </span>
                    <input type="text" class="form-control form-control-cinema" name="keyword" 
                           placeholder="Nhập tên phim bạn muốn tìm..." value="${keyword}">
                </div>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-cinema-primary w-100">
                    <i class="fas fa-search me-1"></i>Tìm Kiếm
                </button>
            </div>
        </form>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-cinema-warning mt-3" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${message}
        </div>
    </c:if>

    <c:if test="${not empty movies}">
        <div class="row mt-4 mb-4">
            <div class="col-12">
                <h3 style="color: var(--cinema-gold);">
                    <i class="fas fa-film me-2"></i>Kết Quả Tìm Kiếm (${movies.size()} phim)
                </h3>
            </div>
        </div>
    </c:if>

    <div class="row g-4">
        <c:forEach items="${movies}" var="movie">
            <div class="col-md-6 col-lg-4">
                <div class="movie-card">
                    <c:set var="movieImage" value="${not empty movie.imageUrl ? movie.imageUrl : movie.poster}" />
                    <c:if test="${not empty movieImage}">
                        <c:choose>
                            <c:when test="${fn:startsWith(movieImage, 'http://') or fn:startsWith(movieImage, 'https://')}">
                                <c:set var="imageSrc" value="${movieImage}" />
                            </c:when>
                            <c:when test="${fn:startsWith(movieImage, '/')}">
                                <c:set var="imageSrc" value="${pageContext.request.contextPath}${movieImage}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="imageSrc" value="${pageContext.request.contextPath}/${movieImage}" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${imageSrc}" class="movie-poster" alt="Poster ${movie.title}" 
                             onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 300 400%22><rect fill=%22%231a1a1a%22 width=%22300%22 height=%22400%22/><text x=%2250%25%22 y=%2250%25%22 fill=%22%23ffc107%22 font-size=%2220%22 text-anchor=%22middle%22 dy=%22.3em%22>${movie.title}</text></svg>'">
                    </c:if>
                    <c:if test="${empty movieImage}">
                        <div class="movie-poster d-flex align-items-center justify-content-center" 
                             style="background: var(--cinema-light-gray); color: var(--cinema-gold); font-size: 1.5rem; font-weight: bold;">
                            ${movie.title}
                        </div>
                    </c:if>
                    <div class="movie-card-body">
                        <h5 class="movie-title">${movie.title}</h5>
                        <div class="mb-2">
                            <span class="movie-status ${movie.status == 'Now Showing' ? 'status-now-showing' : 'status-coming-soon'}">
                                <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>${movie.status}
                            </span>
                        </div>
                        <p class="movie-info">
                            <i class="fas fa-star me-1" style="color: var(--cinema-gold);"></i>
                            <span class="movie-rating">${movie.rating}</span>/10
                        </p>
                        <p class="movie-info">
                            <i class="fas fa-clock me-1"></i>${movie.duration} phút
                        </p>
                        <p class="movie-info">
                            <i class="fas fa-calendar me-1"></i>
                            <fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/>
                        </p>
                        <p class="movie-info text-truncate" style="max-height: 3rem; overflow: hidden;">
                            ${movie.description}
                        </p>
                        <a href="movies?action=detail&id=${movie.id}" class="btn btn-cinema-primary w-100 mt-3">
                            <i class="fas fa-info-circle me-1"></i>Xem Chi Tiết
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty movies && not empty keyword}">
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-film"></i>
            </div>
            <h3 style="color: var(--cinema-text-light);">Không tìm thấy phim nào</h3>
            <p style="color: var(--cinema-text-light);">Vui lòng thử lại với từ khóa khác</p>
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
