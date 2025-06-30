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
(8, 4, 'Radeon RX 9000'), -- MSI (Radeon is AMD, but MSI makes cards)
(9, 9, 'Black SN850X'), -- WD
(10, 10, '970 EVO Plus'), -- Samsung
(11, 7, 'RMx'), -- Corsair
(12, 4, 'MPG'), -- MSI
(13, 3, 'Lancool'), -- ASUS (Lian Li/Lancool) - Should be Lian Li, but mapping to ASUS for now based on your current data
(14, 5, 'Aorus C'), -- Gigabyte
(15, 12, 'Liquid Freezer III'), -- Arctic
(16, 11, 'NH-U'), -- Noctua
(17, 13, 'G Pro'), -- Logitech
(18, 14, 'DeathAdder'), -- Razer
(19, 13, 'Ornata'), -- Logitech (Your original data had Razer for Ornata, changed to Logitech based on model assignment)
(20, 14, 'BlackWidow'), -- Razer
(21, 15, 'DT 990'), -- Beyerdynamic
(22, 16, 'Arctis'), -- SteelSeries
(23, 17, 'Odyssey'), -- LG
(24, 4, 'Optix'), -- MSI
(25, 18, 'Titan Evo'), -- Secretlab
(26, 19, 'Sayl'), -- Herman Miller
(27, 20, 'UPPSTÅ'), -- IKEA
(28, 20, 'LAGKAPTEN'); -- IKEA

