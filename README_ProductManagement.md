# Hướng dẫn sử dụng trang Quản lý Sản phẩm mới

## Tổng quan
Đã tạo trang quản lý sản phẩm mới sử dụng DataTable thay vì modal popup để giải quyết vấn đề tải lên sản phẩm.

## Các file đã tạo/cập nhật

### 1. `web/productManagement.jsp`
- Trang quản lý sản phẩm chính với DataTable
- Giao diện hiện đại với Bootstrap 5
- Tính năng upload Excel với drag & drop
- Preview dữ liệu trước khi upload
- Responsive design

### 2. `web/testProductManagement.jsp`
- Trang test đơn giản để kiểm tra DataTable
- Không có tính năng upload, chỉ hiển thị danh sách sản phẩm

### 3. `src/java/controller/ProductImportServlet.java`
- Cập nhật để trả về JSON response thay vì HTML
- Hỗ trợ AJAX upload từ trang mới

### 4. `src/java/controller/ProductServlet.java`
- Thêm case "productManagement" để xử lý trang mới

## Cách sử dụng

### Truy cập trang quản lý sản phẩm:
```
http://localhost:8080/your-project/productservlet?service=productManagement
```

### Truy cập trang test:
```
http://localhost:8080/your-project/testProductManagement.jsp
```

## Tính năng chính

### 1. DataTable với các tính năng:
- Tìm kiếm sản phẩm
- Phân trang
- Sắp xếp theo cột
- Hiển thị số lượng sản phẩm tùy chọn (5, 10, 25, 50)

### 2. Upload Excel:
- Drag & drop file Excel
- Click để chọn file
- Preview dữ liệu trước khi upload
- Hiển thị loading spinner khi đang xử lý
- Thông báo kết quả upload

### 3. Quản lý sản phẩm:
- Nút Edit: Chuyển đến trang chỉnh sửa sản phẩm
- Nút Delete: Xác nhận và xóa sản phẩm
- Hiển thị trạng thái sản phẩm với badge màu

## Cấu trúc Excel file
File Excel cần có các cột theo thứ tự:
1. Name
2. Brand  
3. Component Type
4. Model
5. Price
6. Import Price
7. Stock
8. SKU
9. Description

## Lưu ý quan trọng

1. **Thư viện cần thiết**: Đảm bảo các thư viện sau đã có trong project:
   - gson-2.10.1.jar (đã có)
   - jakarta.servlet-api-4.0.4.jar (đã có)
   - poi-5.2.3.jar (đã có)

2. **Cấu hình web.xml**: Không cần thay đổi vì đã sử dụng annotation @WebServlet

3. **Database**: Đảm bảo database có các bảng cần thiết cho ProductDAO

## Khắc phục sự cố

### Nếu có lỗi import Jakarta:
- Kiểm tra classpath có đúng thư viện Jakarta không
- Restart IDE nếu cần

### Nếu DataTable không hoạt động:
- Kiểm tra kết nối internet để load CDN
- Kiểm tra console browser có lỗi JavaScript không

### Nếu upload Excel không hoạt động:
- Kiểm tra định dạng file Excel (.xlsx, .xls)
- Kiểm tra cấu trúc dữ liệu trong file
- Xem log server để debug

## So sánh với trang cũ

| Tính năng | Trang cũ (viewProduct.jsp) | Trang mới (productManagement.jsp) |
|-----------|---------------------------|-----------------------------------|
| Hiển thị | Modal popup | DataTable trực tiếp |
| Upload | Modal với form | Section riêng biệt |
| Responsive | Hạn chế | Tốt hơn |
| UX | Phức tạp | Đơn giản, trực quan |
| Performance | Chậm với modal | Nhanh hơn |

## Kết luận
Trang quản lý sản phẩm mới giải quyết vấn đề modal popup không thích hợp với AJAX bằng cách sử dụng DataTable hiện đại, giao diện đẹp và trải nghiệm người dùng tốt hơn. 