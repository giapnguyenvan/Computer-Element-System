# Hướng dẫn sử dụng tính năng Blog với ảnh

## 📋 Tổng quan

Tính năng blog với ảnh cho phép người dùng:
- Tạo blog với nhiều ảnh
- Hiển thị ảnh trong blog cards
- Upload ảnh khi tạo blog mới
- Xem gallery ảnh trong modal

## 🗄️ Cấu trúc Database

### Bảng mới được tạo:

#### 1. Bảng `blog_image`
```sql
CREATE TABLE `blog_image` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `image_alt` varchar(255) DEFAULT NULL,
  `display_order` int DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `fk_blog_image_blog` (`blog_id`),
  CONSTRAINT `fk_blog_image_blog` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE CASCADE
);
```

## 📁 Các file đã được tạo/cập nhật

### Models:
- `src/java/model/BlogImage.java` - Model cho ảnh blog
- `src/java/model/Blog.java` - Cập nhật để hỗ trợ danh sách ảnh

### DAOs:
- `src/java/dal/BlogImageDAO.java` - DAO cho thao tác với ảnh blog
- `src/java/dal/BlogDAO.java` - Cập nhật để hỗ trợ ảnh

### Controllers:
- `src/java/controller/ViewBlogServlet.java` - Cập nhật để xử lý upload ảnh
- `src/java/controller/BlogTestServlet.java` - Servlet test tính năng

### Views:
- `web/blog-test.jsp` - JSP test hiển thị blog với ảnh

## 🚀 Cách sử dụng

### 1. Tạo blog với ảnh

```java
// Tạo blog mới
Blog blog = new Blog(0, "Tiêu đề blog", "Nội dung blog", customerId, null);

// Thêm ảnh vào blog
BlogImage image1 = new BlogImage(0, 0, "/uploads/blog/image1.jpg", "Mô tả ảnh 1", 1, null);
BlogImage image2 = new BlogImage(0, 0, "/uploads/blog/image2.jpg", "Mô tả ảnh 2", 2, null);

blog.addImage(image1);
blog.addImage(image2);

// Lưu blog vào database
int blogId = blogDAO.insertBlog(blog);
```

### 2. Lấy blog với ảnh

```java
// Lấy tất cả blog với ảnh
Vector<Blog> blogs = blogDAO.getAllBlogs(1, 10);

// Lấy blog theo ID với ảnh
Blog blog = blogDAO.getBlogById(blogId);

// Truy cập ảnh của blog
List<BlogImage> images = blog.getImages();
for (BlogImage image : images) {
    System.out.println("Image URL: " + image.getImage_url());
    System.out.println("Image Alt: " + image.getImage_alt());
}
```

### 3. Upload ảnh qua form

```html
<form action="viewblogs" method="POST" enctype="multipart/form-data">
    <input type="text" name="title" placeholder="Blog title" required>
    <textarea name="content" placeholder="Blog content" required></textarea>
    <input type="file" name="images" multiple accept="image/*">
    <input type="hidden" name="action" value="add">
    <button type="submit">Create Blog</button>
</form>
```

## 🎨 Hiển thị trong JSP

### 1. Hiển thị ảnh chính trong blog card

```jsp
<c:choose>
    <c:when test="${not empty blog.images and blog.images.size() > 0}">
        <img src="${blog.images[0].image_url}" alt="${blog.images[0].image_alt}" class="blog-image">
    </c:when>
    <c:otherwise>
        <div class="blog-image-placeholder">
            <i class="fas fa-image fa-2x"></i>
        </div>
    </c:otherwise>
</c:choose>
```

### 2. Hiển thị gallery ảnh

```jsp
<c:if test="${not empty blog.images and blog.images.size() > 1}">
    <div class="image-gallery">
        <c:forEach items="${blog.images}" var="image" varStatus="status">
            <c:if test="${status.index > 0}">
                <img src="${image.image_url}" alt="${image.image_alt}" class="gallery-image">
            </c:if>
        </c:forEach>
    </div>
</c:if>
```

## 🔧 Cấu hình

### 1. MultipartConfig trong Servlet

```java
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
```

### 2. Thư mục upload

Mặc định ảnh sẽ được lưu trong: `web/uploads/blog/`

## 📝 API Methods

### BlogImageDAO
- `getImagesByBlogId(int blogId)` - Lấy tất cả ảnh của một blog
- `insertImage(BlogImage image)` - Thêm ảnh mới
- `updateImage(BlogImage image)` - Cập nhật ảnh
- `deleteImage(int imageId)` - Xóa ảnh
- `deleteImagesByBlogId(int blogId)` - Xóa tất cả ảnh của blog

### BlogDAO (cập nhật)
- `getAllBlogs(int page, int pageSize)` - Lấy blog với ảnh
- `getBlogById(int blogId)` - Lấy blog theo ID với ảnh
- `insertBlog(Blog blog)` - Tạo blog với ảnh
- `updateBlog(Blog blog)` - Cập nhật blog với ảnh

## 🎯 Tính năng chính

1. **Upload nhiều ảnh**: Hỗ trợ drag & drop và chọn file
2. **Hiển thị ảnh chính**: Ảnh đầu tiên hiển thị trong card
3. **Gallery ảnh**: Hiển thị các ảnh còn lại
4. **Alt text**: Hỗ trợ SEO và accessibility
5. **Thứ tự hiển thị**: Có thể sắp xếp thứ tự ảnh
6. **Responsive**: Hiển thị tốt trên mobile

## 🧪 Test

Để test tính năng:

1. Chạy script SQL để tạo bảng `blog_image`
2. Truy cập `/blog-test` để xem demo
3. Tạo blog mới với ảnh qua form
4. Kiểm tra hiển thị ảnh trong blog cards

## ⚠️ Lưu ý

1. Đảm bảo thư mục upload có quyền ghi
2. Kiểm tra kích thước file upload
3. Validate định dạng ảnh (jpg, png, gif)
4. Xử lý lỗi khi upload thất bại
5. Backup ảnh trước khi xóa blog

## 🔄 Cập nhật tiếp theo

- [ ] Thêm tính năng edit ảnh
- [ ] Thêm watermark cho ảnh
- [ ] Tối ưu hóa ảnh (resize, compress)
- [ ] Thêm CDN cho ảnh
- [ ] Thêm lazy loading cho ảnh 