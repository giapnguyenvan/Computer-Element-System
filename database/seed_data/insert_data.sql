-- Insert data into tables
INSERT INTO `componenttype` (type_id, name, description) VALUES
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

INSERT INTO `brand` (brand_id, name, description) VALUES
(1, 'AMD', 'Advanced Micro Devices - Nhà sản xuất CPU và GPU hàng đầu'),
(2, 'Intel', 'Nhà sản xuất CPU số 1 thế giới'),
(3, 'ASUS', 'Nhà sản xuất phần cứng và thiết bị điện tử đa dạng'),
(4, 'MSI', 'Micro-Star International - Chuyên sản xuất phần cứng gaming'),
(5, 'Gigabyte', 'Nhà sản xuất bo mạch chủ và card đồ họa chất lượng cao'),
(6, 'NVIDIA', 'Nhà sản xuất GPU hàng đầu thế giới'),
(7, 'Corsair', 'Chuyên các thiết bị gaming và PC cao cấp'),
(8, 'G.Skill', 'Nhà sản xuất RAM hiệu năng cao'),
(9, 'WD', 'Western Digital - Giải pháp lưu trữ chuyên nghiệp'),
(10, 'Samsung', 'Tập đoàn công nghệ đa quốc gia'),
(11, 'Noctua', 'Chuyên giải pháp tản nhiệt cao cấp'),
(12, 'Arctic', 'Giải pháp làm mát chuyên nghiệp'),
(13, 'Logitech', 'Thiết bị ngoại vi và gaming gear cao cấp'),
(14, 'Razer', 'Thương hiệu gaming gear hàng đầu'),
(15, 'Beyerdynamic', 'Âm thanh chuyên nghiệp từ Đức'),
(16, 'SteelSeries', 'Gaming gear cao cấp'),
(17, 'LG', 'Màn hình và thiết bị điện tử chất lượng cao'),
(18, 'Secretlab', 'Ghế gaming cao cấp'),
(19, 'Herman Miller', 'Ghế văn phòng chuyên nghiệp'),
(20, 'IKEA', 'Nội thất và thiết bị văn phòng'),
(21, 'Kingston', 'Giải pháp bộ nhớ và lưu trữ tin cậy'),
(22, 'Crucial', 'Bộ nhớ và lưu trữ hiệu năng cao'),
(23, 'Team Group', 'Nhà sản xuất RAM và SSD'),
(24, 'Patriot', 'Thiết bị lưu trữ và RAM gaming'),
(25, 'ADATA', 'Giải pháp lưu trữ và RAM đa dạng'),
(26, 'ASRock', 'Bo mạch chủ và card đồ họa giá tốt'),
(27, 'EVGA', 'Phần cứng gaming cao cấp'),
(28, 'Zotac', 'Card đồ họa nhỏ gọn'),
(29, 'Palit', 'Nhà sản xuất GPU giá tốt'),
(30, 'PowerColor', 'Card đồ họa AMD chuyên nghiệp'),
(31, 'Sapphire', 'Card đồ họa AMD cao cấp'),
(32, 'XFX', 'Thiết bị gaming chất lượng cao');

