-- Insert data into componenttype
INSERT INTO componenttype (name) VALUES
('CPU'), ('Mainboard'), ('RAM'), ('GPU'), ('Storage'), 
('PSU'), ('Case'), ('Cooler'), ('Mouse'), ('Keyboard'), 
('Headphone'), ('Monitor'), ('Chair'), ('Desk');

-- Insert data into brand
INSERT INTO brand (name) VALUES
('AMD'), ('Intel'), ('ASUS'), ('MSI'), ('Gigabyte'), 
('NVIDIA'), ('Corsair'), ('G.Skill'), ('WD'), ('Samsung'), 
('Noctua'), ('Arctic'), ('Logitech'), ('Razer'), ('Beyerdynamic'), 
('SteelSeries'), ('LG'), ('Secretlab'), ('Herman Miller'), ('IKEA');

-- Insert data into series
INSERT INTO series (brand_id, name) VALUES
(6, 'Ryzen 9000'), (7, 'Core Ultra 200'), -- CPU (AMD, Intel)
(8, 'ROG Strix'), (10, 'Aorus Elite'), -- Mainboard (ASUS, Gigabyte)
(12, 'Vengeance'), (13, 'Trident Z5'), -- RAM (Corsair, G.Skill)
(11, 'GeForce RTX 50'), (9, 'Radeon RX 9000'), -- GPU (NVIDIA, MSI)
(14, 'Black SN850X'), (15, '970 EVO Plus'), -- Storage (WD, Samsung)
(12, 'RMx'), (9, 'MPG'), -- PSU (Corsair, MSI)
(8, 'Lancool'), (10, 'Aorus C'), -- Case (ASUS, Gigabyte)
(17, 'Liquid Freezer III'), (16, 'NH-U'), -- Cooler (Arctic, Noctua)
(18, 'G Pro'), (19, 'DeathAdder'), -- Mouse (Logitech, Razer)
(18, 'Ornata'), (19, 'BlackWidow'), -- Keyboard (Logitech, Razer)
(20, 'DT 990'), (21, 'Arctis'), -- Headphone (Beyerdynamic, SteelSeries)
(22, 'Odyssey'), (9, 'Optix'), -- Monitor (LG, MSI)
(23, 'Titan Evo'), (24, 'Sayl'), -- Chair (Secretlab, Herman Miller)
(25, 'UPPSTÅ'), (25, 'LAGKAPTEN'); -- Desk (IKEA, IKEA)

-- Insert data into model
INSERT INTO model (series_id, name) VALUES
(1, '9800X3D'), (1, '9700X'), (2, '265K'),
(3, 'X870-F'), (3, 'B650-E'), (4, 'B650 AX'),
(5, 'LPX DDR5-6000'), (5, 'RGB DDR5-6400'), (6, 'Z5 DDR5-6000'),
(7, '5090'), (7, '5080'), (8, '9070 XT'),
(9, '2TB'), (9, '1TB'), (10, '2TB NVMe'),
(11, '850e'), (11, '1000e'), (12, 'A850G'),
(13, '216'), (13, '205'), (14, '700'),
(15, '360mm AIO'), (15, '280mm AIO'), (16, 'U12S'),
(17, 'X Superlight 2'), (17, 'G305'), (18, 'V3'),
(19, 'V4 Pro'), (19, 'Chroma'), (20, 'V3'),
(21, 'Pro 250ohm'), (21, 'Edition 600ohm'), (22, 'Nova Pro'),
(23, '27in QHD 240Hz'), (23, '32in 4K'), (24, 'MPG 27'),
(25, '2022'), (25, '2024'), (26, 'Standard'),
(27, 'Standard'), (27, 'Height-Adjustable'), (28, 'Standard 120x60');

