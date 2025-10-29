<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm phim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="Main.jsp">Cinema System</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="Main.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="SearchMovie.jsp">Tìm kiếm Phim</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <h2 class="mb-4">Tìm kiếm thông tin phim</h2>
    <form class="row gy-2 gx-3 align-items-center" method="post" action="movies">
        <div class="col-sm-6">
            <input type="text" class="form-control" name="keyword" placeholder="Nhập tên phim" value="${keyword}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
    </form>
    <c:if test="${not empty message}">
        <div class="alert alert-warning mt-3" role="alert">${message}</div>
    </c:if>
    <div class="row mt-4">
        <c:forEach items="${movies}" var="movie">
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <c:if test="${not empty movie.poster}">
                        <img src="${movie.poster}" class="card-img-top" alt="Poster ${movie.title}">
                    </c:if>
                    <div class="card-body">
                        <h5 class="card-title">${movie.title}</h5>
                        <p class="card-text mb-1"><strong>Trạng thái:</strong> ${movie.status}</p>
                        <p class="card-text mb-1"><strong>Đánh giá:</strong> ${movie.rating}</p>
                        <p class="card-text mb-1"><strong>Thời lượng:</strong> ${movie.duration} phút</p>
                        <p class="card-text mb-1"><strong>Khởi chiếu:</strong>
                            <fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/>
                        </p>
                        <p class="card-text text-truncate" style="max-height: 4.5rem;">${movie.description}</p>
                        <a href="movies?action=detail&id=${movie.id}" class="btn btn-outline-primary">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