INSERT INTO `series` (series_id, brand_id, name, component_type_id, description) VALUES
(1, 1, 'Ryzen 9000', 1, 'Dòng CPU cao cấp mới nhất của AMD'),
(2, 2, 'Core Ultra 200', 1, 'CPU thế hệ mới với công nghệ hybrid'),
(3, 3, 'ROG Strix', 2, 'Dòng bo mạch chủ cao cấp của ASUS'),
(4, 5, 'Aorus Elite', 2, 'Bo mạch chủ gaming của Gigabyte'),
(5, 7, 'Vengeance', 3, 'RAM hiệu năng cao của Corsair'),
(6, 8, 'Trident Z5', 3, 'RAM DDR5 cao cấp của G.Skill'),
(7, 6, 'GeForce RTX 50', 4, 'GPU thế hệ mới nhất của NVIDIA'),
(8, 4, 'Radeon RX 9000', 4, 'GPU AMD do MSI sản xuất'),
(9, 9, 'Black SN850X', 5, 'SSD NVMe hiệu năng cao'),
(10, 10, '970 EVO Plus', 5, 'SSD NVMe đáng tin cậy'),
(11, 7, 'RMx', 6, 'Nguồn modular cao cấp'),
(12, 4, 'MPG', 6, 'Nguồn gaming của MSI'),
(13, 3, 'Lancool', 7, 'Case tối ưu airflow'),
(14, 5, 'Aorus C', 7, 'Case gaming cao cấp'),
(15, 12, 'Liquid Freezer III', 8, 'Tản nhiệt nước All-in-one'),
(16, 11, 'NH-U', 8, 'Tản nhiệt khí cao cấp'),
(17, 13, 'G Pro', 9, 'Chuột gaming không dây'),
(18, 14, 'DeathAdder', 9, 'Chuột gaming ergonomic'),
(19, 13, 'Ornata', 10, 'Bàn phím cơ membrane'),
(20, 14, 'BlackWidow', 10, 'Bàn phím cơ gaming'),
(21, 15, 'DT 990', 11, 'Tai nghe studio open-back'),
(22, 16, 'Arctis', 11, 'Tai nghe gaming không dây'),
(23, 17, 'Odyssey', 12, 'Màn hình gaming cao cấp'),
(24, 4, 'Optix', 12, 'Màn hình gaming MSI'),
(25, 18, 'Titan Evo', 13, 'Ghế gaming cao cấp'),
(26, 19, 'Sayl', 13, 'Ghế văn phòng ergonomic'),
(27, 20, 'UPPSTÅ', 14, 'Bàn điều chỉnh độ cao'),
(28, 20, 'LAGKAPTEN', 14, 'Bàn làm việc đa năng'),
(29, 21, 'Fury Beast', 3, 'RAM DDR5 hiệu năng cao'),
(30, 21, 'Fury Renegade', 3, 'RAM gaming cao cấp'),
(31, 22, 'Ballistix', 3, 'RAM tối ưu cho gaming'),
(32, 23, 'T-Force', 3, 'RAM RGB hiệu năng cao'),
(33, 24, 'Viper', 3, 'RAM gaming tốc độ cao'),
(34, 25, 'XPG', 3, 'RAM và SSD cao cấp'),
(35, 2, 'Core i9-14000', 1, 'CPU Intel thế hệ 14'),
(36, 2, 'Core i7-14000', 1, 'CPU Intel hiệu năng cao'),
(37, 2, 'Core i5-14000', 1, 'CPU Intel giá/hiệu năng tốt'),
(38, 1, 'Ryzen 7 8000', 1, 'CPU AMD 8 nhân mạnh mẽ'),
(39, 1, 'Ryzen 5 8000', 1, 'CPU AMD phổ thông'),
(40, 6, 'GeForce RTX 40', 4, 'GPU NVIDIA thế hệ trước'),
(41, 1, 'Radeon RX 8000', 4, 'GPU AMD mới nhất'),
(42, 27, 'GeForce RTX', 4, 'GPU NVIDIA by EVGA'),
(43, 28, 'GeForce RTX', 4, 'GPU NVIDIA by Zotac'),
(44, 29, 'GeForce RTX', 4, 'GPU NVIDIA by Palit'),
(45, 30, 'Radeon RX', 4, 'GPU AMD by PowerColor'),
(46, 31, 'Radeon RX', 4, 'GPU AMD by Sapphire'),
(47, 32, 'Radeon RX', 4, 'GPU AMD by XFX');

