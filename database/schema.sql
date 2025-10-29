-- Active: 1755590740281@@127.0.0.1@3306@Cinema


CREATE TABLE IF NOT EXISTS `User` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `fullName` VARCHAR(255),
    `username` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `role` VARCHAR(10),
    `note` VARCHAR(255)
);

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
);

CREATE TABLE IF NOT EXISTS `Cinema` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    `address` VARCHAR(255),
    `description` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Room` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    `capacity` INT,
    `description` VARCHAR(255),
    `format` VARCHAR(255),
    `CinemaId` INT(10),
    FOREIGN KEY (`CinemaId`) REFERENCES `Cinema`(`id`)
);

CREATE TABLE IF NOT EXISTS `Seat` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `position` VARCHAR(255),
    `seatType` VARCHAR(255),
    `RoomId` INT(10),
    FOREIGN KEY (`RoomId`) REFERENCES `Room`(`id`)
);

CREATE TABLE IF NOT EXISTS `ShowTime` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `startTime` DATETIME,
    `endTime` DATETIME,
    `status` VARCHAR(255),
    `MovieId` INT(10),
    `RoomId` INT(10),
    FOREIGN KEY (`MovieId`) REFERENCES `Movie`(`id`),
    FOREIGN KEY (`RoomId`) REFERENCES `Room`(`id`)
);

CREATE TABLE IF NOT EXISTS `Order` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `orderTime` DATETIME,
    `status` VARCHAR(255),
    `total_amount` FLOAT,
    `UserId` INT(10),
    FOREIGN KEY (`UserId`) REFERENCES `User`(`id`)
);

CREATE TABLE IF NOT EXISTS `Ticket` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `price` FLOAT,
    `status` VARCHAR(255),
    `OrderId` INT(10),
    `SeatId` INT(10),
    `ShowTimeId` INT(10),
    FOREIGN KEY (`OrderId`) REFERENCES `Order`(`id`),
    FOREIGN KEY (`SeatId`) REFERENCES `Seat`(`id`),
    FOREIGN KEY (`ShowTimeId`) REFERENCES `ShowTime`(`id`)
);

CREATE TABLE IF NOT EXISTS `Payment` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `method` VARCHAR(255),
    `amount` FLOAT,
    `paidAt` DATETIME,
    `status` VARCHAR(255),
    `OrderId` INT(10),
    FOREIGN KEY (`OrderId`) REFERENCES `Order`(`id`)
);

CREATE TABLE IF NOT EXISTS `MembershipCard` (
    `id` INT(10) PRIMARY KEY AUTO_INCREMENT,
    `cardNumber` VARCHAR(255) UNIQUE,
    `issueAt` DATE,
    `status` VARCHAR(255),
    `UserId` INT(10),
    FOREIGN KEY (`UserId`) REFERENCES `User`(`id`)
);

INSERT INTO `User` (fullName, username, password, email, phone, role, note) VALUES
    ('Nguyễn Quản Lý', 'manager', 'manager123', 'manager@cinema.vn', '0123456789', 'Manager', 'Tài khoản quản lý mặc định'),
    ('Trần Bán Vé', 'cashier', 'cashier123', 'cashier@cinema.vn', '0987654321', 'Cashier', 'Nhân viên bán vé'),
    ('Lê Khách Hàng', 'customer', 'customer123', 'customer@cinema.vn', '0111222333', 'Customer', 'Thành viên thân thiết');

INSERT INTO `Cinema` (name, address, description) VALUES
    ('Cinema Center', '123 Đường Lớn, Quận 1, TP.HCM', 'Rạp trung tâm thành phố với nhiều phòng chiếu hiện đại');

INSERT INTO `Room` (name, capacity, description, format, CinemaId) VALUES
    ('Phòng 1', 120, 'Phòng tiêu chuẩn với màn hình lớn', '2D', 1),
    ('Phòng 2', 90, 'Phòng chiếu phim 3D với âm thanh vòm', '3D', 1);

INSERT INTO `Seat` (position, seatType, RoomId) VALUES
    ('A1', 'Standard', 1),
    ('A2', 'Standard', 1),
    ('B1', 'VIP', 2),
    ('B2', 'VIP', 2);

INSERT INTO `Movie` (title, description, duration, rating, releaseDate, status, poster, trailer, genre, language) VALUES
    ('Lời Chưa Nói', 'Câu chuyện cảm động về tình yêu và gia đình.', 120.0, 8.5, '2024-01-12', 'Now Showing', 'https://example.com/posters/loi-chua-noi.jpg', 'https://example.com/trailers/loi-chua-noi.mp4', 'Tâm lý', 'Tiếng Việt'),
    ('SpiderMan 4', 'Siêu anh hùng SpiderMan trở lại với cuộc phiêu lưu mới.', 135.0, 9.1, '2023-12-20', 'Now Showing', 'https://example.com/posters/spiderman4.jpg', 'https://example.com/trailers/spiderman4.mp4', 'Hành động', 'Tiếng Anh'),
    ('Kỳ Nghỉ Trong Mơ', 'Bộ phim hài hước cho cả gia đình.', 110.0, 7.2, '2023-08-05', 'Coming Soon', 'https://example.com/posters/ky-nghi-trong-mo.jpg', 'https://example.com/trailers/ky-nghi-trong-mo.mp4', 'Hài', 'Tiếng Việt');

INSERT INTO `ShowTime` (startTime, endTime, status, MovieId, RoomId) VALUES
    ('2024-03-01 18:00:00', '2024-03-01 20:15:00', 'Scheduled', 1, 1),
    ('2024-03-01 20:30:00', '2024-03-01 22:45:00', 'Scheduled', 2, 2);

INSERT INTO `Order` (orderTime, status, total_amount, UserId) VALUES
    ('2024-02-28 10:30:00', 'Completed', 200000.0, 3);

INSERT INTO `Ticket` (price, status, OrderId, SeatId, ShowTimeId) VALUES
    (100000.0, 'Issued', 1, 1, 1),
    (100000.0, 'Issued', 1, 2, 1);

INSERT INTO `Payment` (method, amount, paidAt, status, OrderId) VALUES
    ('Credit Card', 200000.0, '2024-02-28 10:35:00', 'Paid', 1);

INSERT INTO `MembershipCard` (cardNumber, issueAt, status, UserId) VALUES
    ('MC-0001', '2023-01-01', 'Active', 3);
