<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <% request.getRequestDispatcher("/movies?action=nowShowing&include=true").include(request, response); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Tạo Lịch Chiếu - Rạp Chiếu Phim</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet" href="css/cinema-style.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-dark navbar-cinema">
                        <div class="container">
                            <a class="navbar-brand" href="MainManager.jsp">
                                <i class="fas fa-user-shield me-2"></i>CINEMA MANAGER
                            </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav me-auto">
                                    <li class="nav-item"><a class="nav-link" href="MainManager.jsp"><i
                                                class="fas fa-home me-1"></i>Trang chủ</a></li>
                                    <li class="nav-item"><a class="nav-link" href="ManageShowtime.jsp"><i
                                                class="fas fa-calendar-alt me-1"></i>Quản lý lịch chiếu</a></li>
                                    <li class="nav-item"><a class="nav-link active" href="#"><i
                                                class="fas fa-plus-circle me-1"></i>Tạo lịch chiếu</a></li>
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
                                <input type="hidden" id="selectedMovieId" name="movieId" required>
                                <input type="hidden" id="selectedRoomId" name="roomId" required>

                                <!-- Phần chọn thời gian -->
                                <div class="row g-4 mb-4">
                                    <div class="col-12">
                                        <h3 class="mb-3" style="color: var(--cinema-gold);">
                                            <i class="fas fa-calendar-alt me-2"></i>Thông Tin Thời Gian
                                        </h3>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="showDate" class="form-label-cinema">
                                            <i class="fas fa-calendar me-1"></i>Ngày Chiếu
                                        </label>
                                        <input type="date" class="form-control form-control-cinema" id="showDate"
                                            name="showDate" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="startTime" class="form-label-cinema">
                                            <i class="fas fa-clock me-1"></i>Giờ Bắt Đầu
                                        </label>
                                        <input type="time" class="form-control form-control-cinema" id="startTime"
                                            name="startTime" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="endTime" class="form-label-cinema">
                                            <i class="fas fa-clock me-1"></i>Giờ Kết Thúc
                                        </label>
                                        <input type="time" class="form-control form-control-cinema" id="endTime"
                                            name="endTime" required>
                                    </div>
                                    <div class="col-12 text-center">
                                        <button type="button" class="btn btn-cinema-primary btn-lg" id="confirmTimeBtn">
                                            <i class="fas fa-check-circle me-2"></i>Xác Nhận Thời Gian
                                        </button>
                                    </div>
                                </div>

                                <!-- Phần chọn phim -->
                                <div class="row g-4 mb-4">
                                    <div class="col-12">
                                        <h3 class="mb-3" style="color: var(--cinema-gold);">
                                            <i class="fas fa-film me-2"></i>Chọn Phim Đang Chiếu
                                        </h3>
                                    </div>
                                    <div class="col-12">
                                        <label for="movieSearch" class="form-label-cinema">
                                            <i class="fas fa-search me-1"></i>Tìm Kiếm Phim
                                        </label>
                                        <input type="text" class="form-control form-control-cinema" id="movieSearch"
                                            placeholder="Nhập tên phim để tìm kiếm...">
                                    </div>
                                    <div class="col-12">
                                        <div class="movie-list-container"
                                            style="max-height: 300px; overflow-y: auto; border: 1px solid var(--cinema-dark-gray); border-radius: 8px; padding: 15px;">
                                            <div id="movieList">
                                                <p class="text-center text-muted">Đang tải danh sách phim...</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Phần chọn phòng -->
                                <div class="row g-4 mb-4">
                                    <div class="col-12">
                                        <h3 class="mb-3" style="color: var(--cinema-gold);">
                                            <i class="fas fa-door-open me-2"></i>Chọn Phòng Trống
                                        </h3>
                                    </div>
                                    <div class="col-12">
                                        <label for="roomSearch" class="form-label-cinema">
                                            <i class="fas fa-search me-1"></i>Tìm Kiếm Phòng
                                        </label>
                                        <input type="text" class="form-control form-control-cinema" id="roomSearch"
                                            placeholder="Nhập tên phòng để tìm kiếm...">
                                    </div>
                                    <div class="col-12">
                                        <div class="room-list-container"
                                            style="max-height: 300px; overflow-y: auto; border: 1px solid var(--cinema-dark-gray); border-radius: 8px; padding: 15px;">
                                            <div id="roomList">
                                                <p class="text-center text-muted">Vui lòng xác nhận thời gian để xem
                                                    danh
                                                    sách phòng trống</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-5 text-center">
                                    <button type="submit" class="btn btn-cinema-primary btn-lg me-3" id="submitBtn"
                                        disabled>
                                        <i class="fas fa-check-circle me-2"></i>Xác Nhận Tạo Lịch Chiếu
                                    </button>
                                    <a href="ManageShowtime.jsp" class="btn btn-cinema-outline btn-lg">
                                        <i class="fas fa-arrow-left me-2"></i>Quay Lại
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <footer class="text-center py-4 mt-5"
                        style="background: var(--cinema-dark-gray); border-top: 2px solid var(--cinema-red);">
                        <div class="container">
                            <p class="mb-0" style="color: var(--cinema-text-light);">
                                <i class="fas fa-film me-2" style="color: var(--cinema-gold);"></i>
                                © 2024 Rạp Chiếu Phim - Hệ Thống Quản Lý
                            </p>
                        </div>
                    </footer>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        let allMovies = [];
                        let allRooms = [];
                        let selectedMovieId = null;
                        let selectedRoomId = null;
                        let timeConfirmed = false;

                        function loadMovies() {
                            fetch('movies?action=nowShowing&format=json')
                                .then(response => response.json())
                                .then(movies => {
                                    allMovies = movies.map(movie => {
                                        let status = movie.status;
                                        if (status === false || status === 'false' || status === null || status === undefined) {
                                            status = '';
                                        }
                                        return {
                                            id: movie.id,
                                            title: movie.title || '',
                                            status: status || '',
                                            duration: movie.duration || 0
                                        };
                                    });
                                    searchMovies();
                                })
                                .catch(error => {
                                    console.error('Không thể tải danh sách phim:', error);
                                });
                        }

                        function searchMovies() {
                            const searchTerm = document.getElementById('movieSearch').value.toLowerCase();
                            const movieList = document.getElementById('movieList');
                            movieList.innerHTML = '';

                            const filteredMovies = allMovies.filter(movie =>
                                movie.title.toLowerCase().includes(searchTerm)
                            );

                            if (filteredMovies.length === 0) {
                                movieList.innerHTML = '<p class="text-center text-muted">Không tìm thấy phim nào</p>';
                                return;
                            }

                            filteredMovies.forEach(movie => {
                                const movieItem = document.createElement('div');
                                movieItem.className = 'movie-item mb-3 p-3';
                                movieItem.style.cssText = 'border: 2px solid transparent; border-radius: 8px; cursor: pointer; transition: all 0.3s;';
                                movieItem.setAttribute('data-movie-id', movie.id);
                                movieItem.onclick = () => selectMovie(movie.id, movie.title);

                                const isSelected = selectedMovieId === movie.id;
                                if (isSelected) {
                                    movieItem.style.borderColor = 'var(--cinema-gold)';
                                    movieItem.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                                }

                                let statusText = '';
                                if (movie.status &&
                                    movie.status !== false &&
                                    movie.status !== 'false' &&
                                    movie.status !== 'null' &&
                                    movie.status !== 'undefined' &&
                                    movie.status !== null &&
                                    movie.status !== undefined) {
                                    const statusStr = String(movie.status);
                                    if (statusStr && statusStr.trim() !== '') {
                                        statusText = statusStr;
                                    }
                                }

                                const durationText = movie.duration && movie.duration > 0 ? ' • ' + movie.duration + ' phút' : '';

                                const movieTitle = movie.title || '';
                                const movieStatusHtml = statusText || durationText ? '<small style="color: var(--cinema-text-light);">' + statusText + durationText + '</small>' : '';
                                const checkIconDisplay = isSelected ? 'block' : 'none';

                                movieItem.innerHTML =
                                    '<div class="d-flex justify-content-between align-items-center">' +
                                    '<div>' +
                                    '<h5 style="color: var(--cinema-gold); margin: 0;">' + movieTitle + '</h5>' +
                                    movieStatusHtml +
                                    '</div>' +
                                    '<i class="fas fa-check-circle" style="display: ' + checkIconDisplay + '; color: var(--cinema-gold);"></i>' +
                                    '</div>';
                                movieList.appendChild(movieItem);
                            });
                        }

                        function selectMovie(movieId, movieTitle) {
                            selectedMovieId = movieId;
                            document.getElementById('selectedMovieId').value = movieId;

                            document.querySelectorAll('.movie-item').forEach(item => {
                                const id = parseInt(item.getAttribute('data-movie-id'));
                                if (id === movieId) {
                                    item.style.borderColor = 'var(--cinema-gold)';
                                    item.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                                    item.querySelector('.fa-check-circle').style.display = 'block';
                                } else {
                                    item.style.borderColor = 'transparent';
                                    item.style.backgroundColor = 'transparent';
                                    item.querySelector('.fa-check-circle').style.display = 'none';
                                }
                            });

                            checkSubmitButton();
                        }

                        function searchRooms() {
                            if (!timeConfirmed) {
                                return;
                            }

                            const searchTerm = document.getElementById('roomSearch').value.toLowerCase();
                            const roomList = document.getElementById('roomList');
                            roomList.innerHTML = '';

                            const filteredRooms = allRooms.filter(room =>
                                room.name.toLowerCase().includes(searchTerm)
                            );

                            if (filteredRooms.length === 0) {
                                roomList.innerHTML = '<p class="text-center text-muted">Không tìm thấy phòng nào</p>';
                                return;
                            }

                            filteredRooms.forEach(room => {
                                const roomItem = document.createElement('div');
                                roomItem.className = 'room-item mb-3 p-3';
                                roomItem.style.cssText = 'border: 2px solid transparent; border-radius: 8px; cursor: pointer; transition: all 0.3s;';
                                roomItem.setAttribute('data-room-id', room.id);
                                roomItem.onclick = () => selectRoom(room.id, room.name);

                                const isSelected = selectedRoomId === room.id;
                                if (isSelected) {
                                    roomItem.style.borderColor = 'var(--cinema-gold)';
                                    roomItem.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                                }

                                let formatText = '';
                                if (room.format &&
                                    room.format !== false &&
                                    room.format !== 'false' &&
                                    room.format !== 'null' &&
                                    room.format !== 'undefined' &&
                                    room.format !== null &&
                                    room.format !== undefined) {
                                    const formatStr = String(room.format);
                                    if (formatStr && formatStr.trim() !== '') {
                                        formatText = formatStr;
                                    }
                                }

                                const capacityText = room.capacity && room.capacity > 0 ? ' • ' + room.capacity + ' ghế' : '';

                                const roomName = room.name || '';
                                const roomFormatHtml = formatText || capacityText ? '<small style="color: var(--cinema-text-light);">' + formatText + capacityText + '</small>' : '';
                                const roomCheckIconDisplay = isSelected ? 'block' : 'none';

                                roomItem.innerHTML =
                                    '<div class="d-flex justify-content-between align-items-center">' +
                                    '<div>' +
                                    '<h5 style="color: var(--cinema-gold); margin: 0;">' + roomName + '</h5>' +
                                    roomFormatHtml +
                                    '</div>' +
                                    '<i class="fas fa-check-circle" style="display: ' + roomCheckIconDisplay + '; color: var(--cinema-gold);"></i>' +
                                    '</div>';
                                roomList.appendChild(roomItem);
                            });
                        }

                        function selectRoom(roomId, roomName) {
                            selectedRoomId = roomId;
                            document.getElementById('selectedRoomId').value = roomId;

                            document.querySelectorAll('.room-item').forEach(item => {
                                const id = parseInt(item.getAttribute('data-room-id'));
                                if (id === roomId) {
                                    item.style.borderColor = 'var(--cinema-gold)';
                                    item.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                                    item.querySelector('.fa-check-circle').style.display = 'block';
                                } else {
                                    item.style.borderColor = 'transparent';
                                    item.style.backgroundColor = 'transparent';
                                    item.querySelector('.fa-check-circle').style.display = 'none';
                                }
                            });

                            checkSubmitButton();
                        }

                        function confirmTime() {
                            const showDate = document.getElementById('showDate').value;
                            const startTime = document.getElementById('startTime').value;
                            const endTime = document.getElementById('endTime').value;

                            if (!showDate || !startTime || !endTime) {
                                alert('Vui lòng chọn đầy đủ ngày và giờ chiếu!');
                                return;
                            }

                            if (endTime <= startTime) {
                                alert('Giờ kết thúc phải sau giờ bắt đầu!');
                                return;
                            }

                            const roomsUrl = 'showtimes?action=availableRooms&date=' + showDate + '&startTime=' + startTime + '&endTime=' + endTime;
                            fetch(roomsUrl)
                                .then(response => response.json())
                                .then(rooms => {
                                    allRooms = rooms.map(room => {
                                        let format = room.format;
                                        if (format === false || format === 'false' || format === null || format === undefined) {
                                            format = '';
                                        }
                                        return {
                                            id: room.id,
                                            name: room.name || '',
                                            format: format || '',
                                            capacity: room.capacity || 0
                                        };
                                    });
                                    timeConfirmed = true;

                                    const roomList = document.getElementById('roomList');
                                    if (rooms.length === 0) {
                                        roomList.innerHTML = '<p class="text-center text-danger">Không có phòng trống tại thời điểm này!</p>';
                                    } else {
                                        searchRooms();
                                    }

                                    const confirmBtn = document.getElementById('confirmTimeBtn');
                                    confirmBtn.classList.remove('btn-cinema-primary');
                                    confirmBtn.classList.add('btn-success');
                                    confirmBtn.innerHTML = '<i class="fas fa-check-circle me-2"></i>Đã Xác Nhận';
                                })
                                .catch(() => {
                                    alert('Không thể tải danh sách phòng trống. Vui lòng thử lại!');
                                });
                        }

                        function checkSubmitButton() {
                            const submitBtn = document.getElementById('submitBtn');
                            if (selectedMovieId && selectedRoomId && timeConfirmed) {
                                submitBtn.disabled = false;
                            } else {
                                submitBtn.disabled = true;
                            }
                        }

                        document.querySelector('form').addEventListener('submit', function (e) {
                            const showDate = document.getElementById('showDate').value;
                            const startTime = document.getElementById('startTime').value;
                            const endTime = document.getElementById('endTime').value;
                            const movieId = document.getElementById('selectedMovieId').value;
                            const roomId = document.getElementById('selectedRoomId').value;

                            console.log('Form submit - showDate:', showDate, 'startTime:', startTime, 'endTime:', endTime);
                            console.log('Form submit - movieId:', movieId, 'roomId:', roomId);

                            if (!showDate || !startTime || !endTime) {
                                e.preventDefault();
                                alert('Vui lòng chọn đầy đủ ngày và giờ chiếu!');
                                return false;
                            }

                            if (!movieId || movieId === '') {
                                e.preventDefault();
                                alert('Vui lòng chọn phim!');
                                return false;
                            }

                            if (!roomId || roomId === '') {
                                e.preventDefault();
                                alert('Vui lòng chọn phòng!');
                                return false;
                            }

                            if (!timeConfirmed) {
                                e.preventDefault();
                                alert('Vui lòng xác nhận thời gian trước khi tạo lịch chiếu!');
                                return false;
                            }

                            const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
                            if (!dateRegex.test(showDate)) {
                                e.preventDefault();
                                alert('Ngày chiếu không hợp lệ!');
                                return false;
                            }

                            return true;
                        });

                        document.addEventListener('DOMContentLoaded', () => {
                            document.getElementById('movieSearch').addEventListener('input', searchMovies);
                            document.getElementById('roomSearch').addEventListener('input', searchRooms);
                            document.getElementById('confirmTimeBtn').addEventListener('click', confirmTime);
                            loadMovies();
                        });
                    </script>
                </body>

                </html>