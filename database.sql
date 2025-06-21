-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for backend
DROP DATABASE IF EXISTS `backend`;
CREATE DATABASE IF NOT EXISTS `backend` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `backend`;

-- Dumping structure for table backend.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.categories: ~4 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
	(3, 'Gia đình', 'Đây là danh mục sản phẩm cần thiết cho gia đình', '2024-12-27 02:06:08', '2025-01-07 06:26:22'),
	(5, 'Văn phòng', 'Đây là danh mục cho văn phòng', '2024-12-30 07:07:12', '2024-12-30 07:07:12'),
	(6, 'Không gian rộng', 'Đây là mô tả cho không gian rộng\r\n', '2024-12-30 07:07:41', '2024-12-30 07:07:41'),
	(9, '123', '123', '2025-01-14 15:53:01', '2025-01-14 15:53:01');

-- Dumping structure for table backend.discounts
DROP TABLE IF EXISTS `discounts`;
CREATE TABLE IF NOT EXISTS `discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.discounts: ~2 rows (approximately)
INSERT INTO `discounts` (`id`, `name`, `discount_value`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
	(2, 'Giảm giá mùa xuân', 15.00, '2025-01-10 00:00:00', '2025-02-10 23:59:59', '2025-01-08 03:28:57', '2025-01-08 03:28:57'),
	(3, 'Giảm giá đặc biệt Tết', 20.00, '2025-01-20 00:00:00', '2025-02-20 00:00:00', '2025-01-08 03:28:57', '2025-01-08 05:26:01'),
	(10, 'asdasd', 12.00, '2025-01-05 00:00:00', '2025-01-06 00:00:00', '2025-01-08 05:29:28', '2025-01-08 05:29:28');

-- Dumping structure for table backend.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_date` date DEFAULT NULL,
  `status` enum('confirmed','processing','shipping','delivered','cancelled') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.orders: ~0 rows (approximately)
INSERT INTO `orders` (`id`, `user_id`, `order_date`, `delivery_date`, `status`, `total_amount`, `shipping_address`, `payment_method`, `created_at`, `updated_at`) VALUES
	(1, 12, '2025-01-07 17:00:00', '2025-01-10', 'shipping', 4600000.00, '4D, Trần Thị Vững, An Bình, Dĩ An Bình Dương', 'COD', '2025-01-08 01:19:51', '2025-01-08 01:19:51'),
	(2, 18, '2025-02-27 14:18:34', '2025-03-02', 'shipping', 3100000.00, 'sdf', 'Credit Card', '2025-02-27 14:18:34', '2025-02-27 14:18:34');

