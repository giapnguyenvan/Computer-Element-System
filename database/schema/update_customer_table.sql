-- Update customer table to add gender and date_of_birth columns
-- For MySQL

ALTER TABLE `customer` 
ADD COLUMN `gender` ENUM('Male', 'Female', 'Other') DEFAULT NULL AFTER `shipping_address`,
ADD COLUMN `date_of_birth` DATE DEFAULT NULL AFTER `gender`;

-- For SQL Server (uncomment if using SQL Server)
/*
ALTER TABLE customer 
ADD gender NVARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
ADD date_of_birth DATE;
*/ 