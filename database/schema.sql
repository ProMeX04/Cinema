-- =====================================================
-- SCHEMA DATABASE CHO HỆ THỐNG QUẢN LÝ RẠP CHIẾU PHIM
-- Tạo chính xác 100% dựa trên thiết kế và code hiện tại
-- =====================================================

-- Xóa database cũ nếu tồn tại (tùy chọn, chỉ dùng khi cần reset)
-- DROP DATABASE IF EXISTS Cinema;
-- CREATE DATABASE Cinema CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE Cinema;

-- =====================================================
-- BẢNG USER - Người dùng hệ thống
-- =====================================================
CREATE TABLE IF NOT EXISTS `User` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `fullName` VARCHAR(255),
    `username` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `role` VARCHAR(10),
    `note` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG CINEMA - Thông tin rạp chiếu phim
-- =====================================================
CREATE TABLE IF NOT EXISTS `Cinema` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    `address` VARCHAR(255),
    `description` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG ROOM - Phòng chiếu phim
-- =====================================================
CREATE TABLE IF NOT EXISTS `Room` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    `capacity` INT,
    `description` VARCHAR(255),
    `format` VARCHAR(255),
    `CinemaId` INT(10),
    FOREIGN KEY (`CinemaId`) REFERENCES `Cinema`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG MOVIE - Thông tin phim
-- =====================================================
CREATE TABLE IF NOT EXISTS `Movie` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(255),
    `description` TEXT,
    `duration` FLOAT,
    `rating` FLOAT,
    `releaseDate` DATE,
    `status` VARCHAR(255),
    `poster` VARCHAR(255),
    `trailer` VARCHAR(255),
    `genre` VARCHAR(255),
    `language` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG SHOWTIME - Lịch chiếu phim
-- Lưu ý: Tên bảng là ShowTime (chữ T viết hoa) để khớp với code
-- =====================================================
CREATE TABLE IF NOT EXISTS `ShowTime` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `startTime` DATETIME NOT NULL,
    `endTime` DATETIME NOT NULL,
    `status` VARCHAR(255),
    `MovieId` INT(10) NOT NULL,
    `RoomId` INT(10) NOT NULL,
    FOREIGN KEY (`MovieId`) REFERENCES `Movie`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`RoomId`) REFERENCES `Room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX `idx_startTime` (`startTime`),
    INDEX `idx_room_time` (`RoomId`, `startTime`, `endTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG SEAT - Ghế ngồi trong phòng chiếu
-- =====================================================
CREATE TABLE IF NOT EXISTS `Seat` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `position` VARCHAR(255),
    `seatType` VARCHAR(255),
    `RoomId` INT(10),
    FOREIGN KEY (`RoomId`) REFERENCES `Room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG ORDER - Đơn đặt vé
-- Lưu ý: Tên cột là total_amount (snake_case) để khớp với schema hiện tại
-- =====================================================
CREATE TABLE IF NOT EXISTS `Order` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `orderTime` DATETIME,
    `status` VARCHAR(255),
    `total_amount` FLOAT,
    `UserId` INT(10),
    FOREIGN KEY (`UserId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG TICKET - Vé xem phim
