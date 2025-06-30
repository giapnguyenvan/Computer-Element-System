-- COMPONENTTYPE
INSERT INTO componenttype (type_id, name, description) VALUES
(1, 'CPU', 'Bộ vi xử lý'),
(2, 'GPU', 'Card đồ họa'),
(3, 'RAM', 'Bộ nhớ trong'),
(4, 'Motherboard', 'Bo mạch chủ'),
(5, 'Storage', 'Ổ cứng'),
(6, 'PSU', 'Nguồn máy tính'),
(7, 'Case', 'Vỏ máy tính'),
(8, 'Cooling', 'Tản nhiệt'),
(9, 'Peripherals', 'Thiết bị ngoại vi'),
(10, 'Monitor', 'Màn hình');

-- BRAND
INSERT INTO brand (brand_id, name) VALUES
(1, 'Intel'),
(2, 'AMD'),
(3, 'NVIDIA'),
(4, 'Corsair'),
(5, 'G.Skill'),
(6, 'ASUS'),
(7, 'Gigabyte'),
(8, 'MSI'),
(9, 'Samsung'),
(10, 'Western Digital'),
(11, 'Seagate'),
(12, 'EVGA'),
(13, 'Thermaltake'),
(14, 'Lian Li'),
(15, 'Arctic'),
(16, 'Logitech'),
(17, 'Razer'),
(18, 'Samsung'),
(19, 'LG'),
(20, 'AOC');

-- SERIES
INSERT INTO series (series_id, brand_id, name) VALUES
(1, 1, 'Core i5'),
(2, 2, 'Ryzen 5'),
(3, 3, 'RTX 30'),
(4, 4, 'Vengeance'),
(5, 5, 'Ripjaws'),
(6, 6, 'ROG Strix'),
(7, 7, 'Aorus Elite'),
(8, 9, 'Black SN850X'),
(9, 9, '970 EVO Plus'),
(10, 4, 'RMx'),
(11, 14, 'Lancool'),
(12, 15, 'Liquid Freezer III'),
(13, 16, 'G Pro'),
(14, 17, 'Ornata'),
(15, 17, 'DT 990'),
(16, 18, 'Odyssey'),
(17, 16, 'Titan Evo'),
(18, 16, 'UPPSTÅ');

-- MODEL
INSERT INTO model (model_id, series_id, name) VALUES
(1, 1, '10400F'),
(2, 1, '10600K'),
(3, 1, '12400F'),
(4, 1, '13700K'),
(5, 1, '13900K'),
(6, 2, '5600X'),
(7, 2, '5800X'),
(8, 3, '3060'),
(9, 3, '3070'),
(10, 3, '3080'),
(11, 3, '4070'),
(12, 4, 'LPX 8GB'),
(13, 4, 'LPX 16GB'),
(14, 4, 'LPX 32GB'),
(15, 5, 'Z 16GB'),
(16, 6, 'Z790-A'),
(17, 6, 'B550-Plus'),
(18, 8, 'B660M Mortar'),
(19, 7, 'B660 DS3H'),
(20, 6, 'A320M-K'),
(21, 4, 'Dominator Platinum 32GB'),
(22, 5, 'Trident Z RGB 16GB'),
(23, 5, 'Fury Beast 8GB');

