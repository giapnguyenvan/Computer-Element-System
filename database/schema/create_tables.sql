DROP DATABASE IF EXISTS project_g2;
CREATE DATABASE IF NOT EXISTS project_g2;
USE project_g2;

-- Xóa bảng theo thứ tự phụ thuộc (bảng con trước, bảng cha sau)
DROP TABLE IF EXISTS `cartitem`;
DROP TABLE IF EXISTS `orderdetail`;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS `productimage`;
DROP TABLE IF EXISTS `productspecification`;
DROP TABLE IF EXISTS `feedback`;
DROP TABLE IF EXISTS `inventorylog`;
DROP TABLE IF EXISTS `blog`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `admin`;
DROP TABLE IF EXISTS `staff`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `model`;
DROP TABLE IF EXISTS `series`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `brand`;
DROP TABLE IF EXISTS `componenttype`;
DROP TABLE IF EXISTS `paymentmethod`;

-- Tạo bảng cha trước
CREATE TABLE `brand` (
  `brand_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `componenttype` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paymentmethod` (
  `payment_method_id` int NOT NULL AUTO_INCREMENT,
  `method_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('Staff','Admin') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `verification_token` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Bảng phụ thuộc nhiều bảng cha
CREATE TABLE `series` (
  `series_id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`series_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `model` (
  `model_id` int NOT NULL AUTO_INCREMENT,
  `series_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  KEY `series_id` (`series_id`),
  CONSTRAINT `model_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `enter_date` date DEFAULT NULL,
  `leave_date` date DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Bảng phụ thuộc nhiều bảng cha
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `component_type_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `price` decimal(18,2) DEFAULT NULL,
  `import_price` decimal(18,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `description` text,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `component_type_id` (`component_type_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`component_type_id`) REFERENCES `componenttype` (`type_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cartitem` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `cartitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(18,2) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `shipping_fee` decimal(10,2) DEFAULT '0.00',
  `status` enum('Pending','Shipping','Completed','Cancel') NOT NULL DEFAULT 'Pending',
  `payment_method_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `paymentmethod` (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orderdetail` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(18,2) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productimage` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `productimage_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productspecification` (
  `spec_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `spec_key` varchar(100) DEFAULT NULL,
  `spec_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`spec_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `productspecification_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `feedback_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventorylog` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `action` enum('Add','Remove','Adjust') NOT NULL,
  `quantity` int NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventorylog_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `blog` (
  `blog_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `customer_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`blog_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transactions` (
  `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
  `transaction_code` varchar(50),
  `order_id` INT NOT NULL,
  `payment_method_id` INT,
  `total_amount` DECIMAL(18,2),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `paid` BOOL DEFAULT FALSE,
  FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`),
  FOREIGN KEY (`payment_method_id`) REFERENCES `paymentmethod`(`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ================================
-- MENU DYNAMIC TABLES
-- ================================
CREATE TABLE menu_item (
    menu_item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    icon VARCHAR(255),
    url VARCHAR(255),
    parent_id INT,
    description TEXT,
    status ENUM('Activate','Deactivate') NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (parent_id) REFERENCES menu_item(menu_item_id)
);

CREATE TABLE menu_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    menu_item_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    url VARCHAR(255),
    description TEXT,
    status ENUM('Activate','Deactivate') NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id)
);

CREATE TABLE menu_attribute_value (
    value_id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_id INT NOT NULL,
    value VARCHAR(100) NOT NULL,
    url VARCHAR(255),
    description TEXT,
    status ENUM('Activate','Deactivate') NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (attribute_id) REFERENCES menu_attribute(attribute_id)
);

CREATE TABLE product_menu_attribute_value (
    product_id INT NOT NULL,
    value_id INT NOT NULL,
    PRIMARY KEY (product_id, value_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (value_id) REFERENCES menu_attribute_value(value_id)
);

-- ================================
-- SELECT ALL DATA FROM TABLES
-- ================================
SELECT * FROM `admin`;
SELECT * FROM `blog`;
SELECT * FROM `brand`;
SELECT * FROM `cartitem`;
SELECT * FROM `componenttype`;
SELECT * FROM `customer`;
SELECT * FROM `feedback`;
SELECT * FROM `inventorylog`;
SELECT * FROM `model`;
SELECT * FROM `order`;
SELECT * FROM `orderdetail`;
SELECT * FROM `paymentmethod`;
SELECT * FROM `product`;
SELECT * FROM `productimage`;
SELECT * FROM `productspecification`;
SELECT * FROM `series`;
SELECT * FROM `staff`;
SELECT * FROM `transactions`;
SELECT * FROM `user`; 