-- COMPONENTTYPE
INSERT INTO componenttype (type_id, name, description) VALUES
(1, 'CPU', 'Bộ vi xử lý'),
(2, 'Mainboard', 'Bo mạch chủ'),
(3, 'RAM', 'Bộ nhớ trong'),
(4, 'GPU', 'Card đồ họa'),
(5, 'Storage', 'Ổ cứng'),
(6, 'PSU', 'Nguồn máy tính'),
(7, 'Case', 'Vỏ máy tính'),
(8, 'Cooler', 'Tản nhiệt'),
(9, 'Mouse', 'Chuột máy tính'),
(10, 'Keyboard', 'Bàn phím'),
(11, 'Headphone', 'Tai nghe'),
(12, 'Monitor', 'Màn hình'),
(13, 'Chair', 'Ghế'),
(14, 'Desk', 'Bàn');

-- BRAND
INSERT INTO brand (brand_id, name) VALUES
(1, 'AMD'),
(2, 'Intel'),
(3, 'ASUS'),
(4, 'MSI'),
(5, 'Gigabyte'),
(6, 'NVIDIA'),
(7, 'Corsair'),
(8, 'G.Skill'),
(9, 'WD'),
(10, 'Samsung'),
(11, 'Noctua'),
(12, 'Arctic'),
(13, 'Logitech'),
(14, 'Razer'),
(15, 'Beyerdynamic'),
(16, 'SteelSeries'),
(17, 'LG'),
(18, 'Secretlab'),
(19, 'Herman Miller'),
(20, 'IKEA');

-- SERIES
INSERT INTO series (series_id, brand_id, name) VALUES
(1, 1, 'Ryzen 9000'), -- AMD
(2, 2, 'Core Ultra 200'), -- Intel
(3, 3, 'ROG Strix'), -- ASUS
(4, 5, 'Aorus Elite'), -- Gigabyte
(5, 7, 'Vengeance'), -- Corsair
(6, 8, 'Trident Z5'), -- G.Skill
(7, 6, 'GeForce RTX 50'), -- NVIDIA
(8, 4, 'Radeon RX 9000'), -- MSI
(9, 9, 'Black SN850X'), -- WD
(10, 10, '970 EVO Plus'), -- Samsung
(11, 7, 'RMx'), -- Corsair
(12, 4, 'MPG'), -- MSI
(13, 3, 'Lancool'), -- ASUS
(14, 5, 'Aorus C'), -- Gigabyte
(15, 12, 'Liquid Freezer III'), -- Arctic
(16, 11, 'NH-U'), -- Noctua
(17, 13, 'G Pro'), -- Logitech
(18, 14, 'DeathAdder'), -- Razer
(19, 13, 'Ornata'), -- Logitech
(20, 14, 'BlackWidow'), -- Razer
(21, 15, 'DT 990'), -- Beyerdynamic
(22, 16, 'Arctis'), -- SteelSeries
(23, 17, 'Odyssey'), -- LG
(24, 4, 'Optix'), -- MSI
(25, 18, 'Titan Evo'), -- Secretlab
(26, 19, 'Sayl'), -- Herman Miller
(27, 20, 'UPPSTÅ'), -- IKEA
(28, 20, 'LAGKAPTEN');