-- Dumping structure for table backend.order_details
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_id` (`order_id`) USING BTREE,
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.order_details: ~2 rows (approximately)
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
	(1, 1, 8, 1, 3100000.00, '2025-01-08 01:22:06', '2025-01-08 01:22:06'),
	(2, 1, 9, 2, 1500000.00, '2025-01-08 01:22:06', '2025-01-08 01:22:06'),
	(3, 2, 8, 1, 3100000.00, '2025-02-27 14:18:34', '2025-02-27 14:18:34');

-- Dumping structure for table backend.otp
DROP TABLE IF EXISTS `otp`;
CREATE TABLE IF NOT EXISTS `otp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `otp_expiry` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `email` (`email`) USING BTREE,
  CONSTRAINT `otp_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.otp: ~13 rows (approximately)
INSERT INTO `otp` (`id`, `email`, `otp`, `otp_expiry`) VALUES
	(8, 'nhutdny123@gmail.com', '715462', '2025-01-14 02:48:45'),
	(9, 'nhutdny123@gmail.com', '640889', '2025-01-14 02:50:41'),
	(10, 'nhutdny123@gmail.com', '040157', '2025-01-14 02:52:04'),
	(11, 'nhutdny123@gmail.com', '219264', '2025-01-14 02:53:15'),
	(12, 'nhutdny123@gmail.com', '657950', '2025-01-14 02:56:43'),
	(13, 'nhutdny123@gmail.com', '501348', '2025-01-14 02:57:56'),
	(14, 'nhutdny123@gmail.com', '955063', '2025-01-14 03:00:59'),
	(15, 'nhutdny123@gmail.com', '909288', '2025-01-14 03:04:15'),
	(16, 'nhutdny123@gmail.com', '689013', '2025-01-14 03:07:29'),
	(17, 'nhutdny123@gmail.com', '479590', '2025-01-14 03:09:01'),
	(18, 'nhutdny123@gmail.com', '498551', '2025-01-14 03:09:58'),
	(19, 'nhutdny123@gmail.com', '069180', '2025-01-14 03:12:08'),
	(20, 'nhutdny123@gmail.com', '597808', '2025-01-14 07:16:33');

-- Dumping structure for table backend.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `brand` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.products: ~33 rows (approximately)
INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `brand`, `category_id`, `status`, `created_at`, `updated_at`) VALUES
	(8, 'Quạt Điều Hòa Không Khí Rapido Everest 3000-D', 'Rapido Everest 3000-D là dòng máy làm mát của thương hiệu Rapido đến từ Đức. Sản phẩm sở hữu thiết kế nhỏ gọn với kích thước 360 x 300 x 713 mm, trọng lượng 6.3kg. Quạt có dung tích 20 lít, lưới chắn bụi dễ dàng tháo lắp, vệ sinh.', 3100000.00, 12, 'Rapido', 3, 0, '2025-01-08 01:13:17', '2025-01-08 01:13:17'),
	(9, 'Quạt điều hòa hơi nước NF45', 'Chiếc quạt này không chỉ làm bạn cảm thấy mát lạnh dễ chịu trong những ngày nóng nực, mà còn đưa bạn đến một trải nghiệm mới với những tính năng thông minh và hiện đại. Hãy cùng chúng tôi khám phá hành trình qua không gian thoải mái và sự hiệu quả vượt trội mà chiếc quạt Nefa NF45 mang lại, lôi quấn bạn vào một thế giới của sự tiện lợi và sự sang trọng', 1500000.00, 23, 'Nefa NF45', 6, NULL, '2025-01-08 01:15:30', '2025-01-08 01:15:30'),
	(10, 'Quạt Điều Hòa Mini Hơi Nước Công Nghệ Hàn Quốc', 'Quạt điều hòa Empire EPQM-4800 là sản phẩm của thương hiệu Empire đến từ Mỹ, được sản xuất tại Trung Quốc. Quạt làm bằng nhựa với vẻ ngoài rất chắc chắn. Kiểu dáng của quạt rất trang nhã đem đến vẻ hiện đại cho không gian sống của bạn. Với kích thước 43 x 33 x 93cm (Ngang x Sâu x Cao) quạt không quá cồng kềnh khi người dùng đặt trong phòng hoặc bất kỳ không gian phù hợp cho nhu cầu làm mát.', 1390000.00, 12, 'Empire', 3, NULL, '2025-01-13 00:18:20', '2025-01-13 00:18:20'),
	(11, 'Quạt Điều Hòa Empire EPQM-4800', 'Quạt điều hòa Empire EPQM-4800 là sản phẩm của thương hiệu Empire đến từ Mỹ, được sản xuất tại Trung Quốc. Quạt làm bằng nhựa với vẻ ngoài rất chắc chắn. Kiểu dáng của quạt rất trang nhã đem đến vẻ hiện đại cho không gian sống của bạn. Với kích thước 43 x 33 x 93cm (Ngang x Sâu x Cao) quạt không quá cồng kềnh khi người dùng đặt trong phòng hoặc bất kỳ không gian phù hợp cho nhu cầu làm mát.', 1490000.00, 10, 'Empire', 6, NULL, '2025-01-13 00:19:20', '2025-01-13 00:19:20'),
	(12, ' QUẠT HƠI NƯỚC ALASKA 50 LÍT A10000', 'Quạt hơi nước Alaska 50 lít A10000 có một ưu điểm đặc biệt là khả năng làm mát và làm ẩm không chỉ trong không gian nhỏ mà còn trong các không gian lớn hơn. Điều này rất hữu ích trong việc làm mát và làm ẩm không gian rộng, trả lời cho câu hỏi tại sao quạt hơi nước kêu to.Với dung tích nước lên đến 50 lít, quạt có khả năng cung cấp không khí mát mẻ và ẩm ướt trong một thời gian kéo dài, mà không cần phải nạp nước thường xuyên. Điều này giúp quạt hoạt động liên tục trong thời gian dài, đáp ứng nhu cầu làm mát và làm ẩm trong các không gian rộng.', 540000.00, 10, 'Alaska', 6, NULL, '2025-01-13 00:21:43', '2025-01-13 00:21:43'),
	(13, 'OOKAS Quạt điều hòa,Máy lạnh đứng di động Điều hòa di động', 'Máy làm mát không khí di động được nâng cấp của OOKAS sử dụng công nghệ làm mát mới nhất của năm 2024: Động cơ hiệu suất cao, thiết kế ống dẫn khí cải tiến và tấm làm mát mật độ cao. Nhanh chóng giảm nhiệt độ môi trường xung quanh xuống 41-49°F khi nước bay hơi để hấp thụ nhiệt, đạt được khả năng làm mát nhanh chóng. Mẹo: Tăng cường hiệu quả làm mát bằng cách thêm túi đá đông lạnh vào bình chứa nước. (*Đã được thử nghiệm ở 95°F trong phòng thí nghiệm, hiệu quả làm mát thay đổi tùy theo độ ẩm trong nhà)', 600000.00, 10, 'OOKAS', 3, NULL, '2025-01-13 00:23:49', '2025-01-13 00:23:49'),
	(14, 'Quạt Điện Phun Sương Tạo Ẩm Omnio, 3 Chế Độ Gió, Có Bình Chứa Nước 600ml, Làm Mát Nhanh, Tích Hợp Đèn Led', 'Đa tính năng, dùng quanh năm: quạt làm mát 5 tia phun sương vào mùa hè, tạo ẩm vào mùa đông, đèn ngủ vào ban đêm, còn có thể dùng làm máy khuếch tán hương thơm vào các ngày trong tuần, tích hợp nhiều chức năng trong một', 300000.00, 20, 'Omino', 5, NULL, '2025-01-13 00:25:28', '2025-01-13 00:25:28'),
	(15, 'Quạt điều hòa Boss S-102', 'Quạt phun sương kết hợp trong phòng điều hòa cực hiệu quả – tiết kiệm điện – tạo độ ẩm – làm dịu mát nhanh chóng cho căn phòng\r\nĐa tính năng, dùng quanh năm: quạt làm mát 5 tia phun sương vào mùa hè, tạo ẩm vào mùa đông, đèn ngủ vào ban đêm, còn có thể dùng làm máy khuếch tán hương thơm vào các ngày trong tuần, tích hợp nhiều chức năng trong một', 3990000.00, 10, 'Boss', 5, NULL, '2025-01-13 00:28:27', '2025-01-13 00:28:27'),
	(16, ' Quạt làm lạnh không khí Galen G020', 'Quạt điều hòa không khí Galen G020 hoạt động với công suất 65W nên sử dụng tiết kiệm điện năng, cho khả năng làm mát hiệu quả với lưu lượng gió đạt 300 m3/giờ, phù hợp với diện tích 20m2. ', 10000000.00, 10, 'Galen', 5, NULL, '2025-01-13 00:30:30', '2025-01-13 00:30:30'),
	(17, 'Quạt Điều Hòa Rapido Everest 3000D', 'Sử dụng đá khô có thể tái sử dụng tạo ra hơi nước mát lạnh.Công suất hoạt động 40W hoạt động tốt ở diện tích từ 10-15m.Quạt điều hòa tạo ion âm lọc sạch không khí, bảo vệ sức khỏe.Dung tích chứa nước lên đến 20 lít cho thời gian làm mát lâu hơn.Động cơ SD siêu tiết kiệm năng lượng, hoạt động nhẹ nhàng, êm ái.Điều khiển điện tử bằng điều khiển từ xa tiện dụng, nhanh chóng hơn.Lưới chắn bụi của quạt được thiết kế rời dễ dàng tháo lắp và vệ sinh.Thiết kế nhỏ gọn, hiện đại, màu sắc vô cùng trang nhã, tiết kiệm diện tích', 1390000.00, 10, 'Everest', 3, NULL, '2025-01-13 00:32:31', '2025-01-13 00:32:31'),
	(18, 'Quạt tháp Panworld PW-8207 Màu đen', 'Quạt tháp Panworld PW-8207 thiết kế nhỏ gọn, hiện đại phù hợp để bố trí mọi nơi trong không gian sống. Quạt còn trang bị chức năng tạo ion, lọc và khử mùi giúp căn nhà của bạn luôn sạch sẽ, thoáng khí.', 1220000.00, 10, 'Thái Lan', 3, NULL, '2025-01-13 00:34:58', '2025-01-13 00:34:58'),
	(19, 'Quạt làm lạnh không khí Galen G020', 'Galen G020 có dung tích bình đựng nước là 4 lít, làm mát bằng hơi nước giúp nhiệt độ tỏa ra ngoài sẽ giảm xuống từ 4 - 5 độ C. Ngoài ra quạt còn đi kèm 2 cục đá khô sẽ tăng cường hiệu quả làm mát tốt hơn.', 1080000.00, 10, 'Galen', 3, NULL, '2025-01-13 00:37:08', '2025-01-13 00:37:08'),
	(20, 'Quạt Điều Hòa Mini Hơi Nước Công Nghệ Hàn Quốc', 'Mang đến trải nghiệm tuyệt vời trong những ngày nóng bức. Với công nghệ hơi nước tiên tiến, sản phẩm tạo ra không khí siêu mát, giúp bạn cảm thấy thoải mái ngay lập tức.Quạt điều hòa mini là đối tác di động lý tưởng, làm se lạnh và tinh chỉnh không khí nhanh chóng, đảm bảo không gian xung quanh luôn mát lạnh và dễ chịu.Quạt hơi nước để bàn vừa nhỏ gọn vừa giúp tiết kiệm điện năng và thân thiện với môi trường ', 220000.00, 10, 'Hàn Quốc', 3, NULL, '2025-01-13 00:39:42', '2025-01-13 00:39:42'),
	(21, 'Quạt phun sương mini hẹn giờ thông minh tích hợp đèn ngủ', '- Máy điều hòa mini làm mát không khí với khả năng làm mát và giữ ẩm không khí, căn phòng của bạn sẽ luôn là một nơi lý tưởng để nghỉ ngơi, thư giãn. Có thiết kế hiện đại, trang nhã làm nổi bật thêm không gian căn phòng.', 231000.00, 12, 'Việt Nam', 3, NULL, '2025-01-13 00:42:31', '2025-01-13 00:42:31'),
	(22, 'QUẠT ĐIỀU HOÀ HƠI NƯỚC 60L + TẶNG 4 ĐÁ KHÔ CÓ BÁNH XE (GIÁ TẬN XƯỞNG)', 'Các bể chứa nước trên và dưới lưu thông làm mát, không khí nóng hút vào qua tấm làm mát trở thành không khí lạnh, làm mát một khu vực rộng lớn.', 1400000.00, 10, 'Việt Nam', 6, NULL, '2025-01-13 00:45:23', '2025-01-13 00:45:23'),
	(23, 'QUẠT HƠI NƯỚC ALASKA 57 LIT AW-8R1', 'Một trong những điểm nổi bật của quạt hơi nước Alaska 57L AW-8R1 là công nghệ hơi nước tiên tiến và hiệu quả mà nó sử dụng. Thiết bị này có một bình chứa nước rộng rãi, có nên mua quạt hơi nước cho phép bạn đổ nước vào và tận hưởng hiệu quả làm mát tuyệt vời.Khi quạt hoạt động, không khí được hút vào và đi qua màng làm mát, nơi nước được phun sương vào màng này. Quá trình này tạo ra một hiệu ứng làm mát tức thì, trong đó không khí được làm lạnh và độ ẩm được cung cấp, giúp làm giảm nhiệt độ và tạo một môi trường mát mẻ và thoải mái.', 540000.00, 10, 'ALASKA ', 3, NULL, '2025-01-13 00:50:49', '2025-01-13 00:50:49'),
	(24, 'QUẠT ĐIỀU HÒA BOSS S-102', 'Quạt điều hòa Boss S-102 sở hữu kiểu dáng hình trụ hiện đại, kết hợp cùng màu trắng và đen sang trọng giúp làm tăng thêm tính thẩm mỹ cho mọi không gian sống của mỗi gia đình Việt.\r\nQuạt điều hòa Boss S-102 trang bị bình chứa nước có dung tích 14 lít, cho phép quạt hoạt động trong nhiều giờ liền mà không cần châm thêm nước. Cửa đổ nước bên hông thân quạt, giúp việc châm nước dễ dàng hơn. Bên cạnh đó, người dùng còn có thể kiểm soát được mức nước nhờ thang đo mực nước vô cùng tiện lợi.Quạt điều hòa hoạt động với công suất 100W, có khả năng làm mát hiệu quả và đảm bảo sức khỏe cho các phòng diện tích từ 10 – 20m² như phòng khách, phòng ngủ hoặc phòng làm việc.', 3500000.00, 10, 'Boss', 6, NULL, '2025-01-13 00:52:24', '2025-01-13 00:52:24'),
	(25, 'Quạt Tích Điện Năng Lượng Mặt Trời 32W Kitawa KQ832-T', 'Quạt tích điện năng lượng mặt trời KQ832 thiết kế giống như những chiếc quạt cây thông dụng chúng ta đang dùng với bộ khung chắc chắn. Kiểu dáng bắt mắt, lồng quạt làm từ nhựa ABS cao cấp giúp quạt có trọng lượng nhẹ hơn, có thể đem đi sử dụng nhiều nơi như trong nhà, văn phòng.Quạt thiết kế chống nước, sử dụng được ở ngoài trời.Động cơ siêu bền, mạnh mẽ. Công suất mạnh mẽ, tiêu thụ điện năng thấp', 1800000.00, 10, 'KITAWA', 3, NULL, '2025-01-13 00:54:15', '2025-01-13 00:54:15'),
	(26, 'Quạt điều hòa hơi nước Làm Lạnh Không Khí KACHI MK202, Công Nghệ Nhật Bản, Tiết Kiệm Điện Năng', 'Quạt hơi nước Kachi còn được gọi là quạt phun sương hay quạt làm mát, làm lạnh không khí được thiết kế theo công nghệ mới nhất của Nhật bản, đã được kiểm nghiệm thật kỹ lưỡng và chất lượng trước khi được sử dụng và nhập khẩu về Việt Nam. Quạt có kích thước rất nhỏ gọn, trọng lượng rất nhẹ với chỉ 6kg, cùng 4 bánh xe phía dưới giúp máy có thể có thể di chuyển một cách nhanh chóng, dễ dàng. ', 1119000.00, 10, 'Nhật Bản', 5, NULL, '2025-01-13 00:56:03', '2025-01-13 00:56:03'),
	(27, 'Quạt phun sương điều hòa hơi nước mini cao cấp', 'Quạt phun sương điều hòa hơi nước mini cao cấpvới khả năng làm mát và giữ ẩm không khí, căn phòng của bạn sẽ luôn là một nơi lý tưởng để nghỉ ngơi, thư giãn. Có thiết kế hiện đại, trang nhã làm nổi bật thêm không gian căn phòng.Tích hợp 3 cấp độ gió làm mát siêu mạnh với công suất max là 10W. Khi phun sương cũng được thiết kế 3 cấp độ nên khi quạt làm việc sẽ rất mạt làm giảm nhanh nhiệt độ.', 228000.00, 10, 'Việt Nam', 5, NULL, '2025-01-13 00:57:30', '2025-01-13 00:57:30'),
	(28, 'Quạt hơi nước cao cấp FujiE AC-18B', 'Máy làm mát là một thiết bị chuyên dùng làm mát không khí bằng việc hấp thụ sự bay hơi của nước. Dựa trên nguyên lý làm mát bằng hơi nước, làm cho khu vực cần làm mát sẽ giảm nhanh từ 5-10 độ C trong quá trình làm mát. Máy hoạt động hoàn toàn tự nhiên không phun sương nên không ảnh hưởng đến sức khỏe con người cũng như làm hỏng hóc các thiết bị trong gia đình.', 950000.00, 10, 'FujiE', 3, NULL, '2025-01-13 00:58:40', '2025-01-13 00:58:40'),
	(29, 'Quạt Phun Sương Tích Điện Điều Hòa Mini L7 Youpin 2 ', 'Quạt làm mát này có thể sạc lại, cũng có thể cắm điện để sử dụng. Cả hai cách đều có thể sử dụng được.Thời gian sạc của nó là 2,5-3 giờ, ở trạng thái sạc đầy, quạt có thể sử dụng từ 3-6 giờ.Dung lượng pin tích hợp 1200mAh-2000mAh.Dung lượng pin tích hợp 1200mAh-2000mAh', 200000.00, 10, 'Trung Quốc', 3, NULL, '2025-01-13 01:01:34', '2025-01-13 01:01:34'),
	(30, 'Quạt Điều Hòa Không Khí Công Suất 65W', 'Quạt điều hòa làm mát không khí được thiết kế với tấm màng lọc bên ngoài giúp người dùng có thể thoải mái sử dụng mà không lo về các vấn đề về sức khỏe như viêm họng, da khô, ... Ngoài ra, tấm màng lọc còn góp phần hỗ trợ khử vi khuẩn, vi trùng trong không khí giúp giảm bớt những phần tử kích ứng hệ hô hấp gây ra những căn bệnh ho, hắt hơi, ngứa họng.Công suất làm mát của Quạt điều hòa không khí chỉ khoảng 65W, đây sẽ là một vật dụng tiết kiệm kinh tế tối đa cho gia đình bạn, và bạn sẽ không còn phải lo chỉ số điện sẽ tăng lên chóng mặt vào những ngày nắng nóng. Quạt làm mát sẽ giúp cho gia đình bạn tiết kiệm chi phí rất nhiều so với các loại máy điều hòa khác.', 1000000.00, 10, 'Việt Nam', 3, NULL, '2025-01-13 01:02:53', '2025-01-13 01:02:53'),
	(31, 'Quạt điều hòa LENODI 60L ', 'Các bể chứa nước trên và dưới lưu thông làm mát, không khí nóng hút vào qua tấm làm mát trở thành không khí lạnh, làm mát một khu vực rộng lớn.Liên tục hòa tan và giải phóng không khí lạnh để đạt được sự làm mát lâu dài.', 859000.00, 10, 'Lenodi', 5, NULL, '2025-01-13 01:04:59', '2025-01-13 01:04:59'),
	(32, 'Quạt Lạnh Hơi Nước Di Động Siêu Mát Với Thế hệ mới CLEAN AIR Q ', 'Dung tích chứa nước 900ml.Thế hệ mới với bộ quạt mát hơn', 690000.00, 10, 'Việt Nam', 3, NULL, '2025-01-13 01:06:35', '2025-01-13 01:06:35'),
	(33, 'Quạt hơi nước Sharp', 'Quạt điều hòa, Sharp quạt hơi nước, quạt máy lạnh mẫu mới với 2 cấp độ gió và làm mát cực nhan lực gió mạnh siêu mát, không gây ồn-Cung cấp không khí góc rộng lớn - màn hình hiển thị kỹ thuật số. Có thể sử dụng sau khi sạc hoặc có thể cắm bằng bộ sạc USB Dung lượng pin: tối đa 1800 + thời gian phun 2-3 giờ Công suất: 25W Bánh răng quạt: Bánh răng thứ hai Bánh răng phun: Bánh răng thứ nhất phun liên tục, bánh răng thứ hai. phun trong 5 giây Dừng trong 5 giây', 1000000.00, 10, 'Sharp', 5, NULL, '2025-01-13 01:08:22', '2025-01-13 01:08:22'),
	(34, 'Quạt hơi nước Hòa Phát HPCF1-051', 'Máy làm mát không khí Hòa Phát HPCF1-051 hoạt động dựa trên nguyên lý bay hơi của nước thông qua tấm làm mát, làm dịu khí nóng, thổi ra gió mát tự nhiên mà không tiêu hao quá nhiều điện năng. Máy làm mát không khí HPCF1-051 có thể dễ dàng hạ nhiệt độ trong phòng, mang lại luồng gió mát lạnh, giảm nhiệt độ không gian xung quanh hữu hiệu. Sản phẩm có khả năng làm mát trên diện tích 30-40m2, phù hợp cho phòng khách lớn, nhà hàng, quán ăn, quán cơm, văn phòng quy mô vừa…', 2500000.00, 10, 'Hoà Phát', 6, NULL, '2025-01-13 01:10:32', '2025-01-13 01:10:32'),
	(35, 'Quạt hơi nước Alpha AF-1605', 'Quạt hơi nước Alpha AF-1605 được trang bị công suất 200W cùng cánh quạt có kích thước 400 mm cho khả năng làm mát cao trong không gian rộng hơn so với những dòng hơi nước thông thường. Có 3 chế độ gió : Gió thường, gió tự nhiên và gió ngủ. Hồng ngoại điều khiển từ xa với màn hình LED hiển thị màu sắc, có chế độ hẹn giờ.', 2400000.00, 10, 'Alpha', 6, NULL, '2025-01-13 01:12:00', '2025-01-13 01:12:00'),
	(36, 'Quạt hơi nước Alaska A1000', 'Quạt hơi nước Alaska A1000 hoạt động theo nguyên lý làm mát tự nhiên bằng nước, cho khả năng làm mát nhanh chóng. Công dụng làm mát bằng hơi nước không gây sốc nhiệt, đảm bảo sức khỏe và giải nhiệt tốt trong thời tiết nóng bức này. Kiểu dáng nhỏ gọn, không chiếm nhiều diện tích. Chân quạt có 4 bánh xe thuận tiện cho việc di chuyển. Các chức năng sẽ được chọn qua bàn phím điện tử hay remote, thể hiển rõ nét trên màn hình LED. Quạt hơi nước A1000 tích hợp chức năng tạo ion lọc khí, tạo ra không khí trong lành, diệt khuẩn bằng cách mô phỏng ion âm trong tự nhiên tạo cảm giác thoãi mái.', 3800000.00, 10, 'Trung Quốc', 6, NULL, '2025-01-13 01:14:27', '2025-01-13 01:14:27'),
	(37, 'Quạt Điều Hòa Hơi Nước Mini Để Bàn - Máy Quạt Đá Mini Phun Sương Có Khay Chứa Đá Tiện Dụng', 'Quạt Điều Hòa Hơi Nước Để Bàn Mẫu Mới 2023, Quạt Phun Sương Hẹn Giờ Kèm Đèn LED 7 Màu Công Nghệ Nhật Bản. Máy điều hòa mini làm mát không khí nhập khẩu với khả năng làm mát và giữ ẩm không khí, căn phòng của bạn sẽ luôn là một nơi lý tưởng để nghỉ ngơi, thư giãn. Có thiết kế hiện đại, trang nhã làm nổi bật thêm không gian căn phòng. Máy điều hòa mini làm mát không khí nhập khẩu là thiết bị làm mát không khí bay hơi cho phép bạn tạo ra khí hậu riêng của mình', 400000.00, 10, 'Nhật Bản', 3, NULL, '2025-01-13 01:16:00', '2025-01-13 01:16:00'),
	(38, 'Quạt Điều Hòa Hơi Nước Mini Để Bàn - Máy Quạt Đá Mini Phun Sương Có Khay Chứa Đá Tiện Dụng', 'Quạt Điều Hòa Hơi Nước Để Bàn Mẫu Mới 2023, Quạt Phun Sương Hẹn Giờ Kèm Đèn LED 7 Màu Công Nghệ Nhật Bản. Máy điều hòa mini làm mát không khí nhập khẩu với khả năng làm mát và giữ ẩm không khí, căn phòng của bạn sẽ luôn là một nơi lý tưởng để nghỉ ngơi, thư giãn. Có thiết kế hiện đại, trang nhã làm nổi bật thêm không gian căn phòng. ', 400000.00, 10, 'Nhật Bản', 3, NULL, '2025-01-13 01:16:13', '2025-01-13 01:16:13'),
	(39, 'Quạt điều hoà hơi nước dung tích 600ml phun sương làm mát 3 chế độ tích hợp đèn led , Quạt để bàn hơi nước', 'Máy điều hòa mini làm mát không khí nhập khẩu với khả năng làm mát và giữ ẩm không khí, căn phòng của bạn sẽ luôn là một nơi lý tưởng để nghỉ ngơi, thư giãn. Có thiết kế hiện đại, trang nhã làm nổi bật thêm không gian căn phòng. Máy điều hòa mini  làm mát không khí nhập khẩu là thiết bị làm mát không khí bay hơi cho phép bạn tạo ra khí hậu riêng của mình', 200000.00, 10, 'Việt Nam', 3, NULL, '2025-01-13 01:18:06', '2025-01-13 01:18:06'),
	(40, 'Quạt điều hòa hơi nước mini Hàn Quốc QuQu', 'Quạt điều hoà mini hơi nước QuQu Hàn Quốc là sản phẩm làm mát không khí là hút, lọc không khí trong phòng thông qua các màng lọc ion làm sạch vi khuẩn giúp không khí trở nên trong lành hơn, sản phẩm làm mát không khí bay hơi cho phép bạn tạo ra khí hậu riêng của mình. Quạt êm dịu và ánh sáng ban đêm nhẹ nhàng làm cho nó hoàn hảo để sử dụng suốt đêm để có một giấc ngủ thoải mái. Quạt điều hoà mini hơi nước QuQu giúp giảm nhiệt cân bằng tạo ẩm giúp không gian mát mẻ hơn. Được thiết kế nhỏ gọn sang trọng, đẹp mắt dùng dòng điện qua cổng USB, thích hợp dùng cho gia đình, văn phòng, nhà bếp, phòng ngủ, …', 700000.00, 10, 'Hàn Quốc', 5, NULL, '2025-01-13 01:20:01', '2025-01-13 01:20:01');

-- Dumping structure for table backend.product_discounts
DROP TABLE IF EXISTS `product_discounts`;
CREATE TABLE IF NOT EXISTS `product_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `product_id` (`product_id`) USING BTREE,
  KEY `discount_id` (`discount_id`) USING BTREE,
  CONSTRAINT `product_discounts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_discounts_ibfk_2` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.product_discounts: ~0 rows (approximately)