INSERT INTO `product` (name, component_type_id, brand_id, series_id, model, price, import_price, stock, sku, description, status, created_at) VALUES
('AMD Ryzen 7 9800X3D', 1, 1, 1, '9800X3D', 480.00, 384.00, 50, 'CPU-AMD-R7-9800X3D', '8-core CPU with 3D V-Cache', 'Active', NOW()),
('AMD Ryzen 9 9700X', 1, 1, 1, '9700X', 400.00, 320.00, 40, 'CPU-AMD-R9-9700X', '8-core high-performance CPU', 'Active', NOW()),
('Intel Core Ultra 7 265K', 1, 2, 2, '265K', 400.00, 320.00, 45, 'CPU-INTEL-265K', 'High-clock CPU for gaming', 'Active', NOW()),
('Intel Core i9-14900K', 1, 2, 2, '14900K', 580.00, 464.00, 25, 'CPU-INTEL-14900K', '24-core flagship CPU for extreme performance', 'Active', NOW()),
('Intel Core i7-14700K', 1, 2, 2, '14700K', 420.00, 336.00, 35, 'CPU-INTEL-14700K', '20-core CPU with hybrid architecture', 'Active', NOW()),
('Intel Core i5-14600K', 1, 2, 2, '14600K', 320.00, 256.00, 50, 'CPU-INTEL-14600K', '14-core CPU perfect for gaming', 'Active', NOW()),
('AMD Ryzen 7 8700X', 1, 1, 1, '8700X', 350.00, 280.00, 40, 'CPU-AMD-R7-8700X', '8-core Zen 4 CPU with excellent efficiency', 'Active', NOW()),
('AMD Ryzen 5 8600X', 1, 1, 1, '8600X', 280.00, 224.00, 60, 'CPU-AMD-R5-8600X', '6-core CPU ideal for gaming and productivity', 'Active', NOW()),
('AMD Ryzen 9 7950X3D', 1, 1, 1, '7950X3D', 700.00, 560.00, 15, 'CPU-AMD-R9-7950X3D', '16-core CPU with 3D V-Cache technology', 'Active', NOW()),
('Intel Core i9-13900KS', 1, 2, 2, '13900KS', 650.00, 520.00, 20, 'CPU-INTEL-13900KS', 'Special edition CPU with higher clock speeds', 'Active', NOW()),
('Corsair Vengeance LPX DDR5-6000 32GB', 3, 7, 5, 'LPX DDR5-6000', 120.00, 96.00, 100, 'RAM-Corsair-LPX-DDR5-6000', '32GB DDR5 dual-channel RAM', 'Active', NOW()),
('Corsair Vengeance RGB DDR5-6400 32GB', 3, 7, 5, 'RGB DDR5-6400', 140.00, 112.00, 80, 'RAM-Corsair-RGB-DDR5-6400', 'RGB DDR5 RAM, 32GB', 'Active', NOW()),
('G.Skill Trident Z5 DDR5-6000 32GB', 3, 8, 6, 'Z5 DDR5-6000', 130.00, 104.00, 90, 'RAM-G.Skill-Z5-DDR5-6000', 'High-speed DDR5 with RGB', 'Active', NOW()),
('Kingston Fury Beast DDR5-5600 32GB', 3, 21, 29, 'Fury Beast DDR5-5600', 110.00, 88.00, 120, 'RAM-Kingston-Fury-Beast-DDR5-5600', '32GB DDR5 RAM with aggressive styling', 'Active', NOW()),
('Kingston Fury Renegade DDR5-6400 32GB', 3, 21, 29, 'Fury Renegade DDR5-6400', 150.00, 120.00, 70, 'RAM-Kingston-Fury-Renegade-DDR5-6400', 'High-performance DDR5 with RGB lighting', 'Active', NOW()),
('Crucial Ballistix DDR5-6000 32GB', 3, 22, 30, 'Ballistix DDR5-6000', 125.00, 100.00, 85, 'RAM-Crucial-Ballistix-DDR5-6000', 'Reliable DDR5 RAM with excellent compatibility', 'Active', NOW()),
('Team Group T-Force Delta DDR5-6400 32GB', 3, 23, 31, 'T-Force Delta DDR5-6400', 135.00, 108.00, 75, 'RAM-Team-Group-T-Force-Delta-DDR5-6400', 'RGB DDR5 RAM with unique design', 'Active', NOW()),
('Patriot Viper DDR5-6000 32GB', 3, 24, 32, 'Viper DDR5-6000', 115.00, 92.00, 95, 'RAM-Patriot-Viper-DDR5-6000', '32GB DDR5 RAM with heat spreader', 'Active', NOW()),
('ADATA XPG Lancer DDR5-6400 32GB', 3, 25, 33, 'XPG Lancer DDR5-6400', 145.00, 116.00, 65, 'RAM-ADATA-XPG-Lancer-DDR5-6400', 'Premium DDR5 RAM with RGB effects', 'Active', NOW()),
('Corsair Dominator Platinum DDR5-7200 32GB', 3, 7, 34, 'Dominator Platinum DDR5-7200', 180.00, 144.00, 40, 'RAM-Corsair-Dominator-Platinum-DDR5-7200', 'Ultra-high-speed DDR5 RAM', 'Active', NOW()),
('NVIDIA GeForce RTX 5090', 4, 6, 7, '5090', 1500.00, 1200.00, 20, 'GPU-NVIDIA-5090', 'Top-tier GPU for 4K gaming', 'Active', NOW()),
('NVIDIA GeForce RTX 5080', 4, 6, 7, '5080', 1000.00, 800.00, 25, 'GPU-NVIDIA-5080', 'High-end GPU for 1440p', 'Active', NOW()),
('MSI Radeon RX 9070 XT', 4, 4, 8, '9070 XT', 800.00, 640.00, 30, 'GPU-MSI-9070-XT', 'AMD GPU with ray tracing', 'Active', NOW()),
('NVIDIA GeForce RTX 4090', 4, 6, 7, '4090', 1600.00, 1280.00, 15, 'GPU-NVIDIA-4090', 'Previous generation flagship GPU', 'Active', NOW()),
('NVIDIA GeForce RTX 4080', 4, 6, 7, '4080', 1200.00, 960.00, 20, 'GPU-NVIDIA-4080', 'High-end RTX 40 series GPU', 'Active', NOW()),
('NVIDIA GeForce RTX 4070 Ti', 4, 6, 7, '4070 Ti', 800.00, 640.00, 35, 'GPU-NVIDIA-4070-Ti', 'Mid-high range GPU with excellent performance', 'Active', NOW()),
('AMD Radeon RX 7900 XTX', 4, 1, 9, '7900 XTX', 1000.00, 800.00, 25, 'GPU-AMD-7900-XTX', 'AMD flagship GPU with 24GB VRAM', 'Active', NOW()),
('AMD Radeon RX 7900 XT', 4, 1, 9, '7900 XT', 900.00, 720.00, 30, 'GPU-AMD-7900-XT', 'High-end AMD GPU for 4K gaming', 'Active', NOW()),
('AMD Radeon RX 7800 XT', 4, 1, 9, '7800 XT', 550.00, 440.00, 40, 'GPU-AMD-7800-XT', 'Mid-range AMD GPU with great value', 'Active', NOW()),
('EVGA GeForce RTX 4070', 4, 27, 10, '4070', 600.00, 480.00, 45, 'GPU-EVGA-4070', 'EVGA RTX 4070 with excellent cooling', 'Active', NOW()),
('Zotac GeForce RTX 4060 Ti', 4, 28, 11, '4060 Ti', 400.00, 320.00, 60, 'GPU-Zotac-4060-Ti', 'Compact RTX 4060 Ti for small builds', 'Active', NOW()),
('Sapphire Radeon RX 7700 XT', 4, 31, 12, '7700 XT', 450.00, 360.00, 50, 'GPU-Sapphire-7700-XT', 'Sapphire RX 7700 XT with Nitro cooling', 'Active', NOW()),
('ASUS ROG Strix X870-F', 2, 3, 3, 'X870-F', 350.00, 280.00, 30, 'MB-ASUS-X870-F', 'AM5 motherboard with Wi-Fi 6E', 'Active', NOW()),
('ASUS ROG Strix B650-E', 2, 3, 3, 'B650-E', 300.00, 240.00, 35, 'MB-ASUS-B650-E', 'B650 chipset with PCIe 5.0', 'Active', NOW()),
('Gigabyte B650 Aorus Elite AX', 2, 5, 4, 'B650 AX', 250.00, 200.00, 50, 'MB-Gigabyte-B650-AX', 'Budget AM5 board with Wi-Fi', 'Active', NOW()),
('WD Black SN850X 2TB', 5, 9, 9, '2TB', 180.00, 144.00, 80, 'SSD-WD-Black-SN850X-2TB', 'High-speed M.2 SSD, 7300MB/s', 'Active', NOW()),
('WD Black SN850X 1TB', 5, 9, 9, '1TB', 100.00, 80.00, 100, 'SSD-WD-Black-SN850X-1TB', '1TB NVMe SSD for gaming', 'Active', NOW()),
('Samsung 970 EVO Plus 2TB', 5, 10, 10, '2TB NVMe', 200.00, 160.00, 70, 'SSD-Samsung-970-EVO-Plus-2TB', 'Reliable 2TB NVMe SSD', 'Active', NOW()),
('Corsair RM850e 80+ Gold', 6, 7, 11, '850e', 130.00, 104.00, 40, 'PSU-Corsair-RM850e-80+Gold', 'Fully modular 850W PSU', 'Active', NOW()),
('Corsair RM1000e 80+ Gold', 6, 7, 11, '1000e', 160.00, 128.00, 35, 'PSU-Corsair-RM1000e-80+Gold', '1000W PSU for high-end builds', 'Active', NOW()),
('MSI MPG A850G', 6, 4, 12, 'A850G', 140.00, 112.00, 50, 'PSU-MSI-MPG-A850G', '80+ Gold PSU, modular', 'Active', NOW()),
('ASUS Lancool 216', 7, 3, 13, '216', 100.00, 80.00, 60, 'Case-ASUS-Lancool-216', 'ATX case with excellent airflow', 'Active', NOW()),
('ASUS Lancool 205', 7, 3, 13, '205', 90.00, 72.00, 70, 'Case-ASUS-Lancool-205', 'Mid-tower case with RGB', 'Active', NOW()),
('Gigabyte Aorus C700', 7, 5, 14, '700', 200.00, 160.00, 20, 'Case-Gigabyte-Aorus-C700', 'Premium ATX case', 'Active', NOW()),
('Arctic Liquid Freezer III 360mm', 8, 12, 15, '360mm AIO', 120.00, 96.00, 60, 'Cooler-Arctic-Liquid-Freezer-III-360mm-AIO', 'High-performance AIO cooler', 'Active', NOW()),
('Arctic Liquid Freezer III 280mm', 8, 12, 15, '280mm AIO', 100.00, 80.00, 65, 'Cooler-Arctic-Liquid-Freezer-III-280mm-AIO', '280mm AIO for compact builds', 'Active', NOW()),
('Noctua NH-U12S', 8, 11, 16, 'U12S', 50.00, 40.00, 80, 'Cooler-Noctua-NH-U12S', 'Air cooler with low noise', 'Active', NOW()),
('Logitech G Pro X Superlight 2', 9, 13, 17, 'X Superlight 2', 100.00, 80.00, 70, 'Mouse-Logitech-G-Pro-X-Superlight-2', 'Lightweight wireless mouse', 'Active', NOW()),
('Logitech G305', 9, 13, 17, 'G305', 50.00, 40.00, 90, 'Mouse-Logitech-G305', 'Budget wireless gaming mouse', 'Active', NOW()),
('Razer DeathAdder V3', 9, 14, 18, 'V3', 80.00, 64.00, 60, 'Mouse-Razer-DeathAdder-V3', 'Ergonomic wired mouse', 'Active', NOW()),
('Razer Ornata V4 Pro', 10, 14, 19, 'V4 Pro', 150.00, 120.00, 40, 'Keyboard-Razer-Ornata-V4-Pro', 'Hybrid mechanical keyboard', 'Active', NOW()),
('Razer Ornata Chroma', 10, 14, 19, 'Chroma', 100.00, 80.00, 50, 'Keyboard-Razer-Ornata-Chroma', 'RGB membrane keyboard', 'Active', NOW()),
('Logitech BlackWidow V3', 10, 13, 20, 'V3', 130.00, 104.00, 45, 'Keyboard-Logitech-BlackWidow-V3', 'Mechanical RGB keyboard', 'Active', NOW()),
('Beyerdynamic DT 990 Pro 250ohm', 11, 15, 21, 'Pro 250ohm', 150.00, 120.00, 25, 'Headphone-Beyerdynamic-DT-990-Pro-250ohm', 'Open-back headphones', 'Active', NOW()),
('Beyerdynamic DT 990 Edition 600ohm', 11, 15, 21, 'Edition 600ohm', 200.00, 160.00, 20, 'Headphone-Beyerdynamic-DT-990-Edition-600ohm', 'Premium open-back headphones', 'Active', NOW()),
('SteelSeries Arctis Nova Pro', 11, 16, 22, 'Nova Pro', 250.00, 200.00, 15, 'Headphone-SteelSeries-Arctis-Nova-Pro', 'Wireless gaming headset', 'Active', NOW()),
('LG Odyssey 27in QHD 240Hz', 12, 17, 23, '27in QHD 240Hz', 400.00, 320.00, 15, 'Monitor-LG-Odyssey-27in-QHD-240Hz', '27-inch QHD monitor, 240Hz', 'Active', NOW()),
('LG Odyssey 32in 4K', 12, 17, 23, '32in 4K', 600.00, 480.00, 10, 'Monitor-LG-Odyssey-32in-4K', '32-inch 4K gaming monitor', 'Active', NOW()),
('MSI Optix MPG 27', 12, 4, 24, 'MPG 27', 350.00, 280.00, 20, 'Monitor-MSI-Optix-MPG-27', '27-inch QHD gaming monitor', 'Active', NOW()),
('Secretlab Titan Evo 2022', 13, 18, 25, '2022', 500.00, 400.00, 10, 'Chair-Secretlab-Titan-Evo-2022', 'Ergonomic gaming chair', 'Active', NOW()),
('Secretlab Titan Evo 2024', 13, 18, 25, '2024', 550.00, 440.00, 8, 'Chair-Secretlab-Titan-Evo-2024', 'Updated ergonomic chair', 'Active', NOW()),
('Herman Miller Sayl', 13, 19, 26, 'Standard', 600.00, 480.00, 5, 'Chair-Herman-Miller-Sayl', 'Minimalist ergonomic chair', 'Active', NOW()),
('IKEA UPPSTÅ Standard', 14, 20, 27, 'Standard', 200.00, 160.00, 30, 'Desk-IKEA-UPPSTÅ-Standard', 'Adjustable height desk', 'Active', NOW()),
('IKEA UPPSTÅ Height-Adjustable', 14, 20, 27, 'Height-Adjustable', 300.00, 240.00, 25, 'Desk-IKEA-UPPSTÅ-Height-Adjustable', 'Motorized standing desk', 'Active', NOW()),
('IKEA LAGKAPTEN 120x60', 14, 20, 28, 'Standard 120x60', 150.00, 120.00, 40, 'Desk-IKEA-LAGKAPTEN-120x60', 'Compact desk for small spaces', 'Active', NOW());

