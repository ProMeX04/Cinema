Manager chọn "Quản lý lịch chiếu" trong MainManager.jsp
MainManager.jsp chuyển đến ManageShowtime.jsp
ManageShowtime.jsp gọi ShowtimeServlet
ShowtimeServlet gọi ShowtimeDAO
ShowtimeDAO gọi phương thức findCurrentShowtime()
findCurrentShowtime() truy vấn database
findCurrentShowtime() gọi lớp Showtime để đóng gói dữ liệu
ShowtimeDAO trả về danh sách Showtime cho ShowtimeServlet
ShowtimeServlet trả về dữ liệu cho ManageShowtime.jsp
ManageShowtime.jsp hiển thị danh sách lịch chiếu cho Manager
Manager chọn "Thêm Mới Lịch Chiếu" trong ManageShowtime.jsp
ManageShowtime.jsp chuyển đến ScheduleShowtime.jsp
ScheduleShowtime.jsp gọi MovieServlet
MovieServlet gọi MovieDAO
MovieDAO gọi phương thức getMovieNowShowing()
getMovieNowShowing() truy vấn database
getMovieNowShowing() gọi lớp Movie để đóng gói dữ liệu
MovieDAO trả về danh sách Movie cho MovieServlet
MovieServlet trả về danh sách phim đang chiếu cho ScheduleShowtime.jsp
ScheduleShowtime.jsp hiển thị danh sách phim cho người dùng
Người dùng nhập ngày và khung giờ trong ScheduleShowtime.jsp
Người dùng click "Xác Nhận Thời Gian" trong ScheduleShowtime.jsp
ScheduleShowtime.jsp gọi ShowtimeServlet để tìm phòng trống
ShowtimeServlet gọi ShowtimeDAO
ShowtimeDAO gọi phương thức findRoomAvailable()
findRoomAvailable() truy vấn database
findRoomAvailable() gọi lớp Room để đóng gói dữ liệu
ShowtimeDAO trả về danh sách Room trống cho ShowtimeServlet
ShowtimeServlet trả về danh sách phòng trống cho ScheduleShowtime.jsp
ScheduleShowtime.jsp hiển thị danh sách phòng trống cho người dùng
Người dùng chọn phim, phòng và xác nhận tạo lịch chiếu trong ScheduleShowtime.jsp
ScheduleShowtime.jsp gọi ShowtimeServlet
ShowtimeServlet gọi ShowtimeDAO
ShowtimeServlet gọi lớp Showtime để đóng gói dữ liệu
ShowtimeServlet gọi ShowtimeDAO.save()
ShowtimeDAO.save() insert dữ liệu vào database
ShowtimeDAO trả về kết quả cho ShowtimeServlet
ShowtimeServlet redirect về ManageShowtime.jsp với thông báo thành công
ManageShowtime.jsp hiển thị thông báo thành công cho Manager
