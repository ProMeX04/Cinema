<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Quản lý</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="MainManager.jsp">Cinema Manager</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="MainManager.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="showtimes">Quản lý lịch chiếu</a></li>
            </ul>
            <form class="d-flex" method="post" action="auth">
                <input type="hidden" name="action" value="logout">
                <button class="btn btn-outline-light" type="submit">Đăng xuất</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Lịch chiếu</h5>
                    <p class="card-text">Quản lý các lịch chiếu hiện tại và tạo lịch mới.</p>
                    <a href="showtimes" class="btn btn-primary">Quản lý lịch chiếu</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Thống kê</h5>
                    <p class="card-text">Xem báo cáo phim, khách hàng và doanh thu (placeholder).</p>
                    <a href="#" class="btn btn-outline-secondary disabled">Đang phát triển</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Quản lý phòng</h5>
                    <p class="card-text">Cập nhật thông tin phòng chiếu (placeholder).</p>
                    <a href="#" class="btn btn-outline-secondary disabled">Đang phát triển</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
