USE project_g2;

-- Dữ liệu cho bảng brand
INSERT INTO `brand` VALUES 
    (1,'Intel'),
    (2,'AMD'),
    (3,'NVIDIA'),
    (4,'ASUS'),
    (5,'Corsair');

-- Dữ liệu cho bảng componenttype
INSERT INTO `componenttype` VALUES 
    (1,'CPU','Central Processing Unit'),
    (2,'GPU','Graphics Processing Unit'),
    (3,'Mainboard','Mainboard'),
    (4,'RAM','Random Access Memory'),
    (6,'USB','Universal Serial Bus'),
    (7,'dsadsad','sadsadasd'),
    (8,'rửeqqwfcdsa','fdsaf'),
    (9,'dsaaaaaaaaaaaaaaaaaaaaaaaaaaadsadsadsadsadsadddd','ewqqqqqqqqqwfdsffffffffffffffdsadasdasdsadsadsacdsadsadsadsadsadsadddsaewqqqqqqqqqwfdsffffffffffffffdsadasdasdsadsadsacdsadsadsadsadsadsadddsaewqqqqqqqqqwfdsffffffffffffffdsadasdasdsadsadsacdsadsadsadsadsadsadddsaewqqqqqqqqqwfdsffffffffffffffdsadasdasdsad');

-- Dữ liệu cho bảng paymentmethod
INSERT INTO paymentmethod(method_name, description)
VALUES
    ('Cash','Tiền mặt'),
    ('Transfer','Chuyển khoản');

-- Dữ liệu cho bảng user
INSERT INTO `user` VALUES 
    (1,'staff01','hashedpassword1','staff01@example.com','Staff','Active',1,NULL),
    (2,'admin01','hashedpassword2','admin01@example.com','Admin','Active',1,NULL);

-- Dữ liệu cho bảng customer
INSERT INTO `customer` VALUES 
    (1,'Lê Thị Khách Hàng','customer01@example.com','hashedpassword3','0909988776','123 Đường ABC, Quận 1, TP.HCM',0,NULL),
    (3,'Phạm Đức Trọng','trongpdhe181640@fpt.edu.vn','$2a$10$iC2jTTQm8GSE5ni9iURIouVE.c/qVXK8PKSshKj7HjAb/Ie5r5Tea','0559868660','ChauPhong-LienHa-DongAnh-HaNoi',1,NULL);

-- Dữ liệu cho bảng staff
INSERT INTO `staff` VALUES 
    (1,1,'Nguyễn Văn Nhân viên','0901123456','2024-01-01',NULL);

-- Dữ liệu cho bảng admin
INSERT INTO `admin` VALUES 
    (1,2,'Trần Thị Quản Trị');

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

-- Dữ liệu cho bảng cartitem
INSERT INTO `cartitem` VALUES 
    (1,1,2,1),
    (2,1,5,1),
    (3,1,3,1),
    (4,1,18,1),
    (5,1,19,1),
    (6,1,20,1),
    (7,1,17,1),
    (8,1,8,1),
    (9,1,9,1); 