-- PRODUCT
INSERT INTO product (product_id, name, component_type_id, brand_id, model_id, price, import_price, stock, description, status, created_at) VALUES
(1, 'Intel Core i5-10400F', 1, 1, 1, 4000000, 3500000, 10, 'CPU Intel 6 nhân 12 luồng', 'Active', NOW()),
(2, 'Intel Core i5-10600K', 1, 1, 2, 4500000, 4000000, 5, 'CPU Intel 6 nhân 12 luồng ép xung', 'Active', NOW()),
(3, 'Intel Core i5-12400F', 1, 1, 3, 4500000, 4000000, 50, '6-core, 12-thread, LGA1700', 'Active', NOW()),
(4, 'Intel Core i7-13700K', 1, 1, 4, 10500000, 9250000, 30, '16-core, 24-thread, LGA1700', 'Active', NOW()),
(5, 'Intel Core i9-13900K', 1, 1, 5, 15000000, 13000000, 10, '24-core, 32-thread, LGA1700', 'Active', NOW()),
(6, 'AMD Ryzen 5 5600X', 1, 2, 6, 5000000, 4250000, 40, '6-core, 12-thread, AM4', 'Active', NOW()),
(7, 'AMD Ryzen 7 5800X', 1, 2, 7, 7750000, 6750000, 25, '8-core, 16-thread, AM4', 'Active', NOW()),
(8, 'NVIDIA RTX 3060 12GB', 2, 3, 8, 8750000, 7500000, 20, '12GB GDDR6, Ray Tracing', 'Active', NOW()),
(9, 'NVIDIA RTX 4070 12GB', 2, 3, 11, 15500000, 13750000, 15, '12GB GDDR6X, DLSS 3', 'Active', NOW()),
(10, 'ASUS RTX 4060 Ti Dual', 2, 6, 8, 12000000, 10500000, 18, '8GB GDDR6, Dual Fan', 'Active', NOW()),
(11, 'AMD Radeon RX 6700 XT', 2, 2, 8, 10000000, 8750000, 12, '12GB GDDR6', 'Active', NOW()),
(12, 'NVIDIA RTX 3080 10GB', 2, 3, 10, 21250000, 19500000, 8, '10GB GDDR6X, High-end gaming', 'Active', NOW()),
(13, 'ASUS ROG Strix Z790-A', 4, 6, 16, 7500000, 6500000, 12, 'LGA1700, DDR5, ATX', 'Active', NOW()),
(14, 'ASUS TUF B550-Plus', 4, 6, 17, 4000000, 3250000, 20, 'AM4, DDR4, ATX', 'Active', NOW()),
(15, 'MSI MAG B660M Mortar', 4, 8, 18, 4500000, 3750000, 25, 'LGA1700, DDR4, mATX', 'Active', NOW()),
(16, 'Gigabyte B660 DS3H', 4, 7, 19, 3500000, 2750000, 18, 'LGA1700, DDR4, ATX', 'Active', NOW()),
(17, 'ASUS PRIME A320M-K', 4, 6, 20, 2000000, 1500000, 30, 'AM4, DDR4, mATX', 'Active', NOW()),
(18, 'Corsair Vengeance LPX 8GB DDR4', 3, 4, 12, 1125000, 875000, 100, '8GB DDR4 3200MHz', 'Active', NOW()),
(19, 'Corsair Vengeance LPX 16GB DDR4', 3, 4, 13, 2000000, 1625000, 80, '16GB DDR4 3200MHz', 'Active', NOW()),
(20, 'G.Skill Trident Z RGB 16GB', 3, 5, 22, 2375000, 2000000, 60, '16GB DDR4 3600MHz', 'Active', NOW()),
(21, 'Kingston Fury Beast 8GB DDR4', 3, 5, 23, 1050000, 800000, 90, '8GB DDR4 3200MHz', 'Active', NOW()),
(22, 'Corsair Dominator Platinum 32GB', 3, 4, 21, 4500000, 3750000, 40, '32GB DDR5 5200MHz', 'Active', NOW());

-- USER
INSERT INTO user (user_id, username, password, email, role, status, is_verified, verification_token) VALUES 
(1, 'staff01', 'hashedpassword1', 'staff01@example.com', 'Staff', 'Active', 1, NULL),
(2, 'admin01', 'hashedpassword2', 'admin01@example.com', 'Admin', 'Active', 1, NULL);

-- CUSTOMER
INSERT INTO customer (customer_id, name, email, password, phone, shipping_address, is_verified, verification_token) VALUES 
(1, 'Lê Thị Khách Hàng', 'customer01@example.com', 'hashedpassword3', '0909988776', '123 Đường ABC, Quận 1, TP.HCM', 1, NULL),
(2, 'NguyenVanGiap', 'giapThieuNang@gmail.com', 'cesvg2810A!', '0994885738', 'KhongBietHoiLamVL', 0, NULL),
(3, 'Phạm Đức Trọng', 'trongpdhe181640@fpt.edu.vn', '$2a$10$iC2jTTQm8GSE5ni9iURIouVE.c/qVXK8PKSshKj7HjAb/Ie5r5Tea', '0559868660', 'ChauPhong-LienHa-DongAnh-HaNoi', 1, NULL),
(4, 'huy', 'huy69332@gmail.com', '$2a$10$cVf/WsqcXPyEOtyJo/fnAeCLD4079ARM8qRdzv3OIrPWohIA9ELF.', '0987565443', NULL, 1, NULL);

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
(1, 1, NOW(), 10000000, 'Hanoi', 20000, 'Pending', 1),
(2, 2, '2024-06-21 09:00:00', 32100000, 'KhongBietHoiLamVL', 10000, 'Pending', 1);

-- ORDERDETAIL
INSERT INTO orderdetail (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 4000000),
(2, 1, 8, 1, 9000000),
(3, 2, 1, 1, 4000000),
(4, 2, 8, 1, 9000000),
(5, 2, 19, 2, 1500000);