-- PRODUCT
INSERT INTO product (name, component_type_id, brand_id, model, price, import_price, stock, description, status, created_at) VALUES
('AMD Ryzen 7 9800X3D', 1, 1, '9800X3D', 480.00, 384.00, 50, '8-core CPU with 3D V-Cache', 'Active', NOW()),
('AMD Ryzen 9 9700X', 1, 1, '9700X', 400.00, 320.00, 40, '8-core high-performance CPU', 'Active', NOW()),
('Intel Core Ultra 7 265K', 1, 2, '265K', 400.00, 320.00, 45, 'High-clock CPU for gaming', 'Active', NOW()),
('ASUS ROG Strix X870-F', 2, 3, 'X870-F', 350.00, 280.00, 30, 'AM5 motherboard with Wi-Fi 6E', 'Active', NOW()),
('ASUS ROG Strix B650-E', 2, 3, 'B650-E', 300.00, 240.00, 35, 'B650 chipset with PCIe 5.0', 'Active', NOW()),
('Gigabyte B650 Aorus Elite AX', 2, 5, 'B650 AX', 250.00, 200.00, 50, 'Budget AM5 board with Wi-Fi', 'Active', NOW()),
('Corsair Vengeance LPX DDR5-6000 32GB', 3, 7, 'LPX DDR5-6000', 120.00, 96.00, 100, '32GB DDR5 dual-channel RAM', 'Active', NOW()),
('Corsair Vengeance RGB DDR5-6400 32GB', 3, 7, 'RGB DDR5-6400', 140.00, 112.00, 80, 'RGB DDR5 RAM, 32GB', 'Active', NOW()),
('G.Skill Trident Z5 DDR5-6000 32GB', 3, 8, 'Z5 DDR5-6000', 130.00, 104.00, 90, 'High-speed DDR5 with RGB', 'Active', NOW()),
('NVIDIA GeForce RTX 5090', 4, 6, '5090', 1500.00, 1200.00, 20, 'Top-tier GPU for 4K gaming', 'Active', NOW()),
('NVIDIA GeForce RTX 5080', 4, 6, '5080', 1000.00, 800.00, 25, 'High-end GPU for 1440p', 'Active', NOW()),
('MSI Radeon RX 9070 XT', 4, 4, '9070 XT', 800.00, 640.00, 30, 'AMD GPU with ray tracing', 'Active', NOW()),
('WD Black SN850X 2TB', 5, 9, '2TB', 180.00, 144.00, 80, 'High-speed M.2 SSD, 7300MB/s', 'Active', NOW()),
('WD Black SN850X 1TB', 5, 9, '1TB', 100.00, 80.00, 100, '1TB NVMe SSD for gaming', 'Active', NOW()),
('Samsung 970 EVO Plus 2TB', 5, 10, '2TB NVMe', 200.00, 160.00, 70, 'Reliable 2TB NVMe SSD', 'Active', NOW()),
('Corsair RM850e 80+ Gold', 6, 7, '850e', 130.00, 104.00, 40, 'Fully modular 850W PSU', 'Active', NOW()),
('Corsair RM1000e 80+ Gold', 6, 7, '1000e', 160.00, 128.00, 35, '1000W PSU for high-end builds', 'Active', NOW()),
('MSI MPG A850G', 6, 4, 'A850G', 140.00, 112.00, 50, '80+ Gold PSU, modular', 'Active', NOW()),
('ASUS Lancool 216', 7, 3, '216', 100.00, 80.00, 60, 'ATX case with excellent airflow', 'Active', NOW()),
('ASUS Lancool 205', 7, 3, '205', 90.00, 72.00, 70, 'Mid-tower case with RGB', 'Active', NOW()),
('Gigabyte Aorus C700', 7, 5, '700', 200.00, 160.00, 20, 'Premium ATX case', 'Active', NOW()),
('Arctic Liquid Freezer III 360mm', 8, 12, '360mm AIO', 120.00, 96.00, 60, 'High-performance AIO cooler', 'Active', NOW()),
('Arctic Liquid Freezer III 280mm', 8, 12, '280mm AIO', 100.00, 80.00, 65, '280mm AIO for compact builds', 'Active', NOW()),
('Noctua NH-U12S', 8, 11, 'U12S', 50.00, 40.00, 80, 'Air cooler with low noise', 'Active', NOW()),
('Logitech G Pro X Superlight 2', 9, 13, 'X Superlight 2', 100.00, 80.00, 70, 'Lightweight wireless mouse', 'Active', NOW()),
('Logitech G305', 9, 13, 'G305', 50.00, 40.00, 90, 'Budget wireless gaming mouse', 'Active', NOW()),
('Razer DeathAdder V3', 9, 14, 'V3', 80.00, 64.00, 60, 'Ergonomic wired mouse', 'Active', NOW()),
('Razer Ornata V4 Pro', 10, 14, 'V4 Pro', 150.00, 120.00, 40, 'Hybrid mechanical keyboard', 'Active', NOW()),
('Razer Ornata Chroma', 10, 14, 'Chroma', 100.00, 80.00, 50, 'RGB membrane keyboard', 'Active', NOW()),
('Logitech BlackWidow V3', 10, 13, 'V3', 130.00, 104.00, 45, 'Mechanical RGB keyboard', 'Active', NOW()),
('Beyerdynamic DT 990 Pro 250ohm', 11, 15, 'Pro 250ohm', 150.00, 120.00, 25, 'Open-back headphones', 'Active', NOW()),
('Beyerdynamic DT 990 Edition 600ohm', 11, 15, 'Edition 600ohm', 200.00, 160.00, 20, 'Premium open-back headphones', 'Active', NOW()),
('SteelSeries Arctis Nova Pro', 11, 16, 'Nova Pro', 250.00, 200.00, 15, 'Wireless gaming headset', 'Active', NOW()),
('LG Odyssey 27in QHD 240Hz', 12, 17, '27in QHD 240Hz', 400.00, 320.00, 15, '27-inch QHD monitor, 240Hz', 'Active', NOW()),
('LG Odyssey 32in 4K', 12, 17, '32in 4K', 600.00, 480.00, 10, '32-inch 4K gaming monitor', 'Active', NOW()),
('MSI Optix MPG 27', 12, 4, 'MPG 27', 350.00, 280.00, 20, '27-inch QHD gaming monitor', 'Active', NOW()),
('Secretlab Titan Evo 2022', 13, 18, '2022', 500.00, 400.00, 10, 'Ergonomic gaming chair', 'Active', NOW()),
('Secretlab Titan Evo 2024', 13, 18, '2024', 550.00, 440.00, 8, 'Updated ergonomic chair', 'Active', NOW()),
('Herman Miller Sayl', 13, 19, 'Standard', 600.00, 480.00, 5, 'Minimalist ergonomic chair', 'Active', NOW()),
('IKEA UPPSTÅ Standard', 14, 20, 'Standard', 200.00, 160.00, 30, 'Adjustable height desk', 'Active', NOW()),
('IKEA UPPSTÅ Height-Adjustable', 14, 20, 'Height-Adjustable', 300.00, 240.00, 25, 'Motorized standing desk', 'Active', NOW()),
('IKEA LAGKAPTEN 120x60', 14, 20, 'Standard 120x60', 150.00, 120.00, 40, 'Compact desk for small spaces', 'Active', NOW());

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

-- BLOG
INSERT INTO blog (title, content, user_id, created_at) VALUES
('Welcome to the PC Store', 'This is our first blog post by staff.', 1, NOW()),
('Admin Announcement', 'This is an announcement from the admin.', 2, NOW());

-- Select all data from tables
SELECT * FROM admin;
SELECT * FROM blog;
SELECT * FROM brand;
SELECT * FROM cartitem;
SELECT * FROM componenttype;
SELECT * FROM customer;
SELECT * FROM feedback;
SELECT * FROM inventorylog;
SELECT * FROM orders;
SELECT * FROM orderdetail;
SELECT * FROM paymentmethod;
SELECT * FROM product;
SELECT * FROM productimage;
SELECT * FROM productspecification;
SELECT * FROM series;
SELECT * FROM staff;
SELECT * FROM user;
SELECT * FROM voucher;
SELECT * FROM voucher_usage;
SELECT * FROM transactions;
SELECT * FROM menu_item;
SELECT * FROM menu_attribute;
SELECT * FROM menu_attribute_value;