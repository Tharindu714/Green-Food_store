-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.32 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for fresh
CREATE DATABASE IF NOT EXISTS `fresh` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fresh`;

-- Dumping structure for table fresh.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `email` varchar(100) NOT NULL,
  `fname` varchar(25) NOT NULL,
  `lname` varchar(25) NOT NULL,
  `verification_code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.admin: ~0 rows (approximately)
REPLACE INTO `admin` (`email`, `fname`, `lname`, `verification_code`) VALUES
	('tharinduchanaka@gmail.com', 'Tharindu', 'Chanaka', '66878e569e131');

-- Dumping structure for table fresh.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_user1_idx` (`user_email`),
  KEY `fk_cart_product1_idx` (`product_id`),
  CONSTRAINT `fk_cart_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_cart_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.cart: ~0 rows (approximately)
REPLACE INTO `cart` (`id`, `qty`, `user_email`, `product_id`) VALUES
	(25, 1, 'kasunijayamali.kg@gmail.com', 13);

-- Dumping structure for table fresh.category
CREATE TABLE IF NOT EXISTS `category` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.category: ~3 rows (approximately)
REPLACE INTO `category` (`c_id`, `name`, `path`) VALUES
	(1, 'Juices', 'category/electronic.jpg'),
	(2, 'Vegetable', 'category/electrical.jpg'),
	(3, 'Fruit', 'category/spareparts.png');

