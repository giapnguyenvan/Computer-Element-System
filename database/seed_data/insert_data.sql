-- COMPONENTTYPE
INSERT INTO componenttype (type_id, name, description) VALUES
(1, 'CPU', 'Bộ vi xử lý'),
(2, 'GPU', 'Card đồ họa'),
(3, 'RAM', 'Bộ nhớ trong');

-- BRAND
INSERT INTO brand (brand_id, name) VALUES
(1, 'Intel'),
(2, 'AMD'),
(3, 'NVIDIA'),
(4, 'Corsair');

-- SERIES
INSERT INTO series (series_id, brand_id, name) VALUES
(1, 1, 'Core i5'),
(2, 2, 'Ryzen 5'),
(3, 3, 'RTX 30'),
(4, 4, 'Vengeance');

-- MODEL
INSERT INTO model (model_id, series_id, name) VALUES
(1, 1, '10400F'),
(2, 2, '5600X'),
(3, 3, '3060'),
(4, 4, 'LPX 16GB');

-- PRODUCT
INSERT INTO product (product_id, name, component_type_id, brand_id, model_id, price, import_price, stock, description, status, created_at) VALUES
(1, 'Intel Core i5-10400F', 1, 1, 1, 4000000, 3500000, 10, 'CPU Intel 6 nhân 12 luồng', 'Active', NOW()),
(2, 'AMD Ryzen 5 5600X', 1, 2, 2, 5000000, 4500000, 8, 'CPU AMD 6 nhân 12 luồng', 'Active', NOW()),
(3, 'NVIDIA RTX 3060', 2, 3, 3, 9000000, 8500000, 7, 'Card đồ họa NVIDIA RTX 3060 12GB', 'Active', NOW()),
(4, 'Corsair Vengeance LPX 16GB', 3, 4, 4, 1500000, 1300000, 20, 'RAM Corsair 16GB DDR4', 'Active', NOW());

-- USER
INSERT INTO user (user_id, username, password, email, role, status, is_verified, verification_token) VALUES 
(1, 'staff01', 'hashedpassword1', 'staff01@example.com', 'Staff', 'Active', 1, NULL),
(2, 'admin01', 'hashedpassword2', 'admin01@example.com', 'Admin', 'Active', 1, NULL);

-- CUSTOMER
INSERT INTO customer (customer_id, name, email, password, phone, shipping_address, is_verified, verification_token) VALUES 
(1, 'Lê Thị Khách Hàng', 'customer01@example.com', 'hashedpassword3', '0909988776', '123 Đường ABC, Quận 1, TP.HCM', 0, NULL),
(2, 'NguyenVanGiap', 'giapThieuNang@gmail.com', 'cesvg2810A!', '0994885738', 'KhongBietHoiLamVL', 0, NULL),
(3, 'Phạm Đức Trọng', 'trongpdhe181640@fpt.edu.vn', '$2a$10$iC2jTTQm8GSE5ni9iURIouVE.c/qVXK8PKSshKj7HjAb/Ie5r5Tea', '0559868660', 'ChauPhong-LienHa-DongAnh-HaNoi', 1, NULL);

-- STAFF
INSERT INTO staff (staff_id, user_id, name, phone, enter_date, leave_date) VALUES 
(1, 1, 'Nguyễn Văn Nhân viên', '0901123456', '2024-01-01', NULL);

-- ADMIN
INSERT INTO admin (admin_id, user_id, name) VALUES 
(1, 2, 'Trần Thị Quản Trị');

-- PAYMENTMETHOD
INSERT INTO paymentmethod (payment_method_id, method_name, description, status) VALUES
(1, 'Cash', 'Tiền mặt', 'Active'),
(2, 'Transfer', 'Chuyển khoản', 'Active');

-- ORDERS
INSERT INTO orders (order_id, customer_id, order_date, total_amount, shipping_address, shipping_fee, status, payment_method_id) VALUES
(1, 1, NOW(), 10000000, 'Hanoi', 20000, 'Pending', 1);

-- ORDERDETAIL
INSERT INTO orderdetail (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 4000000),
(2, 1, 3, 1, 9000000);