-- VOUCHER
INSERT INTO voucher (voucher_id, code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES
(1, 'WELCOME10', '10% off for new users', 'percent', 10.00, 100000, 100, 1, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 'Active'),
(2, 'SUMMER50', '50,000 VND off orders over 500,000 VND', 'fixed', 50000.00, 500000, 50, 2, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Active'),
(3, 'FREEMOUSE', 'Mua bất kỳ bộ PC nào trong tháng này, nhận ngay chuột gaming trị giá 500.000đ. Số lượng có hạn!', 'fixed', 500000, 0, 50, 1, '2024-06-01 00:00:00', '2024-06-30 23:59:59', 'Active');

-- VOUCHER_USAGE
INSERT INTO voucher_usage (usage_id, voucher_id, customer_id, order_id, used_at) VALUES
(1, 1, 1, 1, NOW()),
(2, 1, 3, NULL, '2024-06-21 10:00:00'),
(3, 2, 2, NULL, '2024-06-22 11:00:00');

-- CARTITEM
INSERT INTO cartitem (cart_item_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 8, 1),
(3, 2, 2, 1),
(4, 2, 5, 1),
(5, 2, 3, 1),
(6, 2, 22, 1),
(7, 2, 21, 1),
(8, 2, 20, 1),
(9, 2, 19, 1),
(10, 2, 10, 1),
(11, 2, 11, 1);

-- TRANSACTIONS
INSERT INTO transactions (transaction_id, transaction_code, order_id, payment_method_id, total_amount, created_at, paid) VALUES
(1, 'TXN001', 1, 1, 10000000, NOW(), FALSE),
(2, 'TXN002', 2, 1, 32100000, NOW(), FALSE);

-- MENU_ITEM
INSERT INTO menu_item (menu_item_id, name, icon, url, parent_id, status) VALUES
(1, 'Sản phẩm', 'fas fa-laptop', '/products', NULL, 'Activate'),
(2, 'Danh mục', 'fas fa-th-large', '/categories', NULL, 'Activate'),
(3, 'Quản lý', 'fas fa-cogs', '/admin', NULL, 'Activate'),
(4, 'CPU', 'fas fa-microchip', '/products/cpu', 1, 'Activate'),
(5, 'GPU', 'fas fa-tv', '/products/gpu', 1, 'Activate'),
(6, 'RAM', 'fas fa-memory', '/products/ram', 1, 'Activate'),
(7, 'Build PC', 'fas fa-desktop', '/PCBuilderServlet', NULL, 'Activate');

-- MENU_ATTRIBUTE
INSERT INTO menu_attribute (attribute_id, menu_item_id, name, url, status) VALUES
(1, 1, 'Tất cả sản phẩm', '/products/all', 'Activate'),
(2, 1, 'Sản phẩm mới', '/products/new', 'Activate'),
(3, 1, 'Khuyến mãi', '/products/sale', 'Activate'),
(4, 2, 'Theo thương hiệu', '/categories/brand', 'Activate'),
(5, 2, 'Theo giá', '/categories/price', 'Activate'),
(6, 3, 'Dashboard', '/admin/dashboard', 'Activate'),
(7, 3, 'Cài đặt', '/admin/settings', 'Activate');

-- MENU_ATTRIBUTE_VALUE
INSERT INTO menu_attribute_value (value_id, attribute_id, value, url, status) VALUES
(1, 1, 'Xem tất cả', '/products/list', 'Activate'),
(2, 1, 'Tìm kiếm', '/products/search', 'Activate'),
(3, 2, 'Sản phẩm mới nhất', '/products/latest', 'Activate'),
(4, 2, 'Sắp xếp theo ngày', '/products/sort-by-date', 'Activate'),
(5, 3, 'Giảm giá 50%', '/products/discount-50', 'Activate'),
(6, 3, 'Flash sale', '/products/flash-sale', 'Activate'),
(7, 4, 'AMD', '/categories/brand/amd', 'Activate'),
(8, 4, 'Intel', '/categories/brand/intel', 'Activate'),
(9, 4, 'NVIDIA', '/categories/brand/nvidia', 'Activate'),
(10, 5, 'Dưới 1 triệu', '/categories/price/under-1m', 'Activate'),
(11, 5, '1-5 triệu', '/categories/price/1m-5m', 'Activate'),
(12, 5, 'Trên 5 triệu', '/categories/price/over-5m', 'Activate'),
(13, 6, 'Tổng quan', '/admin/dashboard/overview', 'Activate'),
(14, 6, 'Thống kê', '/admin/dashboard/stats', 'Activate'),
(15, 7, 'Cấu hình hệ thống', '/admin/settings/system', 'Activate'),
(16, 7, 'Cấu hình email', '/admin/settings/email', 'Activate');

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