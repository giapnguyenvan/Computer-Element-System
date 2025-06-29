-- Drop database nếu tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'project_g2')
    DROP DATABASE project_g2;
GO
CREATE DATABASE project_g2;
GO
USE project_g2;
GO

-- Bảng brand
CREATE TABLE brand (
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);

-- Bảng componenttype
CREATE TABLE componenttype (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255)
);

-- Bảng paymentmethod
CREATE TABLE paymentmethod (
    payment_method_id INT IDENTITY(1,1) PRIMARY KEY,
    method_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    status NVARCHAR(20) NOT NULL DEFAULT 'Active'
);

-- Bảng user
CREATE TABLE [user] (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100),
    role NVARCHAR(20) NOT NULL,
    status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    is_verified BIT NOT NULL DEFAULT 0,
    verification_token NVARCHAR(MAX)
);

-- Bảng series
CREATE TABLE series (
    series_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_id INT NOT NULL,
    name NVARCHAR(100),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- Bảng model
CREATE TABLE model (
    model_id INT IDENTITY(1,1) PRIMARY KEY,
    series_id INT NOT NULL,
    name NVARCHAR(100),
    FOREIGN KEY (series_id) REFERENCES series(series_id)
);

-- Bảng customer
CREATE TABLE customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    email NVARCHAR(100) UNIQUE,
    password NVARCHAR(255),
    phone NVARCHAR(20),
    shipping_address NVARCHAR(255),
    is_verified BIT DEFAULT 0,
    verification_token NVARCHAR(255)
);

-- Bảng staff
CREATE TABLE staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name NVARCHAR(100),
    phone NVARCHAR(20),
    enter_date DATE,
    leave_date DATE,
    FOREIGN KEY (user_id) REFERENCES [user](user_id)
);

-- Bảng shipper
CREATE TABLE shipper (
    shipper_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    email NVARCHAR(100),
    status NVARCHAR(20) NOT NULL DEFAULT 'Active'
);

-- Bảng admin
CREATE TABLE admin (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name NVARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES [user](user_id)
);

-- Bảng product
CREATE TABLE product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255),
    component_type_id INT NOT NULL,
    brand_id INT NOT NULL,
    model_id INT,
    price DECIMAL(18,2),
    import_price DECIMAL(18,2),
    stock INT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX),
    status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (component_type_id) REFERENCES componenttype(type_id),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id)
);

-- Bảng cartitem
CREATE TABLE cartitem (
    cart_item_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(18,2),
    shipping_address NVARCHAR(255),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    status NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    payment_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (payment_method_id) REFERENCES paymentmethod(payment_method_id)
);

-- Bảng orderdetail
CREATE TABLE orderdetail (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng productimage
CREATE TABLE productimage (
    image_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng productspecification
CREATE TABLE productspecification (
    spec_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    spec_key NVARCHAR(100),
    spec_value NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng feedback
CREATE TABLE feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    content NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng inventorylog
CREATE TABLE inventorylog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    action NVARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    note NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Bảng blog
CREATE TABLE blog (
    blog_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    customer_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Bảng transactions
CREATE TABLE transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    transaction_code NVARCHAR(50),
    order_id INT NOT NULL,
    payment_method_id INT,
    total_amount DECIMAL(18,2),
    created_at DATETIME DEFAULT GETDATE(),
    paid BIT DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (payment_method_id) REFERENCES paymentmethod(payment_method_id)
);

-- Bảng voucher
CREATE TABLE voucher (
    voucher_id INT IDENTITY(1,1) PRIMARY KEY,
    code NVARCHAR(50) NOT NULL UNIQUE,
    description NVARCHAR(255),
    discount_type NVARCHAR(20) NOT NULL DEFAULT 'percent',
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(18,2) DEFAULT 0.00,
    max_uses INT,
    max_uses_per_user INT,
    start_date DATETIME,
    end_date DATETIME,
    status NVARCHAR(20) NOT NULL DEFAULT 'Active'
);

-- Bảng voucher_usage
CREATE TABLE voucher_usage (
    usage_id INT IDENTITY(1,1) PRIMARY KEY,
    voucher_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_id INT,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (voucher_id) REFERENCES voucher(voucher_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Bảng menu động
CREATE TABLE menu_item (
    menu_item_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    icon NVARCHAR(255),
    url NVARCHAR(255),
    parent_id INT,
    status NVARCHAR(20) NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (parent_id) REFERENCES menu_item(menu_item_id)
);

CREATE TABLE menu_attribute (
    attribute_id INT IDENTITY(1,1) PRIMARY KEY,
    menu_item_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    url NVARCHAR(255),
    status NVARCHAR(20) NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id)
);

CREATE TABLE menu_attribute_value (
    value_id INT IDENTITY(1,1) PRIMARY KEY,
    attribute_id INT NOT NULL,
    value NVARCHAR(100) NOT NULL,
    url NVARCHAR(255),
    status NVARCHAR(20) NOT NULL DEFAULT 'Activate',
    FOREIGN KEY (attribute_id) REFERENCES menu_attribute(attribute_id)
); 