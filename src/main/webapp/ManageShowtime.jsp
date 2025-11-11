<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Gọi ShowtimeServlet để lấy dữ liệu lịch chiếu
    // ShowtimeServlet sẽ gọi ShowtimeDAO.findCurrentShowtime()
    request.getRequestDispatcher("/showtimes?include=true").include(request, response);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Lịch Chiếu - Rạp Chiếu Phim</title>
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
                <li class="nav-item"><a class="nav-link active" href="ManageShowtime.jsp"><i class="fas fa-calendar-alt me-1"></i>Quản lý lịch chiếu</a></li>
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
    <div class="d-flex justify-content-between align-items-center mb-4 mt-4">
        <h1 class="page-title mb-0" style="text-align: left;">
            <i class="fas fa-calendar-alt me-2"></i>Lịch Chiếu Hiện Tại
        </h1>
        <a href="ScheduleShowtime.jsp" class="btn btn-cinema-primary">
            <i class="fas fa-plus-circle me-1"></i>Thêm Mới Lịch Chiếu
        </a>
    </div>
    
    <div class="movie-detail-container">
        <div class="table-responsive">
            <table class="table table-cinema">
                <thead>
                <tr>
                    <th><i class="fas fa-clock me-1"></i>Bắt Đầu</th>
                    <th><i class="fas fa-clock me-1"></i>Kết Thúc</th>
                    <th><i class="fas fa-info-circle me-1"></i>Trạng Thái</th>
                    <th><i class="fas fa-door-open me-1"></i>Phòng</th>
                    <th><i class="fas fa-film me-1"></i>Phim</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${showtimes}" var="showtime">
                    <tr>
                        <td style="color: var(--cinema-gold); font-weight: 600;">
                            <fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td style="color: var(--cinema-text-light);">
                            <fmt:formatDate value="${showtime.endTime}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td>
                            <span class="movie-status ${showtime.status == 'Scheduled' ? 'status-now-showing' : 'status-coming-soon'}">
                                ${showtime.status}
                            </span>
                        </td>
                        <td>
                            <div style="color: var(--cinema-gold); font-weight: 600;">
                                <i class="fas fa-door-open me-1"></i>${showtime.room.name}
                            </div>
                            <small style="color: var(--cinema-text-light);">
                                <c:if test="${not empty showtime.room.format}">
                                    <i class="fas fa-video me-1"></i>${showtime.room.format}
                                </c:if>
                                <c:if test="${not empty showtime.room.cinema.name}">
                                    • <i class="fas fa-building me-1"></i>${showtime.room.cinema.name}
                                </c:if>
                            </small>
                        </td>
                        <td>
                            <div style="color: var(--cinema-gold); font-weight: 600;">
                                ${showtime.movie.title}
                            </div>
                            <small style="color: var(--cinema-text-light);">
                                <c:if test="${not empty showtime.movie.genres}">
                                    <i class="fas fa-tags me-1"></i>
                                    <c:forEach items="${showtime.movie.genres}" var="genre" varStatus="loop">
                                        ${genre.name}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </c:if>
                            </small>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty showtimes}">
                    <tr>
                        <td colspan="5" class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-calendar-times"></i>
                            </div>
                            <h4 style="color: var(--cinema-text-light);">Hiện chưa có lịch chiếu nào</h4>
                            <p style="color: var(--cinema-text-light);">Hãy tạo lịch chiếu mới để bắt đầu</p>
                            <a href="ScheduleShowtime.jsp" class="btn btn-cinema-primary mt-3">
                                <i class="fas fa-plus-circle me-1"></i>Tạo Lịch Chiếu Đầu Tiên
                            </a>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
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
