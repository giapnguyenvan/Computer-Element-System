# Trang Chọn Sản phẩm - Tối ưu cho PC Builder

## Tổng quan
Đã tối ưu trang `productManagement.jsp` để chỉ tập trung vào việc chọn sản phẩm cho PC Builder, loại bỏ các tính năng không cần thiết như upload Excel và add product.

## Các thay đổi đã thực hiện

### ✅ **Đã loại bỏ:**
- **Upload Excel section**: Toàn bộ phần upload file Excel
- **Add Product button**: Nút thêm sản phẩm mới
- **Upload JavaScript functions**: Các hàm xử lý upload
- **XLSX library**: Thư viện không cần thiết
- **Upload CSS styles**: Styles cho upload section
- **Alert messages**: Hệ thống thông báo upload

### ✅ **Đã cải tiến:**
- **Title**: Đổi từ "Product Management" thành "Select Product"
- **Header**: Hiển thị loại linh kiện đang chọn (CPU, GPU, etc.)
- **Info alert**: Thông báo hướng dẫn người dùng
- **DataTable config**: 
  - Sắp xếp theo giá tăng dần (rẻ nhất trước)
  - Tăng số lượng sản phẩm hiển thị (15 thay vì 10)
  - Tối ưu cho việc chọn sản phẩm

### ✅ **Giữ nguyên:**
- **DataTable functionality**: Tìm kiếm, phân trang, sắp xếp
- **Select button**: Nút chọn sản phẩm (✓)
- **Product information**: Hiển thị đầy đủ thông tin sản phẩm
- **Parent communication**: Giao tiếp với PC Builder

## Giao diện mới

### Header Card:
```
┌─────────────────────────────────────────────────────────┐
│ 📦 Select Product                    [CPU] [GPU] [RAM] │
└─────────────────────────────────────────────────────────┘
```

### Info Alert (khi có componentType):
```
ℹ️ Selecting products for CPU. Click the ✓ button to choose a product.
```

### DataTable với nút Select:
```
┌─────┬─────────┬──────────────┬────────┬─────────┬────────┬──────┬────────┬─────────┐
│ ID  │ Image   │ Name         │ Brand  │ Category│ Price  │Stock │ Status │ Actions │
├─────┼─────────┼──────────────┼────────┼─────────┼────────┼──────┼────────┼─────────┤
│ 1   │ [IMG]   │ Intel i7     │ Intel  │ CPU     │ $299   │ 50   │ Active │ [✏️] [🗑️] [✓] │
│ 2   │ [IMG]   │ AMD Ryzen 5  │ AMD    │ CPU     │ $199   │ 30   │ Active │ [✏️] [🗑️] [✓] │
└─────┴─────────┴──────────────┴────────┴─────────┴────────┴──────┴────────┴─────────┘
```

## Cách sử dụng

### 1. Từ PC Builder:
```javascript
// Khi click "Select CPU"
function selectComponent('CPU') {
    const iframe = document.getElementById('viewProductIframe');
    iframe.src = 'productservlet?service=productManagement&componentType=CPU';
}
```

### 2. Trong modal:
- Người dùng thấy danh sách sản phẩm sắp xếp theo giá
- Có thể tìm kiếm, phân trang, sắp xếp
- Click nút ✓ để chọn sản phẩm

### 3. Khi chọn sản phẩm:
```javascript
// Trong iframe
$('#productsTable').on('click', '.select-product', function() {
    const productId = $(this).data('product-id');
    const productName = $(this).data('product-name');
    const productPrice = $(this).data('product-price');
    
    // Gọi hàm từ parent window
    window.parent.selectComponentFromIframe(productId, productName, productPrice, componentType);
});
```

## Lợi ích của tối ưu này

### 🚀 **Performance:**
- Giảm kích thước file (bỏ ~200 dòng code không cần thiết)
- Giảm thời gian load (bỏ XLSX library)
- Tập trung vào chức năng chính

### 🎯 **UX/UI:**
- Giao diện đơn giản, rõ ràng
- Hướng dẫn người dùng rõ ràng
- Sắp xếp theo giá giúp dễ chọn
- Hiển thị loại linh kiện đang chọn

### 🔧 **Maintenance:**
- Code đơn giản hơn, dễ maintain
- Ít dependencies
- Tập trung vào một chức năng duy nhất

## Test

### 1. Test trực tiếp:
```
http://localhost:8080/your-project/productservlet?service=productManagement&componentType=CPU
```

### 2. Test từ PC Builder:
```
http://localhost:8080/your-project/pcBuilder.jsp
```
Sau đó click "Select CPU" hoặc component khác

## Kết luận
Trang chọn sản phẩm đã được tối ưu hoàn toàn cho mục đích PC Builder, loại bỏ các tính năng không cần thiết và tập trung vào trải nghiệm chọn sản phẩm tốt nhất. 