-- =====================================================
CREATE TABLE IF NOT EXISTS `Ticket` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `price` FLOAT,
    `status` VARCHAR(255),
    `OrderId` INT(10),
    `SeatId` INT(10),
    `ShowTimeId` INT(10),
    FOREIGN KEY (`OrderId`) REFERENCES `Order`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`SeatId`) REFERENCES `Seat`(`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`ShowTimeId`) REFERENCES `ShowTime`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG PAYMENT - Thanh toán
-- =====================================================
CREATE TABLE IF NOT EXISTS `Payment` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `method` VARCHAR(255),
    `amount` FLOAT,
    `paidAt` DATETIME,
    `status` VARCHAR(255),
    `OrderId` INT(10),
    FOREIGN KEY (`OrderId`) REFERENCES `Order`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- BẢNG MEMBERSHIPCARD - Thẻ thành viên
-- =====================================================
CREATE TABLE IF NOT EXISTS `MembershipCard` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `cardNumber` VARCHAR(255) UNIQUE,
    `issueAt` DATE,
    `status` VARCHAR(255),
    `UserId` INT(10),
    FOREIGN KEY (`UserId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- DỮ LIỆU MẪU (SAMPLE DATA)
-- =====================================================

-- Xóa dữ liệu cũ nếu cần reset
-- DELETE FROM `Ticket`;
-- DELETE FROM `Payment`;
-- DELETE FROM `Order`;
-- DELETE FROM `MembershipCard`;
-- DELETE FROM `ShowTime`;
-- DELETE FROM `Seat`;
-- DELETE FROM `Room`;
-- DELETE FROM `Movie`;
-- DELETE FROM `Cinema`;
-- DELETE FROM `User`;

-- Chèn dữ liệu User
INSERT INTO `User` (`fullName`, `username`, `password`, `email`, `phone`, `role`, `note`) VALUES
    ('Nguyễn Quản Lý', 'manager', 'manager123', 'manager@cinema.vn', '0123456789', 'Manager', 'Tài khoản quản lý mặc định'),
    ('Trần Bán Vé', 'cashier', 'cashier123', 'cashier@cinema.vn', '0987654321', 'Cashier', 'Nhân viên bán vé'),
    ('Lê Khách Hàng', 'customer', 'customer123', 'customer@cinema.vn', '0111222333', 'Customer', 'Thành viên thân thiết')
ON DUPLICATE KEY UPDATE `username`=`username`;

-- Chèn dữ liệu Cinema
INSERT INTO `Cinema` (`name`, `address`, `description`) VALUES
    ('Cinema Center', '123 Đường Lớn, Quận 1, TP.HCM', 'Rạp trung tâm thành phố với nhiều phòng chiếu hiện đại')
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Room
INSERT INTO `Room` (`name`, `capacity`, `description`, `format`, `CinemaId`) VALUES
    ('Phòng 1', 120, 'Phòng tiêu chuẩn với màn hình lớn', '2D', 1),
    ('Phòng 2', 90, 'Phòng chiếu phim 3D với âm thanh vòm', '3D', 1),
    ('Phòng 3', 150, 'Phòng IMAX với màn hình cực lớn', 'IMAX', 1)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Seat (mẫu)
INSERT INTO `Seat` (`position`, `seatType`, `RoomId`) VALUES
    ('A1', 'Standard', 1),
    ('A2', 'Standard', 1),
    ('A3', 'Standard', 1),
    ('B1', 'VIP', 2),
    ('B2', 'VIP', 2),
    ('C1', 'Standard', 3),
    ('C2', 'Standard', 3)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Movie
INSERT INTO `Movie` (`title`, `description`, `duration`, `rating`, `releaseDate`, `status`, `poster`, `trailer`, `genre`, `language`) VALUES
    ('Lời Chưa Nói', 'Câu chuyện cảm động về tình yêu và gia đình. Một bộ phim tâm lý đầy cảm xúc với diễn xuất xuất sắc của dàn diễn viên.', 120.0, 8.5, '2024-01-12', 'Now Showing', 'https://example.com/posters/loi-chua-noi.jpg', 'https://example.com/trailers/loi-chua-noi.mp4', 'Tâm lý', 'Tiếng Việt'),
    ('SpiderMan 4', 'Siêu anh hùng SpiderMan trở lại với cuộc phiêu lưu mới đầy kịch tính và hành động mãn nhãn.', 135.0, 9.1, '2023-12-20', 'Now Showing', 'https://example.com/posters/spiderman4.jpg', 'https://example.com/trailers/spiderman4.mp4', 'Hành động', 'Tiếng Anh'),
    ('Kỳ Nghỉ Trong Mơ', 'Bộ phim hài hước cho cả gia đình với những tình huống dở khóc dở cười.', 110.0, 7.2, '2023-08-05', 'Coming Soon', 'https://example.com/posters/ky-nghi-trong-mo.jpg', 'https://example.com/trailers/ky-nghi-trong-mo.mp4', 'Hài', 'Tiếng Việt'),
    ('Avengers: Endgame', 'Cuộc chiến cuối cùng của các siêu anh hùng để cứu vũ trụ.', 181.0, 9.5, '2024-02-15', 'Now Showing', 'https://example.com/posters/avengers-endgame.jpg', 'https://example.com/trailers/avengers-endgame.mp4', 'Hành động', 'Tiếng Anh')
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu ShowTime (Lịch chiếu)
INSERT INTO `ShowTime` (`startTime`, `endTime`, `status`, `MovieId`, `RoomId`) VALUES
    ('2024-03-01 18:00:00', '2024-03-01 20:00:00', 'Scheduled', 1, 1),
    ('2024-03-01 20:30:00', '2024-03-01 22:45:00', 'Scheduled', 2, 2),
    ('2024-03-02 14:00:00', '2024-03-02 16:00:00', 'Scheduled', 1, 1),
    ('2024-03-02 19:00:00', '2024-03-02 22:01:00', 'Scheduled', 4, 3)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Order (mẫu)
INSERT INTO `Order` (`orderTime`, `status`, `total_amount`, `UserId`) VALUES
    ('2024-02-28 10:30:00', 'Completed', 200000.0, 3),
    ('2024-02-29 15:20:00', 'Pending', 150000.0, 3)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Ticket (mẫu)
INSERT INTO `Ticket` (`price`, `status`, `OrderId`, `SeatId`, `ShowTimeId`) VALUES
    (100000.0, 'Issued', 1, 1, 1),
    (100000.0, 'Issued', 1, 2, 1),
    (75000.0, 'Issued', 2, 4, 2)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu Payment (mẫu)
INSERT INTO `Payment` (`method`, `amount`, `paidAt`, `status`, `OrderId`) VALUES
    ('Credit Card', 200000.0, '2024-02-28 10:35:00', 'Paid', 1),
    ('Cash', 150000.0, '2024-02-29 15:25:00', 'Paid', 2)
ON DUPLICATE KEY UPDATE `id`=`id`;

-- Chèn dữ liệu MembershipCard (mẫu)
INSERT INTO `MembershipCard` (`cardNumber`, `issueAt`, `status`, `UserId`) VALUES
    ('MC-0001', '2023-01-01', 'Active', 3),
    ('MC-0002', '2024-01-15', 'Active', 3)
ON DUPLICATE KEY UPDATE `cardNumber`=`cardNumber`;

-- =====================================================
-- TẠO INDEX ĐỂ TỐI ƯU HIỆU SUẤT
-- =====================================================
CREATE INDEX IF NOT EXISTS `idx_user_username` ON `User`(`username`);
CREATE INDEX IF NOT EXISTS `idx_movie_status` ON `Movie`(`status`);
CREATE INDEX IF NOT EXISTS `idx_movie_title` ON `Movie`(`title`);
CREATE INDEX IF NOT EXISTS `idx_showtime_movie` ON `ShowTime`(`MovieId`);
CREATE INDEX IF NOT EXISTS `idx_showtime_room` ON `ShowTime`(`RoomId`);
CREATE INDEX IF NOT EXISTS `idx_order_user` ON `Order`(`UserId`);
CREATE INDEX IF NOT EXISTS `idx_ticket_order` ON `Ticket`(`OrderId`);
CREATE INDEX IF NOT EXISTS `idx_ticket_showtime` ON `Ticket`(`ShowTimeId`);
CREATE INDEX IF NOT EXISTS `idx_payment_order` ON `Payment`(`OrderId`);
CREATE INDEX IF NOT EXISTS `idx_membershipcard_user` ON `MembershipCard`(`UserId`);

-- =====================================================
-- KẾT THÚC SCHEMA
-- =====================================================
