<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="alert alert-danger">
        <h4 class="alert-heading">Đã xảy ra lỗi!</h4>
        <p><c:out value="${errorMessage}" default="Có lỗi không mong muốn. Vui lòng thử lại sau."/></p>
        <hr>
        <a href="Main.jsp" class="btn btn-primary">Quay lại trang chủ</a>
    </div>
</div>
</body>
</html>
