Tiêu đề: Tạo dự án Java J2EE "Hệ thống Quản lý Rạp chiếu phim.

Mô tả chung:
Bạn được yêu cầu tạo một dự án ứng dụng web Java J2EE hoàn chỉnh cho một Hệ thống Quản lý Rạp chiếu phim. Hệ thống này phục vụ ba vai trò người dùng chính: Nhân viên Quản lý, Nhân viên Bán hàng và Khách hàng. Dự án phải được xây dựng theo kiến trúc 3 tầng (Client, Server, Database) và tuân thủ chặt chẽ các kịch bản chi tiết, sơ đồ lớp và công nghệ được chỉ định.

1. Công nghệ (Technology Stack):

Kiến trúc: 3 tầng (Client-Server-Database).

Ngôn ngữ: Java (JDK 21).

Nền tảng: J2EE.

Backend (Controller): Java Servlets (ví dụ: MovieServlet, ShowtimeServlet).

Frontend (View): JSP (JavaServer Pages).

Máy chủ ứng dụng: Apache Tomcat v9+.

Cơ sở dữ liệu: MySQL

Connector: MySQL Connector J.

2. Cấu trúc dự án (Mô hình MVC):
Dự án phải được tổ chức theo các gói (packages) tuân thủ mô hình MVC:

View: Gói chứa các file JSP cho giao diện người dùng.

Servlet: Gói chứa các Servlet đóng vai trò Controller.

DAO (Data Access Object): Gói chứa các lớp truy cập dữ liệu (ví dụ: MovieDAO, ShowtimeDAO).

Model: Gói chứa các lớp thực thể (JavaBeans) (ví dụ: Movie, Showtime, User).

3. Các Vai Trò (Actors) và Chức năng:

Nhân viên Quản lý: Xem thống kê (phim, khách hàng, doanh thu). Quản lý lịch chiếu (lên lịch). Quản lý thông tin phim (CRUD). Quản lý phòng chiếu (CRUD).

Nhân viên Bán hàng: Bán vé tại quầy. Xuất thẻ thành viên.

Khách hàng: Đăng kí thành viên. Tìm kiếm phim. Mua vé trực tuyến. Mua vé tại quầy.

4. Sơ đồ Cơ sở dữ liệu:
Tạo các bảng dữ liệu dựa trên sơ đồ CSDL (trang 5 của tài liệu). Các bảng chính bao gồm:

User

MembershipCard

Order

Payment

Ticket

ShowTime

Movie

Cinema

Room

Seat

5. Kịch bản chi tiết (Bắt buộc):
Tạo mã nguồn để triển khai chính xác hai kịch bản (scenario) sau:

Kịch bản 1: Khách hàng Tìm kiếm Thông tin Phim (Module 1)

Trigger: Khách hàng truy cập trang chủ (Main.jsp) và nhấn vào menu "Tìm kiếm Phim".

Hệ thống: Chuyển hướng đến trang SearchMovie.jsp.

Khách hàng: Nhập từ khóa (ví dụ: "Lời Chưa Nói") vào ô tìm kiếm và nhấn nút "Tìm Kiếm".

View (SearchMovie.jsp): Gửi yêu cầu (request) đến MovieServlet.

Controller (MovieServlet): Nhận yêu cầu, gọi phương thức findMovieByTitle(keyword) từ lớp MovieDAO.

DAO (MovieDAO): Thực thi truy vấn SQL để tìm các phim có tên chứa từ khóa. Khởi tạo và đóng gói kết quả vào một List<Movie>.

Hệ thống: MovieDAO trả List<Movie> về cho MovieServlet. MovieServlet chuyển tiếp (forward) danh sách này về lại trang SearchMovie.jsp.

View (SearchMovie.jsp): Hiển thị danh sách kết quả tìm kiếm cho khách hàng (ví dụ: "SpiderMan 4").

Khách hàng: Nhấn vào một bộ phim cụ thể (ví dụ: "SpiderMan 4") từ danh sách kết quả.

View (SearchMovie.jsp): Gửi yêu cầu đến MovieDetail.jsp, truyền movieId của bộ phim đã chọn.

View (MovieDetail.jsp): Gửi yêu cầu đến MovieServlet để lấy thông tin chi tiết của phim.

Controller (MovieServlet): Gọi phương thức getMovieById(id) từ MovieDAO.

DAO (MovieDAO): Truy vấn CSDL để lấy toàn bộ thông tin chi tiết của phim dựa trên id, đóng gói vào một đối tượng Movie và trả về cho MovieServlet.

Controller (MovieServlet): Chuyển tiếp đối tượng Movie chi tiết đến trang MovieDetail.jsp.

View (MovieDetail.jsp): Hiển thị đầy đủ thông tin chi tiết của phim (poster, tiêu đề, mô tả, thể loại,...) cho khách hàng.

Kịch bản 2: Nhân viên Quản lý Lên lịch chiếu (Module 2)

Trigger: Quản lý (Manager) đăng nhập và từ trang MainManager.jsp, nhấn vào "Quản lý lịch chiếu".

Hệ thống: Chuyển hướng đến trang ManageShowtime.jsp.

View (ManageShowtime.jsp): Ngay khi tải, trang này gọi đến ShowtimeServlet để lấy danh sách lịch chiếu hiện tại.

Controller (ShowtimeServlet): Gọi ShowtimeDAO.findCurrentShowtime().

DAO (ShowtimeDAO): Truy vấn CSDL, lấy danh sách lịch chiếu, đóng gói thành List<Showtime> và trả về cho ShowtimeServlet.

Hệ thống: ShowtimeServlet chuyển tiếp danh sách này đến ManageShowtime.jsp. Trang này hiển thị danh sách lịch chiếu.

