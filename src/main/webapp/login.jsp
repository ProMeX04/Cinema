<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Rạp Chiếu Phim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/cinema-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="text-center mb-4">
            <i class="fas fa-film fa-3x mb-3" style="color: var(--cinema-gold);"></i>
            <h2 class="login-title">ĐĂNG NHẬP</h2>
            <p style="color: var(--cinema-text-light);">Rạp Chiếu Phim</p>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-cinema-danger mb-4">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            </div>
        </c:if>
        
        <form method="post" action="auth">
            <div class="mb-3">
                <label for="username" class="form-label-cinema">
                    <i class="fas fa-user me-1"></i>Tên đăng nhập
                </label>
                <input type="text" class="form-control form-control-cinema" id="username" name="username" 
                       placeholder="Nhập tên đăng nhập" required autofocus>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label-cinema">
                    <i class="fas fa-lock me-1"></i>Mật khẩu
                </label>
                <input type="password" class="form-control form-control-cinema" id="password" name="password" 
                       placeholder="Nhập mật khẩu" required>
            </div>
            <button type="submit" class="btn btn-cinema-primary w-100">
                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
            </button>
        </form>
        
        <div class="text-center mt-4">
            <a href="Main.jsp" style="color: var(--cinema-text-light); text-decoration: none;">
                <i class="fas fa-arrow-left me-1"></i>Quay lại trang chủ
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