-- VOUCHER
INSERT INTO voucher (voucher_id, code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES
(1, 'WELCOME10', '10% off', 'percent', 10.00, 100000, 100, 1, NOW(), NOW(), 'Active');

-- VOUCHER_USAGE
INSERT INTO voucher_usage (usage_id, voucher_id, customer_id, order_id, used_at) VALUES
(1, 1, 1, 1, NOW());

-- CARTITEM
INSERT INTO cartitem (cart_item_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 3, 1);

-- TRANSACTIONS
INSERT INTO transactions (transaction_id, transaction_code, order_id, payment_method_id, total_amount, created_at, paid) VALUES
(1, 'TXN001', 1, 1, 10000000, NOW(), FALSE);

-- MENU_ITEM
INSERT INTO menu_item (menu_item_id, name, icon, url, parent_id, status) VALUES
(1, 'Sản phẩm', 'fas fa-laptop', '/products', NULL, 'Activate'),
(2, 'CPU', 'fas fa-microchip', '/products/cpu', 1, 'Activate'),
(3, 'GPU', 'fas fa-tv', '/products/gpu', 1, 'Activate');

-- MENU_ATTRIBUTE
INSERT INTO menu_attribute (attribute_id, menu_item_id, name, url, status) VALUES
(1, 1, 'Tất cả sản phẩm', '/products/all', 'Activate'),
(2, 1, 'Khuyến mãi', '/products/sale', 'Activate');

-- MENU_ATTRIBUTE_VALUE
INSERT INTO menu_attribute_value (value_id, attribute_id, value, url, status) VALUES
(1, 1, 'Xem tất cả', '/products/list', 'Activate'),
(2, 2, 'Giảm giá 50%', '/products/discount-50', 'Activate');

-- Insert data into series
INSERT INTO series (brand_id, name) VALUES
(1, 'Core i5'), (2, 'Ryzen 5'), (3, 'RTX 30'), (4, 'Vengeance'), (5, 'Ripjaws'),
(6, 'ROG Strix'), (7, 'Aorus Elite'), (8, 'Black SN850X'), (9, '970 EVO Plus'), (10, 'RMx'),
(11, 'Lancool'), (12, 'Liquid Freezer III'), (13, 'G Pro'), (14, 'Ornata'), (15, 'DT 990'),
(16, 'Odyssey'), (17, 'Titan Evo'), (18, 'UPPSTÅ');

-- Insert data into model
INSERT INTO model (series_id, name) VALUES
(1, '10400F'), (1, '10600K'), (2, '5600X'),
(3, '3060'), (3, '3070'), (3, '3080'),
(4, 'LPX 16GB'), (4, 'LPX 32GB'), (5, 'Z 16GB'),
(6, 'X870-F'), (6, 'B650-E'), (7, 'B650 AX'),
(8, '2TB'), (8, '1TB'), (9, '2TB NVMe'),
(10, '850e'), (10, '1000e'), (11, '216'),
(12, '360mm AIO'), (12, '280mm AIO'), (13, 'X Superlight 2'),
(14, 'V4 Pro'), (15, 'Pro 250ohm'), (16, '27in QHD 240Hz'),
(17, '2022'), (18, 'Standard');

-- Insert data into product
INSERT INTO product (name, component_type_id, brand_id, model_id, price, import_price, stock, description, status) VALUES
('Intel Core i5-10400F', 1, 1, 1, 4000000, 3500000, 10, 'CPU Intel 6 nhân 12 luồng', 'Active'),
('Intel Core i5-10600K', 1, 1, 2, 4500000, 4000000, 5, 'CPU Intel 6 nhân 12 luồng ép xung', 'Active'),
('AMD Ryzen 5 5600X', 1, 2, 3, 5000000, 4500000, 8, 'CPU AMD 6 nhân 12 luồng', 'Active'),
('NVIDIA RTX 3060', 2, 3, 4, 9000000, 8500000, 7, 'Card đồ họa NVIDIA RTX 3060 12GB', 'Active'),
('NVIDIA RTX 3070', 2, 3, 5, 15000000, 14000000, 4, 'Card đồ họa NVIDIA RTX 3070 8GB', 'Active'),
('NVIDIA RTX 3080', 2, 3, 6, 20000000, 19000000, 2, 'Card đồ họa NVIDIA RTX 3080 10GB', 'Active'),
('Corsair Vengeance LPX 16GB', 3, 4, 7, 1500000, 1300000, 20, 'RAM Corsair 16GB DDR4', 'Active'),
('Corsair Vengeance LPX 32GB', 3, 4, 8, 2800000, 2500000, 10, 'RAM Corsair 32GB DDR4', 'Active'),
('G.Skill Ripjaws Z 16GB', 3, 5, 9, 1600000, 1400000, 15, 'RAM G.Skill 16GB DDR4', 'Active');

-- Insert data into paymentmethod
INSERT INTO paymentmethod (method_name, description) VALUES
('Cash', 'Tiền mặt'),
('Transfer', 'Chuyển khoản');

-- Insert data into orders
INSERT INTO orders (customer_id, order_date, total_amount, shipping_address, shipping_fee, status, payment_method_id) VALUES
(2, '2024-06-21 09:00:00', 32100000, 'KhongBietHoiLamVL', 10000, 'Pending', 1);

-- Insert data into orderdetail
INSERT INTO orderdetail (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 4000000),
(1, 4, 1, 9000000),
(1, 7, 2, 1500000);

-- Insert data into voucher
INSERT INTO voucher (code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES
('WELCOME10', '10% off for new users', 'percent', 10.00, 100000, 100, 1, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 'Active'),
('SUMMER50', '50,000 VND off orders over 500,000 VND', 'fixed', 50000.00, 500000, 50, 2, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Active');

-- Insert data into voucher_usage
INSERT INTO voucher_usage (voucher_id, customer_id, order_id, used_at) VALUES
(1, 3, 1, '2024-06-21 10:00:00'),
(2, 2, 1, '2024-06-22 11:00:00');

-- Insert data into cartitem
INSERT INTO cartitem (customer_id, product_id, quantity) VALUES
(2, 1, 1),
(2, 4, 1),
(2, 7, 2);

-- Insert data into transactions
INSERT INTO transactions (transaction_code, order_id, payment_method_id, total_amount, paid) VALUES
('TXN001', 1, 1, 32100000, FALSE);

-- Insert data into menu_item
INSERT INTO menu_item (name, icon, url, parent_id, status) VALUES
('Sản phẩm', 'fas fa-laptop', '/products', NULL, 'Activate'),
('Danh mục', 'fas fa-th-large', '/categories', NULL, 'Activate'),
('Quản lý', 'fas fa-cogs', '/admin', NULL, 'Activate'),
('CPU', 'fas fa-microchip', '/products/cpu', 1, 'Activate'),
('GPU', 'fas fa-tv', '/products/gpu', 1, 'Activate'),
('RAM', 'fas fa-memory', '/products/ram', 1, 'Activate');

-- Insert data into menu_attribute
INSERT INTO menu_attribute (menu_item_id, name, url, status) VALUES
(1, 'Tất cả sản phẩm', '/products/all', 'Activate'),
(1, 'Sản phẩm mới', '/products/new', 'Activate'),
(1, 'Khuyến mãi', '/products/sale', 'Activate'),
(2, 'Theo thương hiệu', '/categories/brand', 'Activate'),
(2, 'Theo giá', '/categories/price', 'Activate'),
(3, 'Dashboard', '/admin/dashboard', 'Activate'),
(3, 'Cài đặt', '/admin/settings', 'Activate');

-- Insert data into menu_attribute_value
INSERT INTO menu_attribute_value (attribute_id, value, url, status) VALUES
(1, 'Xem tất cả', '/products/list', 'Activate'),
(1, 'Tìm kiếm', '/products/search', 'Activate'),
(2, 'Sản phẩm mới nhất', '/products/latest', 'Activate'),
(2, 'Sắp xếp theo ngày', '/products/sort-by-date', 'Activate'),
(3, 'Giảm giá 50%', '/products/discount-50', 'Activate'),
(3, 'Flash sale', '/products/flash-sale', 'Activate'),
(4, 'AMD', '/categories/brand/amd', 'Activate'),
(4, 'Intel', '/categories/brand/intel', 'Activate'),
(4, 'NVIDIA', '/categories/brand/nvidia', 'Activate'),
(5, 'Dưới 1 triệu', '/categories/price/under-1m', 'Activate'),
(5, '1-5 triệu', '/categories/price/1m-5m', 'Activate'),
(5, 'Trên 5 triệu', '/categories/price/over-5m', 'Activate'),
(6, 'Tổng quan', '/admin/dashboard/overview', 'Activate'),
(6, 'Thống kê', '/admin/dashboard/stats', 'Activate'),
(7, 'Cấu hình hệ thống', '/admin/settings/system', 'Activate'),
(7, 'Cấu hình email', '/admin/settings/email', 'Activate');

-- Select all data from tables
SELECT * FROM `admin`;
SELECT * FROM `blog`;
SELECT * FROM `brand`;
SELECT * FROM `cartitem`;
SELECT * FROM `componenttype`;
SELECT * FROM `customer`;
SELECT * FROM `feedback`;
SELECT * FROM `inventorylog`;
SELECT * FROM `model`;
SELECT * FROM `orders`;
SELECT * FROM `orderdetail`;
SELECT * FROM `paymentmethod`;
SELECT * FROM `product`;
SELECT * FROM `productimage`;
SELECT * FROM `productspecification`;
SELECT * FROM `series`;
SELECT * FROM `staff`;
SELECT * FROM `user`;
SELECT * FROM `voucher`;
SELECT * FROM `voucher_usage`;
SELECT * FROM `transactions`;
SELECT * FROM `menu_item`;
SELECT * FROM `menu_attribute`;
SELECT * FROM `menu_attribute_value`;