-- Create and use database
DROP DATABASE IF EXISTS project_g2;
CREATE DATABASE IF NOT EXISTS project_g2;
USE project_g2;

-- Drop tables in dependency order (child tables first)
DROP TABLE IF EXISTS `cartitem`;
DROP TABLE IF EXISTS `orderdetail`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `productimage`;
DROP TABLE IF EXISTS `productspecification`;
DROP TABLE IF EXISTS `feedback_image`;
DROP TABLE IF EXISTS `feedback`;
DROP TABLE IF EXISTS `blog_image`;
DROP TABLE IF EXISTS `inventorylog`;
DROP TABLE IF EXISTS `blog`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `admin`;
DROP TABLE IF EXISTS `staff`;
DROP TABLE IF EXISTS `shipper`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `series`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `brand`;
DROP TABLE IF EXISTS `componenttype`;
DROP TABLE IF EXISTS `paymentmethod`;
DROP TABLE IF EXISTS `transactions`;
DROP TABLE IF EXISTS `voucher`;
DROP TABLE IF EXISTS `voucher_usage`;
DROP TABLE IF EXISTS `menu_attribute_value`;
DROP TABLE IF EXISTS `menu_attribute`;
DROP TABLE IF EXISTS `menu_item`;

-- Create parent tables
CREATE TABLE `componenttype` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paymentmethod` (
  `payment_method_id` INT NOT NULL AUTO_INCREMENT,
  `method_name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 collate=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `role` ENUM('Staff', 'Admin') NOT NULL,
  `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
  `is_verified` TINYINT(1) NOT NULL DEFAULT '0',
  `verification_token` TEXT,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create dependent tables
CREATE TABLE `series` (
  `series_id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  `component_type_id` INT NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`series_id`),
  KEY `brand_id` (`brand_id`),
  KEY `component_type_id` (`component_type_id`),
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`),
  CONSTRAINT `series_ibfk_2` FOREIGN KEY (`component_type_id`) REFERENCES `componenttype` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `password` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `shipping_address` VARCHAR(255) DEFAULT NULL,
  `is_verified` TINYINT(1) DEFAULT '0',
  `verification_token` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `enter_date` DATE DEFAULT NULL,
  `leave_date` DATE DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shipper` (
  `shipper_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) DEFAULT NULL,
  `component_type_id` INT NOT NULL,
  `brand_id` INT NOT NULL,
  `series_id` INT,
  `model` VARCHAR(100) DEFAULT NULL,
  `price` DECIMAL(18,2) DEFAULT NULL,
  `import_price` DECIMAL(18,2) DEFAULT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `sku` VARCHAR(50) UNIQUE NOT NULL,
  `description` TEXT,
  `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `component_type_id` (`component_type_id`),
  KEY `brand_id` (`brand_id`),
  KEY `series_id` (`series_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`component_type_id`) REFERENCES `componenttype` (`type_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`),
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cartitem` (
  `cart_item_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `cartitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `total_amount` DECIMAL(18,2) DEFAULT NULL,
  `shipping_address` VARCHAR(255) DEFAULT NULL,
  `shipping_fee` DECIMAL(10,2) DEFAULT '0.00',
  `status` ENUM('Pending', 'Shipping', 'Completed', 'Cancel') NOT NULL DEFAULT 'Pending',
  `payment_method_id` INT DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `paymentmethod` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orderdetail` (
  `order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productimage` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `alt_text` VARCHAR(255) DEFAULT NULL,
  `is_primary` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`image_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `productimage_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productspecification` (
  `spec_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `spec_key` VARCHAR(100) DEFAULT NULL,
  `spec_value` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`spec_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `productspecification_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedback` (
  `feedback_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT DEFAULT NULL,
  `product_id` INT DEFAULT NULL,
  `rating` INT NOT NULL,
  `content` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `feedback_chk_1` CHECK (`rating` BETWEEN 1 AND 5)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedback_image` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `feedback_id` INT NOT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `image_alt` VARCHAR(255) DEFAULT NULL,
  `display_order` INT DEFAULT 1,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `feedback_id` (`feedback_id`),
  CONSTRAINT `feedback_image_ibfk_1` FOREIGN KEY (`feedback_id`) REFERENCES `feedback` (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventorylog` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `action` ENUM('Add', 'Remove', 'Adjust') NOT NULL,
  `quantity` INT NOT NULL,
  `note` VARCHAR(255) DEFAULT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventorylog_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `blog` (
  `blog_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`blog_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `blog_image` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `blog_id` INT NOT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `image_alt` VARCHAR(255) DEFAULT NULL,
  `display_order` INT DEFAULT 1,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `blog_id` (`blog_id`),
  CONSTRAINT `blog_image_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transactions` (
  `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
  `transaction_code` VARCHAR(50),
  `order_id` INT NOT NULL,
  `payment_method_id` INT,
  `total_amount` DECIMAL(18,2),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `paid` TINYINT(1) DEFAULT FALSE,
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  FOREIGN KEY (`payment_method_id`) REFERENCES `paymentmethod` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `voucher` (
  `voucher_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(50) NOT NULL UNIQUE,
  `description` VARCHAR(255) DEFAULT NULL,
  `discount_type` ENUM('percent', 'fixed') NOT NULL DEFAULT 'percent',
  `discount_value` DECIMAL(10,2) NOT NULL,
  `min_order_amount` DECIMAL(18,2) DEFAULT 0.00,
  `max_uses` INT DEFAULT NULL,
  `max_uses_per_user` INT DEFAULT NULL,
  `start_date` DATETIME DEFAULT NULL,
  `end_date` DATETIME DEFAULT NULL,
  `status` ENUM('Active', 'Inactive', 'Expired') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`voucher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `voucher_usage` (
  `usage_id` INT NOT NULL AUTO_INCREMENT,
  `voucher_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `order_id` INT DEFAULT NULL,
  `used_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usage_id`),
  KEY `voucher_id` (`voucher_id`),
  KEY `customer_id` (`customer_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `voucher_usage_ibfk_1` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`voucher_id`),
  CONSTRAINT `voucher_usage_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `voucher_usage_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `menu_item` (
  `menu_item_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `icon` VARCHAR(255),
  `url` VARCHAR(255),
  `parent_id` INT,
  `status` ENUM('Activate', 'Deactivate') NOT NULL DEFAULT 'Activate',
  FOREIGN KEY (`parent_id`) REFERENCES `menu_item` (`menu_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `menu_attribute` (
  `attribute_id` INT PRIMARY KEY AUTO_INCREMENT,
  `menu_item_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `url` VARCHAR(255),
  `status` ENUM('Activate', 'Deactivate') NOT NULL DEFAULT 'Activate',
  FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`menu_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `menu_attribute_value` (
  `value_id` INT PRIMARY KEY AUTO_INCREMENT,
  `attribute_id` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  `url` VARCHAR(255),
  `status` ENUM('Activate', 'Deactivate') NOT NULL DEFAULT 'Activate',
  FOREIGN KEY (`attribute_id`) REFERENCES `menu_attribute` (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
