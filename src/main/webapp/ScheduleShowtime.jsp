<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo lịch chiếu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="MainManager.jsp">Cinema Manager</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="showtimes">Quản lý lịch chiếu</a></li>
                <li class="nav-item"><a class="nav-link active" href="#">Lên lịch chiếu</a></li>
            </ul>
            <form class="d-flex" method="post" action="auth">
                <input type="hidden" name="action" value="logout">
                <button class="btn btn-outline-light" type="submit">Đăng xuất</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <h2 class="mb-3">Tạo lịch chiếu mới</h2>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <form method="post" action="showtimes">
        <input type="hidden" name="action" value="create">
        <div class="row g-3">
            <div class="col-md-4">
                <label for="showDate" class="form-label">Ngày chiếu</label>
                <input type="date" class="form-control" id="showDate" name="showDate" required>
            </div>
            <div class="col-md-4">
                <label for="startTime" class="form-label">Giờ bắt đầu</label>
                <input type="time" class="form-control" id="startTime" name="startTime" required>
            </div>
            <div class="col-md-4">
                <label for="endTime" class="form-label">Giờ kết thúc</label>
                <input type="time" class="form-control" id="endTime" name="endTime" required>
            </div>
            <div class="col-md-6">
                <label for="movieId" class="form-label">Phim đang chiếu</label>
                <select class="form-select" id="movieId" name="movieId" required>
                    <option value="" disabled selected>Chọn phim</option>
                    <c:forEach items="${moviesNowShowing}" var="movie">
                        <option value="${movie.id}">${movie.title} (${movie.status})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6">
                <label for="roomId" class="form-label">Phòng trống</label>
                <select class="form-select" id="roomId" name="roomId" required>
                    <option value="" disabled selected>Chọn phòng</option>
                    <c:forEach items="${availableRooms}" var="room">
                        <option value="${room.id}">${room.name} - ${room.format}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Xác nhận Tạo lịch chiếu</button>
            <a href="showtimes" class="btn btn-secondary">Quay lại</a>
        </div>
    </form>
</div>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        fetch('movies?action=nowShowing&format=json')
            .then(response => response.json())
            .then(movies => {
                const movieSelect = document.getElementById('movieId');
                Array.from(movieSelect.options).slice(1).forEach(option => option.remove());
                movies.forEach(movie => {
                    const option = document.createElement('option');
                    option.value = movie.id;
                    option.textContent = `${movie.title} (${movie.status || 'Đang chiếu'})`;
                    movieSelect.appendChild(option);
                });
            })
            .catch(() => console.warn('Không thể tải danh sách phim đang chiếu.'));

        fetch('showtimes?action=availableRooms')
            .then(response => response.json())
            .then(rooms => {
                const roomSelect = document.getElementById('roomId');
                Array.from(roomSelect.options).slice(1).forEach(option => option.remove());
                rooms.forEach(room => {
                    const option = document.createElement('option');
                    option.value = room.id;
                    const formatLabel = room.format ? ` (${room.format})` : '';
                    option.textContent = `${room.name}${formatLabel}`;
                    roomSelect.appendChild(option);
                });
            })
            .catch(() => console.warn('Không thể tải danh sách phòng trống.'));
    });
</script>
</body>
</html>
