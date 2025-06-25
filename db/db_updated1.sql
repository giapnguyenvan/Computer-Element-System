Use Project_G2;
-- ================================
-- PRODUCT RELATED TABLES
-- ================================

CREATE TABLE ComponentType (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Series (
    series_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    name VARCHAR(100),
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
);

CREATE TABLE Model (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    series_id INT NOT NULL,
    name VARCHAR(100),
    FOREIGN KEY (series_id) REFERENCES Series(series_id)
);

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    component_type_id INT NOT NULL,
    brand_id INT NOT NULL,
    series_id INT,
    model_id INT,
    price DECIMAL(18,2),
    import_price DECIMAL(18,2),
    stock INT,
    description TEXT,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (component_type_id) REFERENCES ComponentType(type_id),
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id),
    FOREIGN KEY (series_id) REFERENCES Series(series_id),
    FOREIGN KEY (model_id) REFERENCES Model(model_id)
);

CREATE TABLE ProductSpecification (
    spec_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    spec_key VARCHAR(100),
    spec_value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE ProductImage (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- ================================
-- USER AND ROLES
-- ================================

CREATE TABLE `User` (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
	is_verified BOOLEAN NOT NULL DEFAULT FALSE,
	verification_token TEXT
);

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100),
    phone VARCHAR(20),
    shipping_address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES `User`(user_id)
);

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100),
    phone VARCHAR(20),
    enter_date DATE,
    leave_date DATE,
    FOREIGN KEY (user_id) REFERENCES `User`(user_id)
);

CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES `User`(user_id)
);

-- ================================
-- CART SYSTEM
-- ================================

CREATE TABLE CartItem (
    cart_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- ================================
-- FEEDBACK AND PAYMENT
-- ================================

CREATE TABLE Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE PaymentMethod (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active'
);

-- ================================
-- ORDER AND INVENTORY
-- ================================

CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(18,2),
    shipping_address VARCHAR(255),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
    payment_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(payment_method_id)
);

CREATE TABLE OrderDetail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE InventoryLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    action ENUM('Add', 'Remove', 'Adjust') NOT NULL,
    quantity INT NOT NULL,
    note VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


USE Project_G2;

-- Drop Order-related tables
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS `Order`;

-- Drop Inventory and Feedback
DROP TABLE IF EXISTS InventoryLog;
DROP TABLE IF EXISTS Feedback;

-- Drop Cart if you have it (placeholder)
DROP TABLE IF EXISTS CartItem;
DROP TABLE IF EXISTS Cart;

-- Drop Payment
DROP TABLE IF EXISTS PaymentMethod;

-- Drop User roles
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Customer;

-- Drop User
DROP TABLE IF EXISTS `User`;

-- Drop Product-related detail tables
DROP TABLE IF EXISTS ProductImage;
DROP TABLE IF EXISTS ProductSpecification;

-- Drop main Product table
DROP TABLE IF EXISTS Product;

-- Drop model hierarchy
DROP TABLE IF EXISTS Model;
DROP TABLE IF EXISTS Series;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS ComponentType;