-- Insert data into product
INSERT INTO product (name, component_type_id, brand_id, model_id, price, import_price, stock, description, status) VALUES
('AMD Ryzen 7 9800X3D', 10, 6, 1, 480.00, 384.00, 50, '8-core CPU with 3D V-Cache', 'Active'),
('AMD Ryzen 9 9700X', 10, 6, 2, 400.00, 320.00, 40, '8-core high-performance CPU', 'Active'),
('Intel Core Ultra 7 265K', 10, 7, 3, 400.00, 320.00, 45, 'High-clock CPU for gaming', 'Active'),
('ASUS ROG Strix X870-F', 11, 8, 4, 350.00, 280.00, 30, 'AM5 motherboard with Wi-Fi 6E', 'Active'),
('ASUS ROG Strix B650-E', 11, 8, 5, 300.00, 240.00, 35, 'B650 chipset with PCIe 5.0', 'Active'),
('Gigabyte B650 Aorus Elite AX', 11, 10, 6, 250.00, 200.00, 50, 'Budget AM5 board with Wi-Fi', 'Active'),
('Corsair Vengeance LPX DDR5-6000 32GB', 12, 12, 7, 120.00, 96.00, 100, '32GB DDR5 dual-channel RAM', 'Active'),
('Corsair Vengeance RGB DDR5-6400 32GB', 12, 12, 8, 140.00, 112.00, 80, 'RGB DDR5 RAM, 32GB', 'Active'),
('G.Skill Trident Z5 DDR5-6000 32GB', 12, 13, 9, 130.00, 104.00, 90, 'High-speed DDR5 with RGB', 'Active'),
('NVIDIA GeForce RTX 5090', 13, 11, 10, 1500.00, 1200.00, 20, 'Top-tier GPU for 4K gaming', 'Active'),
('NVIDIA GeForce RTX 5080', 13, 11, 11, 1000.00, 800.00, 25, 'High-end GPU for 1440p', 'Active'),
('MSI Radeon RX 9070 XT', 13, 9, 12, 800.00, 640.00, 30, 'AMD GPU with ray tracing', 'Active'),
('WD Black SN850X 2TB', 14, 14, 13, 180.00, 144.00, 80, 'High-speed M.2 SSD, 7300MB/s', 'Active'),
('WD Black SN850X 1TB', 14, 14, 14, 100.00, 80.00, 100, '1TB NVMe SSD for gaming', 'Active'),
('Samsung 970 EVO Plus 2TB', 14, 15, 15, 200.00, 160.00, 70, 'Reliable 2TB NVMe SSD', 'Active'),
('Corsair RM850e 80+ Gold', 15, 12, 16, 130.00, 104.00, 40, 'Fully modular 850W PSU', 'Active'),
('Corsair RM1000e 80+ Gold', 15, 12, 17, 160.00, 128.00, 35, '1000W PSU for high-end builds', 'Active'),
('MSI MPG A850G', 15, 9, 18, 140.00, 112.00, 50, '80+ Gold PSU, modular', 'Active'),
('ASUS Lancool 216', 16, 8, 19, 100.00, 80.00, 60, 'ATX case with excellent airflow', 'Active'),
('ASUS Lancool 205', 16, 8, 20, 90.00, 72.00, 70, 'Mid-tower case with RGB', 'Active'),
('Gigabyte Aorus C700', 16, 10, 21, 200.00, 160.00, 20, 'Premium ATX case', 'Active'),
('Arctic Liquid Freezer III 360mm', 17, 17, 22, 120.00, 96.00, 60, 'High-performance AIO cooler', 'Active'),
('Arctic Liquid Freezer III 280mm', 17, 17, 23, 100.00, 80.00, 65, '280mm AIO for compact builds', 'Active'),
('Noctua NH-U12S', 17, 16, 24, 50.00, 40.00, 80, 'Air cooler with low noise', 'Active'),
('Logitech G Pro X Superlight 2', 18, 18, 25, 100.00, 80.00, 70, 'Lightweight wireless mouse', 'Active'),
('Logitech G305', 18, 18, 26, 50.00, 40.00, 90, 'Budget wireless gaming mouse', 'Active'),
('Razer DeathAdder V3', 18, 19, 27, 80.00, 64.00, 60, 'Ergonomic wired mouse', 'Active'),
('Razer Ornata V4 Pro', 19, 19, 28, 150.00, 120.00, 40, 'Hybrid mechanical keyboard', 'Active'),
('Razer Ornata Chroma', 19, 19, 29, 100.00, 80.00, 50, 'RGB membrane keyboard', 'Active'),
('Logitech BlackWidow V3', 19, 18, 30, 130.00, 104.00, 45, 'Mechanical RGB keyboard', 'Active'),
('Beyerdynamic DT 990 Pro 250ohm', 20, 20, 31, 150.00, 120.00, 25, 'Open-back headphones', 'Active'),
('Beyerdynamic DT 990 Edition 600ohm', 20, 20, 32, 200.00, 160.00, 20, 'Premium open-back headphones', 'Active'),
('SteelSeries Arctis Nova Pro', 20, 21, 33, 250.00, 200.00, 15, 'Wireless gaming headset', 'Active'),
('LG Odyssey 27in QHD 240Hz', 21, 22, 34, 400.00, 320.00, 15, '27-inch QHD monitor, 240Hz', 'Active'),
('LG Odyssey 32in 4K', 21, 22, 35, 600.00, 480.00, 10, '32-inch 4K gaming monitor', 'Active'),
('MSI Optix MPG 27', 21, 9, 36, 350.00, 280.00, 20, '27-inch QHD gaming monitor', 'Active'),
('Secretlab Titan Evo 2022', 22, 23, 37, 500.00, 400.00, 10, 'Ergonomic gaming chair', 'Active'),
('Secretlab Titan Evo 2024', 22, 23, 38, 550.00, 440.00, 8, 'Updated ergonomic chair', 'Active'),
('Herman Miller Sayl', 22, 24, 39, 600.00, 480.00, 5, 'Minimalist ergonomic chair', 'Active'),
('IKEA UPPSTÅ Standard', 23, 25, 40, 200.00, 160.00, 30, 'Adjustable height desk', 'Active'),
('IKEA UPPSTÅ Height-Adjustable', 23, 25, 41, 300.00, 240.00, 25, 'Motorized standing desk', 'Active'),
('IKEA LAGKAPTEN 120x60', 23, 25, 42, 150.00, 120.00, 40, 'Compact desk for small spaces', 'Active');