INSERT INTO `user` (user_id, username, password, email, role, status, is_verified, verification_token) VALUES
(1, 'staff01', 'hashedpassword1', 'staff01@example.com', 'Staff', 'Active', 1, NULL),
(2, 'admin01', 'hashedpassword2', 'admin01@example.com', 'Admin', 'Active', 1, NULL);

INSERT INTO `customer` (customer_id, name, email, password, phone, shipping_address, is_verified, verification_token) VALUES
(1, 'Lê Thị Khách Hàng', 'customer01@example.com', 'hashedpassword3', '0909988776', '123 Đường ABC, Quận 1, TP.HCM', 1, NULL),
(2, 'NguyenVanGiap', 'giapThieuNang@gmail.com', 'cesvg2810A!', '0994885738', 'KhongBietHoiLamVL', 0, NULL),
(3, 'Phạm Đức Trọng', 'trongpdhe181640@fpt.edu.vn', '$2a$10$iC2jTTQm8GSE5ni9iURIouVE.c/qVXK8PKSshKj7HjAb/Ie5r5Tea', '0559868660', 'ChauPhong-LienHa-DongAnh-HaNoi', 1, NULL),
(4, 'huy', 'huy69332@gmail.com', '$2a$10$cVf/WsqcXPyEOtyJo/fnAeCLD4079ARM8qRdzv3OIrPWohIA9ELF.', '0987565443', NULL, 1, NULL);