Quản lý: Nhấn nút "Thêm mới lịch chiếu".

Hệ thống: Chuyển hướng đến trang ScheduleShowtime.jsp.

View (ScheduleShowtime.jsp): Khi tải trang, thực hiện 2 hành động để lấy dữ liệu:

Gọi MovieServlet -> MovieServlet gọi MovieDAO.getMovieNowShowing() -> Lấy List<Movie> đang chiếu và hiển thị trong "Danh sách phim đang chiếu".

Gọi ShowtimeServlet -> ShowtimeServlet gọi ShowtimeDAO.findAvailableRoom() -> Lấy List<Room> còn trống và hiển thị trong "Phòng Trống".

Quản lý: Chọn "Ngày Chiếu", "Giờ bắt đầu", "Giờ kết thúc", chọn một "Phòng Trống" (ví dụ: Phòng 1) và một "Phim đang chiếu" (ví dụ: Lời Chưa Nói).

Quản lý: Nhấn nút "Xác nhận Tạo lịch chiếu".

View (ScheduleShowtime.jsp): Gửi yêu cầu POST chứa toàn bộ thông tin (ngày, giờ, phòng, phim) đến ShowtimeServlet.

Controller (ShowtimeServlet): Nhận dữ liệu, tạo đối tượng Showtime mới và gọi ShowtimeDAO.save(newShowtime).

DAO (ShowtimeDAO): Thực thi câu lệnh INSERT để lưu đối tượng Showtime mới vào CSDL.

Hệ thống: Trả về kết quả thành công cho ShowtimeServlet, sau đó ShowtimeServlet thông báo lại cho ScheduleShowtime.jsp.

View (ScheduleShowtime.jsp): Hiển thị thông báo "Tạo lịch chiếu thành công" cho quản lý.

6. Yêu cầu Bổ sung (Additional Requirements):

6.1. Xác thực và Phân quyền (Authentication & Authorization):

Tạo trang login.jsp cho phép người dùng đăng nhập.

Sau khi đăng nhập, lưu thông tin người dùng (user object) vào HttpSession.

Với các trang quản lý (ví dụ: ManageShowtime.jsp), hãy sử dụng một Filter để kiểm tra xem người dùng đã đăng nhập và có vai trò (role) là 'Manager' hay chưa. Nếu chưa, chuyển hướng họ về trang đăng nhập.

6.2. Xử lý Lỗi (Error Handling):

Trong kịch bản tìm kiếm phim, nếu không tìm thấy kết quả nào, hãy hiển thị một thông báo thân thiện trên trang SearchMovie.jsp như "Không tìm thấy phim nào phù hợp với từ khóa của bạn."

Sử dụng khối try-catch-finally trong các lớp DAO để xử lý các SQLException. Đảm bảo rằng kết nối CSDL (Connection) luôn được đóng trong khối finally.

Tạo một trang lỗi chung (error.jsp) để hiển thị các lỗi không mong muốn cho người dùng.

6.3. Chất lượng Mã nguồn (Code Quality):

Bảo mật: Sử dụng PreparedStatement trong tất cả các lớp DAO để thực thi truy vấn SQL, nhằm ngăn chặn tấn công SQL Injection.

Quy ước: Tuân thủ quy ước đặt tên của Java (Java Naming Conventions).

Chú thích: Thêm các chú thích (comments) rõ ràng cho các phương thức phức tạp trong lớp Servlet và DAO để giải thích logic.

6.4. Giao diện người dùng (User Interface):

Thiết kế giao diện người dùng sạch sẽ, dễ sử dụng.

Bạn có thể sử dụng một CSS framework như Bootstrap (tải từ CDN) để làm cho giao diện trông chuyên nghiệp và đáp ứng tốt trên nhiều thiết bị (responsive).

## Cấu trúc dự án

```
Cinema/
├── database/
│   └── schema.sql
├── src/
│   └── main/
│       ├── java/
│       │   └── com/cinema/
│       │       ├── dao/
│       │       ├── filter/
│       │       ├── model/
│       │       ├── servlet/
│       │       └── util/
│       └── webapp/
│           ├── WEB-INF/web.xml
│           ├── Main.jsp
│           ├── MainManager.jsp
│           ├── ManageShowtime.jsp
│           ├── MovieDetail.jsp
│           ├── ScheduleShowtime.jsp
│           ├── SearchMovie.jsp
│           ├── error.jsp
│           ├── index.jsp
│           └── login.jsp
```

## Thiết lập môi trường
1. Cài đặt JDK 21 và Apache Tomcat 10 trở lên.
2. Cài đặt MySQL và khởi tạo CSDL bằng script `database/schema.sql`.
3. Cập nhật biến môi trường `CINEMA_DB_URL`, `CINEMA_DB_USER`, `CINEMA_DB_PASSWORD` nếu cần.
4. Đưa thư mục `src/main/webapp` và `src/main/java` vào một dự án WAR (Maven hoặc IDE).
5. Triển khai lên Tomcat và truy cập `http://localhost:8080/Cinema/login.jsp`.

## Tài khoản mẫu
- Quản lý: `manager` / `manager123`
- Nhân viên bán vé: `cashier` / `cashier123`
- Khách hàng: `customer` / `customer123`

## Kiểm thử kịch bản
- **Tìm kiếm phim:** Đăng nhập với tài khoản khách hàng, mở `SearchMovie.jsp`, nhập từ khóa và xác minh kết quả cùng trang chi tiết.
- **Lên lịch chiếu:** Đăng nhập với tài khoản quản lý, vào "Quản lý lịch chiếu", tạo lịch mới tại trang "Lên lịch chiếu".
