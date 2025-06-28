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

-- Dữ liệu cho bảng product
INSERT INTO `product` VALUES 
    (1,'Intel Core i5-12400F',1,1,180.00,150.00,50,'6-core, 12-thread, LGA1700','Active','2025-06-20 09:18:08'),
    (2,'Intel Core i7-13700K',1,1,420.00,370.00,30,'16-core, 24-thread, LGA1700','Active','2025-06-20 09:18:08'),
    (3,'AMD Ryzen 5 5600X',1,2,200.00,170.00,40,'6-core, 12-thread, AM4','Active','2025-06-20 09:18:08'),
    (4,'AMD Ryzen 7 5800X',1,2,310.00,270.00,25,'8-core, 16-thread, AM4','Active','2025-06-20 09:18:08'),
    (5,'Intel Core i9-13900K',1,1,600.00,520.00,10,'24-core, 32-thread, LGA1700','Active','2025-06-20 09:18:08'),
    (6,'NVIDIA RTX 3060 12GB',2,3,350.00,300.00,20,'12GB GDDR6, Ray Tracing','Active','2025-06-20 09:18:08'),
    (7,'NVIDIA RTX 4070 12GB',2,3,620.00,550.00,15,'12GB GDDR6X, DLSS 3','Active','2025-06-20 09:18:08'),
    (8,'ASUS RTX 4060 Ti Dual',2,4,480.00,420.00,18,'8GB GDDR6, Dual Fan','Active','2025-06-20 09:18:08'),
    (9,'AMD Radeon RX 6700 XT',2,2,400.00,350.00,12,'12GB GDDR6','Active','2025-06-20 09:18:08'),
    (10,'NVIDIA RTX 3080 10GB',2,3,850.00,780.00,8,'10GB GDDR6X, High-end gaming','Active','2025-06-20 09:18:08'),
    (11,'ASUS ROG Strix Z790-A',3,4,300.00,260.00,12,'LGA1700, DDR5, ATX','Active','2025-06-20 09:18:08'),
    (12,'ASUS TUF B550-Plus',3,4,160.00,130.00,20,'AM4, DDR4, ATX','Active','2025-06-20 09:18:08'),
    (13,'MSI MAG B660M Mortar',3,4,180.00,150.00,25,'LGA1700, DDR4, mATX','Active','2025-06-20 09:18:08'),
    (14,'Gigabyte B660 DS3H',3,4,140.00,110.00,18,'LGA1700, DDR4, ATX','Active','2025-06-20 09:18:08'),
    (15,'ASUS PRIME A320M-K',3,4,80.00,60.00,30,'AM4, DDR4, mATX','Active','2025-06-20 09:18:08'),
    (16,'Corsair Vengeance LPX 8GB DDR4',4,5,45.00,35.00,100,'8GB DDR4 3200MHz','Active','2025-06-20 09:18:08'),
    (17,'Corsair Vengeance LPX 16GB DDR4',4,5,80.00,65.00,80,'16GB DDR4 3200MHz','Active','2025-06-20 09:18:08'),
    (18,'G.Skill Trident Z RGB 16GB',4,5,95.00,80.00,60,'16GB DDR4 3600MHz','Active','2025-06-20 09:18:08'),
    (19,'Kingston Fury Beast 8GB DDR4',4,5,42.00,32.00,90,'8GB DDR4 3200MHz','Active','2025-06-20 09:18:08'),
    (20,'Corsair Dominator Platinum 32GB',4,5,180.00,150.00,40,'32GB DDR5 5200MHz','Active','2025-06-20 09:18:08');
-- Dữ liệu cho bảng staff
INSERT INTO `staff` VALUES 
    (1,1,'Nguyễn Văn Nhân viên','0901123456','2024-01-01',NULL);

-- Dữ liệu cho bảng user
INSERT INTO `user` VALUES 
    (1,'staff01','hashedpassword1','staff01@example.com','Staff','Active',1,NULL),
    (2,'admin01','hashedpassword2','admin01@example.com','Admin','Active',1,NULL);

-- Dữ liệu cho bảng voucher
INSERT INTO `voucher` (`voucher_id`, `code`, `description`, `discount_type`, `discount_value`, `min_order_amount`, `max_uses`, `max_uses_per_user`, `start_date`, `end_date`, `status`) VALUES
    (1, 'WELCOME10', '10% off for new users', 'percent', 10.00, 100.00, 100, 1, '2024-06-01 00:00:00', '2024-12-31 23:59:59', 'Active'),
    (2, 'SUMMER50', '50,000 VND off orders over 500,000 VND', 'fixed', 50000.00, 500000.00, 50, 2, '2024-06-01 00:00:00', '2024-08-31 23:59:59', 'Active'),
    (3, 'FREEMOUSE', 'Mua bất kỳ bộ PC nào trong tháng này, nhận ngay chuột gaming trị giá 500.000đ. Số lượng có hạn!', 'fixed', 500000, 0, 50, 1, '2024-06-01 00:00:00', '2024-06-30 23:59:59', 'Active');

-- Dữ liệu cho bảng voucher_usage
INSERT INTO `voucher_usage` (`usage_id`, `voucher_id`, `customer_id`, `order_id`, `used_at`) VALUES
    (1, 1, 3, NULL, '2024-06-21 10:00:00'),
    (2, 2, 2, NULL, '2024-06-22 11:00:00'); 
-- Dữ liệu cho bảng cartitem
INSERT INTO `cartitem` VALUES 
    (1,2,2,1),
    (2,2,5,1),
    (3,2,3,1),
    (4,2,18,1),
    (5,2,19,1),
    (6,2,20,1),
    (7,2,17,1),
    (8,2,8,1),
    (9,2,9,1); 