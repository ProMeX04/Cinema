<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="Main.jsp">Cinema System</a>
    </div>
</nav>
<div class="container mt-4">
    <c:if test="${not empty movie}">
        <div class="row">
            <div class="col-md-4">
                <c:if test="${not empty movie.poster}">
                    <img src="${movie.poster}" class="img-fluid rounded" alt="Poster ${movie.title}">
                </c:if>
            </div>
            <div class="col-md-8">
                <h2>${movie.title}</h2>
                <p><strong>Thể loại:</strong> ${movie.genre}</p>
                <p><strong>Ngôn ngữ:</strong> ${movie.language}</p>
                <p><strong>Thời lượng:</strong> ${movie.duration} phút</p>
                <p><strong>Đánh giá:</strong> ${movie.rating}</p>
                <p><strong>Ngày khởi chiếu:</strong>
                    <fmt:formatDate value="${movie.releaseDate}" pattern="dd/MM/yyyy"/>
                </p>
                <p><strong>Trạng thái:</strong> ${movie.status}</p>
                <p>${movie.description}</p>
                <c:if test="${not empty movie.trailer}">
                    <a class="btn btn-outline-info me-2" href="${movie.trailer}" target="_blank">Xem trailer</a>
                </c:if>
                <a href="SearchMovie.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
