<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { padding-top: 30px; }
        .admin-content { margin-left: 50px; }
        .product-image { max-width: 100%; border-radius: 8px; }
        .specification-row { margin-bottom: 10px; }
        .btn-add-spec { margin-top: 10px; }
        .alert { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container admin-content mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4">
                    <i class="fas fa-edit"></i> Edit Product
                </h2>
                                
                <form action="${pageContext.request.contextPath}/producteditservlet" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="${product.productId}">
                    
                    <div class="row">
                        <!-- Product Image -->
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Product Image</h5>
                                    <c:if test="${not empty product.imageUrl}">
                                        <img src="${product.imageUrl}" alt="${product.name}" class="product-image mb-3">
                                    </c:if>
                                    <div class="mb-3">
                                        <label for="imageFile" class="form-label">Upload Image (JPG/PNG only)</label>
                                        <input type="file" class="form-control" id="imageFile" name="imageFile" accept=".jpg,.jpeg,.png">
                                        <div id="selectedImageName" class="form-text"></div>
                                        <input type="hidden" id="imageUrl" name="imageUrl" value="${product.imageUrl}">
                                        <img id="imagePreview" src="${product.imageUrl}" alt="Product Image" class="product-image mb-3" style="display:none; max-width: 100%; border-radius: 8px;"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Product Information -->
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Product Information</h5>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="name" class="form-label">Product Name *</label>
                                                <input type="text" class="form-control" id="name" name="name" 
                                                       value="${product.name}" required maxlength="30">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="sku" class="form-label">SKU *</label>
                                                <input type="text" class="form-control" id="sku" name="sku" 
                                                       value="${product.sku}" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="brandId" class="form-label">Brand *</label>
                                                <select class="form-select" id="brandId" name="brandId" required>
                                                    <option value="">Select Brand</option>
                                                    <c:forEach items="${brands}" var="brand">
                                                        <option value="${brand.brandId}" 
                                                                ${product.brandId == brand.brandId ? 'selected' : ''}>
                                                            ${brand.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="componentTypeId" class="form-label">Component Type *</label>
                                                <select class="form-select" id="componentTypeId" name="componentTypeId" required>
                                                    <option value="">Select Component Type</option>
                                                    <c:forEach items="${categories}" var="category">
                                                        <option value="${category.id}" 
                                                                ${product.componentTypeId == category.id ? 'selected' : ''}>
                                                            ${category.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="seriesId" class="form-label">Series</label>
                                                <select class="form-select" id="seriesId" name="seriesId">
                                                    <option value="">Select Series</option>
                                                    <c:forEach items="${series}" var="s">
                                                        <option value="${s.seriesId}" data-brand-id="${s.brandId}"
                                                            ${product.seriesId == s.seriesId ? 'selected' : ''}>
                                                            ${s.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="model" class="form-label">Model</label>
                                                <input type="text" class="form-control" id="model" name="model" 
                                                       value="${product.model}" maxlength="20">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Price *</label>
                                                <input type="number" class="form-control" id="price" name="price" 
                                                       value="${product.price}" step="0.01" min="0" required>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="importPrice" class="form-label">Import Price</label>
                                                <input type="number" class="form-control" id="importPrice" name="importPrice" 
                                                       value="${product.importPrice}" step="0.01" min="0">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="stock" class="form-label">Stock *</label>
                                                <input type="number" class="form-control" id="stock" name="stock" 
                                                       value="${product.stock}" min="0" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="status" class="form-label">Status *</label>
                                                <select class="form-select" id="status" name="status" required>
                                                    <option value="Active" ${product.status == 'Active' ? 'selected' : ''}>Active</option>
                                                    <option value="Inactive" ${product.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" maxlength="150">${product.description}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Product Specifications -->
                    <div class="card mt-4">
                        <div class="card-body">
                            <h5 class="card-title">Product Specifications</h5>
                            <div id="specificationsContainer">
                                <c:forEach items="${specifications}" var="spec" varStatus="status">
                                    <div class="specification-row row">
                                        <div class="col-md-5">
                                            <input type="text" class="form-control" name="specKeys" 
                                                   value="${spec.specKey}" placeholder="Specification Key">
                                        </div>
                                        <div class="col-md-5">
                                            <input type="text" class="form-control" name="specValues" 
                                                   value="${spec.specValue}" placeholder="Specification Value">
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-danger btn-sm remove-spec">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="button" class="btn btn-success btn-add-spec">
                                <i class="fas fa-plus"></i> Add Specification
                            </button>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/productservlet?service=viewProduct" 
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Product List
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add new specification row
        document.querySelector('.btn-add-spec').addEventListener('click', function() {
            const container = document.getElementById('specificationsContainer');
            const newRow = document.createElement('div');
            newRow.className = 'specification-row row';
            newRow.innerHTML = `
                <div class="col-md-5">
                    <input type="text" class="form-control" name="specKeys" placeholder="Specification Key">
                </div>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="specValues" placeholder="Specification Value">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger btn-sm remove-spec">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `;
            container.appendChild(newRow);
        });
        
        // Remove specification row
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('remove-spec') || e.target.closest('.remove-spec')) {
                const row = e.target.closest('.specification-row');
                if (row) {
                    row.remove();
                }
            }
        });
        
        // Dynamic series loading based on brand selection
        document.getElementById('brandId').addEventListener('change', function() {
            const brandId = this.value;
            const seriesSelect = document.getElementById('seriesId');
            
            if (brandId) {
                // You can implement AJAX call here to load series based on brand
                // For now, we'll just enable/disable the series select
                seriesSelect.disabled = false;
            } else {
                seriesSelect.disabled = true;
                seriesSelect.value = '';
            }
        });

        document.addEventListener('DOMContentLoaded', function() {
            const brandSelect = document.getElementById('brandId');
            const seriesSelect = document.getElementById('seriesId');
            // Clone all options for later filtering
            const allSeriesOptions = Array.from(seriesSelect.options).map(option => option.cloneNode(true));

            function filterSeriesOptions() {
                const selectedBrandId = brandSelect.value;
                const currentSeriesId = "${product.seriesId}";
                seriesSelect.innerHTML = '';
                allSeriesOptions.forEach(option => {
                    if (option.value === '' || option.getAttribute('data-brand-id') === selectedBrandId) {
                        seriesSelect.appendChild(option);
                    }
                });
                // Try to re-select the current series if it matches
                if (currentSeriesId && Array.from(seriesSelect.options).some(opt => opt.value === currentSeriesId)) {
                    seriesSelect.value = currentSeriesId;
                } else {
                    seriesSelect.value = '';
                }
            }

            brandSelect.addEventListener('change', filterSeriesOptions);
            // Initial filter on page load
            filterSeriesOptions();

            // Show image preview if there is an imageUrl
            var imgPreview = document.getElementById('imagePreview');
            var imageUrl = document.getElementById('imageUrl').value;
            if (imageUrl && imageUrl.trim() !== '') {
                imgPreview.style.display = 'block';
                imgPreview.src = imageUrl;
            } else {
                imgPreview.style.display = 'none';
            }
        });

        // Add client-side validation for field lengths
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const model = document.getElementById('model').value.trim();
            const description = document.getElementById('description').value.trim();
            let errorMsg = '';
            if (name.length > 30) {
                errorMsg += 'Product Name cannot exceed 30 characters.\n';
            }
            if (model.length > 20) {
                errorMsg += 'Model cannot exceed 20 characters.\n';
            }
            if (description.length > 150) {
                errorMsg += 'Description cannot exceed 150 characters.\n';
            }
            if (errorMsg) {
                alert(errorMsg);
                e.preventDefault();
            }
        });

        document.getElementById('imageFile').addEventListener('change', function(e) {
            const fileInput = e.target;
            const file = fileInput.files[0];
            const nameDisplay = document.getElementById('selectedImageName');
            const imgPreview = document.getElementById('imagePreview');
            const imageUrl = document.getElementById('imageUrl').value;
            if (file) {
                const fileName = file.name;
                const ext = fileName.split('.').pop().toLowerCase();
                if (["jpg", "jpeg", "png"].includes(ext)) {
                    nameDisplay.textContent = fileName;
                    // Show preview
                    const reader = new FileReader();
                    reader.onload = function(ev) {
                        imgPreview.src = ev.target.result;
                        imgPreview.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    nameDisplay.textContent = '';
                    fileInput.value = '';
                    // Revert to original image if exists
                    if (imageUrl && imageUrl.trim() !== '') {
                        imgPreview.src = imageUrl;
                        imgPreview.style.display = 'block';
                    } else {
                        imgPreview.style.display = 'none';
                    }
                    alert('Only JPG and PNG files are allowed.');
                }
            } else {
                nameDisplay.textContent = '';
                // If no file selected, revert to original image if exists
                if (imageUrl && imageUrl.trim() !== '') {
                    imgPreview.src = imageUrl;
                    imgPreview.style.display = 'block';
                } else {
                    imgPreview.style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>