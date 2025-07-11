# Cập nhật thêm trường Gender và Date of Birth

## Tổng quan
Đã thêm hai trường mới vào hệ thống đăng ký user:
- **Gender**: Giới tính (Male, Female, Other)
- **Date of Birth**: Ngày sinh

## Các thay đổi đã thực hiện

### 1. Database Schema
- **MySQL**: Cập nhật bảng `customer` trong `database/schema/create_tables.sql`
- **SQL Server**: Cập nhật bảng `customer` trong `database/schema/create_tables_sqlserver.sql`
- Tạo file `database/schema/update_customer_table.sql` để cập nhật database hiện tại

### 2. Model Classes
- **Customer.java**: Thêm trường `gender` (String) và `dateOfBirth` (Date)
- **shop/entities/Customer.java**: Thêm trường `gender` và `dateOfBirth` với annotation

### 3. Data Access Layer
- **CustomerDAO.java**: 
  - Cập nhật method `addCustomerWithEmail()` để lưu gender và dateOfBirth
  - Cập nhật method `login()`, `getCustomerByEmail()`, `getAllCustomers()` để đọc gender và dateOfBirth
  - Thêm method `updateCustomerInfoWithGenderAndDOB()` để cập nhật thông tin với gender và dateOfBirth

### 4. Controller
- **RegisterServlet.java**: 
  - Thêm xử lý parameter `gender` và `dateOfBirth`
  - Parse date string thành Date object
  - Validation cho date format

### 5. Frontend
- **Register.jsp**: 
  - Thêm dropdown cho Gender với 3 options: Male, Female, Other
  - Thêm input type="date" cho Date of Birth
  - Thêm validation JavaScript cho gender và dateOfBirth
  - Validation tuổi tối thiểu 13 tuổi và tối đa 120 tuổi

## Validation Rules

### Gender
- Bắt buộc chọn một trong ba options: Male, Female, Other
- Không được để trống

### Date of Birth
- Bắt buộc nhập
- Định dạng: yyyy-MM-dd
- Tuổi tối thiểu: 13 tuổi
- Tuổi tối đa: 120 tuổi
- Phải là ngày trong quá khứ

## Cách sử dụng

### 1. Cập nhật Database
Chạy script SQL để thêm cột mới:
```sql
-- MySQL
ALTER TABLE `customer` 
ADD COLUMN `gender` ENUM('Male', 'Female', 'Other') DEFAULT NULL AFTER `shipping_address`,
ADD COLUMN `date_of_birth` DATE DEFAULT NULL AFTER `gender`;

-- SQL Server
ALTER TABLE customer 
ADD gender NVARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
ADD date_of_birth DATE;
```

### 2. Test đăng ký
1. Truy cập trang đăng ký
2. Điền đầy đủ thông tin bao gồm Gender và Date of Birth
3. Kiểm tra validation hoạt động đúng
4. Kiểm tra dữ liệu được lưu vào database

## Lưu ý
- Các trường mới là optional trong database (có thể NULL) để tương thích với dữ liệu cũ
- Validation được thực hiện ở cả client-side và server-side
- Date format sử dụng ISO format (yyyy-MM-dd) để tương thích với HTML5 date input 