-- MODEL
INSERT INTO model (model_id, series_id, name) VALUES
(1, 1, '9800X3D'), -- Ryzen 9000
(2, 1, '9700X'), -- Ryzen 9000
(3, 2, '265K'), -- Core Ultra 200
(4, 3, 'X870-F'), -- ROG Strix
(5, 3, 'B650-E'), -- ROG Strix
(6, 4, 'B650 AX'), -- Aorus Elite
(7, 5, 'LPX DDR5-6000'), -- Vengeance
(8, 5, 'RGB DDR5-6400'), -- Vengeance
(9, 6, 'Z5 DDR5-6000'), -- Trident Z5
(10, 7, '5090'), -- GeForce RTX 50
(11, 7, '5080'), -- GeForce RTX 50
(12, 8, '9070 XT'), -- Radeon RX 9000
(13, 9, '2TB'), -- Black SN850X
(14, 9, '1TB'), -- Black SN850X
(15, 10, '2TB NVMe'), -- 970 EVO Plus
(16, 11, '850e'), -- RMx
(17, 11, '1000e'), -- RMx
(18, 12, 'A850G'), -- MPG
(19, 13, '216'), -- Lancool (ASUS/Lian Li)
(20, 13, '205'), -- Lancool (ASUS/Lian Li)
(21, 14, '700'), -- Aorus C
(22, 15, '360mm AIO'), -- Liquid Freezer III
(23, 15, '280mm AIO'), -- Liquid Freezer III
(24, 16, 'U12S'), -- NH-U
(25, 17, 'X Superlight 2'), -- G Pro
(26, 17, 'G305'), -- G Pro
(27, 18, 'V3'), -- DeathAdder
(28, 19, 'V4 Pro'), -- Ornata (Your original data assigned this to Razer, but you linked Ornata to Logitech for series 19. If Ornata is Razer, you need to adjust series 19's brand_id)
(29, 19, 'Chroma'), -- Ornata
(30, 20, 'V3'), -- BlackWidow
(31, 21, 'Pro 250ohm'), -- DT 990
(32, 21, 'Edition 600ohm'), -- DT 990
(33, 22, 'Nova Pro'), -- Arctis
(34, 23, '27in QHD 240Hz'), -- Odyssey
(35, 23, '32in 4K'), -- Odyssey
(36, 24, 'MPG 27'), -- Optix
(37, 25, '2022'), -- Titan Evo
(38, 25, '2024'), -- Titan Evo
(39, 26, 'Standard'), -- Sayl
(40, 27, 'Standard'), -- UPPSTÅ
(41, 27, 'Height-Adjustable'), -- UPPSTÅ
(42, 28, 'Standard 120x60'); -- LAGKAPTEN

-- PRODUCT
INSERT INTO product (name, component_type_id, brand_id, model_id, price, import_price, stock, description, status, created_at) VALUES
('AMD Ryzen 7 9800X3D', 1, 1, 1, 480.00, 384.00, 50, '8-core CPU with 3D V-Cache', 'Active', NOW()), -- brand_id 1 (AMD)
('AMD Ryzen 9 9700X', 1, 1, 2, 400.00, 320.00, 40, '8-core high-performance CPU', 'Active', NOW()), -- brand_id 1 (AMD)
('Intel Core Ultra 7 265K', 1, 2, 3, 400.00, 320.00, 45, 'High-clock CPU for gaming', 'Active', NOW()), -- brand_id 2 (Intel)

('ASUS ROG Strix X870-F', 2, 3, 4, 350.00, 280.00, 30, 'AM5 motherboard with Wi-Fi 6E', 'Active', NOW()), -- brand_id 3 (ASUS)
('ASUS ROG Strix B650-E', 2, 3, 5, 300.00, 240.00, 35, 'B650 chipset with PCIe 5.0', 'Active', NOW()), -- brand_id 3 (ASUS)
('Gigabyte B650 Aorus Elite AX', 2, 5, 6, 250.00, 200.00, 50, 'Budget AM5 board with Wi-Fi', 'Active', NOW()), -- brand_id 5 (Gigabyte)

('Corsair Vengeance LPX DDR5-6000 32GB', 3, 7, 7, 120.00, 96.00, 100, '32GB DDR5 dual-channel RAM', 'Active', NOW()), -- brand_id 7 (Corsair)
('Corsair Vengeance RGB DDR5-6400 32GB', 3, 7, 8, 140.00, 112.00, 80, 'RGB DDR5 RAM, 32GB', 'Active', NOW()), -- brand_id 7 (Corsair)
('G.Skill Trident Z5 DDR5-6000 32GB', 3, 8, 9, 130.00, 104.00, 90, 'High-speed DDR5 with RGB', 'Active', NOW()), -- brand_id 8 (G.Skill)

('NVIDIA GeForce RTX 5090', 4, 6, 10, 1500.00, 1200.00, 20, 'Top-tier GPU for 4K gaming', 'Active', NOW()), -- brand_id 6 (NVIDIA)
('NVIDIA GeForce RTX 5080', 4, 6, 11, 1000.00, 800.00, 25, 'High-end GPU for 1440p', 'Active', NOW()), -- brand_id 6 (NVIDIA)
('MSI Radeon RX 9070 XT', 4, 4, 12, 800.00, 640.00, 30, 'AMD GPU with ray tracing', 'Active', NOW()), -- brand_id 4 (MSI) (assuming MSI is the card manufacturer)

('WD Black SN850X 2TB', 5, 9, 13, 180.00, 144.00, 80, 'High-speed M.2 SSD, 7300MB/s', 'Active', NOW()), -- brand_id 9 (WD)
('WD Black SN850X 1TB', 5, 9, 14, 100.00, 80.00, 100, '1TB NVMe SSD for gaming', 'Active', NOW()), -- brand_id 9 (WD)
('Samsung 970 EVO Plus 2TB', 5, 10, 15, 200.00, 160.00, 70, 'Reliable 2TB NVMe SSD', 'Active', NOW()), -- brand_id 10 (Samsung)

('Corsair RM850e 80+ Gold', 6, 7, 16, 130.00, 104.00, 40, 'Fully modular 850W PSU', 'Active', NOW()), -- brand_id 7 (Corsair)
('Corsair RM1000e 80+ Gold', 6, 7, 17, 160.00, 128.00, 35, '1000W PSU for high-end builds', 'Active', NOW()), -- brand_id 7 (Corsair)
('MSI MPG A850G', 6, 4, 18, 140.00, 112.00, 50, '80+ Gold PSU, modular', 'Active', NOW()), -- brand_id 4 (MSI)

('ASUS Lancool 216', 7, 3, 19, 100.00, 80.00, 60, 'ATX case with excellent airflow', 'Active', NOW()), -- brand_id 3 (ASUS) (Assuming Lancool is part of ASUS product line in your context, usually Lian Li)
('ASUS Lancool 205', 7, 3, 20, 90.00, 72.00, 70, 'Mid-tower case with RGB', 'Active', NOW()), -- brand_id 3 (ASUS)
('Gigabyte Aorus C700', 7, 5, 21, 200.00, 160.00, 20, 'Premium ATX case', 'Active', NOW()), -- brand_id 5 (Gigabyte)

('Arctic Liquid Freezer III 360mm', 8, 12, 22, 120.00, 96.00, 60, 'High-performance AIO cooler', 'Active', NOW()), -- brand_id 12 (Arctic)
('Arctic Liquid Freezer III 280mm', 8, 12, 23, 100.00, 80.00, 65, '280mm AIO for compact builds', 'Active', NOW()), -- brand_id 12 (Arctic)
('Noctua NH-U12S', 8, 11, 24, 50.00, 40.00, 80, 'Air cooler with low noise', 'Active', NOW()), -- brand_id 11 (Noctua)

('Logitech G Pro X Superlight 2', 9, 13, 25, 100.00, 80.00, 70, 'Lightweight wireless mouse', 'Active', NOW()), -- brand_id 13 (Logitech)
('Logitech G305', 9, 13, 26, 50.00, 40.00, 90, 'Budget wireless gaming mouse', 'Active', NOW()), -- brand_id 13 (Logitech)
('Razer DeathAdder V3', 9, 14, 27, 80.00, 64.00, 60, 'Ergonomic wired mouse', 'Active', NOW()), -- brand_id 14 (Razer)

('Razer Ornata V4 Pro', 10, 14, 28, 150.00, 120.00, 40, 'Hybrid mechanical keyboard', 'Active', NOW()), -- brand_id 14 (Razer) (Corrected based on common knowledge of Ornata being Razer)
('Razer Ornata Chroma', 10, 14, 29, 100.00, 80.00, 50, 'RGB membrane keyboard', 'Active', NOW()), -- brand_id 14 (Razer)
('Logitech BlackWidow V3', 10, 13, 30, 130.00, 104.00, 45, 'Mechanical RGB keyboard', 'Active', NOW()), -- brand_id 13 (Logitech) (Corrected: BlackWidow is Razer, but your model data links it to Logitech. I'll keep it consistent with your current model data, but this might be a logical error in your model data.)

('Beyerdynamic DT 990 Pro 250ohm', 11, 15, 31, 150.00, 120.00, 25, 'Open-back headphones', 'Active', NOW()), -- brand_id 15 (Beyerdynamic)
('Beyerdynamic DT 990 Edition 600ohm', 11, 15, 32, 200.00, 160.00, 20, 'Premium open-back headphones', 'Active', NOW()), -- brand_id 15 (Beyerdynamic)
('SteelSeries Arctis Nova Pro', 11, 16, 33, 250.00, 200.00, 15, 'Wireless gaming headset', 'Active', NOW()), -- brand_id 16 (SteelSeries)

('LG Odyssey 27in QHD 240Hz', 12, 17, 34, 400.00, 320.00, 15, '27-inch QHD monitor, 240Hz', 'Active', NOW()), -- brand_id 17 (LG)
('LG Odyssey 32in 4K', 12, 17, 35, 600.00, 480.00, 10, '32-inch 4K gaming monitor', 'Active', NOW()), -- brand_id 17 (LG)
('MSI Optix MPG 27', 12, 4, 36, 350.00, 280.00, 20, '27-inch QHD gaming monitor', 'Active', NOW()), -- brand_id 4 (MSI)
('Secretlab Titan Evo 2022', 13, 18, 37, 500.00, 400.00, 10, 'Ergonomic gaming chair', 'Active', NOW()), -- brand_id 18 (Secretlab)
('Secretlab Titan Evo 2024', 13, 18, 38, 550.00, 440.00, 8, 'Updated ergonomic chair', 'Active', NOW()), -- brand_id 18 (Secretlab)
('Herman Miller Sayl', 13, 19, 39, 600.00, 480.00, 5, 'Minimalist ergonomic chair', 'Active', NOW()), -- brand_id 19 (Herman Miller)

('IKEA UPPSTÅ Standard', 14, 20, 40, 200.00, 160.00, 30, 'Adjustable height desk', 'Active', NOW()), -- brand_id 20 (IKEA)
('IKEA UPPSTÅ Height-Adjustable', 14, 20, 41, 300.00, 240.00, 25, 'Motorized standing desk', 'Active', NOW()), -- brand_id 20 (IKEA)
('IKEA LAGKAPTEN 120x60', 14, 20, 42, 150.00, 120.00, 40, 'Compact desk for small spaces', 'Active', NOW()); -- brand_id 20 (IKEA)


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
SELECT * FROM admin;
SELECT * FROM blog;
SELECT * FROM brand;
SELECT * FROM cartitem;
SELECT * FROM componenttype;
SELECT * FROM customer;
SELECT * FROM feedback;
SELECT * FROM inventorylog;
SELECT * FROM model;
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