-- Dumping structure for table backend.product_images
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.product_images: ~81 rows (approximately)
INSERT INTO `product_images` (`id`, `product_id`, `image_url`, `is_primary`, `created_at`, `updated_at`) VALUES
	(69, 8, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_32225/quat-dieu-hoa-k_main_653_1020.png.webp', 1, '2025-01-08 01:13:17', '2025-01-08 01:13:17'),
	(70, 9, 'https://tongkhoquatcongnghiep.vn/wp-content/uploads/2023/12/QUAT-DIEU-HOA-HOI-NUOC-NF45-3-e1703554870736.jpg', 1, '2025-01-08 01:15:30', '2025-01-08 01:15:30'),
	(71, 9, 'https://tongkhoquatcongnghiep.vn/wp-content/uploads/2023/12/QUAT-DIEU-HOA-HOI-NUOC-NF45-5.jpg', 0, '2025-01-08 01:15:30', '2025-01-08 01:15:30'),
	(72, 10, 'https://product.hstatic.net/1000359792/product/d42e23ab3e9da6b9539469c685ee0996_7a108ecdcf5d495199c7e7a96571d06a_master.jpg', 1, '2025-01-13 00:18:20', '2025-01-13 00:18:20'),
	(73, 10, 'https://product.hstatic.net/1000359792/product/vn-11134201-7r98o-ln8r2ntj4yxk5f_426c8864abdf4b82819b940af89a3aae_master.jpeg', 0, '2025-01-13 00:18:20', '2025-01-13 00:18:20'),
	(74, 10, 'https://product.hstatic.net/1000359792/product/vn-11134201-7r98o-ln8r2nsz4dlk26_6cad6135b595453ebd147c0883565526_master.jpeg', 0, '2025-01-13 00:18:20', '2025-01-13 00:18:20'),
	(75, 11, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_34460/quat-dieu-hoa-e_main_229_1020.png.webp', 1, '2025-01-13 00:19:20', '2025-01-13 00:19:20'),
	(76, 12, 'https://kimkhidienmayletrieu.vn/Data/SanPham/6a4af476-96ce-4051-b9f6-341b924dabc6/420-512/a6de4fc4-3738-4b72-bfdf-f3a5f9300be2.jpg', 1, '2025-01-13 00:21:43', '2025-01-13 00:21:43'),
	(77, 12, 'https://kimkhidienmayletrieu.vn/Data/SanPham/6a4af476-96ce-4051-b9f6-341b924dabc6/a728cf89-cb39-4780-a075-5e5b18a89333.png', 0, '2025-01-13 00:21:43', '2025-01-13 00:21:43'),
	(78, 12, 'https://kimkhidienmayletrieu.vn/Data/SanPham/6a4af476-96ce-4051-b9f6-341b924dabc6/6cef059c-3b82-4435-b07f-d35202031e29.png', 0, '2025-01-13 00:21:43', '2025-01-13 00:21:43'),
	(79, 12, 'https://kimkhidienmayletrieu.vn/Data/SanPham/6a4af476-96ce-4051-b9f6-341b924dabc6/28f9c200-fee9-492b-8f58-e0a5c3070510.png', 0, '2025-01-13 00:21:43', '2025-01-13 00:21:43'),
	(80, 13, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lwziy70f542h9b.webp', 1, '2025-01-13 00:23:49', '2025-01-13 00:23:49'),
	(81, 13, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lwziy70f6imx0a.webp', 0, '2025-01-13 00:23:49', '2025-01-13 00:23:49'),
	(82, 13, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lwziy70fgcm188.webp', 0, '2025-01-13 00:23:49', '2025-01-13 00:23:49'),
	(83, 14, 'https://vuagiadungthongminh.com/wp-content/uploads/2024/06/vn-11134207-7qukw-lhsud16euytdca.jpg', 1, '2025-01-13 00:25:28', '2025-01-13 00:25:28'),
	(84, 14, 'https://vuagiadungthongminh.com/wp-content/uploads/2024/06/O1CN01whoP7H1OL9ShW8nS9_2214547431688-0-cib.jpg', 0, '2025-01-13 00:25:28', '2025-01-13 00:25:28'),
	(85, 14, 'https://vuagiadungthongminh.com/wp-content/uploads/2024/06/vn-11134207-7qukw-lh37tz4hvcabfb.jpg', 0, '2025-01-13 00:25:28', '2025-01-13 00:25:28'),
	(86, 15, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_26185/quat-dieu-hoa-b_main_259_1020.png.webp', 1, '2025-01-13 00:28:27', '2025-01-13 00:28:27'),
	(87, 15, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_26185/quat-dieu-hoa-b_multi_3_393_1020.png.webp', 0, '2025-01-13 00:28:27', '2025-01-13 00:28:27'),
	(88, 15, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_26185/quat-dieu-hoa-b_multi_2_870_1020.png.webp', 0, '2025-01-13 00:28:27', '2025-01-13 00:28:27'),
	(89, 16, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-g.jpg', 1, '2025-01-13 00:30:30', '2025-01-13 00:30:30'),
	(90, 16, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-1.jpg', 0, '2025-01-13 00:30:30', '2025-01-13 00:30:30'),
	(91, 16, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-ct.jpg', 0, '2025-01-13 00:30:30', '2025-01-13 00:30:30'),
	(92, 17, 'https://cdn.nguyenkimmall.com/images/thumbnails/600/336/detailed/803/10052024-quat-dieu-hoa-rapido-everest-3000-d-1.jpg', 1, '2025-01-13 00:32:31', '2025-01-13 00:32:31'),
	(93, 17, 'https://cdn.nguyenkimmall.com/images/thumbnails/600/336/detailed/803/10052024-quat-dieu-hoa-rapido-everest-3000-d-2.jpg', 0, '2025-01-13 00:32:31', '2025-01-13 00:32:31'),
	(94, 18, 'https://s.meta.com.vn/Data/image/2020/06/26/quat-thap-panworld-pw-979-1.jpg', 1, '2025-01-13 00:34:58', '2025-01-13 00:34:58'),
	(95, 19, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-g.jpg', 1, '2025-01-13 00:37:08', '2025-01-13 00:37:08'),
	(96, 19, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-1.jpg', 0, '2025-01-13 00:37:08', '2025-01-13 00:37:08'),
	(97, 19, 'https://st.meta.vn/Data/image/2023/06/02/quat-lam-lanh-khong-khi-galen-g020-ct.jpg', 0, '2025-01-13 00:37:08', '2025-01-13 00:37:08'),
	(98, 20, 'https://product.hstatic.net/1000359792/product/vn-11134201-7r98o-ln8r2ntj4yxk5f_426c8864abdf4b82819b940af89a3aae_master.jpeg', 1, '2025-01-13 00:39:42', '2025-01-13 00:39:42'),
	(99, 20, 'https://product.hstatic.net/1000359792/product/vn-11134201-7r98o-lmvr1ldrmo672d_88fb69874427415098fee9a6db3b2d30_master.jpeg', 0, '2025-01-13 00:39:42', '2025-01-13 00:39:42'),
	(100, 20, 'https://product.hstatic.net/1000359792/product/vn-11134201-7r98o-ln8r2nsz4dlk26_6cad6135b595453ebd147c0883565526_master.jpeg', 0, '2025-01-13 00:39:42', '2025-01-13 00:39:42'),
	(101, 21, 'https://webgiadung.com/storage/webgiadungcom/11556/vzdauuk9.jpg', 1, '2025-01-13 00:42:31', '2025-01-13 00:42:31'),
	(102, 21, 'https://webgiadung.com/storage/webgiadungcom/11557/ucx0n8y6.jpg', 0, '2025-01-13 00:42:31', '2025-01-13 00:42:31'),
	(103, 22, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lxgorfzzp4nt72@resize_w900_nl.webp', 1, '2025-01-13 00:45:23', '2025-01-13 00:45:23'),
	(104, 22, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lxgorfzznpwb31@resize_w900_nl.webp', 0, '2025-01-13 00:45:23', '2025-01-13 00:45:23'),
	(105, 22, 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m1rv9mrw8d3n3f@resize_w900_nl.webp', 0, '2025-01-13 00:45:23', '2025-01-13 00:45:23'),
	(106, 23, 'https://kimkhidienmayletrieu.vn/Data/SanPham/06ba8cbf-801d-4c7b-95e7-493738f61ee7/420-512/b57f7976-eb30-4912-8d4b-10339e5ae2ba.jpg', 1, '2025-01-13 00:50:49', '2025-01-13 00:50:49'),
	(107, 23, 'https://kimkhidienmayletrieu.vn/Data/SanPham/06ba8cbf-801d-4c7b-95e7-493738f61ee7/896898b7-889a-4e5d-a5da-b5049bae574c.jpg', 0, '2025-01-13 00:50:49', '2025-01-13 00:50:49'),
	(111, 24, 'https://thietbingoainhap.com/wp-content/uploads/2024/05/10031896-quat-dieu-hoa-boss-s102-1.jpeg', 1, '2025-01-13 00:52:40', '2025-01-13 00:52:40'),
	(112, 24, 'https://thietbingoainhap.com/wp-content/uploads/2024/05/quat-dieu-hoa-b_multi_0_706_1020.png.webp', 0, '2025-01-13 00:52:40', '2025-01-13 00:52:40'),
	(113, 24, 'https://thietbingoainhap.com/wp-content/uploads/2024/05/quat-dieu-hoa-b_multi_1_500_1020.png.webp', 0, '2025-01-13 00:52:40', '2025-01-13 00:52:40'),
	(114, 24, 'https://thietbingoainhap.com/wp-content/uploads/2024/05/quat-dieu-hoa-b_multi_3_393_1020.png.webp', 0, '2025-01-13 00:52:40', '2025-01-13 00:52:40'),
	(115, 25, 'https://bizweb.dktcdn.net/thumb/grande/100/415/961/products/kq832-t.jpg?v=1679207853037', 1, '2025-01-13 00:54:15', '2025-01-13 00:54:15'),
	(116, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/415/961/products/o1cn01fqlpai1wqtggfofp5-2551046359-0-cib.jpg?v=1678846666040', 0, '2025-01-13 00:54:15', '2025-01-13 00:54:15'),
	(117, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/415/961/products/3aa19033b8c44230aadfcb7c680edf3e.jpg?v=1678846666040', 0, '2025-01-13 00:54:15', '2025-01-13 00:54:15'),
	(118, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/415/961/products/b0d78efc42b703642ab516577fbf58ae.jpg?v=1678846666040', 0, '2025-01-13 00:54:15', '2025-01-13 00:54:15'),
	(119, 26, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lk91k1asdyg841.webp', 1, '2025-01-13 00:56:03', '2025-01-13 00:56:03'),
	(120, 26, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lk91k1asgrl497.webp', 0, '2025-01-13 00:56:03', '2025-01-13 00:56:03'),
	(121, 26, 'https://down-vn.img.susercontent.com/file/b9e50199d044b5eb73fb260d43b6a6c6.webp', 0, '2025-01-13 00:56:03', '2025-01-13 00:56:03'),
	(122, 27, 'https://hangxingiatot.com/storage/hangxingiatotcom/12865/oiisbrnu.jpg', 1, '2025-01-13 00:57:30', '2025-01-13 00:57:30'),
	(123, 27, 'https://hangxingiatot.com/storage/hangxingiatotcom/12866/ftgpugbe.jpg', 0, '2025-01-13 00:57:30', '2025-01-13 00:57:30'),
	(124, 27, 'https://hangxingiatot.com/storage/hangxingiatotcom/12867/dh75ggkb.jpg', 0, '2025-01-13 00:57:30', '2025-01-13 00:57:30'),
	(125, 28, 'https://dienmayngohoang.com/wp-content/uploads/2024/11/69.jpg', 1, '2025-01-13 00:58:40', '2025-01-13 00:58:40'),
	(126, 28, 'https://dienmayngohoang.com/wp-content/uploads/2024/11/69.jpg', 0, '2025-01-13 00:58:40', '2025-01-13 00:58:40'),
	(127, 29, 'https://salt.tikicdn.com/cache/750x750/ts/product/f4/87/b4/12dbce880088820afb88ea6a176eda17.jpg.webp', 1, '2025-01-13 01:01:34', '2025-01-13 01:01:34'),
	(128, 29, 'https://salt.tikicdn.com/cache/750x750/ts/product/a7/33/32/da68640b5137ced75a1b4359aaac12a4.jpg.webp', 0, '2025-01-13 01:01:34', '2025-01-13 01:01:34'),
	(129, 29, 'https://salt.tikicdn.com/cache/750x750/ts/product/3e/47/1d/02402aad36bd7febfcc1d25cb524ea8e.jpg.webp', 0, '2025-01-13 01:01:34', '2025-01-13 01:01:34'),
	(130, 30, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lkau3nug96l846.webp', 1, '2025-01-13 01:02:53', '2025-01-13 01:02:53'),
	(131, 30, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lh5pw7qji7eb71.webp', 0, '2025-01-13 01:02:53', '2025-01-13 01:02:53'),
	(132, 30, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lh5pw7r38yr7b6.webp', 0, '2025-01-13 01:02:53', '2025-01-13 01:02:53'),
	(133, 31, 'https://img.lazcdn.com/g/p/45d2064502963841acecca3bc2e62517.jpg_720x720q80.jpg_.webp', 1, '2025-01-13 01:04:59', '2025-01-13 01:04:59'),
	(134, 32, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd3y-luzur02qud57b6.webp', 1, '2025-01-13 01:06:35', '2025-01-13 01:06:35'),
	(135, 32, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd5o-luzur07qn2i17e.webp', 0, '2025-01-13 01:06:35', '2025-01-13 01:06:35'),
	(136, 32, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd5q-luzur15b9xza8d.webp', 0, '2025-01-13 01:06:35', '2025-01-13 01:06:35'),
	(137, 33, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd3v-lwglspl55en65d@resize_w900_nl.webp', 1, '2025-01-13 01:08:22', '2025-01-13 01:08:22'),
	(138, 33, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd5n-lwglsp1pxts947.webp', 0, '2025-01-13 01:08:22', '2025-01-13 01:08:22'),
	(139, 33, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd65-lwglspbzisy109.webp', 0, '2025-01-13 01:08:22', '2025-01-13 01:08:22'),
	(140, 34, 'https://img.lazcdn.com/g/p/401de14dbc27a6a1203698f3b05e7ceb.png_720x720q80.png_.webp', 1, '2025-01-13 01:10:32', '2025-01-13 01:10:32'),
	(141, 34, 'https://img.lazcdn.com/g/p/4b3cda3235d1604e6004b9cb4c88da97.png_720x720q80.png_.webp', 0, '2025-01-13 01:10:32', '2025-01-13 01:10:32'),
	(144, 35, 'https://kingshop.vn/data/images/Quat-hoi-nuoc-va-phunsuong-Alpha-AF-1605_2.jpg', 1, '2025-01-13 01:12:36', '2025-01-13 01:12:36'),
	(145, 36, 'https://kinghouse.vn/wp-content/uploads/quat-hoi-nuoc-alaska-a1000-daidien-1586338609.jpg', 1, '2025-01-13 01:14:27', '2025-01-13 01:14:27'),
	(146, 37, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5nty0p65b.webp', 1, '2025-01-13 01:16:00', '2025-01-13 01:16:00'),
	(147, 37, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5nttszu76.webp', 0, '2025-01-13 01:16:00', '2025-01-13 01:16:00'),
	(148, 37, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5ntv7ka2c.webp', 0, '2025-01-13 01:16:00', '2025-01-13 01:16:00'),
	(149, 38, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5nty0p65b.webp', 1, '2025-01-13 01:16:13', '2025-01-13 01:16:13'),
	(150, 38, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5nttszu76.webp', 0, '2025-01-13 01:16:13', '2025-01-13 01:16:13'),
	(151, 38, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ltopi5ntv7ka2c.webp', 0, '2025-01-13 01:16:13', '2025-01-13 01:16:13'),
	(152, 39, 'https://img.lazcdn.com/g/p/b671e4e347a49b4a53eeef905cc1dca6.jpg_720x720q80.jpg_.webp', 1, '2025-01-13 01:18:06', '2025-01-13 01:18:06'),
	(153, 39, 'https://img.lazcdn.com/g/p/221384f29a1841084a22b6ce8c004e70.jpg_720x720q80.jpg_.webp', 0, '2025-01-13 01:18:06', '2025-01-13 01:18:06'),
	(154, 40, 'https://hueminhkorea.com/wp-content/uploads/2022/04/quat-dieu-hoa-hoi-nuoc-mini-ququ-han-quoc-10.jpg', 1, '2025-01-13 01:20:01', '2025-01-13 01:20:01');

-- Dumping structure for table backend.reviews
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.reviews: ~11 rows (approximately)
INSERT INTO `reviews` (`id`, `product_id`, `username`, `rating`, `comment`, `created_at`, `updated_at`) VALUES
	(7, 40, 'hoang nhut duy', 3, '123', '2025-01-14 05:17:13', '2025-01-14 05:17:13'),
	(12, 40, 'hoang nhut duy', 4, 'sản phẩm tuyệt vời ', '2025-01-14 05:44:10', '2025-01-14 05:44:10'),
	(13, 18, 'hoang nhut duy', 3, 'hay', '2025-01-14 06:35:17', '2025-01-14 06:35:17'),
	(14, 18, 'hoang nhut duy', 5, 'hay qua', '2025-01-14 06:52:51', '2025-01-14 06:52:51'),
	(15, 19, 'hoang nhut duy', 4, 'qua hay', '2025-01-14 06:53:03', '2025-01-14 06:53:03'),
	(16, 8, 'hoang nhut duy', 4, 'sản phẩm tốt', '2025-01-14 07:15:47', '2025-01-14 07:15:47'),
	(17, 39, 'hoang nhut duy', 3, '123123', '2025-01-14 07:18:05', '2025-01-14 07:18:05'),
	(18, 8, 'hoang nhut duy', 4, 'Sản phẩm này tốt', '2025-01-14 11:05:35', '2025-01-14 11:05:35'),
	(19, 40, 'hoang nhut duy', 5, 'hello ', '2025-01-14 13:43:48', '2025-01-14 13:43:48'),
	(20, 40, 'hoang nhut duy', 4, 'helloo', '2025-01-14 13:44:09', '2025-01-14 13:44:09'),
	(21, 40, 'hoang nhut duy', 3, 'hello', '2025-01-14 16:47:21', '2025-01-14 16:47:21');

-- Dumping structure for table backend.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table backend.users: ~11 rows (approximately)
INSERT INTO `users` (`id`, `username`, `password`, `fullName`, `email`, `phone`, `dob`, `address`, `role`, `status`, `created_at`, `updated_at`) VALUES
	(12, 'hoangnhutduy123', '$2a$10$6ywwOM5XejUDZJ8KWyW9p.Ea8TKPGBu1nbCscVFg/v0jHsTVFhjNa', 'Hoàng Nhựt Duy', 'nhutdny123@gmail.com', '0775869195', '2025-01-02', '4D, Trần Thị Vững, An Bình, Dĩ An Bình Dương', 'admin', 'Active', '2025-01-07 05:24:32', '2025-01-07 05:24:32'),
	(13, 'trancongly123', '$2a$10$oLRDBT9xn1zGUkGu2cFPzeL8hxcpWPPtE2At6sVVQk1HfBtrIyuca', 'Trần Công Lý', 'trancongly123@gmail.com', '0775869195', '2002-01-09', '4D, Trần Thị Vững, An Bình, Dĩ An Bình Dương', 'user', 'Active', '2025-01-07 05:36:16', '2025-01-07 05:36:16'),
	(17, 'nguyennhattuong@gmail.com', '$2a$10$hFOFELrGmahKxvmNpvMZ0O.O5Uz4KzKjtAsGLKV.6xrqRcRTE/AYC', 'Nguyễn Nhật Tường', 'nguyennhattuong@gmail.com', '0775869195', '2025-01-15', '4D, Trần Thị Vững, An Bình, Dĩ An Bình Dương', 'user', 'Active', '2025-01-14 03:15:10', '2025-01-14 03:15:10'),
	(18, 'hoainam', '$2a$10$azpH2tYvoEfJ7p8.0Vvr.uWsOSrdvaA743xIU/VeX.T8N7AVBx18m', 'Trần Hoài Nam', 'hoainam@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:12:59', '2025-01-14 15:12:59'),
	(20, 'abc', '$2a$10$S4sMGPwbXpkhWlmXxU.CneTMIOpoXjViv26A7IILeVrdai8kWcAoK', 'abc', 'abc@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:18:15', '2025-01-14 15:18:15'),
	(23, 'rty', '$2a$10$SeMJO7ghbLufgccLvexEjuoXGws2EoDZ.NbcrLGK17jZm8F05sTL6', 'Trần Hoài Nam', 'rty@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:23:30', '2025-01-14 15:23:30'),
	(24, 'hoainam1', '$2a$10$YSh0aAZBvA9GxUsLvPmmH.svc7huZ0coZIQMVMSbVKFyHB4L8MVQq', 'Tran Van a', 'hoainam1@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:27:27', '2025-01-14 15:27:27'),
	(25, 'hoainam2', '$2a$10$2aPpJECrDWm0Utye3qk3QOX1yoURuT2KnpoHIwZzg7Xb3StmfhcsS', 'Tran Van B', 'hoainam2@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:29:15', '2025-01-14 15:29:15'),
	(26, 'hoainam4', '$2a$10$CiJtJfSLF9gwSxphTlEfye8KJyooHCr2muZnC.qT5JUQxTmhR/9xS', 'Tran Van D', 'hoainam4@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:34:41', '2025-01-14 15:34:41'),
	(27, 'trannam', '$2a$10$2qz/Hp9M0CnHRrGP5u9Zz.zG/p6Upw1u5pqxBOmSqQlCYLJIfq0d2', 'abcd', 'trannam@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:37:53', '2025-01-14 15:37:53'),
	(28, 'hoangthinh', '$2a$10$4rrTYVuCQoQhdDjOnwjWyeiVDs777TRvbnEabblsmXurOQbdPMcXW', 'Trần Hoài Nam', 'hoangthinh@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:46:39', '2025-01-14 15:46:39'),
	(29, 'hoangthinh1', '$2a$10$fV2eU7zyAhPCax0eKq6jP.ULinJteX6Q/eLSOq0LPdsLy9VdYORZW', 'Trần Hoài Thinh', 'hoangthinh1@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:48:40', '2025-01-14 15:48:40'),
	(30, 'xyzd', '$2a$10$d4pkcFnFv2kM/8YVKZ.hT.b7j/Ug9OVAOsIu8oRY5iB6BJIwOYDtW', 'xyz', 'xyz@gmail.com', NULL, NULL, NULL, 'user', 'Active', '2025-01-14 15:51:48', '2025-01-14 15:51:48'),
	(45, 'hoainam97', '123', 'Trần Hoài Nam', 'hoainam97@gmail.com', '012345', '2025-02-27', 'Thủ Đức', 'admin', 'Active', '2025-02-27 14:42:32', '2025-02-27 14:42:32'),
	(46, 'sontung', '$2a$10$OnTvp40ydk1APqZKWto8qevhdWhJZ5enlGVhoOK9QNhDnimhcq0o.', 'Sơn Tùng', 'sontung@gmail.com', '0123456789', '2025-02-19', 'Thái Bình', 'admin', 'Active', '2025-02-27 14:59:48', '2025-02-27 14:59:48');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

DROP TABLE IF EXISTS `custom_orders`;
CREATE TABLE IF NOT EXISTS `custom_orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `height` VARCHAR(10),
  `weight` VARCHAR(10),
  `design_type` VARCHAR(100),
  `fabric_color` VARCHAR(100),
  `material` VARCHAR(255),
  `size` VARCHAR(20),
  `bust` FLOAT,
  `waist` FLOAT,
  `hip` FLOAT,
  `sleeve_length` FLOAT,
  `length` FLOAT,
  `message` TEXT,
  `design_file` VARCHAR(255),
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



dcategoriesb

SHOW DATABASES;
USE backend;
SHOW TABLES;

SELECT * FROM custom_orders ORDER BY created_at DESC;

SHOW TABLES;
SELECT * FROM custom_orders;

SELECT * FROM custom_orders ORDER BY id DESC;