-- Insert data into paymentmethod
INSERT INTO paymentmethod (method_name, description) VALUES
('Cash', 'Tiền mặt'),
('Transfer', 'Chuyển khoản');

-- Insert data into user
INSERT INTO `user` (user_id, username, password, email, role, status, is_verified, verification_token) VALUES 
(1, 'staff01', 'hashedpassword1', 'staff01@example.com', 'Staff', 'Active', 1, NULL),
(2, 'admin01', 'hashedpassword2', 'admin01@example.com', 'Admin', 'Active', 1, NULL);

-- Insert data into customer
INSERT INTO `customer` (customer_id, name, email, password, phone, shipping_address, is_verified, verification_token) VALUES 
(1, 'Lê Thị Khách Hàng', 'customer01@example.com', 'hashedpassword3', '0909988776', '123 Đường ABC, Quận 1, TP.HCM', 0, NULL),
(2, 'NguyenVanGiap', 'giapThieuNang@gmail.com', 'cesvg2810A!', '0994885738', 'KhongBietHoiLamVL', 0, NULL),
(3, 'Phạm Đức Trọng', 'trongpdhe181640@fpt.edu.vn', '$2a$10$iC2jTTQm8GSE5ni9iURIouVE.c/qVXK8PKSshKj7HjAb/Ie5r5Tea', '0559868660', 'ChauPhong-LienHa-DongAnh-HaNoi', 1, NULL);

-- Insert data into staff
INSERT INTO `staff` (staff_id, user_id, name, phone, enter_date, leave_date) VALUES 
(1, 1, 'Nguyễn Văn Nhân viên', '0901123456', '2024-01-01', NULL);

-- Insert data into admin
INSERT INTO `admin` (admin_id, user_id, name) VALUES 
(1, 2, 'Trần Thị Quản Trị');