-- Dumping structure for table fresh.chat
CREATE TABLE IF NOT EXISTS `chat` (
  `chat_id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `datetime` datetime NOT NULL,
  `status` int NOT NULL,
  `toadmin` varchar(100) NOT NULL,
  `fromuser` varchar(100) NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `fk_Chat_user1_idx` (`fromuser`),
  CONSTRAINT `fk_Chat_user1` FOREIGN KEY (`fromuser`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.chat: ~0 rows (approximately)
REPLACE INTO `chat` (`chat_id`, `message`, `datetime`, `status`, `toadmin`, `fromuser`) VALUES
	(21, 'Hello I am a New User', '2024-07-05 04:16:55', 1, 'tharinduchanaka@gmail.com', 'dhanushkalakmal@gmail.com');

-- Dumping structure for table fresh.chat2
CREATE TABLE IF NOT EXISTS `chat2` (
  `chat2_id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `datetime` datetime NOT NULL,
  `status` int NOT NULL,
  `Fromadmin` varchar(100) NOT NULL,
  `touser` varchar(100) NOT NULL,
  PRIMARY KEY (`chat2_id`),
  KEY `fk_chat2_user1_idx` (`touser`),
  CONSTRAINT `fk_chat2_user1` FOREIGN KEY (`touser`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.chat2: ~0 rows (approximately)
REPLACE INTO `chat2` (`chat2_id`, `message`, `datetime`, `status`, `Fromadmin`, `touser`) VALUES
	(23, 'Hello Dhanushka', '2024-07-05 04:27:51', 1, 'tharinduchanaka@gmail.com', 'dhanushkalakmal@gmail.com');

-- Dumping structure for table fresh.city
CREATE TABLE IF NOT EXISTS `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) NOT NULL,
  `district_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_city_district1_idx` (`district_id`),
  CONSTRAINT `fk_city_district1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.city: ~2 rows (approximately)
REPLACE INTO `city` (`id`, `city_name`, `district_id`) VALUES
	(1, 'Bandaraweala', 1),
	(13, 'Colombo', 10);

-- Dumping structure for table fresh.district
CREATE TABLE IF NOT EXISTS `district` (
  `id` int NOT NULL AUTO_INCREMENT,
  `district_name` varchar(45) NOT NULL,
  `province_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_district_province1_idx` (`province_id`),
  CONSTRAINT `fk_district_province1` FOREIGN KEY (`province_id`) REFERENCES `province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.district: ~2 rows (approximately)
REPLACE INTO `district` (`id`, `district_name`, `province_id`) VALUES
	(1, 'Badulla', 1),
	(10, 'Colombo', 2);

-- Dumping structure for table fresh.feedback
CREATE TABLE IF NOT EXISTS `feedback` (
  `feed_id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL DEFAULT '0',
  `feedback` text NOT NULL,
  `date` date NOT NULL,
  `product_id` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `Feed_status` int NOT NULL,
  PRIMARY KEY (`feed_id`) USING BTREE,
  KEY `fk_feedback_product1_idx` (`product_id`),
  KEY `fk_feedback_user1_idx` (`user_email`),
  CONSTRAINT `fk_feedback_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_feedback_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.feedback: ~0 rows (approximately)

-- Dumping structure for table fresh.gender
CREATE TABLE IF NOT EXISTS `gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender_name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.gender: ~3 rows (approximately)
REPLACE INTO `gender` (`id`, `gender_name`) VALUES
	(1, 'Male'),
	(2, 'Female'),
	(3, 'Neutual');

-- Dumping structure for table fresh.image
CREATE TABLE IF NOT EXISTS `image` (
  `img_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(150) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`img_id`) USING BTREE,
  KEY `fk_image_product1_idx` (`product_id`),
  CONSTRAINT `fk_image_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.image: ~14 rows (approximately)
REPLACE INTO `image` (`img_id`, `code`, `product_id`) VALUES
	(133, 'category//Product//Aloe Vera Nectar_0_668720b7a91c0.jpeg', 11),
	(134, 'category//Product//Aloe Vera Nectar_1_668720b7aa2a9.jpeg', 11),
	(135, 'category//Product//Aloe Vera Nectar_2_668720b7aabed.jpeg', 11),
	(136, 'category//Product//Aloe Vera Nectar_3_668720b7ab964.jpeg', 11),
	(137, 'category//Product//Aloe Vera Nectar_4_668720b7ac1f1.jpeg', 11),
	(142, 'category//Product//Apple - Red_0_668722d8dc785.jpeg', 13),
	(143, 'category//Product//Apple - Red_1_668722d8dd5bd.jpeg', 13),
	(144, 'category//Product//Apple - Red_2_668722d8ddf0a.jpeg', 13),
	(145, 'category//Product//Apple - Red_3_668722d8dec2d.jpeg', 13),
	(146, 'category//Product//Apple - Red_4_668722d8df6f2.jpeg', 13),
	(147, 'category//Product//Brinjal 1KG Pack_0_668723b053b02.jpeg', 12),
	(148, 'category//Product//Brinjal 1KG Pack_1_668723b054c10.jpeg', 12),
	(149, 'category//Product//Brinjal 1KG Pack_2_668723b05579b.jpeg', 12),
	(150, 'category//Product//Brinjal 1KG Pack_3_668723b0566ae.jpeg', 12);

-- Dumping structure for table fresh.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `total` double NOT NULL,
  `d_status` int NOT NULL,
  `iqty` int DEFAULT NULL,
  `product_id` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `remove_status` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_product1_idx` (`product_id`),
  KEY `fk_invoice_user1_idx` (`user_email`),
  CONSTRAINT `fk_invoice_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_invoice_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.invoice: ~0 rows (approximately)
REPLACE INTO `invoice` (`id`, `order_id`, `date`, `total`, `d_status`, `iqty`, `product_id`, `user_email`, `remove_status`) VALUES
	(23, '668723f9bf3fc', '2024-07-05', 490, 2, 1, 13, 'kasunijayamali.kg@gmail.com', 1),
	(24, '66878fbe9106c', '2024-07-05', 900, 0, 3, 11, 'gemhush@gmail.com', 1);

-- Dumping structure for table fresh.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `qty` int NOT NULL,
  `description` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `datetime_added` datetime NOT NULL,
  `delivery_fee_colombo` double NOT NULL,
  `delivery_fee_other` double NOT NULL,
  `status_id` int NOT NULL,
  `category_id` int NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_status1_idx` (`status_id`),
  KEY `fk_product_category1_idx` (`category_id`),
  KEY `fk_product_admin1_idx` (`admin_email`),
  CONSTRAINT `fk_product_admin1` FOREIGN KEY (`admin_email`) REFERENCES `admin` (`email`),
  CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`c_id`),
  CONSTRAINT `fk_product_status1` FOREIGN KEY (`status_id`) REFERENCES `status` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.product: ~3 rows (approximately)
REPLACE INTO `product` (`id`, `price`, `qty`, `description`, `title`, `datetime_added`, `delivery_fee_colombo`, `delivery_fee_other`, `status_id`, `category_id`, `admin_email`) VALUES
	(11, 300, 247, 'Typical Values per 100 g </br>\r\nEnergy	29.3 kcal / 122.5 kJ </br>\r\nProtein	0.00 g  </br>\r\nCarbohydrates	7.50 g </br>\r\nMinerals	0.08 g </br>\r\nFat	0.10 g </br>\r\nSalt (as NaCl)	0.02 g </br>\r\nWater & Sugar</br>\r\nAloe Vera Pieces with Juice </br>\r\nApple juice concentrate</br> \r\npermitted stabilizer E 418</br> \r\nCalcium Lactate E 327</br> \r\nCitric Acid E 330</br> \r\nTri Sodium citrate E 331</br>\r\n Natural Peach & Melon Flavours and Permitted preservative potassium sorbate', 'Aloe Vera Nectar', '2024-07-05 03:52:47', 100, 150, 1, 1, 'tharinduchanaka@gmail.com'),
	(12, 290, 100, 'Only Colombo 1-10, Nawala, Dehiwala, Mount lavinia, Rajagiriya, kotte, battaramulla, Kalubowila, Kohuwala and Wallampitya are covered. Delivery will be done during curfew periods as well. <br/>\r\n\r\nFresh Brinjals<br/>\r\n1Kg pack<br/>', 'Brinjal 1KG Pack', '2024-07-05 03:56:24', 100, 160, 1, 2, 'tharinduchanaka@gmail.com'),
	(13, 490, 499, 'This is a weighted item. The exact quantity which you receive may differ slightly and as... <br>\r\nBrand - SPAR Sri Lanka <br>\r\nCategory - Fresh Fruit <br>\r\nAvailability - 3000 In Stock <br>', 'Apple - Red', '2024-07-05 04:01:52', 100, 150, 1, 3, 'tharinduchanaka@gmail.com');

-- Dumping structure for table fresh.profile_image
CREATE TABLE IF NOT EXISTS `profile_image` (
  `path` varchar(50) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  PRIMARY KEY (`path`),
  KEY `fk_profile_image_user1_idx` (`user_email`),
  CONSTRAINT `fk_profile_image_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.profile_image: ~0 rows (approximately)
REPLACE INTO `profile_image` (`path`, `user_email`) VALUES
	('resources/proimg/Gemy_66878fb14be43.png', 'gemhush@gmail.com'),
	('resources/proimg/Kasuni_66871acf75a35.jpeg', 'kasunijayamali.kg@gmail.com');

-- Dumping structure for table fresh.province
CREATE TABLE IF NOT EXISTS `province` (
  `id` int NOT NULL AUTO_INCREMENT,
  `province_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.province: ~9 rows (approximately)
REPLACE INTO `province` (`id`, `province_name`) VALUES
	(1, 'Uva'),
	(2, 'Western'),
	(3, 'Northern'),
	(4, 'Southern'),
	(5, 'North Central'),
	(6, 'North West'),
	(7, 'Eastern'),
	(8, 'Sabaragamuwa'),
	(9, 'Central');

-- Dumping structure for table fresh.recent
CREATE TABLE IF NOT EXISTS `recent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `recent_status` int NOT NULL,
  `removed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recent_product1_idx` (`product_id`),
  KEY `fk_recent_user1_idx` (`user_email`),
  CONSTRAINT `fk_recent_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_recent_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.recent: ~0 rows (approximately)
REPLACE INTO `recent` (`id`, `product_id`, `user_email`, `recent_status`, `removed`) VALUES
	(20, 11, 'kasunijayamali.kg@gmail.com', 1, '2024-07-05 04:13:39');

-- Dumping structure for table fresh.status
CREATE TABLE IF NOT EXISTS `status` (
  `s_id` int NOT NULL AUTO_INCREMENT,
  `s_name` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`s_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.status: ~2 rows (approximately)
REPLACE INTO `status` (`s_id`, `s_name`) VALUES
	(1, 'Active'),
	(2, 'Deactivate');

-- Dumping structure for table fresh.user
CREATE TABLE IF NOT EXISTS `user` (
  `email` varchar(100) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `password` varchar(25) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `join_date` date NOT NULL,
  `verification_code` varchar(25) DEFAULT NULL,
  `status` int NOT NULL,
  `gender_id` int NOT NULL,
  PRIMARY KEY (`email`),
  KEY `fk_user_gender_idx` (`gender_id`),
  CONSTRAINT `fk_user_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.user: ~0 rows (approximately)
REPLACE INTO `user` (`email`, `fname`, `lname`, `password`, `mobile`, `join_date`, `verification_code`, `status`, `gender_id`) VALUES
	('dhanushkalakmal@gmail.com', 'Dhanushka', 'Lakmal', 'WMDLkmal67@56', '0753795742', '2024-06-20', NULL, 1, 1),
	('emtylee@gmail.com', 'Eminem', 'Tyler', 'emtyLEE#890', '0781441090', '2024-06-25', NULL, 1, 1),
	('gemhush@gmail.com', 'Gemy', 'Hustler', 'genHish%#889', '0751561764', '2024-06-24', NULL, 1, 1),
	('kasunijayamali.kg@gmail.com', 'Kasuni', 'Jayamali', 'kasuniJayaMali789', '0715555909', '2024-06-20', '66766875c3af7', 1, 2);

-- Dumping structure for table fresh.user_has_address
CREATE TABLE IF NOT EXISTS `user_has_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `line1` text NOT NULL,
  `line2` text NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `city_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_has_address_user1_idx` (`user_email`),
  KEY `fk_user_has_address_city1_idx` (`city_id`),
  CONSTRAINT `fk_user_has_address_city1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`),
  CONSTRAINT `fk_user_has_address_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.user_has_address: ~1 rows (approximately)
REPLACE INTO `user_has_address` (`id`, `line1`, `line2`, `postal_code`, `user_email`, `city_id`) VALUES
	(7, '296/1,', 'Heeloya Road', '90100', 'kasunijayamali.kg@gmail.com', 1),
	(8, '678/2,', 'hillside road,', '90100', 'gemhush@gmail.com', 1);

-- Dumping structure for table fresh.wishlist
CREATE TABLE IF NOT EXISTS `wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wishlist_product1_idx` (`product_id`),
  KEY `fk_wishlist_user1_idx` (`user_email`),
  CONSTRAINT `fk_wishlist_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_wishlist_user1` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table fresh.wishlist: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
