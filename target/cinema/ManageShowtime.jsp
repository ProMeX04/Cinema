<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý lịch chiếu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="MainManager.jsp">Cinema Manager</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="MainManager.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="showtimes">Quản lý lịch chiếu</a></li>
            </ul>
            <form class="d-flex" method="post" action="auth">
                <input type="hidden" name="action" value="logout">
                <button class="btn btn-outline-light" type="submit">Đăng xuất</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Lịch chiếu hiện tại</h2>
        <a href="showtimes?action=prepare" class="btn btn-primary">Thêm mới lịch chiếu</a>
    </div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Bắt đầu</th>
            <th>Kết thúc</th>
            <th>Trạng thái</th>
            <th>Phòng</th>
            <th>Phim</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${showtimes}" var="showtime">
            <tr>
                <td><fmt:formatDate value="${showtime.startTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td><fmt:formatDate value="${showtime.endTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td><c:out value="${showtime.status}"/></td>
                <td>
                    <div><strong>${showtime.room.name}</strong></div>
                    <small class="text-muted">
                        <c:if test="${not empty showtime.room.format}">${showtime.room.format} • </c:if>${showtime.room.cinema.name}
                    </small>
                </td>
                <td>
                    <div><strong>${showtime.movie.title}</strong></div>
                    <small class="text-muted">${showtime.movie.genre}</small>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty showtimes}">
            <tr>
                <td colspan="5" class="text-center text-muted">Hiện chưa có lịch chiếu nào.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
