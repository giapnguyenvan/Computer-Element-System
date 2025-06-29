# Cập nhật chức năng View Detail với ảnh

## 📋 Tổng quan

Chức năng view detail đã được cập nhật để hỗ trợ hiển thị ảnh trong modal. Dưới đây là những thay đổi cần thiết:

## 🔧 Các thay đổi đã thực hiện

### 1. Cập nhật Modal HTML

```html
<!-- Blog Content Modal -->
<div class="modal fade" id="blogContentModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalBlogTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="blog-meta mb-3">
                    <small>
                        <i class="fas fa-user"></i> Author: <span id="modalBlogAuthor"></span><br>
                        <i class="fas fa-calendar"></i> Created: <span id="modalBlogCreated"></span>
                    </small>
                </div>
                
                <!-- Image Gallery Section -->
                <div id="modalBlogImages" class="modal-image-gallery" style="display: none;">
                    <h6>
                        <i class="fas fa-images"></i> Blog Images
                        <span id="modalImageCount" class="modal-image-count"></span>
                    </h6>
                    <div class="image-gallery" id="modalImageGallery">
                        <!-- Images will be loaded here -->
                    </div>
                </div>
                
                <!-- Blog Content -->
                <div class="blog-content-section">
                    <h6><i class="fas fa-file-text"></i> Blog Content</h6>
                    <div id="modalBlogContent" style="white-space: pre-wrap; line-height: 1.6; color: #333;"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
```

### 2. CSS Styles mới

```css
.modal-image-gallery {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
}
.modal-image-gallery h6 {
    margin-bottom: 10px;
    color: #495057;
    font-weight: 600;
}
.modal-image-count {
    background-color: #007bff;
    color: white;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 0.8em;
    margin-left: 10px;
}
.no-images-message {
    text-align: center;
    color: #6c757d;
    font-style: italic;
    padding: 20px;
}
.blog-content-section {
    background-color: #fff;
    border-radius: 8px;
    padding: 15px;
    border: 1px solid #dee2e6;
}
.gallery-image {
    width: 120px;
    height: 80px;
    object-fit: cover;
    border-radius: 5px;
    cursor: pointer;
    transition: transform 0.2s;
    border: 2px solid transparent;
}
.gallery-image:hover {
    transform: scale(1.05);
    border-color: #007bff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}
```

### 3. JavaScript Function cập nhật

```javascript
function showBlogContent(element, title, content, author, created, blogId) {
    document.getElementById('modalBlogTitle').textContent = title;
    document.getElementById('modalBlogContent').textContent = content;
    document.getElementById('modalBlogAuthor').textContent = author;
    document.getElementById('modalBlogCreated').textContent = created;
    
    // Handle images - we'll load them from the server using blogId
    const imagesContainer = document.getElementById('modalBlogImages');
    const imageGallery = document.getElementById('modalImageGallery');
    const imageCount = document.getElementById('modalImageCount');
    
    imagesContainer.style.display = 'none';
    imageGallery.innerHTML = '';
    
    // Load images for this blog
    loadBlogImages(blogId, imageGallery, imageCount, imagesContainer);
    
    new bootstrap.Modal(document.getElementById('blogContentModal')).show();
}

function loadBlogImages(blogId, imageGallery, imageCount, imagesContainer) {
    // Show loading message
    imageGallery.innerHTML = '<div class="no-images-message">Loading images...</div>';
    imagesContainer.style.display = 'block';
    imageCount.textContent = '...';
    
    // Make AJAX call to get images
    fetch(`/api/blog-images?blogId=${blogId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success && data.images.length > 0) {
                imageCount.textContent = data.count;
                imageGallery.innerHTML = '';
                
                data.images.forEach((image, index) => {
                    const imgElement = document.createElement('img');
                    imgElement.src = image.image_url;
                    imgElement.alt = image.image_alt || `Blog image ${index + 1}`;
                    imgElement.className = 'gallery-image';
                    imgElement.title = image.image_alt || `Click to view image ${index + 1}`;
                    imgElement.onclick = () => openImageModal(image.image_url, image.image_alt);
                    imageGallery.appendChild(imgElement);
                });
            } else {
                imageGallery.innerHTML = '<div class="no-images-message">No images available for this blog</div>';
                imageCount.textContent = '0';
            }
        })
        .catch(error => {
            console.error('Error loading images:', error);
            imageGallery.innerHTML = '<div class="no-images-message">Error loading images</div>';
            imageCount.textContent = '0';
        });
}

function openImageModal(imageUrl, imageAlt) {
    // Create a simple image modal
    const modal = document.createElement('div');
    modal.className = 'modal fade';
    modal.innerHTML = `
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Image Preview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <img src="${imageUrl}" class="img-fluid" alt="${imageAlt || 'Blog image'}">
                </div>
            </div>
        </div>
    `;
    document.body.appendChild(modal);
    new bootstrap.Modal(modal).show();
    modal.addEventListener('hidden.bs.modal', () => {
        document.body.removeChild(modal);
    });
}
```

### 4. Cập nhật Blog Card Button

```html
<button type="button" class="btn btn-sm btn-info" 
        onclick="showBlogContent(this, '${fn:escapeXml(blog.title)}', '${fn:escapeXml(blog.content)}', '${fn:escapeXml(customerNames[blog.customer_id])}', '<fmt:formatDate value='${blog.created_at}' pattern='dd/MM/yyyy HH:mm'/>', ${blog.blog_id})">
    <i class="fas fa-eye me-1"></i>View Details
</button>
```

## 🚀 API Endpoint

### GET /api/blog-images?blogId={blogId}

**Response:**
```json
{
    "success": true,
    "blogId": 1,
    "count": 3,
    "images": [
        {
            "image_id": 1,
            "image_url": "/uploads/blog/image1.jpg",
            "image_alt": "Blog image 1",
            "display_order": 1
        },
        {
            "image_id": 2,
            "image_url": "/uploads/blog/image2.jpg",
            "image_alt": "Blog image 2",
            "display_order": 2
        }
    ]
}
```

## 🎯 Tính năng mới

1. **Hiển thị ảnh trong modal**: Gallery ảnh được hiển thị trong modal view detail
2. **Image count**: Hiển thị số lượng ảnh
3. **Click to enlarge**: Click vào ảnh để xem full size
4. **Loading state**: Hiển thị trạng thái loading khi tải ảnh
5. **Error handling**: Xử lý lỗi khi không tải được ảnh
6. **Responsive design**: Gallery ảnh responsive trên mobile

## 📝 Cách sử dụng

1. **Cập nhật file JSP**: Thêm CSS và JavaScript mới
2. **Tạo API endpoint**: Tạo servlet để trả về ảnh theo blog ID
3. **Test functionality**: Kiểm tra hiển thị ảnh trong modal

## ⚠️ Lưu ý

1. Đảm bảo có thư viện Gson để xử lý JSON
2. Kiểm tra đường dẫn ảnh có đúng không
3. Xử lý lỗi khi ảnh không tồn tại
4. Tối ưu hóa kích thước ảnh để load nhanh

## 🔄 Cập nhật tiếp theo

- [ ] Thêm lazy loading cho ảnh
- [ ] Thêm image carousel
- [ ] Thêm zoom functionality
- [ ] Thêm download image feature
- [ ] Thêm image compression 