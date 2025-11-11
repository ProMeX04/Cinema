<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Gọi MovieServlet để lấy các film đang công chiếu
    // MovieServlet sẽ gọi MovieDAO.getMovieNowShowing()
    request.getRequestDispatcher("/movies?action=nowShowing&include=true").include(request, response);
    
    // Gọi ShowtimeServlet để tìm phòng trống
    // ShowtimeServlet sẽ gọi ShowtimeDAO.findRoomAvailable()
    request.getRequestDispatcher("/showtimes?action=availableRooms&include=true").include(request, response);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Lịch Chiếu - Rạp Chiếu Phim</title>
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
                <li class="nav-item"><a class="nav-link" href="MainManager.jsp"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="ManageShowtime.jsp"><i class="fas fa-calendar-alt me-1"></i>Quản lý lịch chiếu</a></li>
                <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-plus-circle me-1"></i>Tạo lịch chiếu</a></li>
            </ul>
            <form class="d-flex" method="post" action="auth">
                <input type="hidden" name="action" value="logout">
                <button class="btn btn-cinema-outline btn-sm" type="submit">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container container-cinema">
    <div class="row mt-4 mb-4">
        <div class="col-12">
            <h1 class="page-title">
                <i class="fas fa-plus-circle me-2"></i>Tạo Lịch Chiếu Mới
            </h1>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-cinema-success mb-4">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-cinema-danger mb-4">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
        </div>
    </c:if>

    <div class="movie-detail-container">
        <form method="post" action="showtimes">
            <input type="hidden" name="action" value="create">
            <div class="row g-4">
                <div class="col-md-4">
                    <label for="showDate" class="form-label-cinema">
                        <i class="fas fa-calendar me-1"></i>Ngày Chiếu
                    </label>
                    <input type="date" class="form-control form-control-cinema" id="showDate" name="showDate" required>
                </div>
                <div class="col-md-4">
                    <label for="startTime" class="form-label-cinema">
                        <i class="fas fa-clock me-1"></i>Giờ Bắt Đầu
                    </label>
                    <input type="time" class="form-control form-control-cinema" id="startTime" name="startTime" required>
                </div>
                <div class="col-md-4">
                    <label for="endTime" class="form-label-cinema">
                        <i class="fas fa-clock me-1"></i>Giờ Kết Thúc
                    </label>
                    <input type="time" class="form-control form-control-cinema" id="endTime" name="endTime" required>
                </div>
                <div class="col-md-6">
                    <label for="movieId" class="form-label-cinema">
                        <i class="fas fa-film me-1"></i>Phim Đang Chiếu
                    </label>
                    <select class="form-select form-select-cinema" id="movieId" name="movieId" required>
                        <option value="" disabled selected>-- Chọn phim --</option>
                        <c:forEach items="${moviesNowShowing}" var="movie">
                            <option value="${movie.id}">${movie.title} (${movie.status})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="roomId" class="form-label-cinema">
                        <i class="fas fa-door-open me-1"></i>Phòng Trống
                    </label>
                    <select class="form-select form-select-cinema" id="roomId" name="roomId" required>
                        <option value="" disabled selected>-- Chọn phòng --</option>
                        <c:forEach items="${availableRooms}" var="room">
                            <option value="${room.id}">
                                ${room.name} 
                                <c:if test="${not empty room.format}">- ${room.format}</c:if>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="mt-5 text-center">
                <button type="submit" class="btn btn-cinema-primary btn-lg me-3">
                    <i class="fas fa-check-circle me-2"></i>Xác Nhận Tạo Lịch Chiếu
                </button>
                <a href="ManageShowtime.jsp" class="btn btn-cinema-outline btn-lg">
                    <i class="fas fa-arrow-left me-2"></i>Quay Lại
                </a>
            </div>
        </form>
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