-- Insert data into shipper
INSERT INTO `shipper` (shipper_id, name, phone, email, vehicle_number, vehicle_type, status, current_location, join_date, rating, total_deliveries) VALUES
(1, 'Nguyễn Văn Giao Hàng', '0901234567', 'shipper01@example.com', '51A-12345', 'Motorcycle', 'Active', 'Quận 1, TP.HCM', '2024-01-15', 4.8, 150),
(2, 'Trần Thị Vận Chuyển', '0902345678', 'shipper02@example.com', '51B-67890', 'Motorcycle', 'Active', 'Quận 3, TP.HCM', '2024-02-01', 4.9, 200),
(3, 'Lê Văn Tài Xế', '0903456789', 'shipper03@example.com', '51C-11111', 'Car', 'Busy', 'Quận 7, TP.HCM', '2024-01-20', 4.7, 80),
(4, 'Phạm Thị Giao Hàng', '0904567890', 'shipper04@example.com', '51D-22222', 'Motorcycle', 'Active', 'Quận 10, TP.HCM', '2024-03-01', 4.6, 120),
(5, 'Hoàng Văn Vận Chuyển', '0905678901', 'shipper05@example.com', '51E-33333', 'Truck', 'Inactive', 'Quận 5, TP.HCM', '2024-02-15', 4.5, 60);

-- Insert data into voucher
INSERT INTO `voucher` (voucher_id, code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES
(1, 'WELCOME10', '10% off for new users', 'percent', 10.00, 100.00, 100, 1, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 'Active'),
(2, 'SUMMER50', '50,000 VND off orders over 500,000 VND', 'fixed', 50000.00, 500000.00, 50, 2, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Active'),
(3, 'FREEMOUSE', 'Free gaming mouse with any PC component purchase this month (limited quantity)', 'fixed', 0.00, 0.00, 50, 1, '2024-06-01 00:00:00', '2024-06-30 23:59:59', 'Active');

-- Insert data into orders
INSERT INTO `orders` (order_id, customer_id, order_date, total_amount, shipping_address, shipping_fee, status, payment_method_id, shipper_id) VALUES
(1, 2, '2024-06-21 09:00:00', 3210.00, 'KhongBietHoiLamVL', 10.00, 'Pending', 1, NULL);

-- Insert data into orderdetail
INSERT INTO `orderdetail` (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1, 22, 1, 400.00), -- AMD Ryzen 9 9700X
(2, 1, 25, 1, 300.00), -- ASUS ROG Strix B650-E
(3, 1, 23, 1, 400.00), -- Intel Core Ultra 7 265K
(4, 1, 38, 1, 140.00), -- MSI MPG A850G
(5, 1, 39, 1, 90.00),  -- ASUS Lancool 205
(6, 1, 40, 1, 200.00), -- Gigabyte Aorus C700
(7, 1, 37, 1, 160.00), -- Corsair RM1000e 80+ Gold
(8, 1, 28, 1, 140.00), -- Corsair Vengeance RGB DDR5-6400 32GB
(9, 1, 29, 1, 130.00); -- G.Skill Trident Z5 DDR5-6000 32GB

-- Insert data into voucher_usage
INSERT INTO `voucher_usage` (usage_id, voucher_id, customer_id, order_id, used_at) VALUES
(1, 1, 3, 1, '2024-06-21 10:00:00'),
(2, 2, 2, 1, '2024-06-22 11:00:00');

-- Insert data into cartitem
INSERT INTO `cartitem` (cart_item_id, customer_id, product_id, quantity) VALUES 
(1, 2, 22, 1), -- AMD Ryzen 9 9700X
(2, 2, 25, 1), -- ASUS ROG Strix B650-E
(3, 2, 23, 1), -- Intel Core Ultra 7 265K
(4, 2, 38, 1), -- MSI MPG A850G
(5, 2, 39, 1), -- ASUS Lancool 205
(6, 2, 40, 1), -- Gigabyte Aorus C700
(7, 2, 37, 1), -- Corsair RM1000e 80+ Gold
(8, 2, 28, 1), -- Corsair Vengeance RGB DDR5-6400 32GB
(9, 2, 29, 1); -- G.Skill Trident Z5 DDR5-6000 32GB

-- Insert data into transactions
INSERT INTO `transactions` (transaction_id, transaction_code, order_id, payment_method_id, total_amount, paid) VALUES
(1, 'TXN001', 1, 1, 3210.00, FALSE);

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
SELECT * FROM `shipper`;
SELECT * FROM `staff`;
SELECT * FROM `user`;
SELECT * FROM `voucher`;
SELECT * FROM `voucher_usage`;
SELECT * FROM `transactions`;