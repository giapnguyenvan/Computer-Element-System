# Cập nhật PC Builder với Modal Product Management

## Tổng quan
Đã cập nhật PC Builder để sử dụng trang `productManagement.jsp` trong modal thay vì DataTable trực tiếp.

## Các thay đổi đã thực hiện

### 1. Cập nhật `web/pcBuilder.jsp`
- **Modal content**: Thay đổi từ DataTable trực tiếp sang iframe
- **JavaScript**: Thêm hàm `selectComponentFromIframe()` để xử lý chọn sản phẩm
- **Progress bar**: Thêm hàm `updateProgressBar()` để cập nhật tiến độ

### 2. Cập nhật `web/productManagement.jsp`
- **Nút Select**: Thêm nút "Chọn" (✓) cho mỗi sản phẩm
- **JavaScript**: Thêm xử lý sự kiện click nút Select
- **Parent communication**: Giao tiếp với parent window để chọn sản phẩm

### 3. Cập nhật `src/java/controller/ProductServlet.java`
- **Parameter handling**: Thêm xử lý parameter `componentType`
- **Attribute passing**: Truyền componentType vào JSP

## Cách hoạt động

### 1. Khi người dùng click "Select CPU" (hoặc component khác):
```javascript
function selectComponent(type) {
    currentComponentType = type;
    $('#viewProductModal').modal('show');
    const iframe = document.getElementById('viewProductIframe');
    iframe.src = `productservlet?service=productManagement&componentType=${type}`;
}
```

### 2. Modal hiển thị trang productManagement.jsp với iframe:
```html
<iframe id="viewProductIframe" src="productservlet?service=productManagement" style="width:100%; height:80vh; border:none;"></iframe>
```

### 3. Khi người dùng click nút "Chọn" trong iframe:
```javascript
$('#productsTable').on('click', '.select-product', function() {
    const productId = $(this).data('product-id');
    const productName = $(this).data('product-name');
    const productPrice = $(this).data('product-price');
    
    // Gọi hàm từ parent window
    if (window.parent && window.parent.selectComponentFromIframe) {
        window.parent.selectComponentFromIframe(productId, productName, productPrice, componentType);
    }
});
```

### 4. Parent window nhận thông tin và cập nhật UI:
```javascript
function selectComponentFromIframe(productId, productName, price, componentType) {
    // Đóng modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('viewProductModal'));
    if (modal) modal.hide();
    
    // Cập nhật UI
    const stepElement = document.getElementById(`step-${componentType.toLowerCase()}`);
    const selectedElement = document.getElementById(`selected-${componentType.toLowerCase()}`);
    if (stepElement && selectedElement) {
        stepElement.classList.add('selected');
        selectedElement.textContent = productName;
        selectedElement.style.color = '#28a745';
    }
    
    // Lưu vào session storage
    const selection = {
        productId: productId,
        productName: productName,
        price: price,
        componentType: componentType
    };
    sessionStorage.setItem(`selected_${componentType}`, JSON.stringify(selection));
    
    // Cập nhật progress bar
    updateProgressBar();
    
    // Hiển thị thông báo
    showNotification(`Đã chọn ${componentType.toUpperCase()}: ${productName}`, 'success');
}
```

## Lợi ích của thay đổi này

### ✅ **Trước đây (DataTable trực tiếp):**
- Phải tạo API riêng để lấy dữ liệu
- Khó xử lý phân trang, tìm kiếm
- Giao diện hạn chế
- Khó maintain

### ✅ **Bây giờ (iframe với productManagement.jsp):**
- Tận dụng toàn bộ tính năng của DataTable
- Có sẵn tìm kiếm, phân trang, sắp xếp
- Giao diện đẹp và responsive
- Dễ maintain và mở rộng
- Tái sử dụng code hiệu quả

## Test

### 1. Test trang chính:
```
http://localhost:8080/your-project/pcBuilder.jsp
```

### 2. Test modal riêng:
```
http://localhost:8080/your-project/testPCBuilderModal.jsp
```

### 3. Test trang productManagement trực tiếp:
```
http://localhost:8080/your-project/productservlet?service=productManagement&componentType=CPU
```

## Troubleshooting

### Nếu modal không hiển thị:
1. Kiểm tra console browser có lỗi JavaScript không
2. Kiểm tra network tab xem iframe có load được không
3. Kiểm tra URL của iframe có đúng không

### Nếu không chọn được sản phẩm:
1. Kiểm tra parameter componentType có được truyền đúng không
2. Kiểm tra hàm `selectComponentFromIframe` có được định nghĩa trong parent window không
3. Kiểm tra data attributes của nút Select có đúng không

### Nếu progress bar không cập nhật:
1. Kiểm tra hàm `updateProgressBar()` có được gọi không
2. Kiểm tra các element ID có đúng không
3. Kiểm tra session storage có lưu được không

## Kết luận
Thay đổi này giúp PC Builder có trải nghiệm người dùng tốt hơn với DataTable đầy đủ tính năng, đồng thời tái sử dụng code hiệu quả từ trang quản lý sản phẩm. 