INSERT INTO `staff` (staff_id, user_id, name, phone, enter_date, leave_date) VALUES
(1, 1, 'Nguyễn Văn Nhân viên', '0901123456', '2024-01-01', NULL);

INSERT INTO `admin` (admin_id, user_id, name) VALUES
(1, 2, 'Trần Thị Quản Trị');

INSERT INTO `paymentmethod` (payment_method_id, method_name, description, status) VALUES
(1, 'Cash', 'Tiền mặt', 'Active'),
(2, 'Transfer', 'Chuyển khoản', 'Active');

INSERT INTO `orders` (order_id, customer_id, order_date, total_amount, shipping_address, shipping_fee, status, payment_method_id) VALUES
(1, 1, NOW(), 10000000, 'Hanoi', 20000, 'Pending', 1),
(2, 2, '2024-06-21 09:00:00', 32100000, 'KhongBietHoiLamVL', 10000, 'Pending', 1);

INSERT INTO `orderdetail` (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 4000000),
(2, 1, 8, 1, 9000000),
(3, 2, 1, 1, 4000000),
(4, 2, 8, 1, 9000000),
(5, 2, 19, 2, 1500000);

INSERT INTO `voucher` (voucher_id, code, description, discount_type, discount_value, min_order_amount, max_uses, max_uses_per_user, start_date, end_date, status) VALUES
(1, 'WELCOME10', '10% off for new users', 'percent', 10.00, 100000, 100, 1, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 'Active'),
(2, 'SUMMER50', '50,000 VND off orders over 500,000 VND', 'fixed', 50000.00, 500000, 50, 2, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Active'),
(3, 'FREEMOUSE', 'Mua bất kỳ bộ PC nào trong tháng này, nhận ngay chuột gaming trị giá 500.000đ. Số lượng có hạn!', 'fixed', 500000, 0, 50, 1, '2024-06-01 00:00:00', '2024-06-30 23:59:59', 'Active');

INSERT INTO `voucher_usage` (usage_id, voucher_id, customer_id, order_id, used_at) VALUES
(1, 1, 1, 1, NOW()),
(2, 1, 3, NULL, '2024-06-21 10:00:00'),
(3, 2, 2, NULL, '2024-06-22 11:00:00');

INSERT INTO `cartitem` (cart_item_id, customer_id, product_id, quantity) VALUES
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

INSERT INTO `transactions` (transaction_id, transaction_code, order_id, payment_method_id, total_amount, created_at, paid) VALUES
(1, 'TXN001', 1, 1, 10000000, NOW(), FALSE),
(2, 'TXN002', 2, 1, 32100000, NOW(), FALSE);

INSERT INTO `menu_item` (menu_item_id, name, icon, url, parent_id, status) VALUES
(1, 'Sản phẩm', 'fas fa-laptop', '/products', NULL, 'Activate'),
(2, 'Danh mục', 'fas fa-th-large', '/categories', NULL, 'Activate'),
(3, 'Quản lý', 'fas fa-cogs', '/admin', NULL, 'Activate'),
(4, 'CPU', 'fas fa-microchip', '/products/cpu', 1, 'Activate'),
(5, 'GPU', 'fas fa-tv', '/products/gpu', 1, 'Activate'),
(6, 'RAM', 'fas fa-memory', '/products/ram', 1, 'Activate'),
(7, 'Build PC', 'fas fa-desktop', '/PCBuilderServlet', NULL, 'Activate');

INSERT INTO `menu_attribute` (attribute_id, menu_item_id, name, url, status) VALUES
(1, 1, 'Tất cả sản phẩm', '/products/all', 'Activate'),
(2, 1, 'Sản phẩm mới', '/products/new', 'Activate'),
(3, 1, 'Khuyến mãi', '/products/sale', 'Activate'),
(4, 2, 'Theo thương hiệu', '/categories/brand', 'Activate'),
(5, 2, 'Theo giá', '/categories/price', 'Activate'),
(6, 3, 'Dashboard', '/admin/dashboard', 'Activate'),
(7, 3, 'Cài đặt', '/admin/settings', 'Activate');

INSERT INTO `menu_attribute_value` (value_id, attribute_id, value, url, status) VALUES
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

INSERT INTO `blog` (title, content, user_id, created_at) VALUES
('Welcome to the PC Store', 'This is our first blog post by staff.', 1, NOW()),
('Admin Announcement', 'This is an announcement from the admin.', 2, NOW());

-- Update user table to add Shipper role
ALTER TABLE `user`
MODIFY COLUMN `role` ENUM('Staff', 'Admin', 'Shipper') NOT NULL;

-- Insert a new user with Shipper role
INSERT INTO `user` (username, password, email, role, status, is_verified, verification_token)
VALUES ('shipper01', 'hashedpassword3', 'shipper01@example.com', 'Shipper', 'Active', 1, NULL);

-- Insert corresponding shipper information
INSERT INTO `shipper` (name, phone, email, status)
VALUES ('Nguyễn Văn Shipper', '0901234567', 'shipper01@example.com', 'Active');

-- Insert product images
INSERT INTO `productimage` (product_id, image_url, alt_text, is_primary)
SELECT p.product_id, 'IMG/product/cpu1.jpg', p.name, TRUE
FROM product p
JOIN componenttype ct ON p.component_type_id = ct.type_id
WHERE ct.name = 'CPU';

INSERT INTO `productimage` (product_id, image_url, alt_text, is_primary)
SELECT p.product_id, 'IMG/product/gpu1.jpg', p.name, TRUE
FROM product p
JOIN componenttype ct ON p.component_type_id = ct.type_id
WHERE ct.name = 'GPU';

INSERT INTO `productimage` (product_id, image_url, alt_text, is_primary)
SELECT p.product_id, 'IMG/product/ram1.jpg', p.name, TRUE
FROM product p
JOIN componenttype ct ON p.component_type_id = ct.type_id
WHERE ct.name = 'RAM';

ALTER TABLE `customer` 
ADD COLUMN `gender` ENUM('Male', 'Female', 'Other') DEFAULT NULL AFTER `shipping_address`,
ADD COLUMN `date_of_birth` DATE DEFAULT NULL AFTER `gender`;

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

