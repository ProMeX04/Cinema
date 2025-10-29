<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Quản lý Rạp chiếu phim - Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="Main.jsp">Cinema System</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="Main.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="SearchMovie.jsp">Tìm kiếm Phim</a></li>
            </ul>
            <form class="d-flex" method="post" action="auth">
                <input type="hidden" name="action" value="logout">
                <button class="btn btn-outline-light" type="submit">Đăng xuất</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">Chào mừng đến với hệ thống đặt vé trực tuyến</h1>
            <p class="col-md-8 fs-4">Hãy tìm kiếm bộ phim yêu thích của bạn và đặt vé ngay hôm nay!</p>
            <a class="btn btn-primary btn-lg" href="SearchMovie.jsp">Tìm kiếm Phim</a>
        </div>
    </div>
</div>
</body>
</html>
